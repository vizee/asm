package hack

import (
	"runtime"
	"sync"
	"testing"
)

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
