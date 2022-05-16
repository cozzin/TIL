## CircleCI

## Xcode에서 연결한 SPM이 private repo에 있을 때 github 인증을 실패하는 이슈가 있음
- 해결책: https://support.circleci.com/hc/en-us/articles/360044709573-Swift-Package-Manager-fails-to-clone-from-private-Git-repositories

## Private SPM checkout 하기
- CircleCI 설정을 바꾸려고 했으나, ssh는 자동으로 지정되고 있었음
- SPM 추가할 때 ssh 주소로 추가해주면 되는데, Xcode에서 지정하면 ssh 주소로 넣어도 자동으로 http 주소로 바꿔버림... 😯
- `.xcodeproj/project.pbxproj`를 텍스트로 열어서 아래와 같이 필요한 부분 수정하면 됨

```bash
/* Begin XCRemoteSwiftPackageReference section */
		5F0AD55528294A54005A2B37 /* XCRemoteSwiftPackageReference "<package-name>" */ = {
			isa = XCRemoteSwiftPackageReference;
			repositoryURL = "<ssh주소>";
			requirement = {
				kind = exactVersion;
				version = 1.0.5;
			};
		};
/* End XCRemoteSwiftPackageReference section */
```

## Artifact 업로드 하기

circle ci snippet 보면 잘 나와있긴한데, 나중에도 헷갈리지 않게 주석으로 설명 추가

```yml
version: 2
jobs:
build:
  working_directory: /tmp
  steps:
    - run:
        name: Creating Dummy Artifacts
        command: |
          echo "my artifact file" > /tmp/art-1;
          mkdir /tmp/artifacts;
          echo "my artifact files in a dir" > /tmp/artifacts/art-2; # 1. 파일을 특정 위치에 저장
    - store_artifacts:
        path: /tmp/art-1 # 폴더 위치
        destination: artifact-file # 결과물 이름
    - store_artifacts:
        path: /tmp/artifacts
```