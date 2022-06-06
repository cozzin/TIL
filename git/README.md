# git

## An unknown error occurred. ERROR: You're using an RSA key with SHA-1, which is no longer allowed. Please use a newer client or a different key type.

- [Answer](https://stackoverflow.com/questions/71498990/cannot-resolve-swift-packages-after-15th-march-2022-in-xcode/71498991#71498991)
- 기존에는 `SHA-1`으로 RSA key를 사용했는데 이제는 못쓴다고 한다.
- `ssh-keygen -t ecdsa -b 521 -C "your_email@example.com"`
- 위와 같이 입력해주면 `~/.ssh` 폴더 아래에 `id_ecdsa.pub`(공개키), `id_ecdsa`(개인키)가 만들어진다.
- 클립보드에 복사 `pbcopy < ~/.ssh/id_ecdsa.pub` 
- [SSH keys / Add new](https://github.com/settings/ssh/new)에 추가해주기
