; %1 -> eflags result
;
; returns
; eax -> 0 / 1
;   0 -> not active
;   1 -> active
%macro isCpuidActive 1
  mov ecx, %1

  mov eax, ecx
  xor eax, 1 << 21
  push eax
  popfd

  pushfd
  pop eax

  push ecx
  popfd

  xor eax, ecx
  shr eax, 21
  and eax, 1
%endmacro


; %1 -> message
; %2 -> message length
%macro print 2
  mov eax, 4
  mov ebx, 1
  mov ecx, %1
  mov edx, %2
  int 0x80
%endmacro


; %1 -> exit code
%macro exit 1
  mov eax, 1
  mov ebx, %1
  int 0x80
%endmacro



section .data
  pos_cpuid_msg db "cpuid is enabled", 0xA, 0
  len_pos_cpuid equ $ - pos_cpuid_msg

  neg_cpuid_msg db "cpuid is not active", 0XA, 0
  len_neg_cpuid equ $ - neg_cpuid_msg


section .bss
  eflags_result resb 4
  cpuid_active resb 1


section .text
  global _start

_start:
  pushfd
  pop eax
  mov [eflags_result], eax

  isCpuidActive eax
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
