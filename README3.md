

# Chapter 8. XML Programming API

![image-20201118120759135](C:\workspace\xml\images\image-20201118120759135.png)

* Simple API for XML (SAX)

<br/>

![image-20201118120836044](C:\workspace\xml\images\image-20201118120836044.png)

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

![image-20201118122016358](C:\workspace\xml\images\image-20201118122016358.png)

* SAX도 라이브러리고, 누군가는 지원하는걸 만들어 줘야 한다.
* 그래서 뭐.. XML 파서 제작자가 지원 한답디다.
* 일반적으로 XML Parser는 라이브러리 역할을 한다. DOM, SAX 둘 다 지원을 한대.

<br/>

![image-20201118122316185](C:\workspace\xml\images\image-20201118122316185.png)

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

![image-20201118122610076](C:\workspace\xml\images\image-20201118122610076.png)

* 클래스 선언 → 객체 생성 (saxhandler)
* saxhandler를 XML parser에 등록한다.
* 파서는 특정 이벤트 발생할 때마다 해당 이벤트를 처리하는 메소드를 호출

<br/>

![image-20201118122741267](C:\workspace\xml\images\image-20201118122741267.png)



<br/>

### SAX 를 사용하는 자바 프로그램의 예

![image-20201118123127391](C:\workspace\xml\images\image-20201118123127391.png)

* **원래는 contentHandler 인터페이스를 모두 구현(implements)해야 하지만**..
  * 11개의 메소드가 있어서 쓰든 안쓰든 다 구현해줘야 한다..
* 대신에 **DefaultHandler를 상속(extends)한다!**
  * 그러면 원하는것만 Overriding 하면 되니까.
* DefaultHandler 상속 받아서 this로 인터페이스 구현한 객체를 등록 해두면

<br/>

![image-20201118123618966](C:\workspace\xml\images\image-20201118123618966.png)

* 파서가 xml을 읽어 오면 

<br/>

![image-20201125104925806](C:\workspace\xml\images\image-20201125104925806.png)

<br/>

### 실습 8-1) SAX 맛보기

![image-20201118123743578](C:\workspace\xml\images\image-20201118123743578.png)

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

![image-20201125105232611](C:\workspace\xml\images\image-20201125105232611.png)

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

![image-20201125105836968](C:\workspace\xml\images\image-20201125105836968.png)

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

![image-20201125110341107](C:\workspace\xml\images\image-20201125110341107.png)

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

![image-20201125112345360](C:\workspace\xml\images\image-20201125112345360.png)

* getLength()
* getQName()
* getLocalName() : 인덱스로 찾는거
* getValue() : 인덱스로 찾는거
* getValue() : 이름으로 찾는거
* getType() : 인덱스로 찾은 속성 형식
* getType() : 이름으로 찾은 속성 형식

<br/>

### 실습 8-3) Attribute 추출하기

![image-20201125115729974](C:\workspace\xml\images\image-20201125115729974.png)

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

![image-20201125120633493](C:\workspace\xml\images\image-20201125120633493.png)

<br/>

### Integration

![image-20201125121425641](C:\workspace\xml\images\image-20201125121425641.png)

* 다른 컴퓨터끼리 정보를 교환하는 것을 정보시스템 통합이라고 합니다.

<br/>

![image-20201125121711002](C:\workspace\xml\images\image-20201125121711002.png)

* ERP : 전사적 자원 관리라고 해서, SAP이라고 아직도 많이 쓰이는 시스템이 있대.
  * MS나, Oracle... 등..
  * SOAP이 정말 많이 쓰인대. IT 컨설팅??
* Intranet은 내부망
* Extranet은 외부망. 회사와 회사 등

<br/>

![image-20201125123122852](C:\workspace\xml\images\image-20201125123122852.png)

<br/>

![image-20201125123512327](C:\workspace\xml\images\image-20201125123512327.png)

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

![image-20201125124437227](C:\workspace\xml\images\image-20201125124437227.png)

