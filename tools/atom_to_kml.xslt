<?xml version="1.0" encoding="UTF-8"?>

<!--

Converts an atom-formatted blog where every entry has been tagged with georss-location
into KML. Only tested with the Blogger export format and Google Earth/Maps.

Usage steps:

1. Export your blog from Blogger (Settings -> Other -> Export)
2. Apply this XSLT transformation to the export file (e.g. "xsltproc atom_to_kml.xslt my_blog.xml > my_blog.kml")
3. Open the resulting my_blog.kml with Google Earth or Google Maps

@author Kaarel Kaljurand (kaljurand@gmail.com)
@version 2010-10-12

-->

<xsl:stylesheet
	xmlns="http://earth.google.com/kml/2.0"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:georss="http://www.georss.org/georss"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0"
>

	<xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>

	<xsl:template match="/">
		<kml>
			<Document>
				<name>Trip 2009-2010 travel blog in KML</name>
				<description>Trip 2009-2010 travel blog browsable by location</description>
				<Style id="p">
					<IconStyle>
						<scale>1</scale>
						<Icon>
							<href>http://labs.google.com/ridefinder/images/mm_20_red.png</href>
						</Icon>
					</IconStyle>
				</Style>
				<xsl:apply-templates/>
			</Document>
		</kml>
	</xsl:template>

	<xsl:template match="atom:feed">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="atom:entry[georss:point]">
		<xsl:element name="Placemark">
			<xsl:element name="styleUrl">
				<xsl:text>#p</xsl:text>
			</xsl:element>

			<xsl:element name="description">
				<xsl:text>Published by </xsl:text>
				<xsl:value-of select="atom:author/atom:name"/>
				<xsl:text> in </xsl:text>
				<xsl:value-of select="atom:published"/>
				<xsl:text>. </xsl:text>
				<xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:value-of select="atom:link[@rel='alternate']/@href"/>
					</xsl:attribute>
					<xsl:text>(link to the blog)</xsl:text>
				</xsl:element>
				<br/>
				<xsl:value-of select="atom:content"/>
			</xsl:element>

			<xsl:element name="name">
				<xsl:value-of select="atom:title"/>
			</xsl:element>

			<!-- KML requires: (lon,lat), while GeoRSS requires (lat,lon) -->
			<xsl:element name="Point">
				<xsl:element name="coordinates">
					<xsl:value-of select="substring-after(georss:point, ' ')"/>
					<xsl:text>,</xsl:text>
					<xsl:value-of select="substring-before(georss:point, ' ')"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|node()"/>

</xsl:stylesheet>
