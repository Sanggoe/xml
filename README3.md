# Chapter 8. XML Programming API

![image-20201118120759135](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118120759135.png)

* Simple API for XML (SAX)

<br/>

![image-20201118120836044](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118120836044.png)

* DOM과 SAX의 장단점이 명확하다.
* DOM
  * 작은 파일
  * 데이터를 **편하게 접근**하고자 할 때 편하다.
* SAX
  * 큰 파일
  * 원하는 부분이 파일의 일부일 때
  * 스트림 방식에서 한번 훑고 지나간다. 그래서 **속도**면에선 빠르다.
  * 개인이 만든거래. SAX는. 지금은 국제 표준이 되었다고...

<br/>

![image-20201118122016358](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118122016358.png)

* SAX도 라이브러리고, 누군가는 지원하는걸 만들어 줘야 한다.
* 그래서 뭐.. XML 파서 제작자가 지원 한답디다.
* 일반적으로 XML Parser는 라이브러리 역할을 한다. DOM, SAX 둘 다 지원을 한대.

<br/>

![image-20201118122316185](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118122316185.png)

* SAX는 시퀀스를 STREAM 형식으로 쭉 읽어버린다. 딱히 돔트리를 만들거나 하지 않는다.
* 다만 이벤트가 발생하면 이벤트 핸들러가 작동한다.
* 어떤 문자열이 발견 되면, 어떤 element가 발견되면 핸들러를 호출해 달라고 해놓는다.
  * Call back function 이라는 함수를 달아두는 것.
  * 원하는 대상이 발견 되면, 함수가 호출되며 데이터를 넘겨준다.
  * 한번 쭉 읽는거다보니.. 속도는 빠르다.
  * 콜백함수가 인터페이스의 함수! 내용을 처리하는 ContentHandler의 메소드들을 구현한 객체를 파서한테 넘겨주면 얘기 데이터를 넘겨서 호출호출호출...
  * SAX의 경우 한번 지나가버리면 끝! 스캔 하면 끝이다. 다시 앞으로 돌아가지 않는다.
  * **컨텐트 핸들러 인터페이스를 구현해주는것이 SAX 프로그램이다.**
* 하지만 개발자 입장에서 보면... DOM은 접근하기 편하다.

<br/>

![image-20201118122610076](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118122610076.png)

* 클래스 선언 → 객체 생성 (saxhandler)
* saxhandler를 XML parser에 등록한다.
* 파서는 특정 이벤트 발생할 때마다 해당 이벤트를 처리하는 메소드를 호출

<br/>

![image-20201118122741267](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118122741267.png)



<br/>

### SAX 를 사용하는 자바 프로그램의 예

![image-20201118123127391](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118123127391.png)

* **원래는 contentHandler 인터페이스를 모두 구현(implements)해야 하지만**..
  * 11개의 메소드가 있어서 쓰든 안쓰든 다 구현해줘야 한다..
* 대신에 **DefaultHandler를 상속(extends)한다!**
  * 그러면 원하는것만 Overriding 하면 되니까.
* DefaultHandler 상속 받아서 this로 인터페이스 구현한 객체를 등록 해두면

<br/>

![image-20201118123618966](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118123618966.png)

* 파서가 xml을 읽어 오면 

<br/>

![image-20201125104925806](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125104925806.png)

<br/>

### 실습 8-1) SAX 맛보기

![image-20201118123743578](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201118123743578.png)

<br/>

* xml 문서 예제 코드

```xml
<?xml version="1.0" encoding="EUC-KR"?>
<주소록>
    <회원>
        <이름 글자수="3">박성숙</이름>
        <영문이름>Park, Seong Sook</영문이름>
        <주소>서울시 강동구 천호1동 234-12</주소>
        <전화번호 분류="휴대폰">010-5555-5555</전화번호>
    </회원>
    <회원>
        <이름 글자수="3">조정헌</이름>
        <영문이름>Cho, Jeong Heon</영문이름>
        <주소>서울시 강남구 삼성동 255-1</주소>
        <전화번호 분류="집전화">445-6789</전화번호>
    </회원>
</주소록>
```

