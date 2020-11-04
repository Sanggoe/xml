

### 여러 개의 Schema 사용하기

![image-20201028104013821](./images/image-20201028104013821.png)

* import 는 다른 스키마의 전역 선언만을 참조해서 '사용' 할 수 있도록 하는것
* include는 다른 스키마를 '포함' 하도록 하는 것 // namespace가 동일해야 한다!? 

* redefine는 미리 선언된 것을 '**재정의**'하도록 하는 것

<br/>

![image-20201028104111145](./images/image-20201028104111145.png)

* 자바 패키지 import 하는 것과 같다고 생각하면 된다~
* 해당 패키기의 클래스를 '쓰는' 거지 바뀌지 않잖아.
* 그대로 **가져와서 사용하는 것**

<br/>

![image-20201028104408764](./images/image-20201028104408764.png)

* 동일한 targetNamespace나, targetNamespace가 없는 문서만 사용 가능하다!
* 양자로 들인다고 생각하면 될 듯. 부모가 없거나, 나랑 같아야 데려올 수 있죠.
* 가져와서 **내 namespace로 포함시키는 것**.

<br/>

![image-20201028105019254](./images/image-20201028105019254.png)

* 이미 선언되어 있는 target:songType 을 재정의 하는 것!
* 자바에서 상속을 받은 다음에 멤버변수를 추가하듯이.
* 그래서 사용할때는 target:SongType으로 하고, 정의할때는 name="SongType" 이렇게 써야 한다.
* **질문! redefine으로 가져와서 재정의 할 때, 그대로 가져와서 재정의하는 부분이  "추가"가 되는 건가요? 아니면 아예 "구현 자체를 새로" 하는건가요??** 

<br/>

![image-20201028104741708](./images/image-20201028104741708.png)

<br/>

## Chapter 6. XML Translation - XSLT

![image-20201028105345686](./images/image-20201028105345686.png)

* XML S/W 활용 방법 배울 것
  * SAX
  * DOM
* XML 응용 Part

<br/>

### 목차

![image-20201028105623765](./images/image-20201028105623765.png)

<br/>

### XSLT?

![image-20201028105701024](./images/image-20201028105701024.png)

* XSLT란 eXtensibl Stylesheet Language Transformation
* 이 시간 이후로 xsd는 이미 정의되어 있다고 가정하고 하자! 안써!

<br/>

### XSLT 문서 작성과 지정하기

![image-20201028110439441](./images/image-20201028110439441.png)

* **암기할 것 ★**
* <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
* xml 문서에서는 xsl-stylesheet 로, xsl 문서에서는 xsl:stylesheet로 쓰는 것이 최근 표준안이다.

<br/>

### XSLT 문서구조

![image-20201028110648857](./images/image-20201028110648857.png)

* **암기!! 외우세요 첫 줄 ★**
* xsl:template match 에 해당하는 부분을, 맞는 요소 등을 찾아라.
* xml 문서에 대해 xslt를 써서 xml이나 html로 변환하여 출력한다.
* 이 때, match해서 찾는 그 부분이 출력 문장으로 나간다.

<br/>

### XSLT 맛보기

![image-20201028110931197](./images/image-20201028110931197.png)

<br/>

![image-20201028111106757](./images/image-20201028111106757.png)

* **\<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">**
* 첫 줄 외워서 쓰기 꼭 중요. stylesheet로 구성되어 있다.
* 디렉토리와 마찬가지로 xml 을 트리형태로 만들었을 때 경로를 / 로 표현한다.
* / 를 document root 라고 한다. 모든 xml의 가장 기본적인 root.
* / 아래에 root element가 달려있다.

<br/>

#### template match 부분의 코드를 확대해서 보자.

![image-20201028111530408](./images/image-20201028111530408.png)

* 매치가 되면 템플릿 사이에 있는 결과물이 output으로 나온다.
* 그대로 나가는게 아니라, 아래 템플릿들을 적용해라! 라는 apply-templates 코드가 적용된다.
* XPath 인 "/제품/핸드폰" 에 해당하는 애들을 찾아서, 찾게 된 녀석들 각각에 대해서 템플릿을 적용해라!

<br/>

#### 적용할 템플릿의 match 부분

![image-20201028111558274](./images/image-20201028111558274.png)

* 매치가 된 부분은 아래  match 에 대해 이런식으로 해라. 라는.. Mapping 하는 부분인 것 같다.
* 다시 얘기하지만, 순서대로 진행하는 것이 아니다!
* Xpath를 이용해서 match 시켜서 replace 한 다음 그걸 output으로 내는 것이다.

<br/>

![image-20201028111934493](./images/image-20201028111934493.png)

<br/>

#### XSLT 돌려보는 사이트

