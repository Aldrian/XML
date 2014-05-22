/* 											*/
/*		Requêtes XPath et XQuery - TP XML	*/
/*											*/


/* Capitale de la france */
/* Xpath : */
	//Pays[@id="F"]/Capitale/@ref/string()
/* XQuery : */
	for $d in //Ville
	for $a in //Pays
	where $a/.[@id="F"]
	where $d/.[@id=$a/Capitale/@ref/string()]
	return $d/Nom

/* Pays frontaliers de la France */

	//Pays[@id="F"]/Frontalier/@ref/string()

	for $a in //Pays
	for $b in //Pays
	where $a/.[@id="F"]
	where $b/.[@id=$a/Frontalier/@ref/string()]
	return $b/Nom

/* Liste des Pays traversés par le Danube */

	for $a in //Ville
	for $b in //Riviere
	where $b/Nom/string() = "Donau"
	where $a/TraverseePar/@ref = $b/@id
	return $a

/* Pays ayant au moins une ville de plus d'un million d'habitants */

	for $a in //Pays
	where $a/Ville/Population > 1000000
	return $a/Nom

/* Rivières d'Europe */

	for $b in //Continent	(:Europe:)
	for $c in //Pays	(:Pays d'Europe:)
	for $a in //Riviere
	where $b/Nom/string() = "Europe"
	where $c/ContenuDans/@continent = $b/@id
	where $a/@id = $c/Ville/TraverseePar/@ref
	return $a/Nom/string()

/* 