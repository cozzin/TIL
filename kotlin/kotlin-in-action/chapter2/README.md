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

### 2.1.4 더 쉽게 문자열 형식 지정: 문자열 템플릿

```kt
"Hello, $name"
"Hello, ${args[0]}"
"${args[0]}님 반가워요"
"$name 반가워요 ${if (true) "정말로" else "아니야사실"}" // hi 반가워요 정말로
```

## 2.2 클래스와 프로퍼티

Java Bean 클래스

```java
public class Person {
    private final String name;

    public Person(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
```

코틀린으로 표현하면 이렇게 간단함!!

```kt
class Person(val name: String)
```

- 코틀린의 기본 가시성은 public, 변경자를 생략해도 됨

### 2.2.1 프로퍼티

- 프로퍼티 = 필드 + 접근자

```kt
class Person (
    val name: String, // read-only. (private) field. (public) getter
    var isMarried: Boolean // read-write. (private) field. (public) getter. (public) setter
)
```

```kt
val person = Person("Bob", true)
println(person.name) // Bob
println(person.isMarried) // true
```

#### 코틀린 클래스를 자바에서 쓸 때

- getter에는 get이 붙지 않음 => `isMarried`
- setter에는 is를 set으로 바꾼 이름을 사용 => `setMarried` 

#### 자바 클래스를 코틀린에서 쓸 때

- (java) `setName`, `getName` => (kotlin) `name`
- (java) `isMarried`, `setMarrid` => (kotlin) `isMarried`

### 2.2.2 커스텀 접근자

이것만 봤을 때는 그다지 간결해보이지는 않는다...

```kt
class Rectangle(val height: Int, val width: Int) {
    val isSquare: Boolean
        get() {
            return height == width
        }
}
```
이렇게 할수도 있다고 한다! 한결 낫다

```kt
val isSquare: Boolean
    get() = height == width
```

재미로 해봤는데, 코드 블럭 one line으로 표현은 안된다

```kt
val isSquare: Boolean
    get() { height == width } // ❌ 컴파일 에러
```

> 일반적으로 클래스의 특성(프로퍼티에는 특서잉라는 뜻이 있다)을 정의하고 싶다면 프로퍼티로 그 특성을 정의해야 한다. (p.74)

이게 재밌는 부분이었는데 computed property로 해도 되고 파라미터가 없는 함수를 만들어도 상관 없는 경우가 있다. 예를 들어 위의 프로퍼티를 아래와 같이 만들어도 성능 차이는 없다.
하지만 클래스의 속성이면 프로퍼티를 쓰라고 저자는 제안한다. 클래스 설계할 때 한번 고민해봐도 좋을 듯 하다.

```kt
fun isSquare(): Boolean = height == width
```

### 2.2.3 코틀린 소스코드 구조: 디렉터리와 패키지

