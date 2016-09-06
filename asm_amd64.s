#include "textflag.h"

// func Stos8(addr *byte, cnt int, b byte)
TEXT ·Stos8(SB),NOSPLIT,$0-17
	MOVQ addr+0(FP), DI
	MOVQ cnt+8(FP), CX
	MOVB b+16(FP), AL
	REPN
	STOSB
	RET

// func Scas64(addr *uintptr, cnt int, v uintptr) (ret int)
TEXT ·Scas64(SB),NOSPLIT,$0-32
	MOVQ addr+0(FP), DI
	MOVQ cnt+8(FP), CX
	MOVQ CX, DX
	MOVQ v+16(FP), AX
	REPN
	SCASQ
	JZ found
	XORQ DX, DX
found:
	SUBQ CX, DX
	DECQ DX
	MOVQ DX, ret+24(FP)
	RET

// func LockOr32(addr *uint32, val uint32)
TEXT ·LockOr32(SB),NOSPLIT,$0-12
    MOVQ addr+0(FP), BP
    MOVL val+8(FP), AX
    LOCK
    ORL AX, (BP)
    RET

// func LockCmpxchg8(addr *byte, cmp byte, val byte) (ok bool)
TEXT ·LockCmpxchg8(SB),NOSPLIT,$0-17
    MOVQ addr+0(FP), BP
    MOVB cmp+8(FP), AL
    MOVB val+9(FP), AH
    LOCK
    CMPXCHGB AH, (BP)
    SETEQ ok+16(FP)
    RET
