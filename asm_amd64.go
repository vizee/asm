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

//go:noescape
func LockCmpxchg16B(addr *uint64, cmplo uint64, cmphi uint64, vallo uint64, valhi uint64) (ok bool)

// sse

//go:noescape
func Movoa(from *uint64, to *uint64)

//go:noescape
func Movou(from *uint64, to *uint64)

// misc

func CPUID(ax uint32, cx uint32) (a uint32, b uint32, d uint32, c uint32)

func Rdtsc() int64

func Rdtscp() (tsc int64, cpuid uint32)
