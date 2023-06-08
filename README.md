# Odległość-Levenshteina
Semestr 3 - Architektura Komputerów
---
Algorytm Levenshteina, służy do obliczenia odległości edycyjnej (odległości Levenshteina). Jest to najmniejsza liczba działań prostych (wstawienia nowego znaku, usunięcia lub zamiany znaku), prowadząca do przekształcenia jednego napisu w drugi.  
  
Idea algorytmu levenshtain polega na stworzeniu tablicy dwuwymiarowej, o wymiarach *m+1* na *n+1* gdzie *m* i *n* to odpowiednio długości porównywanych wyrazów (liczba znaków bez kończącego 0). Pierwszy wiersz i kolumnę tej tablicy uzupełniamy wartościami od 0 do, odpowiednio, *m* i *n* (funkcję realizującą to zadanie nazwijmy utworz_i_zainicjuj). Dla przykładu, dla łańcuchów "fakt" (m=4), "ako" (n=3) tabela po inicjacji wygląda jak poniżej. 

#### Pusta tabela:  
|     |   | _f_  | _a_ | _k_ | _t_ |
|-----|---|------|-----|-----|-----|
|     | 0 | 1    | 2   | 3   | 4   |
| _a_ | 1 | 0    | 0   | 0   | 0   |
| _k_ | 2 | 0    | 0   | 0   | 0   |
| _o_ | 3 | 0    | 0   | 0   | 0   |
  
<sub>Uwaga: znaki (litery) z łańcuchów podane są w celu łatwiejszego zobrazowania działania nie występują w tabeli!</sub>  
  
Następnie bierzemy po kolei wartości wiersza i porównujemy literę dotyczącą tego wiersza z literą dotyczącą kolumny. Dokonujemy porównania znaków na zasadzie każda z każdą. Przy każdym porównaniu wykonujemy poniższą procedurę (nazwaną dalej ustaw_ij):  

Daną komórkę wypełniamy wartością, którą będzie minimalna wartość z:  
- wartości komórki leżącej bezpośrednio nad naszą aktualną komórką, powiększoną o 1,
- wartości komórki leżącej bezpośrednio w lewo od naszej aktualnej komórki, powiększoną o 1,
- wartości komórki leżącej bezpośrednio w lewą górną stronę od aktualnej komórki, powiększoną o wartość kosztu. Jeśli literki są identyczne, ustawiamy koszt na 0, jeśli nie, na 1.  
  
Po wykonaniu wszystkich porównań, odległością edycyjną będzie wartość w komórce \[*m+1*, *n+1*\] <sub>(licząc komórki od 1)</sub>. Odległość Levenshteina dla analizowanego przykładu jest równa 2 (pogrubiona wartość).  

#### Wypełniona tabela:
|     |   | _f_  | _a_ | _k_ | _t_   |
|-----|---|------|-----|-----|-------|
|     | 0 | 1    | 2   | 3   | 4     |
| _a_ | 1 | 1    | 1   | 2   | 3     |
| _k_ | 2 | 2    | 2   | 1   | 2     |
| _o_ | 3 | 3    | 3   | 2   | **2** |

---

Napisz w 32-bitowym asemblerze funkcję przystosowaną do wywołania z poziomu języka C, która wyznaczy odległość Levenshteina, dla dwóch wejściowych łańcuchów w formacie UTF-16 (tylko znaku Unicode BMP).
```
unsigned int levenshtain (wchar_t* napisA, wchar_t* napisB);
```

Do realizacji tej funkcji należy wykorzystać trzy dostępne podprogramy: 

1. *lstrlenW* - funkcja określająca długość łańcucha UTF-16 (bez kończącego znaku 0), którego adres podany jest jako argument tej funkcji. Jest ona zakodowana zgodnie ze standardem WinAPI, a jej prototyp wygląda następująco: 
```
int lstrlenW (wchar_t* 1pString);
```
2. *utworz_i_zainicjuj* - funkcja zgodna ze standardem C, tworząca [tabelę](#pusta-tabela)  o wymiarach (*m+1*)x(*n+1*), tzn. <sup>(1)</sup> rezerwującą pamięć, <sup>(2)</sup> wypełniającą pierwszy wiersz i kolumnę właściwymi wartościami i <sup>(3)</sup> zerującą pozostałe elementy. Wymiary *m* i *n* przekazane są jako parametry, zaś wskaźnik na utworzoną tablicę zwracany jako wynik działania.
```
void utworz_i_zainicjuj(unsigned int m, unsigned int n);
```
3. *ustaw_ij* - funkcja przystosowana do wywołania z poziomu języka C wyznaczająca wartość odległości pomiędzy dwoma znakami *a* i *b* znajdującymi się odpowiednio na pozycji *i* i *j* łańcuchów bazowych (początkową pozycję w łańcuchu liczymy od 1) i umieści ją w tabeli na pozycji \[*i*,*j*\].
```
void ustaw_ij (void* tablica, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m);
```
<sub>Parametr *m* oznacza długość łańcucha z którego pochodzi pierwszy znak.</sub> 
