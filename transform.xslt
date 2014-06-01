<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output omit-xml-declaration="yes" indent="yes"/>
<xsl:strip-space elements="*"/>

<!--  A la fin d'une ville, récupère toutes les rivières qui traversent la ville, et les fleuves et montagnes qui la bordent  -->
<xsl:template name="rivieresTraversees" match="located_at">
	<xsl:if test="@watertype='river'">
		<TraverseePar ref="{@river}"/>
	</xsl:if>
	<xsl:if test="@watertype='sea'">
		<BordePar ref="{@sea}"/>
	</xsl:if>
	
</xsl:template>


<!--  Récupères toutes les villes contenues dans un pays  -->
<xsl:template name="ville" match="city">
	<Ville id="{@id}">
		<Nom>
			<xsl:value-of select="name"/>
		</Nom>
		<Population>
			<xsl:value-of select="population"/>
		</Population>	
		<Latitude>
			<xsl:value-of select="latitude"/>
		</Latitude>
			<xsl:value-of select="longitude"/>
		<Longitude>
		</Longitude>
		<xsl:apply-templates select="located_at"/>	
	</Ville>
</xsl:template>

<!--  Récupère toutes les villes contenues dans une province  -->
<xsl:template name="villeDansProvince" match="province">
	<xsl:apply-templates select="city"/> 
</xsl:template>

<!--  Récupère toutes les bordures d'un pays  -->
<xsl:template name="bordures" match="border">
	<Frontalier ref="{@country}"/>
</xsl:template>

<!--  Récupère toutes les rivières de la base  -->
<xsl:template name="rivieres" match="river">  
	<Riviere id="{@id}">
		<Nom>
			<xsl:value-of select="name"/>
		</Nom>
		<Longueur>
			<xsl:value-of select="length"/>
		</Longueur>
	</Riviere>
</xsl:template>

<!--  Récupère tous les continents de de la base 
	  Enregistre le continent actuellement parcouru, et va
	  imbriquer à l'intérieur les pays contenu dans ce continent	  
 -->
<xsl:template match="continent">
    <Continent id="{@id}">
        <Nom>
            <xsl:value-of select="name"/>
        </Nom>
        <Surface>
            <xsl:value-of select="area"/>
        </Surface>
        <xsl:apply-templates select="/mondial/country">
        <xsl:with-param name="continent">
          <xsl:value-of select="@id" />
        </xsl:with-param>
      </xsl:apply-templates>
    </Continent>
  </xsl:template>

<!--  Récupère tous les mers de la base  -->
<xsl:template name="mers" match="sea">
	<Mer id="{@id}">
		<Nom>
			<xsl:value-of select="name"/>
		</Nom>
		<Surface>
			<xsl:value-of select="area"/>
		</Surface>
	</Mer>
</xsl:template>

<!--  Récupère toutes les montagnes de la base  -->
<xsl:template name="montagnes" match="mountain">
	<Montagne id="{@id}">
		<Nom>
			<xsl:value-of select="name"/>
		</Nom>
		<Surface>
			<xsl:value-of select="area"/>
		</Surface>
	</Montagne>
</xsl:template>

<!--  Templates ignorant les autres éléments  -->
<xsl:template name="lacs" match="lake"></xsl:template>
<xsl:template name="organisations" match="organization"></xsl:template>
<xsl:template name="iles" match="island"></xsl:template>
<xsl:template name="déserts" match="desert"></xsl:template>

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

