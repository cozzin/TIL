# ch01 연습문제

## 1. 정수를 읽어서 2진수, 8진수, 16진수로 출력하는 프로그램을 작성하라. 읽어 온 정수의 역수를 16진 부동소수점 수로 출력하라.

```java
public class Exercise01 {
    public static void main(String[] args) {
        for (int input : new int[]{2, 10, 15}) {
            System.out.println(Integer.toBinaryString(input));
            System.out.println(Integer.toOctalString(input));
            System.out.println(Integer.toHexString(input));
            System.out.println(Float.toHexString(-input));
            System.out.println();
        }
    }
}
```

## 2

```java
public class Exercise02 {
    public static void main(String[] args) {
        for (int input : new int[]{-1231, -1, 0,  1, 359, 360}) {
            System.out.printf("input: %d, mod: %d, floorMod: %d", input, input % 360, Math.floorMod(input, 360));
            System.out.println();
        }
    }
}
```

```console
input: -1231, mod: -151, floorMod: 209
input: -1, mod: -1, floorMod: 359
input: 0, mod: 0, floorMod: 0
input: 1, mod: 1, floorMod: 1
input: 359, mod: 359, floorMod: 359
input: 360, mod: 0, floorMod: 0
```
