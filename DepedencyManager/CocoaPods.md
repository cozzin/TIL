# CocoaPods

## weak_frameworks

- https://guides.cocoapods.org/syntax/podspec.html#weak_frameworks
- https://stackoverflow.com/questions/59216594/optional-framework-in-cocoapods-depending-on-ios-version
- 하위 버전에서 해당 framework 지원하지 못할 때 weak_framework로 세팅 가능

```
spec.weak_framework = 'Twitter'
```
```
spec.weak_frameworks = 'Twitter', 'SafariServices'
```
