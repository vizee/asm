package asm

import (
	"testing"
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
