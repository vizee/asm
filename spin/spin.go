package spin

//go:noescape
func Lock(l *int32)

//go:noescape
func Wait(n uint32)
