[[RegEx Pattern meanings]]

## Assignment 1

| Task  | Text    |
| ----- | ------- |
| match | abcdefg |
| match | abcde   |
| match | abc     |

### My solution

```
([a-z]+)
```


## Assignment 2

| Task  | Text         |
| ----- | ------------ |
| match | abc123xyz    |
| match | define "123" |
| match | var g = 123; |

### My solution

```
.+
```


Or:

```
.*
```


Or: 

```
[a-z\s"\d+=;]*
```


## Assignment 3

| Task  | Text |
| ----- | ---- |
| match | cat  |
| match | 856  |
| match | ?=+. |
| skip  | abc1 |

### My solution

```
([^abc1]+)
```


Or:

```
...\.
```


## Assignment 4

| Task  | Text |
| ----- | ---- |
| match | can  |
| match | man  |
| match | fan  |
| skip  | dan  |
| skip  | ran  |
| skip  | pan  |

### My solution

```
[^drp]an
```


Or:

```
[cmf] an
```


## Assignment 5


| Task  | Text |
| ----- | ---- |
| match | hog  |
| match | dog  |
| skip  | bog  |

### My solution


```
[hd]og
```



Or:

```
[^b]og
```


## Assignment 6


| Task  | Text |
| ----- | ---- |
| match | Ana  |
| match | Bob  |
| match | Cpc  |
| skip  | aax  |
| skip  | bby  |
| skip  | ccz  |


### My Solution

```
[A-C][n-p][a-c]
```



## Assignment 7


| Task  | Text      |
| ----- | --------- |
| match | wazzzzzup |
| match | wazzzup   |
| skip  | wazup     |



### My solution

```
waz{3,5}up
```




## Assignment 8

| Task  | Text    |
| ----- | ------- |
| match | aaaabcc |
| match | aabbbb  |
| match | aacc    |
| skip  | a       |

### My solution

```
a{2,4}b{0,4}c{1,2}
```


Or:

```
aa+b*c+
```


## Assignment 9

| Task  | Text            |
| ----- | --------------- |
| match | 1 file found?   |
| match | 2 files found?  |
| match | 24 files found? |
| skip  | no files found. |


### My solution

```
\d+ files? found\?
```



## Assignment 10

| Task  | Text      |
| ----- | --------- |
| match | 1.    abc |
| match | 2.   abc  |
| match | 3     abc |
| skip  | 4.abc     |


### My solution

```
.\s+
```



## Assignment 11


| Task  | Text                                            |
| ----- | ----------------------------------------------- |
| match | Mission: Successul                              |
| skip  | Last Mission: unsuccessful                      |
| skip  | Next Mission: successful upon capture of target |

### My solution

```
^Mission: successful$
```


## Assignment 12

| Task  | Text                       |
| ----- | -------------------------- |
| match | file_record_transcript.pdf |
| match | file_0724199.pdf           |
| skip  | testfile_fake.pdf.tmp      |


### My solution

```
([a-z_\d+]+).pdf$
```


or 


```
^(file.+)\.pdf$
```



## Assignment 13

| Task  | Text     |
| ----- | -------- |
| match | Jan 1987 |
| match | May 1969 |
| match | Aug 2011 |

### My solution

```
(\w+ (\d+))
```



## Assignment 14

| Task  | Text      |
| ----- | --------- |
| match | 1280x720  |
| match | 1920x1600 |
| match | 1024x768  |


### My Solution

```
(\d+)x(\d+)
```



## Assignment 15

| Task  | Text        |
| ----- | ----------- |
| match | I love dogs |
| match | I love cats |
| skip  | I love logs |
| skip  | I love cogs |


### My solution


```
I love (cats|dogs)
```



## Assignment 16

| Task  | Text                                                         |
| ----- | ------------------------------------------------------------ |
| match | The quick brown fox jumps over the lazy dog.                 |
| match | There were 614 instances of students getting 90.0% or above. |
| match | The FCC had to censor the network for saying &$#*@!.         |


### My solution

```
.+
```


Or:

```
.*
```


Or:

```
([A-z\s\d+\.\%+ &\$#\*@!]+)
```