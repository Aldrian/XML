<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>


<xsl:template match="/">
  <monde xmlns="http://xsd_monde/">
    <xsl:apply-templates select="//continent"/>
    <xsl:apply-templates select="//river"/>
    <xsl:apply-templates select="//sea"/>
  </monde>
</xsl:template>

<!-- template continent -->
<xsl:template match="continent">
  <xsl:variable name="continent_name" select="./@id"/>
  <continent xmlns="http://xsd_monde/">
    <xsl:attribute name="id">
      <xsl:value-of select="./@id"/>
    </xsl:attribute>
    <surface xmlns="http://xsd_monde/">
      <xsl:value-of select="./area"/>
    </surface>
    <!-- pays -->
    <xsl:apply-templates select="//country[./encompassed[@continent=$continent_name]]"/>
  </continent>
</xsl:template>


<!-- template rivieres -->
<xsl:template match="river">
<river xmlns="http://xsd_monde/">
  <xsl:attribute name="id">
    <xsl:value-of select="./@id"/>
  </xsl:attribute>
  <name xmlns="http://xsd_monde/">
    <xsl:value-of select="./name"/>
  </name>
  <length xmlns="http://xsd_monde/">
    <xsl:value-of select="./length"/>
  </length>
</river>
</xsl:template>

<!-- template mer -->
<xsl:template match="sea">
<sea xmlns="http://xsd_monde/">
  <xsl:attribute name="id">
    <xsl:value-of select="./@id"/>
  </xsl:attribute>
  <name xmlns="http://xsd_monde/">
    <xsl:value-of select="./name"/>
  </name>
</sea>
</xsl:template>

<!-- pays -->
<xsl:template match="country">
<country xmlns="http://xsd_monde/">
  <xsl:variable name="country_name" select="./@car_code"/>
  <xsl:attribute name="id">
    <xsl:value-of select="$country_name"/>
  </xsl:attribute>
  <xsl:attribute name="area">
    <xsl:value-of select="./@area"/>
  </xsl:attribute>
  <xsl:attribute name="capital">
    <xsl:value-of select="./@capital"/>
  </xsl:attribute>
  <xsl:attribute name="sea">
    <xsl:value-of select="//sea[located[./@country=$country_name]]/name"/>
  </xsl:attribute>
  <name xmlns="http://xsd_monde/">
    <xsl:value-of select="./name"/>
  </name>
  <population xmlns="http://xsd_monde/">
    <xsl:value-of select="./population"/>
  </population>
  <!-- pays frontaliers -->
  <xsl:apply-templates select="./border"/>
  <!-- montagnes -->
  <xsl:apply-templates select="//mountain[located[./@country=$country_name]]"/>
  <!-- villes -->
  <xsl:apply-templates select="//city[./@country=$country_name]"/>
</country>
</xsl:template>


<!-- borders -->
<xsl:template match="border">
  <border xmlns="http://xsd_monde/">
    <xsl:attribute name="country">
      <xsl:value-of select="./@country"/>
    </xsl:attribute>
  </border>
</xsl:template>

<!-- montagnes -->
<xsl:template match="mountain">
  <mountains xmlns="http://xsd_monde/">
    <xsl:attribute name="id">
      <xsl:value-of select="./@id"/>
    </xsl:attribute>
    <name xmlns="http://xsd_monde/">
      <xsl:value-of select="./name"/>
    </name>
    <altitude xmlns="http://xsd_monde/">
      <xsl:value-of select="./elevation"/>
    </altitude>
  </mountains>
</xsl:template>

<!-- villes -->
<xsl:template match="city">
  <xsl:variable name="city_name" select="./@id"/>
  <xsl:variable name="country_name" select="./@country"/>
  <city xmlns="http://xsd_monde/">
    <xsl:attribute name="id">
      <xsl:value-of select="$city_name"/>
    </xsl:attribute>
    <xsl:attribute name="country">
      <xsl:value-of select="./@country"/>
    </xsl:attribute>
    <xsl:attribute name="river">
      <xsl:value-of select="//river[./@country=$country_name]/@id"/>
    </xsl:attribute>
    <name xmlns="http://xsd_monde/">
      <xsl:value-of select="./name"/>
    </name>
    <population xmlns="http://xsd_monde/">
      <xsl:value-of select="./population"/>
    </population>
    <longitude xmlns="http://xsd_monde/">
      <xsl:value-of select="./longitude"/>
    </longitude>
    <latitude xmlns="http://xsd_monde/">
      <xsl:value-of select="./latitude"/>
    </latitude>
  </city>
</xsl:template>



</xsl:stylesheet>

<!-- a faire  
* optionnel : programmation conditionnelle pour les balises vides
-->