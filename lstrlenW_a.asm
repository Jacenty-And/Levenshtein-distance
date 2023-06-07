.686
.model flat
public _lstrlenW_a
.code
_lstrlenW_a PROC
;int lstrlenW(wchar_t* lpString) {
;	for (int i = 0; ; i++) if (lpString[i] == 0) return i;
push ebp
mov ebp, esp

mov eax, [ebp+8] ; wchar_t* lpString
sub eax, 2
mov ecx, 0
ptl:
inc ecx
add eax, 2
cmp word ptr [eax], 0
jnz ptl
dec ecx
mov eax, ecx

pop ebp
ret
_lstrlenW_a ENDP
END