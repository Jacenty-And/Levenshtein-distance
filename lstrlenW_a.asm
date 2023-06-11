.686
.model flat
public _lstrlenW_a
.code
_lstrlenW_a PROC
; int lstrlenW(wchar_t* lpString) {
;	 for (int i = 0; ; i++) if (lpString[i] == 0) return i;
push ebp
mov ebp, esp
push ebx
push esi
push edi

mov eax, [ebp+8] ; wchar_t* lpString
sub eax, 2
mov ecx, 0
next_char:
inc ecx
add eax, 2
cmp word ptr [eax], 0
jnz next_char
dec ecx
mov eax, ecx

pop edi
pop esi
pop ebx
pop ebp
ret
_lstrlenW_a ENDP
END