<br/>

* SaxHandlerClass.java 코드

```java
import org.xml.sax.XMLReader;
import org.xml.sax.SAXException;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

public class SaxHandlerClass extends DefaultHandler {
    public static void main(String[] args) throws Exception {
        System.out.println("start...");
        SaxHandlerClass saxhandler = new SaxHandlerClass();
        saxhandler.read(args[0]);
    }

    public void read(String fileName) throws Exception {
        XMLReader readerObj = XMLReaderFactory.createXMLReader(
                "org.apache.xerces.parsers.SAXParser");
        readerObj.setContentHandler(this);
        readerObj.parse(fileName);
    }

    public void startDocument() throws SAXException {
        System.out.println("parsing start ... ");
    }

    public void endDocument() throws SAXException {
        System.out.println("parsing end.");
    }

    public void startElement(String uri, String localName,
                             String fullName, Attributes atts) throws SAXException {
        System.out.println("Element is " + fullName);
    }
}
```

<br/>

![image-20201125105232611](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125105232611.png)

* ContentHandler를 implements 받아서 다 구현하는 방법
  * 귀찮다.
* DefaultHandler를 extends 받아서 필요한것만 overriding 하는 방법
  * 보통 이 방법을 많이 쓴다.
* 주요 메소드들
  * startDocument()
  * endDocument()
  * startElement(String uri, String localName, String fullName, Attributes atts)
    * Element의 이름만 읽는다
  * endElement(String uri, String localName, String fullName, Attributes atts)
    * Element의 이름만 읽는다
  * characters(char[] chars, int start, int len)
    * Element가 text을 가질 때,  string값을 읽을때 필요

<br/>

![image-20201125105836968](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125105836968.png)

* 주의할 점!! 다 읽은 다음에 characters가 한 번 호출 되는 것이 아니다.
  * 그 안에 들어갈 내용이 길어질 수도 있다.
  * 내부의 버퍼를 충분히 두긴 하지만, 길이에 대한 제약이 없기 때문에 보장은 못한다.
  * 파서가 한 번에 읽어준다는 보장이 없어서, 어떤 경우에는 나눠서 읽을 수 있다.
  * 즉, 문장은 하나지만 characters가 여러 번에 나누어서 호출될 수 있다.
  * 대부분 길진 않지만, 프로그래머는 예외 사항에 대해서도 방어적으로 해야한다.
* 이에 대한 해결방안.
  * 문자열 임시 저장소를 만든 다음, append!

<br/>

### 실습 8-2) 문자열 추출하기

![image-20201125110341107](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125110341107.png)

<br/>

* xml 문서 예제 코드

```xml
<?xml version="1.0" encoding="EUC-KR"?>
<주소록>
    <회원>
        <이름 글자수="3">박성숙</이름>
        <영문이름>Park, Seong Sook</영문이름>
        <주소>서울시 강동구 천호1동 234-12</주소>
        <전화번호 분류="휴대폰">010-5555-5555</전화번호>
    </회원>
    <회원>
        <이름 글자수="3">조정헌</이름>
        <영문이름>Cho, Jeong Heon</영문이름>
        <주소>서울시 강남구 삼성동 255-1</주소>
        <전화번호 분류="집전화">445-6789</전화번호>
    </회원>
</주소록>
```

<br/>

* SaxHandlerClass2.java 코드

