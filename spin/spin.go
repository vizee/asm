package spin

//go:noescape
func Lock(l *int32)

func Wait()

func WaitN(n uint32)
