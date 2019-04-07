#include "textflag.h"

TEXT ·TLS(SB), NOSPLIT, $8
	MOVQ (TLS), AX
	MOVQ AX, ret+0(FP)
	RET

// func Nanotime()
TEXT ·Nanotime(SB), NOSPLIT, $0
	JMP runtime·nanotime(SB)