```java
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

public class SaxHandlerClass2 extends DefaultHandler {

    public static void main(String[] args) throws Exception {
        System.out.println("start...");
        SaxHandlerClass2 saxhandler = new SaxHandlerClass2();
        saxhandler.read(args[0]);
    }

    public void read(String fileName) throws Exception {
        XMLReader readerObj = XMLReaderFactory.createXMLReader(
                "org.apache.xerces.parsers.SAXParser");
        readerObj.setContentHandler(this);
        readerObj.parse(fileName);
    }

    @Override
    public void startDocument() throws SAXException {
        System.out.println("parsing start ... ");
    }


    @Override
    public void endDocument() throws SAXException {
        System.out.println("parsing end.");
    }
	// string value를 담을 임시 변수
    StringBuffer strbuff = new StringBuffer(); 
    String whatElement; // 어떤 요소인지 판단을 위한 임시 변수

    @Override
    public void startElement(String uri, String localName, String fullName, Attributes atts) throws SAXException {
        whatElement = fullName;
        strbuff.setLength(0);
        System.out.println("Element is " + fullName);
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        if (whatElement.equals("이름")) {
            System.out.println(whatElement + " has " + strbuff);
        }
    }

    @Override
    public void characters(char[] chars, int start, int len) throws SAXException {
        strbuff.append(chars, start, len);
    }
}

```

<br/>

![image-20201125112345360](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125112345360.png)

* getLength()
* getQName()
* getLocalName() : 인덱스로 찾는거
* getValue() : 인덱스로 찾는거
* getValue() : 이름으로 찾는거
* getType() : 인덱스로 찾은 속성 형식
* getType() : 이름으로 찾은 속성 형식

<br/>

### 실습 8-3) Attribute 추출하기

![image-20201125115729974](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125115729974.png)

<br/>

* xml 문서 예제 코드

```xml
<?xml version="1.0" encoding="EUC-KR"?>
<주소록>
    <회원>
        <이름 글자수="3">박성숙</이름>
        <영문이름>Park, Seong Sook</영문이름>
        <주소>서울시 강동구 천호1동 234-12</주소>
        <전화번호 분류="휴대폰">010-5555-5555</전화번호>
    </회원>
    <회원>
        <이름 글자수="3">조정헌</이름>
        <영문이름>Cho, Jeong Heon</영문이름>
        <주소>서울시 강남구 삼성동 255-1</주소>
        <전화번호 분류="집전화">445-6789</전화번호>
    </회원>
</주소록>
```

<br/>

* SaxHandlerClass3.java 코드

```java
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

public class SaxHandlerClass3 extends DefaultHandler {

    public static void main(String[] args) throws Exception {
        System.out.println("start...");
        SaxHandlerClass3 saxhandler = new SaxHandlerClass3();
        saxhandler.read(args[0]);
    }

    public void read(String fileName) throws Exception {
        XMLReader readerObj = XMLReaderFactory.createXMLReader(
                "org.apache.xerces.parsers.SAXParser");
        readerObj.setContentHandler(this);
        readerObj.parse(fileName);
    }

    @Override
    public void startDocument() throws SAXException {
        System.out.println("parsing start ... ");
    }


    @Override
    public void endDocument() throws SAXException {
        System.out.println("parsing end.");
    }

    @Override
    public void startElement(String uri, String localName, String fullName, Attributes atts) throws SAXException {
        if (localName.equals("회원")) { // 회원 Element마다 띄어쓰기로 구분
            System.out.println();
        }
        System.out.println("Element is " + fullName);
        for (int i = 0; i < atts.getLength(); i++) {
            System.out.println("Element("+fullName+") has attribute(" + atts.getLocalName(i) + ") is " + atts.getValue(i));
        }
    }
}
```

<br/>

<br/>

# Chapter 9. Web Services

![image-20201125120633493](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125120633493.png)

<br/>

### Integration

![image-20201125121425641](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125121425641.png)

* 다른 컴퓨터끼리 정보를 교환하는 것을 정보시스템 통합이라고 합니다.

<br/>

![image-20201125121711002](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125121711002.png)

* ERP : 전사적 자원 관리라고 해서, SAP이라고 아직도 많이 쓰이는 시스템이 있대.
  * MS나, Oracle... 등..
  * SAP이 정말 많이 쓰인대. IT 컨설팅??
* Intranet은 내부망
* Extranet은 외부망. 회사와 회사 등

<br/>

![image-20201125123122852](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125123122852.png)

