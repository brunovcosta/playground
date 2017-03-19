	.file	"minimum.c"
	.text
	.globl	desenha
	.type	desenha, @function
desenha:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$16384, %edi
	call	glClear
	movl	$4, %edi
	call	glBegin
	pxor	%xmm2, %xmm2
	pxor	%xmm1, %xmm1
	movss	.LC1(%rip), %xmm0
	call	glColor3f
	movss	.LC2(%rip), %xmm1
	movss	.LC3(%rip), %xmm0
	call	glVertex2f
	pxor	%xmm2, %xmm2
	movss	.LC1(%rip), %xmm1
	pxor	%xmm0, %xmm0
	call	glColor3f
	movss	.LC4(%rip), %xmm1
	movss	.LC5(%rip), %xmm0
	call	glVertex2f
	movss	.LC1(%rip), %xmm2
	pxor	%xmm1, %xmm1
	pxor	%xmm0, %xmm0
	call	glColor3f
	movss	.LC6(%rip), %xmm1
	movss	.LC7(%rip), %xmm0
	call	glVertex2f
	call	glEnd
	call	glFlush
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	desenha, .-desenha
	.section	.rodata
	.align 8
.LC8:
	.string	"Menor aplica\303\247\303\243o poss\303\255vel :D"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	leaq	-4(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	glutInit
	movl	$.LC8, %edi
	call	glutCreateWindow
	movl	$desenha, %edi
	call	glutDisplayFunc
	call	glutMainLoop
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC1:
	.long	1065353216
	.align 4
.LC2:
	.long	3207803699
	.align 4
.LC3:
	.long	3204448256
	.align 4
.LC4:
	.long	3188006584
	.align 4
.LC5:
	.long	3211159142
	.align 4
.LC6:
	.long	3201092813
	.align 4
.LC7:
	.long	3184315597
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
