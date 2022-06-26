# Debug Swift debugging with LLDB

external framework를 link하고 나서 디버깅 불가능한 경우가 있음

![](/assets/images/2022-06-26-22-33-56.png)

Swift Compiler -> 기계어로 번역할 때 `__dbug_info`가 생성되는데 이걸 `.dSYM`에 매핑시킴

![](/assets/images/2022-06-26-22-36-19.png)

일단 LLDB가 framework의 dSYM을 적절하게 찾았는지 확인해야한다: `image list` command로 할 수 있음.
여기서 예시로 든 framework 이름은 TerminalInterface 


```
(lldb) image list TerminalInterface
```

dSYM 파일은 적절하게 찾았음을 확인할 수 있다

![](/assets/images/2022-06-26-22-39-24.png)

그럼 이제 `image lookup` 을 써보자. 현재 address를 넣으면 됨

![](/assets/images/2022-06-26-22-44-31.png)

```
(lldb) image lookup -va 0x100176989
```

확인해보면 로컬 머신이 아니라 빌드 서버를 포인트하고 있어서 lldb가 제대로 작동하지 않는 것이었음

![](/assets/images/2022-06-26-22-45-38.png)

이걸 고칠 수 있음! LLDB는 built-in source map을 가지고 있어서 redirect 할 수 있음

```
(lldb) setting list target.source-map
```

![](/assets/images/2022-06-26-22-47-59.png)

Scheme Setting > LLDB Init File

파일 하나 만들어서 source-map 지정해주면 됨

![](/assets/images/2022-06-26-22-48-31.png)

![](/assets/images/2022-06-26-22-49-00.png)

![](/assets/images/2022-06-26-22-49-38.png)

그리고 나서 프로젝트 다시 실행 

그러면 소스코드로 제대로 들어가짐

![](/assets/images/2022-06-26-22-51-19.png)

### Source path remapping

#### Customizable LLDB setting

```
settings set target.source-map prefix new
```

#### XML `<UUID>.plist` in `.dSYM` bundle

```
DBGSourcePathRemapping dictionary
```

![](/assets/images/2022-06-26-22-54-48.png)


## Source path canonicalization

![](/assets/images/2022-06-26-22-55-48.png)

무튼 `po words`는 여전히 안되는 짜증나는 상황

![](/assets/images/2022-06-26-22-56-28.png)

`frame variable words`, `v words`는 되네

![](/assets/images/2022-06-26-22-57-24.png)

po 왜 안먹히는지 알아보자

![](/assets/images/2022-06-26-22-58-35.png)

LLDB는 Debugger 이면서 Compiler. 
Debugger의 기능을 다 쓰기 위해서는 LLDB는 Swift와 Clang compiler 모든 기능 copy를 포함해야한다.

![](/assets/images/2022-06-26-23-00-32.png)

타입 정보가 있어야 함

![](/assets/images/2022-06-26-23-01-51.png)

LLDB는 타입정보를 `__debug_info`에서 가져옴

![](/assets/images/2022-06-26-23-02-21.png)

또한 LLDB는 Swift reflection metadata로부터 타입을 가져옴

![](/assets/images/2022-06-26-23-03-28.png)

컴파일러 사이드에서는 모듈에서 가져옴.
이러한 구분은 `Xcode 14` 부터 적용됨

## swift-healthcheck

![](/assets/images/2022-06-26-23-05-04.png)

![](/assets/images/2022-06-26-23-05-25.png)

![](/assets/images/2022-06-26-23-05-42.png)

healthcheck 로그 마지막 부분을 보면 LLDB가 `TerminalUI` Swift module를 import하지 못했음을 알 수 있다

![](/assets/images/2022-06-26-23-08-22.png)

![](/assets/images/2022-06-26-23-08-36.png)

## Register Swift modules with the Linker

```
ld ... -add-ast-path /path/to/My.swiftmodule
```

![](/assets/images/2022-06-26-23-11-26.png)

이거 뭐하는건지 잘 이해못함

## Avoding seiralized search paths in Swift modules

![](/assets/images/2022-06-26-23-15-12.png)

![](/assets/images/2022-06-26-23-15-34.png)

## Wrap-up

![](/assets/images/2022-06-26-23-16-54.png)

- LLDB 쪽은 볼 때 마다 어려운데, 
`TerminalUI Swift module를 import하지 못했음을 알 수 있다` 이후로 어떻게 해결했는지 잘 이해가 안되었음.
스터디 시간에 확인 필요.

