package asm

import (
	"testing"
	"unsafe"
)

func TestStos8(t *testing.T) {
	arr := []byte{1, 2, 3, 4}
	Stos8(&arr[0], len(arr)-1, 0)
	t.Log(arr)
}

func TestScas64(t *testing.T) {
	arr := []uint64{1, 2, 3}
	t.Log(Scas64(&arr[0], len(arr), 1))
	t.Log(Scas64(&arr[0], len(arr), 2))
	t.Log(Scas64(&arr[0], len(arr), 3))
	t.Log(Scas64(&arr[0], len(arr), 4))
}

func TestLockAnd32(t *testing.T) {
	v := uint32(1)
	LockAnd32(&v, 2)
	t.Log(v)
}

func TestLockOr32(t *testing.T) {
	v := uint32(1)
	LockOr32(&v, 2)
	t.Log(v)
}

func TestLockCmpxchg8(t *testing.T) {
	v := byte(1)
	t.Log(LockCmpxchg8(&v, 2, 3))
	t.Log(LockCmpxchg8(&v, 1, 2))
	t.Log(v)
}

func NOTestLockCmpxchg16B(t *testing.T) {
	v := [2]uint64{0, 1}
	p := &v[0]
	t.Logf("%x", *p)
	t.Log(LockCmpxchg16B(&v[0], 2, 3, 4, 5))
	t.Log(LockCmpxchg16B(&v[0], 0, 1, 4, 5))
	t.Log(v)
}

func NOTestMovoa(t *testing.T) {
	v := [2]uint64{1, 2}
	v2 := [2]uint64{3, 4}
	Movoa(&v[0], &v2[0])
	t.Log("v", v)
	t.Log("v2", v2)
}

func TestMovou(t *testing.T) {
	v := [2]uint64{1, 2}
	v2 := [2]uint64{3, 4}
	Movou(&v[0], &v2[0])
	t.Log("v", v)
	t.Log("v2", v2)
}

func TestCPUID(t *testing.T) {
	var s [4]uint32
	s[0], s[1], s[2], s[3] = CPUID(0, 0)

	var magic [2]uintptr
	magic[0] = uintptr(unsafe.Pointer(&s[1]))
	magic[1] = 12
	t.Log(s[0], *(*string)(unsafe.Pointer(&magic)))
}

func TestRdtsc(t *testing.T) {
	t.Log(Rdtsc())
}

func TestRdtscp(t *testing.T) {
	t.Log(Rdtscp())
}