<br/>

![image-20201125123512327](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125123512327.png)

* 조금 오래된 이야기긴 하지만 아직도 유효한... 시스템 통합의 기능에 관련된 내용이다.
* Client 진영 즉, 일반적으로 PC쪽에서 힘을 얻고있는 기술
  * MS 쪽은 DCOM을 써서 통합을 하자!
    1. 운영체제, 플랫폼, 업체에 종속적이다.
    2. 프로그래밍 언어에 비종속적이다.
* Server 진영 즉, 기업의 PC등 WAS가 대표적인 서버쪽에서 힘을 얻고있는 기술
  * Java 쪽은 RMI를 써서 통합하자!
  * SUN(지금의 Oracle)
    1. 운영체제, 플랫폼 업체에 비종속적이다.
    2. 프로그래밍 언어에 종속적이다.

<br/>

### RPC 메커니즘

![image-20201125124437227](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125124437227.png)

* **좁은 의미**에서는 UNIX에서 외부 컴퓨터의 C함수 호출하는 것
* **넓은 의미**에서는 원격으로 함수 기능을 호출하는 기술을 통칭

<br/>

### DCOM

![image-20201125124626437](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125124626437.png)

* 예시로 word 프로그램 내에서 excel 컴포넌트 사용이 가능하다!
* 이걸 분산환경에서 쓸 수 있도록 한 것이 DCOM 이라고 하는데 이해가 잘 안간다!

<br/>

### CORBA

![image-20201125124826694](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125124826694.png)

* DCOM vs JAVA 각 진영이 붙었다. 이 기술이 트렌드지! 하고 서로 미는것.
* 근데 CORBA 라는게 혜성처럼 나왔대. 물론 사그라들었지만...
* 오픈, 기업에 비종속적, 네트워크 상에서 협업 가능
* 플랫폼, 운영체제, 언어 모두 비종속적 이라는 장점!
* 아주 유용할 줄 알았는 데....!!!
* 코바의 최대 약점... 밀어주는 회사가 없었다!! 배포가 안됬구만.
  * DCOM는 MS, Java RMI는 IBM, SUN .... 등...
* 하지만 IIOP, ORB 등의 기술들을 CORBA가 남겼다!!!
  * 기술적인 면에서는 자산을 많이 남겼대.
  * 하지만 SI 기술로서는 사장이 되었다고....

<br/>

### Java RMI

![image-20201125124727452](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125124727452.png)

* 플랫폼에 독립적, But 언어는 Java를 써야함

<br/>

![image-20201125125235306](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125125235306.png)

* DCOM과 Java RMI의 문제점 등

<br/>

### Firewall 문제

![image-20201125125328859](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125125328859.png)

* 미리 열려져있는 port, 80이나 8080를 사용하는 방법으로 방화벽 문제를 해결하긴 하는데.. 아니면 관리자에게 열어달라고 요청!

<br/>

### 새로운 스타, Web Service

![image-20201125130124953](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201125130124953.png)

* Web Services (이것도 기술 이름이야!)
* 시스템을 통합하기 위한 기술이다.
* 기존 시스템 자원 그대로 사용 가능!!
  * 즉 비용, 시간면에서 단축 가능
* 새로운 정보시스템 구축 시, Web Service 기술 가능
* 업체, 운영체제, 플랫폼, 프로그래밍 언어에 비종속적
  * 느슨한 기술!
* 현재 인터넷 표준 기술을 사용
  * XML, HTTP, HTTPS...
* Firewall에 비교적 자유로움



* Microsoft, IBM을 포함한 대부분의 기업체에서 지원을 결정했다!!
* 정보시스템 통합을 위한 실제적인 국제 표준!! ★Star★등★극★

<br/>

시스템 통합이 무엇이고, 관련 기술이 무엇이며, 장점과 단점이 무엇이 있는지, 그리고 지금 기술이 왜 대두되게 되었다! 하는 것!

<br/>

<br/>

<br/>

