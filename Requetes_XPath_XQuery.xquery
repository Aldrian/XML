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