* **좁은 의미**에서는 UNIX에서 외부 컴퓨터의 C함수 호출하는 것
* **넓은 의미**에서는 원격으로 함수 기능을 호출하는 기술을 통칭
  * 원격으로 다른 컴퓨터의 기능을 요청하거나 데이터를 요청하는 기술
  * 핵심 기술이 **MS에서 나오는 DCOM**과, 이에 **대응해서 나온 Java RMI**
  * 각각의 **약점**을 가지고 있었다.
  * 그 약점들을 보완해 나온게 CORBA인데, 흥행하지 못했음. 밀어주는 업체가 없었기 때문...

<br/>

### DCOM

![image-20201125124626437](C:\workspace\xml\images\image-20201125124626437.png)

* 예시로 word 프로그램 내에서 excel 컴포넌트 사용이 가능하다!
* 이걸 분산환경에서 쓸 수 있도록 한 것이 DCOM 이라고 하는데 이해가 잘 안간다!

<br/>

### CORBA

![image-20201125124826694](C:\workspace\xml\images\image-20201125124826694.png)

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

![image-20201125124727452](C:\workspace\xml\images\image-20201125124727452.png)

* 플랫폼에 독립적, But 언어는 Java를 써야함

<br/>

![image-20201125125235306](C:\workspace\xml\images\image-20201125125235306.png)

* DCOM과 Java RMI의 문제점 등

<br/>

### Firewall 문제

![image-20201125125328859](C:\workspace\xml\images\image-20201125125328859.png)

* 미리 열려져있는 port, 80이나 8080를 사용하는 방법으로 방화벽 문제를 해결하긴 하는데.. 아니면 관리자에게 열어달라고 요청!

<br/>

### 새로운 스타, Web Service!!

![image-20201125130124953](C:\workspace\xml\images\image-20201125130124953.png)

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



* 물론 표준이라곤 하지만, 웹 서비스를 구성하는 작은 기술들이 있다.
  * 핵심적인 기술들은 UDDI, SOAP, WSDL (, HTML, SMTP ... 등도 각각은 표준이긴 함)	
    * UDDI는 사장되다시피 되고 있다고...
  * 이런 기술들이 같이 어우러져서 웹 서비스를 구성한다.
  * 그래서 어떠어떠한걸 어떻게 써야한다 라고 명확히 나와있는게 아니고, 느슨한 형태로 되어있다.
* SOAP, WSDL, UDDI 세 가지 핵심 기술들로 구성되어 있다! ★★★ **외우세요**

<br/>

기억할 부분, 시스템 통합이 무엇이고, 관련 기술이 무엇이며, 장점과 단점이 무엇이 있는지, 그리고 지금 기술이 왜 대두되게 되었다! 하는 것!

<br/>

### Web Services 란 무엇이냐?

![image-20201202105730223](C:\workspace\xml\images\image-20201202105730223.png)

![image-20201202110100614](C:\workspace\xml\images\image-20201202110100614.png)

* IBM의 정의
  * **웹서비스**는 operation들의 집합을 기술해 놓은 **인터페이스**이다!
  * 이는 **네트워크**를 통해서 접근 가능하다. (분산 되어있다)
  * **표준화 된 XML 메시징**(이 개념이 SOAP)을 사용해서, 특정한 목적을 달성하기 위한 것이다.
    * 자바의 인터페이스와 비슷한 개념이라고 생각하자
* 느슨하게 연결되어있는 소프트웨어 컴포넌트들이다.

<br/>

![image-20201202110126446](C:\workspace\xml\images\image-20201202110126446.png)

