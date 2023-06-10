# Levenshtein-distance
Semester 3 - Computer Architecture
---
Levenshtein algorithm, is used to calculate the edit distance (Levenshtein distance). It is the smallest number of simple actions (inserting a new character, deleting or replacing a character) leading to the transformation of one string into another.  
  
The idea of the levenshtain algorithm is to create a two-dimensional array, of size *m+1* by *n+1* where *m* and *n* are respectively the lengths of the words being compared (the number of characters without a terminating null). We populate the first row and column of this array with values from 0 to *m* and *n*, respectively (let's call the function performing this task *create_and_initialise*). For example, for the strings "fact" (m=4), "ako" (n=3) the table after initialisation looks like the following. 

#### Empty table:  
|     |   | _f_  | _a_ | _c_ | _t_ |
|-----|---|------|-----|-----|-----|
|     | 0 | 1    | 2   | 3   | 4   |
| _a_ | 1 | 0    | 0   | 0   | 0   |
| _k_ | 2 | 0    | 0   | 0   | 0   |
| _o_ | 3 | 0    | 0   | 0   | 0   |
  
<sub>Note: the characters from the strings are given to make it easier to illustrate the action and do not appear in the table!</sub>  
  
Then we take the row values one at a time and compare the letter relating to that row with the letter relating to the column. We make character comparisons on an each-to-any basis. For each comparison, we execute the following procedure (hereafter called *set_ij*):  

We fill the given cell with a value, which will be the minimum value from:  
- the value of the cell lying directly above our current cell, incremented by 1,
- the value of the cell lying directly to the left of our current cell, incremented by 1,
- the value of the cell lying directly to the top left of our current cell, increased by the cost value. If the letters are identical, we set the cost to 0, if not, to 1.  
  
After all comparisons have been made, the edit distance will be the value in cell \[*m+1*, *n+1*\] <sub>(cells are counted from 1)</sub>. The Levenshtein distance for the given example is equal to 2 (bold value).

#### Filled table:  
|     |   | _f_  | _a_ | _c_ | _t_   |
|-----|---|------|-----|-----|-------|
|     | 0 | 1    | 2   | 3   | 4     |
| _a_ | 1 | 1    | 1   | 2   | 3     |
| _k_ | 2 | 2    | 2   | 1   | 2     |
| _o_ | 3 | 3    | 3   | 2   | **2** |

---

Write a function in 32-bit assembler suitable for calling from the C language level to determine the Levenshtein distance, for two input strings in UTF-16 format (Unicode BMP character only).  
```
unsigned int levenshtein (wchar_t* stringA, wchar_t* stringB);
```

Three subprograms should be used to perform this function:  

1. *lstrlenW* - function that specifies the length of a UTF-16 string (without the terminating null character) whose address is given as an argument to this function. It is encoded according to the WinAPI standard, and its prototype looks as follows:  
```
int lstrlenW (wchar_t* lpString);
```
2. *create_and_initialise* - function according to the C standard that creates a [table](#empty-table) with size (*m+1*)x(*n+1*), <sup>(1)</sup> reserve the memory, <sup>(2)</sup> fill the first row and column with calculated values, <sup>(3)</sup> zeroing the remaining elements. Sizes *m* and *n* are passed as arguments, and the pointer to the created table is returned by the function.  
```
void create_and_initialise(unsigned int m, unsigned int n);
```
3. *set_ij* - function adapted to be called from the C language level that determines the value of the distance between the two characters *a* and *b* located respectively at the *i* and *j* positions of the base strings (the initial position in the string is counted from 1) and will place it in the table at position \[*i*,*j*\].
```
void set_ij (void* table, wchar_t a, wchar_t b, unsigned int i, unsigned int j, unsigned int m);
```
<sub>The *m* parameter indicates the length of the string from which the first character comes.</sub> 