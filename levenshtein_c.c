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
void* create_and_initialise_a(unsigned int m, unsigned int n);
void* create_and_initialise(unsigned int m, unsigned int n) {
	int** table = (int**)malloc((n + 1) * sizeof(int*));
	for (unsigned int i = 0; i < n + 1; i++)
		table[i] = (int*)malloc((m + 1) * sizeof(int));
	for (unsigned int i = 0; i < n + 1; i++)
		for (unsigned int j = 0; j < m + 1; j++) {
			if (i == 0)
				table[0][j] = j;
			else if (j == 0)
				table[i][0] = i;
			else
				table[i][j] = 0;
		}
	return table;
}
int min3(int a, int b, int c) {
	int buffer = a;
	if (b < buffer) buffer = b;
	if (c < buffer) buffer = c;
	return buffer;
}
void set_ij_a(int* table, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m);
void set_ij(int** table, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m) {
	int x = table[i][j - 1] + 1;
	int y = table[i - 1][j] + 1;
	int z = table[i - 1][j - 1];
	if (a != b) z += 1;
	table[i][j] = min3(x, y, z);
}
unsigned int levenshtein_a(wchar_t* stringA, wchar_t* stringB);
unsigned int levenshtein(wchar_t* stringA, wchar_t* stringB) {
	unsigned int m = lstrlenW(stringA);
	unsigned int n = lstrlenW(stringB);
	int** table = (int**)create_and_initialise(m, n);

	for (unsigned int i = 1; i < n + 1; i++)
		for (unsigned int j = 1; j < m + 1; j++)
			set_ij(table, stringA[j - 1], stringB[i - 1], i, j, m);
	unsigned int distance = table[n][m];

	for (unsigned int i = 0; i < n + 1; i++) {
		for (unsigned int j = 0; j < m + 1; j++)
			printf("%d ", table[i][j]);
		printf("\n");
	}

	for (int i = 0; i < n + 1; i++)
		free(table[i]);
	free(table);

	return distance;
}
int main() {
	printf("%d\n", levenshtein(L"fakty", L"aktywa"));
	printf("%d", levenshtein_a(L"fakty", L"aktywacja"));
	//printf("%d", levenshtein_a(L"jacenty", L"jacek"));
	/*int table[6][8] = { { 0, 1, 2, 3, 4, 5, 6, 7 },
					      { 1, 0, 1, 2, 3, 4, 5, 6 },
					      { 2, 1, 0, 1, 2, 3, 4, 5 },
					      { 3, 2, 1, 0, 1, 2, 3, 4 },
					      { 4, 3, 2, 1, 0, 1, 2, 3 },
					      { 5, 4, 3, 2, 1, 1, 2, 3 }, };*/
	int table[6][8] = { { 0, 1, 2, 3, 4, 5, 6, 7 },
					      { 1, 0, 0, 0, 0, 0, 0, 0 },
					      { 2, 0, 0, 0, 0, 0, 0, 0 },
					      { 3, 0, 0, 0, 0, 0, 0, 0 },
					      { 4, 0, 0, 0, 0, 0, 0, 0 },
					      { 5, 0, 0, 0, 0, 0, 0, 0 }, };

	int* table_a = (int*)create_and_initialise_a(7, 5);
	printf("\n");
	printf("empty table_a\n");
	for (unsigned int i = 0; i < 5 + 1; i++) {
		for (unsigned int j = 0; j < 7 + 1; j++)
			printf("%d ", table_a[i * 8 + j]);
		printf("\n");
	}

	printf("\n");
	printf("empty table\n");
	for (unsigned int i = 0; i < 5 + 1; i++) {
		for (unsigned int j = 0; j < 7 + 1; j++)
			printf("%d ", table[i][j]);
		printf("\n");
	}
	wchar_t* a = L"jacenty";
	wchar_t* b = L"jacek";
	levenshtein_a(a, b);
	for (unsigned int i = 1; i < lstrlenW_a(b) + 1; i++)
		for (unsigned int j = 1; j < lstrlenW_a(a) + 1; j++)
			set_ij_a(table, a[j - 1], b[i - 1], i, j, lstrlenW_a(a));
	printf("\n");
	printf("table set_ij_a\n");
	for (unsigned int i = 0; i < 5 + 1; i++) {
		for (unsigned int j = 0; j < 7 + 1; j++)
			printf("%d ", table[i][j]);
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