* 프로그램이 요청하고, 프로그램이 들어주는 것. 근데 서로서로는 잘 모르는. RPC 매커니즘. 그거에대한 표준이 웹 서비스고...
* 세 개의 참여하는 **주체**가 (**외우세요★★★)** - 사람이 아니고 다 소프트웨어에요.
  * **기능 제공자(server)**
  * **기능 요청자(client)**
  * **서비스 중재자(broker?)**
    * CORBAL에 보면 IIOP 프로토콜이 있고, ORB가 중재자가 있다라고 했는데...
    * 이 ORB역할이 서비스 중재자!
    * 예를 들어, 날씨 앱이라고 가정 한다면 날씨 정보를 누가 알려주는지 요청한다.
    * 클라이언트는 서비스 브로커한테 원하는 기능이 있는지 찾아보도록 요청한다.
    * 서비스 브로커는 같은 기능을 제공하는 서비스 프로바이더를 찾아서 정보를 준다. .... 모르겠어 잘... 직접 예시를 들어야 알 수 있을 것 같아
  * publish는 등록, 클라이언트는 find
    * 이러한 기능이 UDDI!
  * 클라이언트가 서버한테 연결을 요청하는 bind 기능과 관련된게 **WSDL**
  * 리퀘스트를 할 때 메시지를 주고 받는 기능과 관련된게 **SOAP**

<br/>

![image-20201202111034242](C:\workspace\xml\images\image-20201202111034242.png)

* **외우세요 ★★★**
  * 서비스 공표 및 찾기에 관련된것이 UDDI : Universal Discovery, Discription, and Integration
  * 서비스 표현과 관련된게 WSDL : Web Service Description Language
  * 정보를 가지고 주고받는 XML 메시징 관련된게 SOAP : Simple Object Access Protocol
    * 이렇게 여러 가지 요소들을 조합을 해서 만드는 것이 웹 서비스....

<br/>

![image-20201202111435073](C:\workspace\xml\images\image-20201202111435073.png)

* 여행사 컴퓨터 시스템이 있다. 이게 어떤식으로 동작을 하느냐면..
* 항공사, 호텔사, 렌트카, 날씨 기상청 등에서 서비스 해주는 인터페이스를 제공한다. (역할로서의 Object)
* SOAP으로 접근할 수 있는 메소드 들을 가지고 있는 인터페이스. 발권...
* 그럼 항공사로부터 대한항공의 어떤 인터페이스와 어떻게 접근할 수 있는지가 담긴 정보인 .WSDL 파일(XML)을 받는다.
* 그 기능들을 이용해서 여행사의 시스템 개발자가 서비스를 만드는 것이다.
* 즉, 자기네들 접근하는 기능을 인터페이스로 만들어두고, 그와 관련된 WSDL 파일을 만들면 그걸 보내주기만 하면 편하고 쉽게 가능하다는것...!
* 기능이 필요하면 해당 회사의 인터페이스를 호출하기만 하면 되니까 한곳에서 여러 곳의 업무를 볼 수 있다.

<br/>

![image-20201202112016124](C:\workspace\xml\images\image-20201202112016124.png)

* open되어 있다. Text 기반의..
* CORBA와 다르게, 다국적 기업들이 웹 서비스를 지원한다!
* 새로운 기술이 나오지 않는 한 당분간 웹 서비스가 흥행..

<br/>

### SOAP

![image-20201202112248696](C:\workspace\xml\images\image-20201202112248696.png)

* SOAP : 분산된 환경 하에서 구조화된 정보(xml)를 주고받기 위한 목적으로 개발된 경량화된 프로토콜이다. ★
* Simple Object Access Protocol 외우세요! ★★★
* http나 https 위에서 xml로 정보를 주고받는다.

<br/>

![image-20201202112334077](C:\workspace\xml\images\image-20201202112334077.png)

* 일반적으로는 클라이언트에서 서버쪽에 SOAP으로 request를 날리면 response를 SOAP으로 보낼 수 있다.
* 웹 서버측에 SOAP Server를 등록해서 이용할 수 있다.

<br/>

![image-20201202112539870](C:\workspace\xml\images\image-20201202112539870.png)

