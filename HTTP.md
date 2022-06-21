## Port

- IP: 목적지 서버를 찾는것
- Port: 서버 안에서 돌아가는 애플리케이션을 찾는것. 같은 IP내에서 프로세스 구분

### TCP/IP 패킷정보
- 출발지 IP, **PORT**
- 목적지 IP, **PORT**
- 전송데이터

### PORT 번호
- 0 ~ 65535 할당가능
- 0 ~ 1023: 잘 알려진 포트, 사용하지 않는 것이 좋음
  - FTP: 20, 21
  - TELNET: 23
  - HTTP: 80
  - HTTPS: 443

## DNS

- IP는 변경될 수 있음
- 도메인 네임 시스템
- 전화번호부 같은 서버

### DNS 사용

도메인을 구입해서 DNS 서버에 등록

1. 클라이언트 -> DNS 서버로 요청: 도메인 명 google.com
2. DNS서버 -> 클라이언트 응답 200.200.200.2
3. 클라이언트 -> 200.200.200.2 서버 접속 

## 인터넷 네트워크 정리

- 인터넷 통신
- IP(Internet Protocol): 메세지를 보내기 위한 규약
- TCP: 메세지 도착 순서 보장
- UCP: 거의 IP랑 비슷한데 포트 정보 추가됨
- PORT: 같은 IP 안에서 동작하는 애플리케이션 구분하기 위함
- DNS: IP는 변하기 쉽고 기억하기 어려워서 DNS에 등록해두고 사용함

## 🔗 URI(Uniform Resource Identifier)

- "URI는 로케이터(**L**ocator), 이름(**N**ame) 또는 둘 다 추가로 분류될 수 있다" ([참고](https://www.ietf.org/rfc/rfc3986.txt))
- <img width="715" alt="image" src="https://user-images.githubusercontent.com/11647461/174804560-9180f96e-a2b5-448b-82e5-8eac90df26c7.png">
- URI: 리소스 식별
- URL: 리소스 위치. 일반적으로 웹브라우저에 적는거
- URN: 리소스 이름. 
- <img width="1051" alt="image" src="https://user-images.githubusercontent.com/11647461/174805122-304ee904-a1a7-4b93-a544-c6a73cceabcb.png">

### URI 단어뜻
- **U**niform: 리소스 식별하는 통일된 방식
- **R**esource: 자원. URI로 식별할 수 있는 모든 것(제한 없음).
  - HTML 파일만 리소스가 되는건 아님. 실시간 교통 정보 같은 우리가 구분할 수 있는 모든 정보가 될 수 있음
- **I**dentifier: 다른 항목과 구분하는데 필요한 정보

### URL, URN 단어 뜻
- URL - Locator: 리소스가 있는 위치를 지정
- URN - Name: 리소스에 이름을 부여
  - 위치는 변할 수 있지만, 이름은 변하지 않는다
  - ex) urn:isbn:123213123 
  - URN 이름만으로 실제 리소스를 찾을 수 있는 방법이 보편화 되지 않음
  - 예전에 시도했는데 잘 안됐다고 함
  - 강의에서는 앞으로 URI를 URL과 같은 의미로 이야기함

### URL 분석

```
https://www.google.com/search?q=hello&hl=ko
```

### URL 전체 문법

- `scheme://[userinfo@]host[:port][/path][?query][#fragment]`
- `https://www.google.com/search?q=hello&hl=ko`

### scheme

- 주로 프로토콜 사용
- 프로토콜: 어떤 방식으로 자원에 접근할 것인가 하는 약속 규칙
  - http, https, ftp 등등
- http는 80포트, https는 443 포트를 주로 사용, 포트는 생략 가능. 생략하면 주로 사용되는 포트 사용함
  - https는 http에 보안 추가 (HTTP Secure)

### userinfo

- URL에 사용자 정보를 포함해서 인증
- 거의 사용하지 않음

### host

- 호스트명
- 도메인명 또는 IP 주소를 직접 사용 가능

### port

- 접속 포트
- 생략 가능

### path

- 리소스 경로
- 계층적 구조
- `/home/file1.jpg`
- `/members`
- `/members/100`: 100 id를 가진 회원 정보 조회 하는 식으로 설계할 수 있음

### query

- key=value 형태
- `?`로 시작, `&`로 추가 가능
- query parameter, query string 등으로 불림.

### fragment

- html 내부 북마크 등에 사용
- 서버에 전송하는 정보는 아님