* **xslttest.appspot.com**
* 브라우저 보기가 안되거나 오류가 있을 경우, 번거롭지만 위 사이트에서 하자.
* 하지만 실행 해 본 경험상 아래처럼 하면 되더라.
  * xml 파일에서는 xsl-stylesheet, xsl 파일에서는 xsl:stylesheet로 한다.
  * 익스플로러로 실행한다.
  * 크롬으로 보면 결과는 안나온다. 하지만, 코드 보기를 통해 xml 문서로는 보인다.

<br/>

### 실습 6-1) XSLT 돌려보기

![image-20201028112450827](./images/image-20201028112450827.png)

<br/>

* **ex6_1_hp.xml 코드**

```xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="ex6_1_hp.xsl"?>
<제품>
	<핸드폰>
		<모델명>SCH-X147</모델명>
		<통신사>SKT</통신사>
		<구입형태>기기변경</구입형태>
		<제조사>삼성전자</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">253000</가격>
	</핸드폰>

	<핸드폰>
		<모델명>iphone 12</모델명>
		<통신사>SK</통신사>
		<구입형태>기기변경</구입형태>
		<제조사>Apple</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">1253000</가격>
	</핸드폰>

	<핸드폰>
		<모델명>Galaxy Note 11</모델명>
		<통신사>SKT</통신사>
		<구입형태>기기변경</구입형태>
		<제조사>삼성전자</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">1353000</가격>
	</핸드폰>

	<핸드폰>
		<모델명>Galaxy S12</모델명>
		<통신사>KT</통신사>
		<구입형태>기기변경</구입형태>
		<제조사>삼성전자</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">1053000</가격>
	</핸드폰>

	<핸드폰>
		<모델명>CX-300L</모델명>
		<통신사>019</통신사>
		<구입형태>신규가입</구입형태>
		<제조사>LG전자</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">270000</가격>
	</핸드폰>
</제품>
```

<br/>

* **ex6_1_hp.xsl 코드**

```xml
<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
	<HTML>
	<HEAD>
		<TITLE>XML 문서의 내용을 테이블 형태로 보여주기</TITLE>
	</HEAD>
	<BODY>
		<BR/>
		<P align="center"><font color="#FA4C79" size="6">핸드폰 리스트</font></P>
		<BR/>
		<TABLE align="center" BORDER="0" cellpadding="5" cellspacing="2">
		<THEAD>
		<TR>
				<TH bgcolor="#0365B1"><font color="white">모델명</font></TH>
				<TH bgcolor="#0365B1"><font color="white">통신사</font></TH>
				<TH bgcolor="#0365B1"><font color="white">구입형태</font></TH>
				<TH bgcolor="#0365B1"><font color="white">제조사</font></TH>
				<TH bgcolor="#0365B1"><font color="white">색상</font></TH>
				<TH bgcolor="#0365B1"><font color="white">판매량</font></TH>
				<TH bgcolor="#0365B1"><font color="white">가격</font></TH>
		</TR>
		</THEAD>
		<TBODY>
				<xsl:apply-templates select = "/제품/핸드폰"/>
		</TBODY>
		</TABLE>
	</BODY>
	</HTML>
</xsl:template>

<xsl:template match = "/제품/핸드폰">
	<TR>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="모델명"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="통신사"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="구입형태"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="제조사"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="색상"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="판매량"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="가격"/></p></TD>
	</TR>
</xsl:template>

</xsl:stylesheet>
```

<br/>

#### Template 선언 \<xsl:template>

![image-20201028120921022](./images/image-20201028120921022.png)

* xml 문서에서 찾아라! 하는 그 경로가 **Xpath** 이다.
* 이제 그걸 발견 하면 **매칭** 해서 출력문장으로 변환해서 Output으로 낸다.
* 출력 문장은 Markup Language여야 한다. 또, well-formed 해야 한다.
  * html, xml ... 등
* 다른 속성으로는 mode, priority(우선순위), name 등이 있다.

<br/>

### 실습 6-2) Match되는 template이 여러 개라면??

![image-20201028121234920](./images/image-20201028121234920.png)

* **적용 순서!!** ★
  * 좀 더 정확하게 지정된 tamplate을 적용
    * "**/***" 보다 "**/제품**" 이 더 정확한 지정이다.
  * priority 순위가 더 큰 template을 적용
    * priority 옵션을 주었다면, 해당 속성이 높은 것이 수행된다.
  * 가장 나중에 오는 template을 적용
    * 코드 상에 **마지막에 오는 것**이 수행된다.
* 따라서 위 예제의 경우에는 가장 마지막 것이 수행된다.

<br/>

### XPath Pattern

![image-20201028121851398](./images/image-20201028121851398.png)

