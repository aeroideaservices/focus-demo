package tracer

import (
	"github.com/opentracing/opentracing-go"
)

type ScopeManager struct {
	active *Scope
}

func (s *ScopeManager) Activate(span opentracing.Span) *Scope {
	restorer := func(scope *Scope) {
		s.active = scope
	}
	s.active = &Scope{
		scopeManager: s,
		span:         span,
		ToRestore:    s.active,
		restorer:     restorer,
	}

	return s.active
}

func (s *ScopeManager) GetActive() *Scope {
	return s.active
}
