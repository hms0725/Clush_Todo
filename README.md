 Clush_ToDo_List
---
Clush 과제전형 제출을 위해 만든 앱. Spring Boot와 mysql, **구글 지도 API**를 활용하여 "위치기반 ToDo List" 애플리케이션을 구현하였다.


 #  ![플젝](https://github.com/hms0725/Clush_Todo/blob/master/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.png) 프로젝트 소개


"**위치기반 Clush_ToDo_List**"는 사용자가 할 일들을 구글 지도에서 주소와 함께 저장해 해당 일정을 어디서 진행할 수 있는지 확인 및 관리가 가능한 애플리케이션. 

>## 개발 기간
>+ 2025.02.08 ~ 2025.02.11
>+ 기간동안 과정 일지 기록(https://blog.naver.com/hms0725-)

>## 기술 스택
>+ Java, Spring boot v3, mysql 등
>  
>본 프로젝트는 Spring boot 3.2.3와 MySql 기반으로 작성이 되었다. REST API를 기반 백엔드 서비스를 제공하기 위해 Spring Web과 톰캣 기반에서 구현되었다. 


>## 주요 기능
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
>    + 할 일의 체크박스를 클릭해 완료/미완료 여부 관리가 가능
      

>## 사용법
>1. text박스에 할 일을 작성 후 구글지도를 클릭해 원하는 장소를 클릭하면 주소 기입란에 자동으로 주소가 기입 됌.(주소기입은 선택사항) 추가하기 버튼을 누른 후 저장되고 List에 나타남
>![저장](https://github.com/hms0725/Clush_Todo/blob/master/%EC%98%81%EC%83%81/%EC%B6%94%EA%B0%80.gif)
>
>2. List에서 지도 아이콘을 클릭하면 할 일과 함께 저장된 주소 정보가 팝업창으로 나타남
>![주소](https://github.com/hms0725/Clush_Todo/blob/master/%EC%98%81%EC%83%81/%EC%A3%BC%EC%86%8C.gif)
>
>3. List에서 원하는 할 일을 검색하면 해당 글자에 맞는 할 일만 List에 보여지고 관리가 가능
>![검색](https://github.com/hms0725/Clush_Todo/blob/master/%EC%98%81%EC%83%81/%EA%B2%80%EC%83%89.gif)
>
>4. 수정버튼을 클릭 해 해당 텍스트 박스에서 바로 수정가능한 상태가 되고 취소 및 확인이 가능
>![수정](https://github.com/hms0725/Clush_Todo/blob/master/%EC%98%81%EC%83%81/%EC%88%98%EC%A0%95.gif)
>
>5. 삭제 버튼으로 삭제 가능
>![삭제](https://github.com/hms0725/Clush_Todo/blob/master/%EC%98%81%EC%83%81/%EC%82%AD%EC%A0%9C.gif)
>
>6. 완료한 할 일은 체크박스를 클릭 해 완료여부로 바꾸고 가로줄이 쳐저 직관적으로 관리가 가능
>![완료](https://github.com/hms0725/Clush_Todo/blob/master/%EC%99%84%EB%A3%8C.gif)
>




>## **빌드 및 실행방법
> + cmd창을 열어 프로젝트 폴더가 있는 위치로 이동
>
>   + ``` cd C:\Spring\SpringSrc17\Clush ```
>
> + 프로젝트 폴더 위치에서 소스빌드파일 생성
>
>   + ``` gradlew build ```
>
> + 빌드파일은 프로젝트 폴더에 [build\libs]폴더에 생긴다. libs폴더로 이동
>
>   + ``` cd C:\spring\springSrc17\Clush\build\libs ```
>
> + libs에 .jar/.war 파일이 있다.(나는 .war로 생성) 해당 파일을 실행
>
>   + ``` java -jar Clush-0.0.1-SNAPSHOT.war ```
>
> + 실행 명령어 입력 후 cmd 화면
>
>![실행](https://github.com/hms0725/Clush_Todo/blob/master/screen.png)
>
> + 크롬창에 들어와 내가 설정한 포트번호와 주소를 입력해준다.
>
>   + ``` localhost:3335 ```
>
>  + 실행된 TodoList 화면을 사용
> + DB스키마 및 기초데이터 [백업파일](https://github.com/hms0725/Clush_Todo/blob/master/todo_db_todo.sql)
>   

>## 라이브러리
> + 프론트엔드 주력 컴포넌트
>>  + ### jQuery
>>    jQuery는 DOM 조작, 이벤트처리, AJAX 요청 등을 간단히 처리할 수 있다. 나는 주로 DOM요소의 선택, 클릭 이벤트처리에 활용하였다.
>>    
>>        $(".map-btn").click() 버튼 클릭 이벤트를 처리
>>    
>>        $("todo-item").append() 할 일을 화면에 동적으로 추가
>>
>>   + ### AJAX
>>      페이지 새로고침 없이 서버와 데이터를 주고받을 수 있는 기술이다. 화면을 동적으로 갱신하거나 데이터를 서버와 비동기적으로 처리할 때 사용하였다.
>>
>>         $.ajax() 서버에 요청을 보내고 응답을 받아와 화면에 반영
>>
>> 
>
>
> + 백엔드 주력 라이브러리
>> + ### JSP tag Library - JSTL
>>
>>>JSTL은Java 코드 대신 HTML Tag 형태로 직관적인 코딩을 지원하는 라이브러리로 웹 애플리케이션 개발에 유용한 집합. Jsp페이지 내에서 Java코드와 HTML코드가 혼합되면 가독성이 떨어지기 때문에 JSTL을 사용해 반복문 등을 간편하게 처리하고 model과 view를 분리하였다.
>>
>>  + ### Java Library - Slf4j
>>
>>>Slf4j는 logging 프레임워크에 대한 인터페이스 집합으로 매번 인스턴스를 선언하거나 클래스 이름이 변경될 때마다 코드 수정할 필요 없이 logging을 관리할 수 있다. 로깅프레임워크가 변경되더라도 코드 수정 없이 사용할 수 있어 유지보수의 용이함을 사용하였다.
>>
>

>### Api 명세
>
>(http://localhost:3335/swagger-ui/index.html)
>![](https://github.com/hms0725/Clush_Todo/blob/master/swagger.png)
>
>


>### 테스트케이스
> ![](https://github.com/hms0725/Clush_Todo/blob/master/TestCaseScreen.png)









###### 프로젝트 기여자
###### - 홍미숙 hms910725@naver.com




###### 과제전형을 위한 프로젝트였지만 무엇을 해야 할 지 몰라 헤매일 때 길을 찾을 수 있게 되어서 감사한 시간이었다. 그리고 너무 재밌다.ㅎㅅㅎ 다른 것도 해봐야지!
