#include <stdio.h>
//#include <stdlib.h>
//int tab[5][4] = { 0, 1, 2, 3, 4,
//				    1, 1, 1, 2, 3,
//				    2, 2, 2, 1, 2,
//				    3, 3, 3, 2, 2, };
int lstrlenW_a(wchar_t* lpString);
int lstrlenW(wchar_t* lpString) {
	for (int i = 0; ; i++) if (lpString[i] == 0) return i;
}
void* utworz_i_zainicjuj_a(unsigned int m, unsigned int n);
void* utworz_i_zainicjuj(unsigned int m, unsigned int n) {
	int** tablica = (int**)malloc((n + 1) * sizeof(int*));
	for (unsigned int i = 0; i < n + 1; i++)
		tablica[i] = (int*)malloc((m + 1) * sizeof(int));
	for (unsigned int i = 0; i < n + 1; i++)
		for (unsigned int j = 0; j < m + 1; j++) {
			if (i == 0)
				tablica[0][j] = j;
			else if (j == 0)
				tablica[i][0] = i;
			else
				tablica[i][j] = 0;
		}
	return tablica;
}
int min3(int a, int b, int c) {
	int bufor = a;
	if (b < bufor) bufor = b;
	if (c < bufor) bufor = c;
	return bufor;
}
void ustaw_ij_a(int* tablica, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m);
void ustaw_ij(int** tablica, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m) {
	int x = tablica[i][j - 1] + 1;
	int y = tablica[i - 1][j] + 1;
	int z = tablica[i - 1][j - 1];
	if (a != b) z += 1;
	tablica[i][j] = min3(x, y, z);
}
unsigned int levenshtain_a(wchar_t* napisA, wchar_t* napisB);
unsigned int levenshtain(wchar_t* napisA, wchar_t* napisB) {
	unsigned int m = lstrlenW(napisA);
	unsigned int n = lstrlenW(napisB);
	int** tablica = (int**)utworz_i_zainicjuj(m, n);

	for (unsigned int i = 1; i < n + 1; i++)
		for (unsigned int j = 1; j < m + 1; j++)
			ustaw_ij(tablica, napisA[j - 1], napisB[i - 1], i, j, m);
	unsigned int odleglosc = tablica[n][m];

	for (unsigned int i = 0; i < n + 1; i++) {
		for (unsigned int j = 0; j < m + 1; j++)
			printf("%d ", tablica[i][j]);
		printf("\n");
	}

	for (int i = 0; i < n + 1; i++)
		free(tablica[i]);
	free(tablica);

	return odleglosc;
}
int main() {
	printf("%d\n", levenshtain(L"fakty", L"aktywa"));
	printf("%d", levenshtain_a(L"fakty", L"aktywacja"));
	//printf("%d", levenshtain_a(L"jacenty", L"jacek"));
	/*int tablica[6][8] = { { 0, 1, 2, 3, 4, 5, 6, 7 },
					      { 1, 0, 1, 2, 3, 4, 5, 6 },
					      { 2, 1, 0, 1, 2, 3, 4, 5 },
					      { 3, 2, 1, 0, 1, 2, 3, 4 },
					      { 4, 3, 2, 1, 0, 1, 2, 3 },
					      { 5, 4, 3, 2, 1, 1, 2, 3 }, };*/
	int tablica[6][8] = { { 0, 1, 2, 3, 4, 5, 6, 7 },
					      { 1, 0, 0, 0, 0, 0, 0, 0 },
					      { 2, 0, 0, 0, 0, 0, 0, 0 },
					      { 3, 0, 0, 0, 0, 0, 0, 0 },
					      { 4, 0, 0, 0, 0, 0, 0, 0 },
					      { 5, 0, 0, 0, 0, 0, 0, 0 }, };

	int* tablica_a = (int*)utworz_i_zainicjuj_a(7, 5);
	printf("\n");
	printf("pusta tablica_a\n");
	for (unsigned int i = 0; i < 5 + 1; i++) {
		for (unsigned int j = 0; j < 7 + 1; j++)
			printf("%d ", tablica_a[i * 8 + j]);
		printf("\n");
	}

	printf("\n");
	printf("pusta tablica\n");
	for (unsigned int i = 0; i < 5 + 1; i++) {
		for (unsigned int j = 0; j < 7 + 1; j++)
			printf("%d ", tablica[i][j]);
		printf("\n");
	}
	wchar_t* a = L"jacenty";
	wchar_t* b = L"jacek";
	levenshtain_a(a, b);
	for (unsigned int i = 1; i < lstrlenW_a(b) + 1; i++)
		for (unsigned int j = 1; j < lstrlenW_a(a) + 1; j++)
			ustaw_ij_a(tablica, a[j - 1], b[i - 1], i, j, lstrlenW_a(a));
	printf("\n");
	printf("tablica wypelniona przez ustaw_ij_a\n");
	for (unsigned int i = 0; i < 5 + 1; i++) {
		for (unsigned int j = 0; j < 7 + 1; j++)
			printf("%d ", tablica[i][j]);
		printf("\n");
	}
	return 0;
}

//     j a c e n t y 
//   0 1 2 3 4 5 6 7
// j 1 0 1 2 3 4 5 6
// a 2 1 0 1 2 3 4 5
// c 3 2 1 0 1 2 3 4
// e 4 3 2 1 0 1 2 3
// k 5 4 3 2 1 1 2 3