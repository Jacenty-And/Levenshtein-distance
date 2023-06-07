.686
.model flat
extern _malloc : PROC
public _levenshtain_a
public _lstrlenW_aa ; standard WinAPI
public _utworz_i_zainicjuj_aa
public _ustaw_ij_aa
.data
dlugoscA dd ?
dlugoscB dd ?
tablica  dd ?
napisA   dd ?
napisB   dd ?
.code
_utworz_i_zainicjuj_aa PROC
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
_utworz_i_zainicjuj_aa ENDP
_lstrlenW_aa PROC
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
_lstrlenW_aa ENDP
_ustaw_ij_aa PROC
;void ustaw_ij(int* tablica, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m) {
;	int x = tablica[i][j - 1] + 1;
;	int y = tablica[i - 1][j] + 1;
;	int z = tablica[i - 1][j - 1];
;	if (a != b) z += 1;
;	tablica[i][j] = min3(x, y, z);
push ebp
mov ebp, esp
push ebx
push ecx
push edx
push esi
push edi

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

pop edi
pop esi
pop edx
pop ecx
pop ebx
pop ebp
ret
_ustaw_ij_aa ENDP
_levenshtain_a PROC
;unsigned int levenshtain(wchar_t* napisA, wchar_t* napisB) {
;	unsigned int m = lstrlenW(napisA);
;	unsigned int n = lstrlenW(napisB);
;	int* tablica = utworz_i_zainicjuj(m, n);
;
;	for (unsigned int i = 1; i < n + 1; i++)
;		for (unsigned int j = 1; j < m + 1; j++)
;			ustaw_ij(tablica, napisA[j - 1], napisB[i - 1], i, j, m);
;	unsigned int odleglosc = tablica[n][m];
;
;	return odleglosc;

push ebp
mov ebp, esp

;	unsigned int m = lstrlenW(napisA);
mov esi, [ebp+8]  ; wchar_t* napisA
push esi
call _lstrlenW_aa
add esp, 4
mov [dlugoscA], eax

;	unsigned int n = lstrlenW(napisB);
mov edi, [ebp+12] ; wchar_t* napisB
push edi
call _lstrlenW_aa
add esp, 4
mov [dlugoscB], eax

;	int* tablica = utworz_i_zainicjuj(m, n);
push [dlugoscB]
push [dlugoscA]
call _utworz_i_zainicjuj_aa
add esp, 8
mov [tablica], eax

;	for (unsigned int i = 1; i < n + 1; i++)
;		for (unsigned int j = 1; j < m + 1; j++)
;			ustaw_ij(tablica, napisA[j - 1], napisB[i - 1], i, j, m);

;void ustaw_ij(int* tablica, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m) {
mov esi, [ebp+8]  ; wchar_t* napisA
mov [napisA], esi
mov edi, [ebp+12] ; wchar_t* napisB
mov [napisB], edi
mov ecx, [dlugoscB]
ptl1:
	push ecx
	mov edx, ecx       ; edx - i
	mov ecx, [dlugoscA] ; ecx - j
	ptl2:			    
		push [dlugoscA] ; unsigned int m

		mov edi, [dlugoscA]
		sub edi, ecx ; dlugoscA - j
		inc edi      ; zaczynamy od 1
		push edi     ; unsigned int j

		mov edi, [dlugoscB]
		sub edi, edx ; dlugoscB - i
		inc edi      ; zaczynamy od 1
		push edi     ; unsigned int i

		mov edi, [dlugoscB]
		sub edi, edx ; edi - numer litery
		shl edi, 1   ; litera - 2 bajty
		mov esi, [napisB]
		add esi, edi
		movzx edi, word ptr [esi]
		push edi   ; wchar_t b

		mov edi, [dlugoscA]
		sub edi, ecx ; edi - numer litery
		shl edi, 1   ; litera - 2 bajty
		mov esi, [napisA]
		add esi, edi
		movzx edi, word ptr [esi]
		push edi   ; wchar_t a
		
		push [tablica]  ; int* tablica

		call _ustaw_ij_aa	
		add esp, 24
	loop ptl2
	pop ecx
loop ptl1

;	unsigned int odleglosc = tablica[n][m];
;	return odleglosc;
mov eax, [dlugoscA]
inc eax
mov ebx, [dlugoscB]
inc ebx
mov edx, 0
mul ebx 
dec eax
mov esi, eax ; esi - ostatni element tablicy
shl esi, 2   ; esi * 4 - kazdy int 4 bajty
mov ebx, [tablica]
add ebx, esi
mov eax, [ebx]

pop ebp
ret
_levenshtain_a ENDP
END