import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
let $provs0 := if (exists($careServicesRequest/requestParams/facility/@entityID)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/requestParams/facility/service/operatingHours/@position)) then $provs1  else ()
let $provs3 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id($provs2,$careServicesRequest/requestParams/id) else ()
let $srvc := $provs3[1]/facilities/facility[upper-case(@entityID) =upper-case($careServicesRequest/requestParams/facility/@entityID)]/service[position() = $careServicesRequest/requestParams/facility/service/@position]
let  $provs4:=   
  if (count($srvc) = 1) 
    then
    let $oh := $srvc/operatingHours[position() = $careServicesRequest/requestParams/facility/service/operatingHours/@position]
    return <provider entityID="{$careServicesRequest/requestParams/id/@entityID}">
      <facilities>
	<facility entityID="{$careServicesRequest/requestParams/facility/@entityID}">
	  <service position="{$careServicesRequest/requestParams/facility/service/@position}" >
	    <operatingHours position="{$careServicesRequest/requestParams/facility/service/operatingHours/@position}">{$oh/*}</operatingHours>
	  </service>
	</facility>
      </facilities>
      {$careServicesRequest}
    </provider>
  else ()


return csd_bl:wrap_providers($provs4)
