package tracer

import (
	"github.com/opentracing/opentracing-go"
)

type ParentSpan struct {
	Parent *Scope
}

func (t ParentSpan) Apply(o *opentracing.StartSpanOptions) {}

type AsyncSpan struct {
	Async bool
}

func (t AsyncSpan) Apply(o *opentracing.StartSpanOptions) {}
