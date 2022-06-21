# What's new in Swift

- TOFU: SPM 다운받을 때 fingerpint 인증
- Command plugins
- DocC: objc도 지원함

## Package plugins

아래 두개 들어보자! 특정 라인 또는 선택된 코드에만 적용할 수 있는지 확인해보고 싶음. 그게 가능하다면 번역이나 문법체크도 가능할 듯.

- Meet Swift Package plugins
- Create Swift Pcakge plugins

## Module aliasing

모듈 이름 중복되는거 aliases로 구분해서 충돌없이 사용할 수 있음

## Optional unwrapping

`if let something = something` 이제는 더 간단하게 쓸 수 있음

```swift
if let workingDirectoryMailmapURL {
    mailmapLines = try String(contentsOf: workingDirectoryMailmapURL).split(separator: "\n")
}
```

```swift
guard let workingDirectoryMailmapURL else { return }

mailmapLines = try String(contentsOf: workingDirectoryMailmapURL).split(separator: "\n")
```
