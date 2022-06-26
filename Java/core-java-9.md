# 코어 자바 9

### 1.5.5 문자열 API

- 자바에서 String 클래스는 불변(immutable)
- CharSequence: String, StringBuilder, 문자 시퀀스의 supertype

### 1.5.6 코드 포인트와 코드 유닛

- UTF-16. 가변길이, 하위 호완성 지원
- 현재 유니코드는 21비트를 요구함. 유효한 유니코드 값을 `코드 포인트(code point)`라고 한다.

#### 16비트 안에서 표현가능한 문자만 있다면

```java
// i번쨰 문자
char ch = str.chatAt(i);

// 문자열의 길이
int length = str.length();
```

#### 문자열을 제대로 처리하려면

```java
// i번쨰 유니코드의 코드 포인트
int codePoint = str.codePointAt(str.offsetByCodePoints(0, i));

// 코드 포인트의 총 수
int length = str.codePointCount(0, str.length());
```
