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
let $provs2 := if (exists($careServicesRequest/facility/@entityID))  then $provs1 else ()
let $provs3 := if (exists($careServicesRequest/facility/service/@entityID))  then $provs2 else ()
let $provider:=   if ( count($provs3) = 1 ) then $provs3[1] else ()
let $facs := $provider/facilities/facility[upper-case(@entityID) = upper-case($careServicesRequest/facility/@entityID)]
let $fac := if (count($facs) = 1) then $facs[1] else ()
return if (exists($fac))
  then
  let $position := count($fac/service) +1
  let $srvc := 
  <service entityID="{$careServicesRequest/facility/service/@entityID}">
    {(
      $careServicesRequest/facility/service/organization,
      $careServicesRequest/facility/service/language,
      $careServicesRequest/facility/service/freeBusyURI
     )}
  </service>
  let $provs3:=  
  <provider entityID="{$provider/@entityID}">
    <facilities>
      <facility entityID="{$fac/@entityID}">
	<service position="{$position}" entityID="{$careServicesRequest/facility/service/@entityID}"/>
      </facility>
    </facilities>
  </provider>
  return 
    (insert node $srvc into $fac ,    
    csd_blu:wrap_updating_providers($provs3)
  )
else   csd_blu:wrap_updating_providers(())
      
