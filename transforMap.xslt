<?xml version="1.0" standalone="no"?>

<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns="http://www.w3.org/2000/svg"
width="800" height="800" >


<!--  Pays traité uniquement si son continent est actuellement traité  -->
<xsl:template match="country">
	<xsl:param name="continent" />
    <xsl:if test="encompassed/@continent = $continent">
	    <Pays id="{@car_code}">
		    <Nom> 
		    	<xsl:value-of select="name"/>
		  	</Nom>
		  	<Surface>
		  		<xsl:value-of select="@area" />
		  	</Surface>
		  	
		  	<Population>
		  		<xsl:value-of select="population" />
		  	</Population>

		  	<xsl:apply-templates select="province"/> 
		  	<xsl:apply-templates select="city"/> 

	   		<xsl:apply-templates select="border"/>
		  	<Capitale ref="{@capital}"/>
	    </Pays>
	</xsl:if>               
</xsl:template>

<!-- Template principal -->
<xsl:template match="mondial">
	<Monde>
		<xsl:apply-templates select="continent"/>    
		<xsl:apply-templates select="river"/>       
		<xsl:apply-templates select="mountain"/>
		<xsl:apply-templates select="sea"/>
		<xsl:apply-templates select="lake"/>
		<xsl:apply-templates select="island"/>
		<xsl:apply-templates select="organization"/>
		<xsl:apply-templates select="desert"/>
	</Monde>
</xsl:template>

</xsl:stylesheet>