* **/** : **XML document의 root** 이지, root element를 말하는게 아니다. ★ 
  * document root 아래에 root element가 달린다.
  * / 를 붙이면 절대 위치, 안붙이면 상대 위치를 의미한다.
* **XPath**로 매치가 되는게 단수가 아니라 **복수개인 경우가 많다**.
* ***** : **모든 요소**들을 지정하는 wild character 이다.
* **.** : 현재 요소. 현재 위치를 말한다.
  * 붙여도 되고 안붙여도 상관 없다.
* **..** : 부모 요소를 나타낸다.
  * 현재 위치와 형제관계 즉, sibling (DOM 에서 사용 된다) 관계가 된다.

<br/>

![image-20201028122510541](./images/image-20201028122510541.png)

* **//** : **경로에 상관 없이** 후손들 중에 아무나 있으면 찾아라!
  * **"핸드폰//가격"** : 핸드폰의 자손 요소들 중 모든 가격 요소들을 지정
* **@** : **attribute**를 의미
  * **"가격/@단위"** : 현재  요소 아래 존재하는 가격 요소의 단위 attribute 지정
* **/ | * | @*** : **document root**나, **모든 요소**나, 모든 attribute를 의미

<br/>

![image-20201028123445172](./images/image-20201028123445172.png)

* 조건 XPath Pattern
  * 요소를 찾은 다음, "조건식을 만족하는 **요소명**"을 찾는 것이다!!
  * 비교연산자, 논리연산자 사용 가능
  * **&lt** : **<**, less then 더 작은 것.
  * **&gt** : **>**, 더 큰 것.
* 특별하게 조건 없이 그냥 쓰면 하위 요소 중 **존재 여부가 조건**
  * **핸드폰[색상]** : 핸드폰 요소들 중, **색상 속성이 존재하는** 핸드폰 요소들만 지정
  * **핸드폰[4]** : 현재 요소의 하위 요소인 '핸드폰' 중 5번째 요소
* **핸드폰[index() \&lt; 3]** : 핸드폰 요소 중 처음에 오는 3개의 핸드폰 요소들 지정. (오타!) 0 1 2
* **핸드폰[last()]** : 마지막 핸드폰 요소 지정

<br/>

![image-20201028123522946](./images/image-20201028123522946.png)

* 앞서 본 template은 match였다면, apply-templates는 select 이다. 찾아서 템플릿을 적용하라는 의미!
* 찾게 된 각각에 대해서 템플릿을 적용하게 된다.
* mode라는걸 지정해서 해당 모드에 맞는 템플릿이 적용되는데, 디버깅 할때 뭐 골라서 사용할 때..? 쓴다고.
* 위 왼쪽 경우
  * order가 현재 위치, requistion 부분이 output으로 나온다.
  * select가 없을 경우 현재 위치의 child-element 들에 대해서 템플릿이 적용한다고 보면 된다.
* 우측의 경우
  * select 된 item에 대해서 템플릿이 적용된다고 보면 된다.

<br/>

### 실습 6-3) XPath pattern 익히기

![image-20201028124028842](./images/image-20201028124028842.png)

<br/>

* **ex6_1_hp.xml 코드**

```xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="ex6_3_hp.xsl"?>
<제품>
	<핸드폰>
		<모델명>SCH-X147</모델명>
		<통신사>SKT</통신사>
		<구입형태>기기변경</구입형태>
		<제조사>삼성전자</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">253000</가격>
	</핸드폰>

	<핸드폰>
		<모델명>iphone 12</모델명>
		<통신사>SK</통신사>
		<구입형태>신규가입</구입형태>
		<제조사>Apple</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">123000</가격>
	</핸드폰>

	<핸드폰>
		<모델명>Galaxy Note 11</모델명>
		<통신사>SKT</통신사>
		<구입형태>기기변경</구입형태>
		<제조사>삼성전자</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">1353000</가격>
	</핸드폰>

	<핸드폰>
		<모델명>Galaxy S12</모델명>
		<통신사>KT</통신사>
		<구입형태>기기변경</구입형태>
		<제조사>삼성전자</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">153000</가격>
	</핸드폰>

	<핸드폰>
		<모델명>CX-300L</모델명>
		<통신사>019</통신사>
		<구입형태>신규가입</구입형태>
		<제조사>LG전자</제조사>
		<색상>화이트</색상>
		<판매량 단위="개">30</판매량>
		<가격 화폐="원">270000</가격>
	</핸드폰>
</제품>
```

<br/>

* **ex6_1_hp.xsl 코드**

