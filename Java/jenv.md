# jenv

## 설치

```sh
arch -arm64 brew install jenv
```

## jenv 활성화

```sh
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
source ~/.zshrc
```

## jdk 다운로드

```sh
brew install --cask adoptopenjdk/openjdk/adoptopenjdk11
```

## env에 jdk 추가하기

```sh
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-9.jdk/Contents/Home
```

## 버전 설정

### 로컬

```
jenv local openjdk64-11.0.11
```

### 전역

```
jenv global openjdk64-11.0.11
```

## 불필요한 버전 제거

```
jenv remove <version>
```

참고: [https://inma.tistory.com/157](https://inma.tistory.com/157)
