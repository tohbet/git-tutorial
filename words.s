	.file	"words.c"
	.local	root
	.comm	root,8,8
	.section	.rodata
.LC0:
	.string	"Error:Out of memory\n"
	.text
	.globl	memory_error
	.type	memory_error, @function
memory_error:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$20, %edx
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	call	fwrite@PLT
	movl	$8, %edi
	call	exit@PLT
	.cfi_endproc
.LFE2:
	.size	memory_error, .-memory_error
	.globl	save_string
	.type	save_string, @function
save_string:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	addl	$1, %eax
	movl	%eax, %eax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L3
	call	memory_error
.L3:
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	save_string, .-save_string
	.globl	enter
	.type	enter, @function
enter:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L6
	movl	$24, %edi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L7
	call	memory_error
.L7:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	$0, (%rax)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	$0, 8(%rax)
	movq	-40(%rbp), %rax
	movq	(%rax), %rbx
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	save_string
	movq	%rax, 16(%rbx)
	jmp	.L5
.L6:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	16(%rax), %rax
	movq	-48(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L11
	cmpl	$0, -20(%rbp)
	jns	.L10
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	leaq	8(%rax), %rdx
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	enter
	jmp	.L5
.L10:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdx
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	enter
	jmp	.L5
.L11:
	nop
.L5:
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	enter, .-enter
	.section	.rodata
.LC1:
	.string	"r"
.LC2:
	.string	"Error:Unable to open %s\n"
	.text
	.globl	scan
	.type	scan, @function
scan:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movq	%rdi, -136(%rbp)
	movq	-136(%rbp), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L13
	movq	stderr(%rip), %rax
	movq	-136(%rbp), %rdx
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$8, %edi
	call	exit@PLT
.L13:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fgetc@PLT
	movl	%eax, -20(%rbp)
	call	__ctype_b_loc@PLT
	movq	(%rax), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$1024, %eax
	testl	%eax, %eax
	jne	.L14
	cmpl	$-1, -20(%rbp)
	je	.L14
	jmp	.L13
.L14:
	cmpl	$-1, -20(%rbp)
	je	.L22
	movl	-20(%rbp), %eax
	movb	%al, -128(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L17
.L20:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fgetc@PLT
	movl	%eax, -20(%rbp)
	call	__ctype_b_loc@PLT
	movq	(%rax), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$1024, %eax
	testl	%eax, %eax
	je	.L23
	movl	-20(%rbp), %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	cltq
	movb	%dl, -128(%rbp,%rax)
	addl	$1, -4(%rbp)
.L17:
	movl	-4(%rbp), %eax
	cmpl	$99, %eax
	jbe	.L20
	jmp	.L19
.L23:
	nop
.L19:
	movl	-4(%rbp), %eax
	cltq
	movb	$0, -128(%rbp,%rax)
	leaq	-128(%rbp), %rax
	movq	%rax, %rsi
	leaq	root(%rip), %rdi
	call	enter
	jmp	.L13
.L22:
	nop
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	scan, .-scan
	.globl	print_tree
	.type	print_tree, @function
print_tree:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L27
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	print_tree
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdi
	call	print_tree
	jmp	.L24
.L27:
	nop
.L24:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	print_tree, .-print_tree
	.section	.rodata
	.align 8
.LC3:
	.string	"Error:Wrong number of parameters\n"
.LC4:
	.string	"on the command line\n"
.LC5:
	.string	"Usage is\n"
.LC6:
	.string	"\twords 'file'\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	cmpl	$2, -4(%rbp)
	je	.L29
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$33, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$20, %edx
	movl	$1, %esi
	leaq	.LC4(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$9, %edx
	movl	$1, %esi
	leaq	.LC5(%rip), %rdi
	call	fwrite@PLT
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$14, %edx
	movl	$1, %esi
	leaq	.LC6(%rip), %rdi
	call	fwrite@PLT
	movl	$8, %edi
	call	exit@PLT
.L29:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	scan
	movq	root(%rip), %rax
	movq	%rax, %rdi
	call	print_tree
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Debian 6.3.0-18) 6.3.0 20170516"
	.section	.note.GNU-stack,"",@progbits
