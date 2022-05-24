# 스프링 입문 - 코드로 배우는 스프링 부트, 웹 MVC, DB 접근 기술

[https://www.inflearn.com/course/%EC%8A%A4%ED%94%84%EB%A7%81-%EC%9E%85%EB%AC%B8-%EC%8A%A4%ED%94%84%EB%A7%81%EB%B6%80%ED%8A%B8](https://www.inflearn.com/course/%EC%8A%A4%ED%94%84%EB%A7%81-%EC%9E%85%EB%AC%B8-%EC%8A%A4%ED%94%84%EB%A7%81%EB%B6%80%ED%8A%B8)

## intelliJ 단축키

- Cmd + Shift + Enter: 가장 적절한걸로 자동완성
- Option + Cmd + v: 함수의 결과를 담는 변수를 선언해줌
![](images/2022-05-21-11-31-32.png)
- Shift + F6: 변수명을 Refactor 할 수 있음
![](images/2022-05-21-11-34-04.png)
- `/**` 까지만 입력하고 Enter: Document comment 스니펫 만들어줌
![](images/2022-05-21-11-47-44.png) 
- Control + T: 리팩토링 관련된 여러 기능 선택할 수 있음
![](images/2022-05-21-11-52-32.png) 
- Cmd + Shift + T: 해당 클래스에 매칭되는 테스트 클래스 만들기
![](images/2022-05-21-12-06-22.png)

## 사소한 문제 해결

- [인텔리제이 Run 실행 안 될 때 해결 방법](https://ottl-seo.tistory.com/entry/%EC%9D%B8%ED%85%94%EB%A6%AC%EC%A0%9C%EC%9D%B4-Run-%EC%8B%A4%ED%96%89-%EC%95%88-%EB%90%A0-%EB%95%8C-%ED%95%B4%EA%B2%B0-%EB%B0%A9%EB%B2%95)

## 라이브러리 살펴보기

- spring-boot-starter-web
- spring-boot-starter(공통): 스프링 부트 + 스프링 코어 + 로깅

> SDK 만들때 spring 모듈 구조 참고해도 좋을 듯

## @ResponseBody 사용원리

![](images/2022-05-21-10-52-32.png)

- ResponseBody, 템플릿 엔진 다 크게는 비슷한 흐름을 가진다
- Response Data들이 들어있는데 객체를 JSON으로 바꿔주는 annotation이 `@ResponseBody`.
- `@ResponseBody`가 걸려있으면, `HttpMessageConverter` 통해서 변환해준다. 굉장히 간편한 기능인듯!

## 회원 관리 예제 - 백엔드 개발

![](images/2022-05-21-10-48-05.png)

- 컨트롤러: 웹 MVC의 컨트롤러 역할
- 서비스: 핵심 비즈니스 로직 구현. 비즈니스에 의존적으로 설계함. 해당 비즈니스 용어로 유추할 수 있으면 좋음.
- 리포지토리: 데이터베이스에 접근, 도메인 객체를 DB에 저장하고 관리
- 도메인: 비즈니스 도메인 객체, 예) 회원, 주문, 쿠폰 등등 주로 데이터베이스에 저장하고 관리됨

> 도메인 레이어가 아직은 제대로 이해가 되지 않는다... DB에 저장하는 데이터를 객체로 만들어 둔걸로 보면 되는걸까?

## 회원 리포지토리 테스트 케이스 작성

- JUnit 사용

### @AfterEach
ios test의 tearDown과 같은 역할

```java
@AfterEach
public void afterEach() {
    repository.clearStore();
}
```

### @Test

테스트 클래스 인지 지정할 필요도 없이, function에 `@Test` annotation만 붙여주면 됨. 

> annotation을 어떻게 감지하는지, 커스텀하게 만들 수 있는건지도 찾아봐야 할 듯

```java
@Test
public void save() {
    Member member = new Member();
    member.setName("spring");

    repository.save(member);

    Member result = repository.findById(member.getId()).get();
    assertThat(member).isEqualTo(result);
}
```

### import static
```java
import static org.assertj.core.api.Assertions.*;
```

이런식으로 import static 해두면 사용하는 곳에서 패키지 지정없이 바로 쓸 수 있음

![](images/2022-05-21-23-47-41.png)

option + enter 해보면 static import로 변경해주는 항목이 뜸

### Dependency Injection

- Service가 Repository 객체를 의존하고 있는데 의존 관계를 드러나게 하고, 
테스트 환경에 따라 Repository를 교체해주기 위해서는 의존성 주입이 필요하다.
- cmd + n > constructor 사용하면 init으로 객체를 주입받을 수 있도록 IDE가 금방 만들어준다

```java
class MemberServiceTest {

    MemberService memberService;
    MemoryMemberRepository memberRepository;

    @BeforeEach
    public void beforeEach() {
        memberRepository = new MemoryMemberRepository();
        memberService = new MemberService(memberRepository); // Dependency Injection
    }
}
```

## 스프링 빈과 의존관계

![](images/2022-05-22-16-17-05.png)

- `@Controller` 이런 스프링 관련 annotation이 붙어있으면, 스프링이 어떤 곳에 객체를 생성해서 관리함
- 이런걸 Bean Pattern이라고 함

```java
@Controller
public class MemberController {
    
    private final MemberService memberService = new MemberService();
}
```

- 이런식으로 바로 Controller에서 생성해주면 객체마다 Service를 생성하게 됨
- 그런데 service를 중복으로 생성할 필요 없는 경우에는 Spring Container에 등록해두고 가져오면 됨

### @Autowired

- Spring이 객체를 생성할 때 constructor를 호출할 텐데, 그때 `@Autowired`가 붙어있으면 파라미터를 Container에서 생성해서 주입해줌
- 예제에서는 Controller -> Service -> Repository 로 의존하고 있음

```java
@Controller
public class MemberController {

    private final MemberService memberService;
    
    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }
}
```

```java
@Service
public class MemberService {

    private final MemberRepository memberRepository;

    @Autowired
    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }
}
```

```java
@Repository
public class MemoryMemberRepository implements MemberRepository
```


### 스프링 빈을 등록하는 2가지 방법
1. 컴포넌트 스캔과 자동 의존관계 설정
2. 자바 코드로 직접 스프링 빈 등록하기

### 컴포넌트 스캔과 자동 의존관계 설정

- `@Component` annotation이 있으면 스프링 빈으로 자동 등록됨
- `@Controller`, `@Service`, `@Repository` 안에 까보면 `@Component`라고 되어 있음
- 스프링 빈을 등록할 때 기본으로 싱글톤으로 등록. 설정으로 싱글톤이 아니게 할 수 있음. 특별한 경우가 아니면 싱글톤 사용

### 의존성 주입

- 생성자 주입
- 필드 주입
- setter 주입

생성자 주입이 제일 좋음! 의존 관계가 실행중에 동적으로 변경되는 경우가 거의 없음
