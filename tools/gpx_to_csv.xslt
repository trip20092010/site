<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
	xmlns="http://www.topografix.com/GPX/1/1"
	xmlns:gpx="http://www.topografix.com/GPX/1/1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	version="1.0"
>

<!--
   <trkpt lat="48.140167" lon="11.566036">
    <ele>669.799</ele>
    <time>2007-04-01T12:33:55Z</time>
   </trkpt>
-->

	<xsl:output method="text"/>

	<xsl:template match="gpx:trkpt">
		<xsl:value-of select="@lon"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="@lat"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="gpx:ele"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="gpx:time"/>
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

<xsl:template match="text()"></xsl:template>

</xsl:stylesheet>
