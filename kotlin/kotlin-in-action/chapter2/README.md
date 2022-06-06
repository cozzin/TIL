# [kotlin in action] 2장. 코틀린 기초

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

`반면 대입문은 자바에서는 식이었으나 코틀린에서는 문이 됐다.` <- 🤔 이 말은 아직 제대로 이해못했다

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

🤔 재미로 해봤는데, 코드 블럭 one line으로 표현은 안된다

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

코틀린 파일의 상단에 이런식으로 들어간다

```kt
package geometry.shapes // 패키지 선언
import java.util.Random // 표준 자바 라이브러리 클래스를 임포트
```

- 🤔 iOS 개발과는 다른점이 패키지 구조가 있다는 점인데, 파일 구조를 그대로 따라서 패키지에 담아주지 않고 파일 상단에 패키지 선언을 굳이 하는 이유가 궁금하다
- [TIP] 자바와 코틀린을 함께 사용하는 프로젝트에서는 자바의 방식을 따르는 게 중요하다. 자바의 방식을 따르지 않으면 자바 클래스를 코틀린 클래스로 마이그레이션할 때 문제가 생길 수도 있다. (p.76)

## 2.3 선택 표현과 처리: enum과 when

- 코틀린에서 enum은 소프트 키워드
- enum은 클래스 앞에 있을 때는 특별한 의미, 그러나 다른 곳에서는 이름에 사용될 수 있음

```kt
enum class Color {
    RED, ORANGE, YELLOW, GREEN, BLUE, INDIGO, VIOLET
}
```

```kt
enum class Color(
    val r: Int, val g: Int, val b: Int
) {
    RED(255, 0, 0), ORANGE(255, 165, 0),
    YELLOW(255, 255, 0), GREEN(0, 255, 0); // 여기에 세미콜론을 반드시 써야함 🤔 이유가 뭘까??
    
    fun rgb() = (r * 256 + g) * 256 + b // enum 안에서 메서드 정의
}
```

```kt
import ch02.colors.Color

fun getWarmth(color: Color) = when(color) {
    Color.RED, Color.ORANGE -> "warm" 
    Color.GREEN -> "neutral"
    Color.BLUE, Color.INDIGO, Color.VIOLT -> "cold"
}
```

```kt
import ch02.colors.Color.* // 짧은 이름으로 사용하기 위해 enum 상수를 모두 임포트

fun getWarmth(color: Color) = when(color) {
    RED, ORANGE -> "warm" 
    GREEN -> "neutral"
    BLUE, INDIGO, VIOLT -> "cold"
}
```

### 2.3.5 스마트 캐스트

- is로 검사하고 나면 굳이 변수를 원하는 타입으로 캐스팅하지 않아도 마치 처음부터 그 변수가 원하는 타입으로 선언된 것 처럼 사용할 수 있다.
- 하지만 실제로는 컴파일러가 캐스팅을 수행해준다. (p.85)

```kt
fun eval(e: Expr): Int {
    if (e is Sum) {
        return eval(e.right) + eval(e.left) // e는 Sum으로 캐스팅된 상태
    }
}
```

## 2.4 대상을 이터레이션: while과 for 루프

### 2.4.2 수에 대한 이터레이션: 범위와 수열

#### 1 부터 100까지 루프

```kt
for (i in 1..100) {
    print(fizzBuzz(i))
}
```

#### 100 부터 1까지 2간격으로 루프

```kt
for (i in 100 downTo 1 step 2) {
    print(fizzBuzz(i))
}
```

#### 0부터 n-1 까지 루프

```kt
for (x in 0 until size)
```

```kt
for (x in 0..size-1)
```

#### 인덱스와 함께 이터레이션

- `list.withIndex()`
- Swift의 `enumeration()`과 같은 기능. 나는 `withIndex()`가 더 직관적으로 느껴짐

### 2.4.4 in으로 컬렉션이나 범위의 원소 검사

- `in`: 어떤 값이 범위에 속하는지 검사
- `!in`: 어떤 값이 범위에 속하지 않는지 검사
- 비교가 가능한 클래스라면(java.lang.Comparable 인터페이스를 구현한 클래스라면) 객체를 사용해 범위를 만들 수 있음

```kt
fun isLetter(c: Char) = c in 'a'..'z' // 이거랑 동일함 'a' <= c && c <= 'z'
fun isNotDigit(c: Char) = c !in '0'..'9'
```

## 2.5 코틀린의 예외 처리

-  함수 호출 스택을 거슬러 올라가면서 예외를 처리하는 부분이 나올 때까지 예외를 다시 던진다(rethrow) (p.96)

### 2.5.1 try, catch, finally

```kt
fun readNumber(reader: BufferedReader): Int? { // 코틀린에서 예외 명시가 없음. 🤔 불편할 것 같은데... 이게 진짜 좋은걸까?
    try {
        val line = reader.readLine()
        return Integer.parseInt(line)
    }
    catch (e: NumberFormatException) {
        return null
    }
    finally {
        reader.close()
    }
}
```

- 코틀린에서는 함수가 던지는 예외를 지정하지 않고 발생한 예외를 잡아내도 되고 잡아내지 않아도 된다. 
  - 🤔 이거 근데 그러면 서비스 운영하다가 실수로 에러 터지는거 아닌가?
- 자바는 체크 예외 처리를 강제한다. 하지만 프로그래머들이 의미 없이 예외를 다시 던지거나 ... 그로 인해 예외 처리 규칙이 실제로는 오류 발생을 방지하지 못하는 경우가 자주 있다. 
  - 🤔 그런데 오류 발생을 방지하지 못하는건 실수일 뿐인데, 함수가 에러를 발생하는지 표시 안해주면 더 위험해지는 것 같은데 실제로는 어떨까?
- 하지만 실제 스트림을 닫다가 실패하는 경우 특별히 스트림을 사용하는 클라이언트 프로그램이 취할 수 있는 의미 있는 동작은 없다. 그러므로 이 IOException을 잡아내는 코드는 그냥 불필요하다.
  - 🤔 정말로 항상 불필요한건지 찾아봐야할 듯
