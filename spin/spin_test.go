package spin

import (
	"sync/atomic"
	"testing"
	"time"
)

func TestSpinLock(t *testing.T) {
	l := int32(0)

	Lock(&l)
	t.Log("l:", l)

	// try unlock
	t.Log("try unlock:", atomic.CompareAndSwapInt32(&l, 1, 0))
	t.Log("l:", l)
}

func TestSpinWait(t *testing.T) {
	b := time.Now()
	a := time.Now()
	t.Log("cost", a.Sub(b))
	b = time.Now()
	WaitN(100)
	a = time.Now()
	t.Log("cost2", a.Sub(b))
}
