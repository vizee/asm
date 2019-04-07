#include "textflag.h"

// func Stos8(addr *byte, cnt int, b byte)
TEXT ·Stos8(SB), NOSPLIT, $0-17
	MOVQ addr+0(FP), DI
	MOVQ cnt+8(FP), CX
	MOVB b+16(FP), AL
	REPN
	STOSB
	RET

// func Scas64(addr *uintptr, cnt int, v uintptr) (ret int)
TEXT ·Scas64(SB), NOSPLIT, $0-32
	MOVQ addr+0(FP), DI
	MOVQ cnt+8(FP), CX
	MOVQ CX, DX
	MOVQ v+16(FP), AX
	REPN
	SCASQ
	JZ   found
	XORQ DX, DX

found:
	SUBQ CX, DX
	DECQ DX
	MOVQ DX, ret+24(FP)
	RET

// func LockAnd32(addr *uint32, val uint32) uint32
TEXT ·LockAnd32(SB), NOSPLIT, $0-20
	MOVQ addr+0(FP), BP
	MOVL val+8(FP), AX
	LOCK
	ANDL AX, (BP)
	MOVL AX, ret+16(FP)
	RET

// func LockOr32(addr *uint32, val uint32)
TEXT ·LockOr32(SB), NOSPLIT, $0-20
	MOVQ addr+0(FP), BP
	MOVL val+8(FP), AX
	LOCK
	ORL  AX, (BP)
	MOVL AX, ret+16(FP)
	RET

// func LockCmpxchg8(addr *byte, cmp byte, val byte) (ok bool)
TEXT ·LockCmpxchg8(SB), NOSPLIT, $0-17
	MOVQ     addr+0(FP), BP
	MOVB     cmp+8(FP), AL
	MOVB     val+9(FP), AH
	LOCK
	CMPXCHGB AH, (BP)
	SETEQ    ok+16(FP)
	RET

#define LOCK_CMPXCHG16B_DI_M BYTE $0xf0; BYTE $0x48; BYTE $0x0f; BYTE $0xc7; BYTE $0x0f

// func LockCmpxchg16B(addr *uint128, cmplo uint64, cmphi uint64, vallo uint64, valhi uint64) (ok bool)
TEXT ·LockCmpxchg16B(SB), NOSPLIT, $0-41
	MOVQ  addr+0(FP), DI
	MOVQ  cmplo+8(FP), AX
	MOVQ  cmphi+16(FP), DX
	MOVQ  vallo+24(FP), BX
	MOVQ  valhi+32(FP), CX
	LOCK_CMPXCHG16B_DI_M
	SETEQ ok+40(FP)
	RET

// func Movoa(from *uint64, to *uint64)
TEXT ·Movoa(SB), NOSPLIT, $0-16
	MOVQ  from+0(FP), AX
	MOVOA (AX), X0
	MOVQ  to+8(FP), AX
	MOVOA X0, (AX)
	RET

// func Movou(from *uint64, to *uint64)
TEXT ·Movou(SB), NOSPLIT, $0-16
	MOVQ  from+0(FP), AX
	MOVOU (AX), X0
	MOVQ  to+8(FP), AX
	MOVOU X0, (AX)
	RET

// func CPUID(ax uint32, cx uint32) (a uint32, b uint32, d uint32, c uint32)
TEXT ·CPUID(SB), NOSPLIT, $0-24
	MOVL ax+0(FP), AX
	MOVL cx+4(FP), CX
	CPUID
	MOVL AX, a+8(FP)
	MOVL BX, b+12(FP)
	MOVL DX, d+16(FP)
	MOVL CX, c+20(FP)
	RET

// func Rdtsc() int64
TEXT ·Rdtsc(SB), NOSPLIT, $0-8
	LFENCE
	RDTSC
	SHLQ $32, DX
	ORQ  AX, DX
	MOVQ DX, ret+0(FP)
	RET

#define RDTSCP BYTE $0x0f; BYTE $0x01; BYTE $0xf9

// func Rdtscp() (tsc int64, cpuid uint32)
TEXT ·Rdtscp(SB), NOSPLIT, $0-12
	RDTSCP
	SHLQ $32, DX
	ORQ  AX, DX
	MOVQ DX, tsc+0(FP)
	MOVL CX, cpuid+8(FP)
	RET
