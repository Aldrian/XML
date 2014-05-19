<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output omit-xml-declaration="yes" indent="yes"/>
<xsl:strip-space elements="*"/>

<!------------------------------------------------------------->
<!-- Premier parsing du fichier pour récupérer les continents-->
<!------------------------------------------------------------->



<!------------------------------------------------------------->
<!----Templates appelés quand arrivés au bon niveau des nodes-->
<!------------------------------------------------------------->



<!----A la fin d'une ville, récupère toutes les rivières qui traversent la ville-->
<xsl:template name="rivieresTraversees" match="located_at">
	<xsl:if test="@watertype='river'">
		<TraverseePar>
			<xsl:value-of select="@river"/>
		</TraverseePar>
	</xsl:if>
</xsl:template>



<!----Récupères toutes les villes contenues dans un pays-->
<xsl:template name="ville" match="city">
	<Ville id="{@id}">
		<Nom>
			<xsl:value-of select="name"/>
		</Nom>
		<Population>
			<xsl:value-of select="population"/>
		</Population>	
		<xsl:apply-templates select="located_at"/>	
	</Ville>
</xsl:template>



<!----Récupère toutes les bordures d'un pays-->
<xsl:template name="bordures" match="border">
	<Frontalier ref="{@country}"/>
</xsl:template>


<!----Récupère les continents dans lequel le pays est encapsulé /!\ Bientôt obsolète-->
<xsl:template name="contenuDans" match="encompassed">
	<ContenuDans continent="{@continent}"/>
</xsl:template>


<!----Récupère toutes les rivières de la base-->
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


<!----Récupère tous les continents de la base-->
<xsl:template name="continents" match="continent">
	<Continent id="{@id}">
		<Nom>
			<xsl:value-of select="name"/>
		</Nom>
		<Surface>
			<xsl:value-of select="area"/>
		</Surface>
	</Continent>
</xsl:template>


<!----Template principal -->
<xsl:template match="country">
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

	  	<xsl:apply-templates select="encompassed"/> 
	  	<xsl:apply-templates select="city"/> 
   		<xsl:apply-templates select="border"/>
	  	<Capitale ref="{@capital}"/>
    </Pays>
    <xsl:apply-templates select="river"/>
    <xsl:apply-templates select="continent"/>
</xsl:template>
</xsl:stylesheet>

