<html>
  <header>
    <title>Carte du monde</title>
  </header>
  <body>
  <svg width="100%" height="100%" >
    <rect width = "100%" height = "100%" fill ="gray" />
  {
    for $cities in //city
    where $cities/string(population) != ""
    and $cities/string(longitude) != ""
    and $cities/string(latitude) != ""
    let $pop := $cities/number(population) div 4000000
    let $lgX := (180+$cities/number(longitude))*(100 div 360)
    let $lgY := (90-$cities/number(latitude))*(100 div 160) 
    return 
    <g>
      <circle cx="{$lgX}%" cy="{$lgY}%" r="{$pop}%" fill="black" />
      {
        if($pop > 0.3)
        then <text x="{$txt_lgX}%" y="{$lgY}%" fill="white" font-size="7px">{$cities/string(name)}</text>
        else ()
      }
    </g>
  }
  </svg>
  </body>
</html> 