```xml
<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
	<HTML>
	<HEAD>
		<TITLE>XML 문서의 내용을 테이블 형태로 보여주기</TITLE>
	</HEAD>
	<BODY>
		<BR/>

		<!-- 1st table -->
		<P align="center"><font color="#FA4C79" size="6">핸드폰 리스트</font></P>
		<BR/>
		<TABLE align="center" BORDER="0" cellpadding="5" cellspacing="2">
		<THEAD>
		<TR>
				<TH bgcolor="#0365B1"><font color="white">모델명</font></TH>
				<TH bgcolor="#0365B1"><font color="white">통신사</font></TH>
				<TH bgcolor="#0365B1"><font color="white">구입형태</font></TH>
				<TH bgcolor="#0365B1"><font color="white">제조사</font></TH>
				<TH bgcolor="#0365B1"><font color="white">색상</font></TH>
				<TH bgcolor="#0365B1"><font color="white">판매량</font></TH>
				<TH bgcolor="#0365B1"><font color="white">가격</font></TH>
		</TR>
		</THEAD>
		<TBODY>
				<xsl:apply-templates select = "/제품/핸드폰"/>
		</TBODY>
		</TABLE>

		<!-- 2nd table -->
		<BR/>
		<TABLE align="center" BORDER="0" cellpadding="5" cellspacing="2">
		<THEAD>
		<TR>
				<TH bgcolor="#0365B1"><font color="white">모델명</font></TH>
				<TH bgcolor="#0365B1"><font color="white">통신사</font></TH>
				<TH bgcolor="#0365B1"><font color="white">구입형태</font></TH>
				<TH bgcolor="#0365B1"><font color="white">제조사</font></TH>
				<TH bgcolor="#0365B1"><font color="white">색상</font></TH>
				<TH bgcolor="#0365B1"><font color="white">판매량</font></TH>
				<TH bgcolor="#0365B1"><font color="white">가격</font></TH>
		</TR>
		</THEAD>
		<TBODY>
				<xsl:apply-templates select = "/제품/핸드폰[구입형태='신규가입']"/> <!-- 신규 가입인 핸드폰들 -->
		</TBODY>
		</TABLE>

		<!-- 3rd table -->
		<BR/>
		<TABLE align="center" BORDER="0" cellpadding="5" cellspacing="2">
		<THEAD>
		<TR>
				<TH bgcolor="#0365B1"><font color="white">모델명</font></TH>
				<TH bgcolor="#0365B1"><font color="white">통신사</font></TH>
				<TH bgcolor="#0365B1"><font color="white">구입형태</font></TH>
				<TH bgcolor="#0365B1"><font color="white">제조사</font></TH>
				<TH bgcolor="#0365B1"><font color="white">색상</font></TH>
				<TH bgcolor="#0365B1"><font color="white">판매량</font></TH>
				<TH bgcolor="#0365B1"><font color="white">가격</font></TH>
		</TR>
		</THEAD>
		<TBODY>
				<xsl:apply-templates select = "/제품/핸드폰[가격 &lt; 260000]"/> <!-- 가격이 26만원 이하인 핸드폰들 -->
		</TBODY>
		</TABLE>

	</BODY>
	</HTML>
</xsl:template>

<xsl:template match = "/제품/핸드폰">
	<TR>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="모델명"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="통신사"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="구입형태"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="제조사"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="색상"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="판매량"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="가격"/></p></TD>
	</TR>
</xsl:template>

</xsl:stylesheet>
```

<br/>

### 노드 값 \<xsl:value-of>

![image-20201028125504238](./images/image-20201028125504238.png)

* 현재 위치 아래에 customer가 있고 그 id에 해당하는 attribute를 출력..
* 선택된 위치의 값을 출력해주는 태그
* \<xsl:value-of select="." /> : 현재 노드의 내용을 출력
* \<xsl:value-of select="./@id" /> : 현재 노드의 id attribute 값을 출력

<br/>

### 실습 6-4) template 적용하기

![image-20201028125553552](./images/image-20201028125553552.png)

<br/>

* ex6_4_hp.xml 코드

```xml
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="ex6_4_hp.xsl"?>
<simple>
	<name> John </name>
	<name> David </name>
	<name> Mark </name>
	<name> Kim </name>
	<name> Agatha </name>
	<name> Park </name>
</simple>
```

<br/>

* ex6_4_hp.xsl 코드

```xml
<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
	<HTML>
	<HEAD>
		<TITLE>simple xslt example </TITLE>
	</HEAD>
	<BODY>
		<xsl:apply-templates select="simple/name" />
	</BODY>
	</HTML>
</xsl:template>

<xsl:template match="name">
	<p> <xsl:value-of select="."/> </p>
</xsl:template>

</xsl:stylesheet>
```

* xsl:template match="/" 로 우선 document root 를 매핑 해주어 HTML 양식으로 만든다.
* xsl:apply-templates select="simple/name" 으로 해당 위치의 name 요소들에 대해 각각 template 적용.
* xsl:template match="name" 으로 name 요소를 매핑해서 \<p> 태그 안에 선택된 요소의 value를 출력.
  * 현재 위치에서 select="." 하면 해당 값을 출력.

<br/>

<br/>

<br/>

<br/>