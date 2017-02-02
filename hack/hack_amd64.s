#include "textflag.h"

// func ProcPin() int
TEXT ·ProcPin(SB), NOSPLIT, $8-8
	CALL runtime·procPin(SB)
	MOVQ (SP), AX
	MOVQ AX, ret+0(FP)
	RET

// func ProcUnpin()
TEXT ·ProcUnpin(SB), NOSPLIT, $0-0
	CALL runtime·procUnpin(SB)
	RET