* 꼭 웹 브라우져일 필요는 없긴 함.
* 클라이언트가 요청을 하면, 서버가 받아서 기능을 수행하는 처리를 한 다음 응답을 한다.
* SOAP request와 SOAP response처럼 주고받는 메시지들을 SOAP Envelope 이라고 한다.

<br/>

![image-20201202112712671](C:\workspace\xml\images\image-20201202112712671.png)

* SOAP Envelope이 있는데, 그 안에 **헤더**와 **바디**가 있다! ★★★ 외우세요
* 근데 헤더는 생략 가능

<br/>

#### 예시

![image-20201202113025230](C:\workspace\xml\images\image-20201202113025230.png)

* soap request안에 soap 인벨롭 envelope이 들어간다.
* Envelope 이것도 표준안.
* 그치만 addNumbers나 numOne.. 등은 표준화가 아니고, 따로 만든거기 때문에 default로 Envelope 프리픽스가 적용되면 안된다!
* 표준안과 개발자가 정의한 것은 다르니까 namespace를 다르게 주어야 한다.
* 다시 정리하면, soap request를 하는데, 해당 태그 안에 body에서 addNumbers 기능을 수행하는데, 파라미터로는 12, 24를 넘겨줘라...
* 이렇게 클라이언트에서 보낸다.

<br/>

![image-20201202113353804](C:\workspace\xml\images\image-20201202113353804.png)

* 그럼 서버측에서 이런 soap response를 답변해온다.

<br/>

### Request 예제

![image-20201202113409949](C:\workspace\xml\images\image-20201202113409949.png)

<br/>

### Response 예제

![image-20201202114009813](C:\workspace\xml\images\image-20201202114009813.png)

![image-20201202114220497](C:\workspace\xml\images\image-20201202114220497.png)

* request로 XML이 날아온 것을
* 클라이언트 코드와 서버 코드가 SOAP 형태로, xml 객체를 만들고 보내서 받고.. 그런 형태로 주고받는다.

<br/>

### Example Environment

* WSDL

![image-20201202114502230](C:\workspace\xml\images\image-20201202114502230.png)

* 코드 자체를 알 필요는 없구..
* WSDL을 사용해서 어떻게 사용되고 활용되고 동작하는 시스템을 만드는가? 그 매커니즘을 이해!!



* 클라이언트가 요청을 하면 SOAP으로 요청이 들어오고 서블릿이.. 
* 중간에 WAS서버가 이를 처리할 서블릿이나, 처리할 녀석을 선택한다. 스프링에선 **컨트롤러**!!
* 이 때 서블릿을 만들어 낼 때, WSDL에서 코드를 만들어 내서 자동화된 코드가 작성 된다. 스켈레톤 코드. 구조
* 네트워크에 대한건 신경쓸 필요 없고, 내 기능에 대한 것만 내가 작성해야 한다. 



* 클라이언트와 서버를 중개 해주는 것이 디스패처. 어떤 서블릿 코드를 수행해줄 것인지 결정해주는 WAS 서버.
* 통신 네트워크에 대한것은 WSDL을 통해서 자동 생성된 코드가 알아서 해준다.
* 그럼 개발자는 클라이언트와 서버측 동작 코드만 구현하도록 하면 쉽게 쓸 수 있다.

<br/>

### WSDL

![image-20201202120537480](C:\workspace\xml\images\image-20201202120537480.png)

* WSDL(Web Service Description Language) : 웹 서비스의 위치와 Interface에 대한 정보를 XML로 기술
* Interface
* Data type
  * 타입 선언!
* Binding
  * 포트와 포트타입을, Operation과 Operation을 어떻게 묶어줄거냐!
* Address
  * 어떤 프로토콜을 이용해서 사용할거냐!
* Service 라고 하면 기능에 대한 것!
  * 발권이 서비스다 라고 예시를 들면..
    * 여러 기능들을 해주는 인터페이스들이 있을 것.
    * 고객정보 처리
    * 예약 처리
    * 결제 처리
    * 이런 인터페이스들을 Port 라고 부른다.
      * 자바의 인터페이스라고 생각하면 됨.
      * Port 안에 여러 메소드들이 있는거여. Operation.
  * 즉, 인터페이스들.. Port들의 모임이 Service!

