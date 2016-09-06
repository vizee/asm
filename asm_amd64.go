package asm

// string

//go:noescape
func Stos8(addr *byte, cnt int, b byte)

//go:noescape
func Scas64(addr *uint64, cnt int, v int) (ret int)

// lock

//go:noescape
func LockOr32(addr *uint32, val uint32)

//go:noescape
func LockCmpxchg8(addr *byte, cmp byte, val byte) (ok bool)
