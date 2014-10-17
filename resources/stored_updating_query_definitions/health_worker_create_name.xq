import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@entityID)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/name))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $position := count($provider/demographic/name) +1
    let $provs3:=  
    <provider entityID="{$provider/@entityID}">
      <demographic>
	<name position="{$position}"/>
      </demographic>
    </provider>
    return 
      (
	if (exists($provider/demographic))
	  then insert node $careServicesRequest/name into $provider/demographic 
	else
	  insert node <demographic>{$careServicesRequest/name}</demographic> into $provider
	  ,   csd_blu:wrap_updating_providers($provs3)
	)
  else  csd_blu:wrap_updating_providers(())
      