<br/>

![image-20201202121020635](C:\workspace\xml\images\image-20201202121020635.png)

* 전체 통틀어서 Web service라고 한다~
* 웹 프로바이더는 자신이 제공하는 서비스를 WSDL형식으로 publish 할 것이다.
* 클라이언트는 내가 원하는 기능이 뭐가 있는지를 UDDI 기능으로 찾아본다.
* 그럼 등록된 것들 중 맞는 서비스를 찾아 반환을 할 것



* UDDI는 초기에 수요가 늘어날거라 예측 했지만.. 일반 검색 기능으로 하는게 더 편하고 성능고 좋아서..
* 사장된기술.

<br/>



<br/>

![image-20201202121859726](C:\workspace\xml\images\image-20201202121859726.png)

* 서비스는 서버!
* 포트 타입
* 해당 포트 안에 메소드가 있는 것이야~
  * 우리는 submitOrder를 구현해야 하는 것!!

* 클라이언트가 SimpleOrderServer에게 주문을 요청하는 것.

<br/>

### 그에 대한 구현 예제

![image-20201202121935075](C:\workspace\xml\images\image-20201202121935075.png)

1. submitOrderRequest에 대한 타입을 선언하는 것!
2. PortType을 선언하는 것!

<br/>

![image-20201202122324254](C:\workspace\xml\images\image-20201202122324254.png)

* 바인딩!!
* 통신 프로토콜은 http를 쓰겠다!
* 포트타입 선언한 것
* 포트를 선언하고...

<br/>

### 클라이언트측 코드

![image-20201202122710147](C:\workspace\xml\images\image-20201202122710147.png)

* 서버에서 제공하는 WSDL 파일을 가져와서 프로그램을 돌리면 자동으로 자바 파일들을 생성해준다.
* 이렇게 자동으로 생성이 되고, 내부 동작들은 몰라도 된다. 그걸 활용하는 코드만 만들면 되는 것.

<br/>

### 이런 코드들이 자동으로 만들어진다 볼필요는 없구..

![image-20201202122733894](C:\workspace\xml\images\image-20201202122733894.png)

![image-20201202122753434](C:\workspace\xml\images\image-20201202122753434.png)

![image-20201202122924523](C:\workspace\xml\images\image-20201202122924523.png)

<br/>

### 그걸 활용하는 코드, 클라이언트측

![image-20201202123058142](C:\workspace\xml\images\image-20201202123058142.png)

* 그냥.. 서비스 객체 받아와서 만들고, ...
* 네트워크 관련, 통신 관련 SOAP 관련, HTTP 관련 코드 하나도 없다! 내가 신경 쓸 필요 없다는 거야. 이게 API?
* 로컬상에서 함수 호출해서 객체 만들고 객체로 함수 호출한 거 밖에 없다.

<br/>

### 서버측 코드

![image-20201202123328044](C:\workspace\xml\images\image-20201202123328044.png)

* 마찬가지로, 설계자가 WSDL을 만들어 놓으면 서버 개발자가 그걸 가지고 자동으로 생성된 것 중 Impl 만.
* 서버 개발자가 볼 부분은 Impl. 가있는 서비스 구현 코드!! 만 보면 돼.
* submitOrder 메소드만 구현하면 된다는 거야

<br/>

![image-20201202123445643](C:\workspace\xml\images\image-20201202123445643.png)

<br/>

![image-20201202123656460](C:\workspace\xml\images\image-20201202123656460.png)

<br/>

### UDDI

간단하게 설명하고 넘어가요

![image-20201202123809971](C:\workspace\xml\images\image-20201202123809971.png)

* Service Provider 입장에서는 기능을 등록하는 역할
* Request 입장에서는 기능을 찾는 역할

