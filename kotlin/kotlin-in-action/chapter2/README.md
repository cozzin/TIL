# 2장. 코틀린 기초

## 2.1 기본 요소: 함수와 변수

### 2.1.1 Hello, World!

```kt
fun main() {
    println("Hello, world!!!")
}
```

- 함수를 최상위 수준에 정의할 수 있음 (Java와 다른점)

### 2.1.2 함수

- 코드를 대화형으로 호출할 수 있는 코틀린 REPL을 여기서 써보게 된다. 
- 내 환경에는 `kotlinc`를 여기서 써보는데 일단 설치가 안되어 있어서 [여기 링크](https://kotlinlang.org/docs/command-line.html#homebrew) 보면서 설치했다.
- mac에서는 homebrew로 설치하는게 버전관리가 되어서 깔끔할듯

```bash
$ brew update
$ brew install kotlin # arch -arm64 brew install
```

m1 mac 사용자의 경우

```bash
$ brew update
$ arch -arm64 brew install
```

연습해보기

```kt
 ernest.hong@Ernest  ~  kotlinc
Welcome to Kotlin version 1.6.21 (JRE 18.0.1.1+0)
Type :help for help, :quit for quit
>>> fun max(a: Int, b: Int): Int { // 여기까지 입력하고 엔터치면 입력이 완료되지 않았기 때문에 다음줄 입력을 기다린다 (... 으로 표시됨)
...     return if (a>b) a else b
... }
>>> printlin(max(1, 2)) //  여기서 오타를 냈다 😅 그러면 아래와 같이 친절하게 알려준다
error: unresolved reference: printlin
printlin(max(1, 2))
^

>>> println(max(1, 2))
2
>>> :quit // 프로그램을 종료하려면 이렇게 입력하면 된다
```

여기서 좀 특이한걸 볼 수 있는데 if 다음에 return이 따로 없다. 책에서는 이렇게 설명한다.

> 코틀린 if는 문장(statement)이 아니고 식(expression)이라는 점이 흥미롭다.
> 이 예제의 코틀린 if 식은 자바 3항 연산자로 작성한 (a>b) ? a : b 식과 비슷하다. (p.62)

#### Kotlin - if

- if: 식(expression)
- 식(expression)은 값을 만들어냄
- return 필요없음

#### Java - if

- if: 문장(statement)
- 문장(statement)은 값을 만들어내지 않음
- return 필요함

> 반면 대입문은 자바에서는 식이었으나 코틀린에서는 문이 됐다. 그로 인해 자바와 달리 대입식과 비교식을 잘못 바꿔 써서 버그가 생기는 경우가 없다.

`반면 대입문은 자바에서는 식이었으나 코틀린에서는 문이 됐다.` <- 이 말은 아직 제대로 이해못했다

#### 식이 본문인 함수

```kt
fun max(a: Int, b: Int): Int = if (a>b) a else b
```

컴파일러가 타입 유추할 수 있기 때문에, 반환 타입 생략가능. expression이기 때문에 반환 타입을 생략할 수 있는 듯

```kt
fun max(a: Int, b: Int) = if (a>b) a else b
```

### 2.1.3 변수

- `val`: value. immutable
- `var`: variable. mutable

#### Tip
- 그런데 아무리 `val`로 되어 있어도 레퍼런스 타입을 가리키는거면 클래스 내부는 당연히 변경 가능.
- 기본적으로는 `val` 사용해서 불변으로 사용하고, 필요할 때 `var`로 변경하는 것 추천. 이건 Swift에서도 비슷한 개념이었다.

