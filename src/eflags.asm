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
