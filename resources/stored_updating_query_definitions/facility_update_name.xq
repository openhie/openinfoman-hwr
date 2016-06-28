import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $fac0 := if (exists($careServicesRequest/primaryName/@position)) then /CSD/facilityDirectory/*  else ()
let $fac1 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($fac0,$careServicesRequest/id) else ()
let $name := $fac1[1]/primaryName[position() = $careServicesRequest/primaryName/@position]
return
  if (count($fac1) = 1 and exists($name)) 
    then
    let $fac2 := 
    <facility entityID="{$fac1[1]/@entityID}">
	  <name position="{$careServicesRequest/primaryName/@position}"/>
    </facility>
    let $new_name := $careServicesRequest/primaryName
    return
      (
	csd_blu:bump_timestamp($fac1[1]),
	replace  node $name with $new_name,
	csd_blu:wrap_updating_facilities($fac2)
     )
  else 	csd_blu:wrap_updating_facilities(())

