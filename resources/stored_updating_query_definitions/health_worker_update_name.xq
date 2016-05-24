import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/requestParams/name/@position)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id($provs0,$careServicesRequest/requestParams/id) else ()
let $name := $provs1[1]/demographic/name[position() = $careServicesRequest/requestParams/name/@position]
return
  if (count($provs1) = 1 and exists($name)) 
    then
    let $provs2 := 
    <provider entityID="{$provs1[1]/@entityID}">
      <demographic>
	<name position="{$careServicesRequest/requestParams/name/@position}"/>
      </demographic>
    </provider>
    let $new_name := 
    <name>
     {$careServicesRequest/requestParams/name/*}
    </name>
    return
      (
	csd_blu:bump_timestamp($provs1[1]),
	replace  node $name with $new_name,
	csd_blu:wrap_updating_providers($provs2)
     )
  else 	csd_blu:wrap_updating_providers(())

