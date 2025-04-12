; %1 -> eflags result
;
; returns
; rax -> 0 / 1
;   0 -> not active
;   1 -> active
%macro isCpuidActive 1
  mov rcx, %1

  mov rax, rcx
  xor rax, 1 << 21
  push rax
  popfq

  pushfq
  pop rax

  push rcx
  popfq

  xor rax, rcx
  shr rax, 21
  and rax, 1
%endmacro


; %1 -> message
; %2 -> message length
%macro print 2
  mov rax, 1
  mov rdi, 1
  mov rsi, %1
  mov rdx, %2
  syscall
%endmacro


; %1 -> exit code
%macro exit 1
  mov rax, 60
  mov rdi, %1
  syscall
%endmacro



section .data
  pos_cpuid_msg db "cpuid is enabled", 0xA, 0
  len_pos_cpuid equ $ - pos_cpuid_msg

  neg_cpuid_msg db "cpuid is not active", 0xA, 0
  len_neg_cpuid equ $ - neg_cpuid_msg


section .bss
  eflags_result resb 8
  cpuid_active resb 1


section .text
  global _start

_start:
  pushfq
  pop rax
  mov [eflags_result], rax

  isCpuidActive rax
  mov [cpuid_active], al

  cmp byte [cpuid_active], 0
  je .cpuid_neg

  print pos_cpuid_msg, len_pos_cpuid
  jmp .done

.cpuid_neg:
  print neg_cpuid_msg, len_neg_cpuid
  jmp .done

.done:
  exit 0
