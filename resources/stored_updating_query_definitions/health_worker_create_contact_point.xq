import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/requestParams/id/@entityID)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/requestParams/contactPoint))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $position := count($provider/demographic/contactPoint) +1
    let $cp := 
      <contactPoint>
	{(
	  if (exists($careServicesRequest/requestParams/contactPoint/codedType)) then  $careServicesRequest/requestParams/contactPoint/codedType else (),
	  if (exists($careServicesRequest/requestParams/contactPoint/equipment)) then  $careServicesRequest/requestParams/contactPoint/equipment else (),
	  if (exists($careServicesRequest/requestParams/contactPoint/purpose)) then  $careServicesRequest/requestParams/contactPoint/purpose else (),
	  if (exists($careServicesRequest/requestParams/contactPoint/certificate)) then  $careServicesRequest/requestParams/contactPoint/certificate else ()
	 )}
      </contactPoint>
    let $provs3:=  
    <provider entityID="{$provider/@entityID}">
      <demographic>
	<contactPoint position="{$position}"/>
      </demographic>
    </provider>
    return 
      (insert node $cp into $provider/demographic ,    
      csd_blu:wrap_updating_providers($provs3)
      )
  else  csd_blu:wrap_updating_providers(())
      
