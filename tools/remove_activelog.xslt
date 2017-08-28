<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
	xmlns="http://www.topografix.com/GPX/1/1"
	xmlns:gpx="http://www.topografix.com/GPX/1/1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	version="1.0"
>

	<xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>

	<xsl:template match="gpx:gpx">
		<xsl:element name="gpx">
			<xsl:attribute name="creator"></xsl:attribute>
			<xsl:attribute name="version">1.1</xsl:attribute>
			<xsl:attribute name="xsi:schemaLocation">http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd</xsl:attribute>

			<xsl:element name="trk">
				<!--<xsl:element name="name">noname</xsl:element>-->
				<xsl:element name="trkseg">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="gpx:name"/>

	<xsl:template match="gpx:trk|gpx:trkseg">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
