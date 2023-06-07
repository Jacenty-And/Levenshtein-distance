.686
.model flat
public _ustaw_ij_a
.code
_ustaw_ij_a PROC
;void ustaw_ij(int* tablica, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m) {
;	int x = tablica[i][j - 1] + 1;
;	int y = tablica[i - 1][j] + 1;
;	int z = tablica[i - 1][j - 1];
;	if (a != b) z += 1;
;	tablica[i][j] = min3(x, y, z);
push ebp
mov ebp, esp

; int x = tablica[i][j - 1] + 1;
mov eax, [ebp+8]  ; int*          tablica
mov ecx, [ebp+20] ; unsigned int  i
mov edx, [ebp+24] ; unsigned int  j
dec edx           ; j - 1
mov ebx, [ebp+28] ; unsigned int  m
inc ebx      ; dlugosc rzedu

shl edx, 2   ; j * 4 (4 bajty dla inta)
add eax, edx ; kolumna j tablicy

shl ecx, 2   ; i * 4 (4 bajty dla inta)
mov esi, eax ; esi = int* tablica
mov eax, ecx ; eax = i
mov edx, 0
mul ebx		 ; i * m
add eax, esi ; kolumna j, rzad i
mov esi, [eax]
inc esi      ; +1
push esi     

; int y = tablica[i - 1][j] + 1;
mov eax, [ebp+8]  ; int*          tablica
mov ecx, [ebp+20] ; unsigned int  i
dec ecx           ; i - 1
mov edx, [ebp+24] ; unsigned int  j
mov ebx, [ebp+28] ; unsigned int  m
inc ebx           ; dlugosc rzedu

shl edx, 2   ; j * 4 (4 bajty dla inta)
add eax, edx ; kolumna j tablicy

shl ecx, 2   ; i * 4 (4 bajty dla inta)
mov esi, eax ; esi = int* tablica
mov eax, ecx ; eax = i
mov edx, 0
mul ebx		 ; i * m
add eax, esi ; kolumna j, rzad i
mov esi, [eax]
inc esi      ; +1
push esi      

;	int z = tablica[i - 1][j - 1];
mov eax, [ebp+8]  ; int*          tablica
mov ecx, [ebp+20] ; unsigned int  i
dec ecx           ; i - 1
mov edx, [ebp+24] ; unsigned int  j
dec edx           ; j - 1
mov ebx, [ebp+28] ; unsigned int  m
inc ebx           ; dlugosc rzedu

shl edx, 2   ; j * 4 (4 bajty dla inta)
add eax, edx ; kolumna j tablicy

shl ecx, 2   ; i * 4 (4 bajty dla inta)
mov esi, eax ; esi = int* tablica
mov eax, ecx ; eax = i
mov edx, 0
mul ebx		 ; i * m
add eax, esi ; kolumna j, rzad i
mov esi, [eax]

;	if (a != b) z += 1;
mov ecx, [ebp+12] ; wchar_t a
mov edx, [ebp+16] ; wchar_t b
cmp ecx, edx
jz dalej
inc esi ; +1
dalej:
push esi

pop eax
pop esi
cmp eax, esi
jb wieksza1
mov eax, esi
wieksza1:
pop esi
cmp eax, esi
jb wieksza2
mov eax, esi
wieksza2:

;	tablica[i][j] = min3(x, y, z);
mov edi, eax ; edi = min(x, y, z)
mov eax, [ebp+8]  ; int*          tablica
mov ecx, [ebp+20] ; unsigned int  i
mov edx, [ebp+24] ; unsigned int  j
mov ebx, [ebp+28] ; unsigned int  m
inc ebx           ; dlugosc rzedu

shl edx, 2   ; j * 4 (4 bajty dla inta)
add eax, edx ; kolumna j tablicy

shl ecx, 2   ; i * 4 (4 bajty dla inta)
mov esi, eax ; esi = int* tablica
mov eax, ecx ; eax = i
mov edx, 0
mul ebx		 ; i * m
add eax, esi ; kolumna j, rzad i
mov [eax], edi

pop ebp
ret
_ustaw_ij_a ENDP
END