package tracer

import (
	"bytes"
	"github.com/opentracing/opentracing-go/ext"
	"io"
	"net/http"
	"regexp"
)

type TracingRoundTripper struct {
	Proxy http.RoundTripper
}

func NewTracingClient() *http.Client {
	return &http.Client{
		Transport: TracingRoundTripper{Proxy: http.DefaultTransport},
	}
}

func (lrt TracingRoundTripper) RoundTrip(req *http.Request) (res *http.Response, e error) {
	name := req.Method + "." + req.URL.Path
	tracer := NewTracer(name)
	defer tracer.Close()
	scope := tracer.GetScope()
	if scope != nil {
		span := scope.GetSpan()
		ext.HTTPMethod.Set(span, req.Method)
		ext.HTTPUrl.Set(span, req.URL.String())
	}
	tracer.SetTag("http.host", req.Host)
	tracer.SetTag("http.path", req.URL.Path)

	if len(req.Header) > 0 {
		tracer.LogData("headers", lrt.clearMapData(req.Header))
	}
	if len(req.URL.Query()) > 0 {
		tracer.LogData("query", lrt.clearMapData(req.URL.Query()))
	}
	if req.Body != nil {
		b, _ := io.ReadAll(req.Body)
		body := string(b)
		req.Body = io.NopCloser(bytes.NewBuffer(b))
		tracer.LogData("body", lrt.clearStringData(body))
	}

	AddTraceToRequest(req)
	res, err := lrt.Proxy.RoundTrip(req)
	if err != nil {
		tracer.LogError(err)
	}

	return res, err
}

func (lrt TracingRoundTripper) clearStringData(data string) string {
	re := regexp.MustCompile("(\"(password|pass|identifier|login)\"\\s?:\\s?)\"([^\"]+)\"")
	data = re.ReplaceAllString(data, "$1\"******\"")
	return data
}

func (lrt TracingRoundTripper) clearMapData(data map[string][]string) map[string][]string {
	result := make(map[string][]string)
	for key, values := range data {
		if key == "password" || key == "pass" || key == "identifier" || key == "login" {
			result[key] = []string{"******"}
		} else {
			result[key] = values
		}
	}
	return result
}