<br/>

![image-20201202123838425](C:\workspace\xml\images\image-20201202123838425.png)

<br/>

![image-20201202123943588](C:\workspace\xml\images\image-20201202123943588.png)

<br/>

![image-20201202124440747](C:\workspace\xml\images\image-20201202124440747.png)

<br/>

### Reference Sites

* W3C http://www.w3.org
* SOAP http://www.w3.org/TR/soap/
* WSDL http://www.w3.org/TR/wsdl
* UDDI http://www.uddi.org
* ebXML http://www.ebxml.org
* Web Services http://www.webservices.org
* XML Training http://www.xmledu.net

<br/>

![image-20201209103757500](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209103757500.png)



객관식, 주관식(단답형)

<br/>

<br/>

![image-20201209104855921](C:\workspace\xml\images\image-20201209104855921.png)

<br/>![image-20201209105241465](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209105241465.png)

* 우리는 3번 괄호 서비스를 타겟으로 할거야!

<br/>

![image-20201209105559196](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209105559196.png)

<br/>

![image-20201209105810005](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209105810005.png)

<br/>

![image-20201209110323168](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209110323168.png)

<br/>

![image-20201209110405755](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209110405755.png)

<br/>

![image-20201209110532304](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209110532304.png)

<br/>

![image-20201209110551256](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209110551256.png)

<br/>

![image-20201209110709653](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209110709653.png)

<br/>

![image-20201209110919763](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209110919763.png)

<br/>

![image-20201209110934495](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209110934495.png)

<br/>

![image-20201209111702227](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209111702227.png)

<br/>

![image-20201209112440916](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209112440916.png)

* ```
  http://openapi.airkorea.or.kr/openapi/services/rest/서비스이름/
  함수?stationName=종로구&dataTerm=month
  &pageNo=1&numOfRows=10&ver=1.3&ServiceKey=서비스키
  ```

<br/>

![image-20201209112542514](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209112542514.png)

<br/>

![image-20201209112617244](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209112617244.png)

<br/>

![image-20201209113504694](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209113504694.png)

```javascript
/* Javascript 샘플 코드 */


var xhr = new XMLHttpRequest(); // 서버와 주고받을 객체. state는 0
var url = 'http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty'; /*URL*/
var queryParams = '?' + encodeURIComponent('ServiceKey') + '='+'서비스키'; /*Service Key*/
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /**/
queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
queryParams += '&' + encodeURIComponent('stationName') + '=' + encodeURIComponent('종로구'); /**/
queryParams += '&' + encodeURIComponent('dataTerm') + '=' + encodeURIComponent('DAILY'); /**/
queryParams += '&' + encodeURIComponent('ver') + '=' + encodeURIComponent('1.3'); /**/
xhr.open('GET', url + queryParams); // 통로 역할. state는 1
xhr.onreadystatechange = function () { // 주고받는 객체가 상태가 바뀔 때 받을 녀석 지정
    if (this.readyState == 4) { // 다 받은 경우 state는 4
        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
    }
}; // send 할 때도, receive 시작할 때도, receive 다 받은 후에도 자동 호출. 하지만 다 받은 경우(4)에만 수행된다!

xhr.send(''); // request 보낸것. xhr이 유지된 상태다. state는 2
// 
```

<br/>

![image-20201209114612743](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209114612743.png)

<br/>

![image-20201209114626412](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209114626412.png)

<br/>

![image-20201209114658033](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209114658033.png)

<br/>

![image-20201209114706117](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209114706117.png)

<br/>

![image-20201209114713968](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209114713968.png)

<br/>

![image-20201209114824245](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209114824245.png)

<br/>

```

```

<br/>

<br/>









![image-20201209120021292](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209120021292.png)





![image-20201209122950368](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201209122950368.png)





![image-20201214000029351](C:\Users\smpsm\AppData\Roaming\Typora\typora-user-images\image-20201214000029351.png)