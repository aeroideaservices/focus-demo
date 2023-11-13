package notify

type Notification struct {
	Code  string `json:"code"`
	Value any    `json:"value"`
}

type Notifier interface {
	NotifyUser(userId string, msg any) error
	NotifyAll(msg any) error
}
