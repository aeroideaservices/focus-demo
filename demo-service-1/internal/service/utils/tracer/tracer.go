package tracer

import (
	"bytes"
	"github.com/opentracing/opentracing-go"
	"github.com/opentracing/opentracing-go/ext"
	fields "github.com/opentracing/opentracing-go/log"
	"runtime/debug"
	"sync"
)

var (
	scopeManager   = &ScopeManager{}
	lock           = sync.RWMutex{}
	tracerDisabled = false
)

func SetTracerDisabled(disabled bool) {
	tracerDisabled = disabled
}

type TracerInterface interface {
	GetScope() *Scope
	Close()
	SetTag(key string, value interface{})
	SetTags(list map[string]interface{})
	LogMessage(message string)
	Log(key, message string)
	LogData(key string, data interface{})
	LogError(err interface{})
}

func NewTracer(tracerName string, opts ...opentracing.StartSpanOption) TracerInterface {
	if tracerDisabled {
		return &NullTracer{}
	}
	lock.Lock()
	defer lock.Unlock()
	gr := string(bytes.Fields(debug.Stack())[1])
	preparedOpts, async := initTracer(gr, opts...)
	activeSpan := opentracing.StartSpan(tracerName, preparedOpts...)
	scope := scopeManager.Activate(activeSpan)
	scope.Async = async
	scope.Gr = gr
	return &Tracer{scope: scope}
}

func initTracer(gr string, opts ...opentracing.StartSpanOption) ([]opentracing.StartSpanOption, bool) {
	scope := scopeManager.GetActive()
	async := false
	asyncSet := false
	parentSet := false
	for _, op := range opts {
		switch v := op.(type) {
		case ParentSpan:
			scope = v.Parent
			parentSet = true
		case AsyncSpan:
			async = v.Async
			asyncSet = true
		}
	}
	if scope != nil {
		if !asyncSet {
			async = scope.Async
		}

		var syncScope *Scope
		if parentSet {
			syncScope = scope
		} else {
			syncScope = scope.GetParent(gr)
		}
		if syncScope != nil {
			opts = append(opts, opentracing.ChildOf(syncScope.GetSpan().Context()))
		}
	}
	return opts, async
}

type Tracer struct {
	scope    *Scope
	hasError bool
}

func (t *Tracer) GetScope() *Scope {
	return t.scope
}

func (t *Tracer) Close() {
	t.scope.Close()
}

func (t *Tracer) SetTag(key string, value interface{}) {
	t.scope.GetSpan().SetTag(key, value)
}

func (t *Tracer) SetTags(list map[string]interface{}) {
	for key, value := range list {
		t.scope.GetSpan().SetTag(key, value)
	}
}

func (t *Tracer) LogMessage(message string) {
	t.scope.GetSpan().LogFields(fields.String("message", message))
}

func (t *Tracer) Log(key, message string) {
	t.scope.GetSpan().LogFields(fields.String(key, message))
}

func (t *Tracer) LogData(key string, data interface{}) {
	t.scope.GetSpan().LogFields(fields.Object(key, data))
}

func (t *Tracer) LogError(err interface{}) {
	if t.hasError != true {
		ext.Error.Set(t.scope.GetSpan(), true)
		t.hasError = true
	}
	t.scope.GetSpan().LogFields(
		fields.Object("error.object", err),
		fields.Event("error"),
	)
}

type NullTracer struct {
}

func (t *NullTracer) GetScope() *Scope {
	return nil
}

func (t *NullTracer) Close() {
}

func (t *NullTracer) SetTag(key string, value interface{}) {
}

func (t *NullTracer) SetTags(list map[string]interface{}) {
}

func (t *NullTracer) LogMessage(message string) {
}

func (t *NullTracer) Log(key, message string) {
}

func (t *NullTracer) LogData(key string, data interface{}) {
}

func (t *NullTracer) LogError(err interface{}) {
}
