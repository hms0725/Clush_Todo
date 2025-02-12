 Clush_ToDo_List
---
Clush 과제전형 제출을 위해 만든 앱. Spring Boot와 mysql, 구글 지도 API를 활용하여 "위치기반 ToDo List" 애플리케이션을 구현하였습니다.


 ##  ![플젝](https://github.com/hms0725/Clush_Todo/blob/master/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.png) 프로젝트 소개


"**위치기반 Clush_ToDo_List**"는 사용자가 할 일들을 구글 지도에서 주소와 함께 저장해 해당 일정을 어디서 진행할 수 있는지 확인 및 관리할 수 있는 애플리케이션입니다. 

>### 개발 기간
>+ 2025.02.08 ~ 2025.02.11
>+ 기간동안 과정 일지 기록(https://blog.naver.com/hms0725-)

>### 기술 스택
>+ Java, Spring boot v3, mysql 등
>  
>본 프로젝트는 Spring boot 3.2.3와 MySql 기반으로 작성이 되었습니다. REST API를 기반 백엔드 서비스를 제공하기 위해 Spring Web과 톰캣 기반에서 구현되었습니다. 


>### 주요 기능
>+ 저장
>    + 할 일을 구글 지도에서 원하는 장소와 함께 저장이 가능
>
>+ 조회
>   + 할 일 List에 저장되어 있는 할 일들을 조회가 가능
>    + List에서 지도 아이콘을 클릭 해 팝업창으로 할 일과 함께 저장되어 있는 주소 확인이 가능
>    + 검색 창에서 찾고자 하는 할 일을 검색하여 조회가 가능
>
>+ 수정
>    + 할 일 List에서 수정버튼을 이용해 텍스트 창에서 바로 수정 및 저장이 가능
>     
>+ 삭제
>    + 할 일 List에서 삭제버튼을 이용해 바로 삭제가 가능
>     
>+ 완료/ 미완료
>    + 완료 된 할 일은 체크박스를 클릭하여 완료여부 관리가 가능
      

>### 사용법
>1.![저장](https://github.com/hms0725/Clush_Todo/blob/master/%EC%B6%94%EA%B0%80.gif)
>-> text박스에 할 일을 작성 후 구글지도를 클릭해 원하는 장소를 클릭하면 주소 기입란에 자동으로 주소가 기입 됌.(주소기입은 선택사항)
>
> 이후 추가하기 버튼을 누르면 할 일이 저장되고 아래 List에 나타남.

>2.![주소](https://github.com/hms0725/Clush_Todo/blob/master/%EC%A3%BC%EC%86%8C.gif)
>-> List에서 지도 아이콘을 클릭하면 할 일과 함께 저장된 주소 정보가 팝업창으로 나타남
>
>3.![검색](https://github.com/hms0725/Clush_Todo/blob/master/%EA%B2%80%EC%83%89.gif)
>->List에서 원하는 할 일을 작성하면 해당 글자에 맞는 할 일만 List에 보여지고 관리가 가능
>
>4.![수정](https://github.com/hms0725/Clush_Todo/blob/master/%EC%88%98%EC%A0%95.gif)
>->수정버튼을 클릭 해 해당 텍스트 박스에서 바로 수정가능한 상태가 되고 취소 및 확인이 가능
>
>5.![삭제](https://github.com/hms0725/Clush_Todo/blob/master/%EC%82%AD%EC%A0%9C.gif)
>->삭제 버튼으로 삭제 가능
>
>6.![완료](https://github.com/hms0725/Clush_Todo/blob/master/%EC%99%84%EB%A3%8C.gif)
>->완료한 할 일은 체크박스를 클릭 해 완료여부로 바꾸고 가로줄이 쳐저 직관적으로 관리가 가능

>### 라이브러리
> + 프론트엔드 주력 컴포넌트
>>   + JavaScript - React.js
>> React.js는 뛰어난 유연성과 호환성이 강점이다. 별도의 컴포넌트를 만들어 쉽게 재사용할 수 있기 대문에 확장성이 뛰어나고 최적화가 쉽다. 주력 컴포넌트로는 함수형 컴포넌트를 사용하였는데 render() 함수가 필요없어서 마운트 속도가 빠르고 가독성이 좋다는 장점이 있기 때문이다.
>>
>
>
> + 백엔드 주력 라이브러리
>>   + JSP tag Library - JSTL
>>
>>>JSTL은Java 코드를 바로 사용하지 않고 HTML Tag 형태로 직관적인 코딩을 지원하는 라이브러리로 웹 애플리케이션 개발 플랫폼을 위한 컴포넌트 모음집이다. Jsp페이지 내에서 Java코드와 HTML코드가 섞여 있으면 가독성이 떨어진다. JSTL을 사용하면 연산, 조건문, 반복문을 편하게 처리할 수 있고 model과 view를 분리할 수 있기 때문에 좀 더 직관적이고 좋은 가독성과 간편함을 위해 사용하였다.
>
>>   + Java Library - Slf4j
>>
>>>Slf4j는 logging 프레임워크에 대한 인터페이스 모음집으로 매번 인스턴스를 선언하지 않아도 되고, 클래스 이름이 바뀔 때마다 코드 수정을 하지 않아도 되는 간편함이 있어 사용하였음.
>>>구체적인 로깅프레임워크가 변경되더라도 별다른 코드의 수정이 불필요해진다.
>>
>
---




##### 프로젝트 기여자
- 홍미숙 hms910725@naver.com

