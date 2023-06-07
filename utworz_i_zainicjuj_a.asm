.686
.model flat
extern _malloc : PROC
public _utworz_i_zainicjuj_a
.code
_utworz_i_zainicjuj_a PROC
push ebp
mov ebp, esp
;void * utworz_i_zainicjuj(unsigned int m, unsigned int n) {
;	int** tablica = (int**)malloc((n + 1) * sizeof(int*));
;	for (unsigned int i = 0; i < n + 1; i++)
;		tablica[i] = (int*)malloc((m + 1) * sizeof(int));
;	for (unsigned int i = 0; i < n + 1; i++)
;		for (unsigned int j = 0; j < m + 1; j++) {
;			if (i == 0)
;				tablica[0][j] = j;
;			else if (j == 0)
;				tablica[i][0] = i;
;			else
;				tablica[i][j] = 0;
;		}
;	return tablica;
mov eax, [ebp+8]  ; unsigned int m
inc eax			  ; m + 1
mov ebx, [ebp+12] ; unsigned int n
inc ebx           ; n + 1
mov edx, 0
mul ebx      ; eax - m * n
push eax     ; esp - m * n
shl eax, 2   ; eax - m * n * 4 bajty dla inta
push eax
call _malloc ; eax - adres poczatku tablicy
add esp, 4
pop ecx      ; ecx - m * n
mov edi, ecx ; edi - m * n
mov edx, 0
mov ebx, 1
push eax
ptl:
mov dword ptr [eax], 0
push edi
sub edi, ecx     ; edi - obiegi petli
cmp edi, [ebp+8] ; if edi > m dalej
ja dalej
mov [eax], edi   ; pierwszy rzad: 0, 1, 2, ..., m
dalej:
pop edi
mov esi, [ebp+8] ; esi - m
inc esi
cmp edx, esi ; if edx = m + 1 dalej1
jnz dalej1
mov edx, 0
mov [eax], ebx
inc ebx
dalej1:
inc edx
add eax, 4
loop ptl
pop eax ; adres poczatku tablicy

pop ebp
ret
_utworz_i_zainicjuj_a ENDP
END