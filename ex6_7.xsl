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
				<TH bgcolor="#0365B1"><font color="white">순번</font></TH>
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
	<!-- select 된 순서대로 넘버링 -->
	<!-- <TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:number format="1"/></p></TD>	-->
	
	<!-- 출력되는 순서대로 넘버링, format을 로마자로 -->
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:number value="position()" format="I"/></p></TD>

	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="모델명"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="통신사"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="구입형태"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="제조사"/></p></TD>
	<TD bgcolor="#DEE3EF">
		<xsl:if test="색상"><p align="center" style="margin-top:3px;"><xsl:value-of select="색상"/></p></xsl:if>
		<xsl:if test="not (색상)"><p align="center" style="margin-top:3px;">-</p></xsl:if>
	</TD>
<!--<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;">
		<xsl:choose>
			<xsl:when test="색상"><xsl:value-of select="색상"/></xsl:when>
			<xsl:otherwise>-</xsl:otherwise>
		</xsl:choose>
	</p></TD>
-->
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="판매량"/></p></TD>
	<TD bgcolor="#DEE3EF"><p align="center" style="margin-top:3px;"><xsl:value-of select="format-number(가격,'###,##0')"/></p></TD>
	</TR>
</xsl:template>

</xsl:stylesheet>