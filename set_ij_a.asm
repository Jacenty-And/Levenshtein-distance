.686
.model flat
public _set_ij_a
.code
_set_ij_a PROC
; void set_ij(int* table, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m) {
; 	 int x = table[i][j - 1] + 1;
; 	 int y = table[i - 1][j] + 1;
; 	 int z = table[i - 1][j - 1];
; 	 if (a != b) z += 1;
; 	 table[i][j] = min3(x, y, z);
push ebp
mov ebp, esp
push ebx
push esi
push edi

; int x = table[i][j - 1] + 1;
mov eax, [ebp+8]  ; int*          table
mov ecx, [ebp+20] ; unsigned int  i
mov edx, [ebp+24] ; unsigned int  j
dec edx           ; j - 1
mov ebx, [ebp+28] ; unsigned int  m
inc ebx			  ; row size

shl edx, 2   ; j * 4 (4 bytes for int)
add eax, edx ; column j 

shl ecx, 2   ; i * 4 (4 bytes for int)
mov esi, eax ; esi = int* table
mov eax, ecx ; eax = i
mov edx, 0
mul ebx		 ; i * m
add eax, esi ; column j, row i
mov esi, [eax]
inc esi      ; +1
push esi     

; int y = table[i - 1][j] + 1;
mov eax, [ebp+8]  ; int*          table
mov ecx, [ebp+20] ; unsigned int  i
dec ecx           ; i - 1
mov edx, [ebp+24] ; unsigned int  j
mov ebx, [ebp+28] ; unsigned int  m
inc ebx           ; row size

shl edx, 2   ; j * 4 (4 bytes for int)
add eax, edx ; column j 

shl ecx, 2   ; i * 4 (4 bytes for int)
mov esi, eax ; esi = int* table
mov eax, ecx ; eax = i
mov edx, 0
mul ebx		 ; i * m
add eax, esi ; column j, row i
mov esi, [eax]
inc esi      ; +1
push esi      

;	int z = table[i - 1][j - 1];
mov eax, [ebp+8]  ; int*          table
mov ecx, [ebp+20] ; unsigned int  i
dec ecx           ; i - 1
mov edx, [ebp+24] ; unsigned int  j
dec edx           ; j - 1
mov ebx, [ebp+28] ; unsigned int  m
inc ebx           ; row size

shl edx, 2   ; j * 4 (4 bytes for int)
add eax, edx ; column j

shl ecx, 2   ; i * 4 (4 bytes for int)
mov esi, eax ; esi = int* table
mov eax, ecx ; eax = i
mov edx, 0
mul ebx		 ; i * m
add eax, esi ; column j, row i
mov esi, [eax]

;	if (a != b) z += 1;
mov ecx, [ebp+12] ; wchar_t a
mov edx, [ebp+16] ; wchar_t b
cmp ecx, edx
je equal
inc esi ; +1
equal:
push esi

pop eax
pop esi
cmp eax, esi
jb greater1
mov eax, esi
greater1:
pop esi
cmp eax, esi
jb greater2
mov eax, esi
greater2:

;	table[i][j] = min3(x, y, z);
mov edi, eax ; edi = min(x, y, z)
mov eax, [ebp+8]  ; int*          table
mov ecx, [ebp+20] ; unsigned int  i
mov edx, [ebp+24] ; unsigned int  j
mov ebx, [ebp+28] ; unsigned int  m
inc ebx           ; row size

shl edx, 2   ; j * 4 (4 bytes for int)
add eax, edx ; column j

shl ecx, 2   ; i * 4 (4 bytes for int)
mov esi, eax ; esi = int* table
mov eax, ecx ; eax = i
mov edx, 0
mul ebx		 ; i * m
add eax, esi ; column j, row i
mov [eax], edi

pop edi
pop esi
pop ebx
pop ebp
ret
_set_ij_a ENDP
END
