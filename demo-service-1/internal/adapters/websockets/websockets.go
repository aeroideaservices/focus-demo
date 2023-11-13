package websockets

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/olahol/melody"
	"github.com/pkg/errors"
	"go.uber.org/zap"
)

const subscriberKey = "user-id"
const serviceKey = "service"
const serviceName = "reviews-cms"

type Websockets struct {
	ws     *melody.Melody
	logger *zap.SugaredLogger
}

func NewWebsockets(ws *melody.Melody, logger *zap.SugaredLogger) *Websockets {
	return &Websockets{
		ws:     ws,
		logger: logger,
	}
}

func (w *Websockets) Subscribe(rw http.ResponseWriter, r *http.Request, userId string) error {
	w.logger.Debugw("subscribing websockets", "userId", userId)
	err := w.ws.HandleRequestWithKeys(rw, r, map[string]interface{}{
		subscriberKey: userId,
		serviceKey:    serviceName,
	})
	if err != nil {
		return errors.Wrap(err, "subscribe error")
	}

	w.logger.Debugw("subscribed websockets", "userId", userId)
	return nil
}

func (w *Websockets) NotifyUser(userId string, msg any) error {
	b, err := json.Marshal(msg)
	if err != nil {
		return fmt.Errorf("marshal message error: %w", err)
	}

	err = w.ws.BroadcastFilter(b, func(session *melody.Session) bool {
		return checkUserId(session, userId) && checkServiceName(session)
	})
	if err != nil {
		return fmt.Errorf("broadcasting error: %w", err)
	}

	return nil
}

func (w *Websockets) NotifyAll(msg any) error {
	b, err := json.Marshal(msg)
	if err != nil {
		return fmt.Errorf("marshal message error: %w", err)
	}

	err = w.ws.BroadcastFilter(b, func(session *melody.Session) bool {
		return checkServiceName(session)
	})
	if err != nil {
		return fmt.Errorf("broadcasting error: %w", err)
	}

	return nil
}

func checkServiceName(session *melody.Session) bool {
	val, ok := session.Get(serviceKey)
	if !ok {
		return false
	}
	service, ok := val.(string)
	if !ok {
		return false
	}

	return service == serviceName
}

func checkUserId(session *melody.Session, userId string) bool {
	v, ok := session.Get(subscriberKey)
	if !ok {
		return false
	}
	sessionUserId, ok := v.(string)
	if !ok {
		return false
	}

	return sessionUserId == userId
}
