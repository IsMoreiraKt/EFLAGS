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
