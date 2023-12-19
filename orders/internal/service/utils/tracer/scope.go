package tracer

import (
	"github.com/opentracing/opentracing-go"
)

type Scope struct {
	scopeManager *ScopeManager
	span         opentracing.Span
	ToRestore    *Scope
	restorer     func(scope *Scope)
	IsClosed     bool
	Async        bool
	Gr           string
}

func (s *Scope) GetSpan() opentracing.Span {
	return s.span
}

func (s *Scope) getByGr(gr string) *Scope {
	syncScope := s
	if syncScope == nil {
		return nil
	}
	if syncScope.Gr != gr {
		for {
			if syncScope.ToRestore == nil {
				syncScope = s
				break
			}
			syncScope = syncScope.ToRestore
			if !syncScope.IsClosed && syncScope.Gr == gr {
				break
			}
		}
	}
	if syncScope.Gr != gr {
		return nil
	}

	return syncScope
}

func (s *Scope) getByAsync() *Scope {
	syncScope := s
	if syncScope.Async {
		for {
			if syncScope.ToRestore == nil {
				break
			}
			syncScope = syncScope.ToRestore
			if !syncScope.IsClosed && !syncScope.Async {
				break
			}
		}
	}
	if syncScope.Async {
		return nil
	}
	return syncScope
}

func (s *Scope) GetParent(gr string) *Scope {
	syncScope := s.getByGr(gr)
	if syncScope != nil {
		return syncScope
	}
	return s.getByAsync()
}

func (s *Scope) Close() {
	if s.IsClosed == true {
		return
	}
	s.span.Finish()
	s.IsClosed = true
	if s.scopeManager.GetActive() != s {
		return
	}

	toRestore := s.ToRestore
	for {
		if toRestore == nil {
			break
		} else if toRestore.IsClosed {
			toRestore = toRestore.ToRestore
		} else {
			break
		}
	}
	s.restorer(toRestore)
}
