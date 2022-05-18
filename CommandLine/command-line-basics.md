# Command Line Basics

[https://www.raywenderlich.com/4729-command-line-basics](https://www.raywenderlich.com/4729-command-line-basics)

## Man Pages

명령어 사용법 살펴보기

```
$ man man
```

```
NAME
       man - format and display the on-line manual pages

SYNOPSIS
       man [-acdfFhkKtwW] [--path] [-m system] [-p string] [-C config_file] [-M pathlist] [-P pager] [-B browser] [-H
 htmlpager] [-S section_list] [section] name
       ...
```

- 마우스 스크롤 해서 위아래로 내릴 수 있음
- `q`를 써서 종료

## Navigation

- `pwd`: 현재 위치한 폴더 알아보기
- `cd <destination-path>`: `<destination-path>`로 이동하기
- `clear`: 화면정리

### ls 사용법 찾아보기

```
$ man ls
```

```
NAME
     ls – list directory contents

SYNOPSIS
     ls [-@ABCFGHILOPRSTUWabcdefghiklmnopqrstuvwxy1%,] [--color=when] [-D format] [file ...]

DESCRIPTION
     For each operand that names a file of a type other than directory, ls displays its name as well as
     any requested, associated information.  For each operand that names a file of type directory, ls
     displays the names of files contained within that directory, as well as any requested, associated
     information.

     If no operands are given, the contents of the current directory are displayed.  If more than one
     operand is given, non-directory operands are displayed first; directory and non-directory operands
     are sorted separately and in lexicographical order.
```

### `ls -a`: 숨겨진 파일도 리스트에 포함하기

```
     -A      Include directory entries whose names begin with a dot (‘.’) except for . and ...
             Automatically set for the super-user unless -I is specified.
```

```
$ ls -a
.                .git             Book             DepedencyManager _config.yml
..               .github          CI               README.md        _includes
.DS_Store        .gitignore       CommandLine      Spring           단어장.md
```

- `.`: 현재 폴더를 의미함
- `..`: 상위 폴더를 의미함

## Creation and Destruction

```shell
mkdir folder_name # 폴더 생성
cd folder_name # 폴더 이동
touch file_name # 파일 생성
open . # 현재 위치 폴더 열기
cp original_file copied_file # 파일 복붙
rm file_name_to_remove # 파일 삭제
rm -r folder_name # 폴더 및 폴더 내 파일 삭제 (recursively)
```
