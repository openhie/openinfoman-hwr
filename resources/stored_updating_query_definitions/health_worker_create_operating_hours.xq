import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/requestParams/facility/@entityID)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/requestParams/facility/service/operatingHours)) then $provs1  else ()
let $provs3 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id($provs2,$careServicesRequest/requestParams/id) else ()
let $srvc := $provs3[1]/facilities/facility[upper-case(@entityID) = upper-case($careServicesRequest/requestParams/facility/@entityID)]/service[position() = $careServicesRequest/requestParams/facility/service/@position]
return if (count($srvc) = 1) 
  then
  let $position := count($srvc/operatingHours)
  let $provs4:=  
  <provider entityID="{$careServicesRequest/requestParams/id/@entityID}">
    <facilities>
      <facility entityID="{$careServicesRequest/requestParams/facility/@entityID}">
	<service position="{$careServicesRequest/requestParams/facility/service/@position}" entityID="{$careServicesRequest/requestParams/facility/service/@entityID}">
	  <operatingHours position="{$position}" />
	</service>
      </facility>
    </facilities>
  </provider>
  return 
    (insert node $careServicesRequest/requestParams/facility/service/operatingHours into $srvc[1] ,    
    csd_blu:wrap_updating_providers($provs4)
  )
else   csd_blu:wrap_updating_providers(())
      
