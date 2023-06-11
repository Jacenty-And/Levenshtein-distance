.686
.model flat
extern _malloc : PROC
public _create_and_initialise_a
.code
_create_and_initialise_a PROC
push ebp
mov ebp, esp
push ebx
push esi
push edi
; void* create_and_initialise(unsigned int m, unsigned int n) {
;	int** table = (int**)malloc((n + 1) * sizeof(int*));
;	for (unsigned int i = 0; i < n + 1; i++)
;		table[i] = (int*)malloc((m + 1) * sizeof(int));
;	for (unsigned int i = 0; i < n + 1; i++)
;		for (unsigned int j = 0; j < m + 1; j++) {
;			if (i == 0)
;				table[0][j] = j;
;			else if (j == 0)
;				table[i][0] = i;
;			else
;				table[i][j] = 0;
;		}
;	return table;
mov eax, [ebp+8]  ; unsigned int m
inc eax			  ; m + 1
mov ebx, [ebp+12] ; unsigned int n
inc ebx           ; n + 1
mov edx, 0
mul ebx      ; eax - m * n
push eax     ; esp - m * n
shl eax, 2   ; eax - m * n * 4 bytes for int
push eax
call _malloc ; eax - table's beginnig address
add esp, 4
pop ecx      ; ecx - m * n
mov edi, ecx ; edi - m * n
mov edx, 0
mov ebx, 1
push eax
table_loop:
mov dword ptr [eax], 0
push edi
sub edi, ecx     ; edi - loop counter
cmp edi, [ebp+8] ; if edi > m next
ja next
mov [eax], edi   ; first row: 0, 1, 2, ..., m
next:
pop edi
mov esi, [ebp+8] ; esi - m
inc esi
cmp edx, esi ; if edx = m + 1 next1
jnz next1
mov edx, 0
mov [eax], ebx
inc ebx
next1:
inc edx
add eax, 4
loop table_loop
pop eax ; table's beginnig address

pop edi
pop esi
pop ebx
pop ebp
ret
_create_and_initialise_a ENDP
END
