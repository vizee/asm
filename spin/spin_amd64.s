#include "textflag.h"

// func Lock(l *int32)
TEXT ·Lock(SB), NOSPLIT, $0-8
	MOVQ l+0(FP), BP
	XORL AX, AX
	MOVL $1, CX

trylock:
	LOCK
	CMPXCHGL CX, 0(BP)
	JNZ      spinwait
	RET

spinwait:
	PAUSE
	TESTL 0(BP), AX
	JNZ   spinwait
	JMP   trylock

TEXT ·Wait(SB), NOSPLIT, $0-0
	PAUSE
	RET

// func WaitN(n uint32)
TEXT ·WaitN(SB), NOSPLIT, $0-4
	MOVL  n+0(FP), CX
	TESTL CX, CX
	JZ    done

redo:
	PAUSE
	LOOP redo

done:
	RET
