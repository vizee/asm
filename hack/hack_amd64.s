#include "textflag.h"

TEXT ·TLS(SB), NOSPLIT, $8
	MOVQ (TLS), AX
	MOVQ AX, ret+0(FP)
	RET

// func ProcPin() int
TEXT ·ProcPin(SB), NOSPLIT, $0
	JMP runtime·procPin(SB)

// func ProcUnpin()
TEXT ·ProcUnpin(SB), NOSPLIT, $0
	JMP runtime·procUnpin(SB)

// func Nanotime()
TEXT ·Nanotime(SB), NOSPLIT, $0
	JMP runtime·nanotime(SB)
