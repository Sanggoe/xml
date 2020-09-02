# 웹정보 프레임워크

<br/>

## 1주차, Introduction

### HTML의 문제점

* 문서의 구조나 의미(content)보다는 표현(presentation) 부분에 중점
  * 문서 처리의 자동화가 어려움
* <**태그**> <**/태그**> 로 구성되어있는 것을 XML에서는 **element**라고 한다.
* XML에서는 태그 안에 해당 정보를 포함한다.
  * ![image-20200902103349196](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902103349196.png)

<br/>

### XML

* **eXtensible Markup Language** ★

* SGML : 가장 포괄적인 마크업 언어
* XML : SGML의 기능들을 뽑아내서 만든 부분집합.
  * 비유하자면, SGML과 XML은 자료형으로 볼 수 있다. int, long, ...
* HTML : SGML을 적용시켜서 만든 언어 (인스턴스)
  * 비유하자면, HTML은 자료형에 대한 변수로 볼 수 있다. value, sum ...
  * 따라서 언어 자체에 대해서 XML과 HTML은 '비교 대상'은 아니다.

<br/>

### XML vs SGML vs HTML

![image-20200902104129839](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902104129839.png)

* 문법적인 면에서 더 엄격한 경우, 오히려 심플하다고 볼 수 있다.
* **XML은 namespace를 지원한다!** ★
  * XML은 태그set을 정의할 수 있다. 
  * 그런데, 그것이 중복되지 않아야 해서 그 set을 구분하기 위해서 쓰는 것을 말한다.
  * Java를 예로들면 같은 이름의 class가 다른 것을 구분하기 위해 package 개념이 있듯

<br/>

**★ 암기★**

![image-20200902104625041](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902104625041.png)

![image-20200902104957501](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902104957501.png)

* 위에는 HTML, 아래는 XML의 속성값 표현 예시.
* **XML은 HTML과 다르게 태그 Set을 정의하여 사용 가능! ★**

<br/>

### XML의 장점

![image-20200902105254655](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902105254655.png)

* **문서의 내용과 스타일을 분리하여 기술한다!** ★
  * 스타일은 css 와 같은 보여지는, presentation 부분

<br/>

### XML의 용도

![image-20200902105627551](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902105627551.png)

* **문서로서의 기능과, XML이 국제 표준이기 때문에 OS 등이 달라도 시스템간 자료로서의 기능 또한 수행할 수 있다. ★**

<br/>

### XML 관련 도구

![image-20200902105858586](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902105858586.png)

<br/>

### XML Overview

![image-20200902110133715](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902110133715.png)

* Prolog
  * XML 문서 선언문 ( <?xml ~ ... > ) 필수
  * PI 선택
  * DTD 선택
* Body
  * root element 태그 필수로 하나만 존재
  * content 루트 안의 내용들을 말함

* **위 문서의 구조는 ★ 암기사항 ★**

<br/>

![image-20200902110842602](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902110842602.png)

* DTD는 내부/외부 Schema는 외부에만
* **Body 부분은 최상위 root element 하나만 나온다. ★**

<br/>

![image-20200902110700408](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902110700408.png)

* 첫 줄 외우자! 버전까지는 반드시 나온다. 인코딩은 옵션.
* Prolog에서 PI는 생략된 코드. PI나 DTD는 생략 가능.
* students가 body의 root element

<br/>

### 실습 ex1-1)

* encoding="euc-kr" : ANSI 인코딩 형식
* encoding="utf-8" : 보편적인 한글 지원 인코딩 형식 
* 실제 코딩한 방식과 저장한 방식 선택이 같아야 한다

<br/>

![image-20200902121241115](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902121241115.png)

<br/>

* 브라우저로 열어본 모습

![image-20200902123158938](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20200902123158938.png)

* HTML과 다르게 XML은 보여지는 것보다 **'정보'를 표시하는 '형식'에 더 관심이 있는 언어**이기 때문에 이쁘게 나오지 않는 것이다!

<br/>

<br/>

## 2주차

