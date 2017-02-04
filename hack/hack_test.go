package hack

import (
	"runtime"
	"sync"
	"testing"
)

func TestTLS(t *testing.T) {
	t.Log(TLS())
}

func TestProcPin(t *testing.T) {
	if runtime.NumCPU() == 1 {
		runtime.GOMAXPROCS(2)
	}

	var wg sync.WaitGroup
	for i := 0; i < 10; i++ {
		wg.Add(1)
		go func() {
			n := ProcPin()
			ProcUnpin()
			t.Log(n)
			wg.Done()
		}()
	}
	wg.Wait()
}

func TestNanotime(t *testing.T) {
	t.Log(Nanotime())
}
