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
let $provs2 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id($provs1,$careServicesRequest/requestParams/id) else ()
let $provs3 := 
  if (count($provs2) = 1) 
    then 
    let $provider :=  $provs2[1] 
    return 
    <provider entityID="{$provider/@entityID}">
      {
	if (exists($careServicesRequest/requestParams/facility/@entityID) and exists($careServicesRequest/requestParams/facility/service/@position)) 
	  then 
	  <facilities>
	    <facility entityID="{$careServicesRequest/requestParams/facility/@entityID}">
	    {
	      for $srvc in $provider/facilities/facility[upper-case(@entityID) = upper-case($careServicesRequest/requestParams/facility/@entityID)]/service[position() = $careServicesRequest/requestParams/facility/service/@position]
	      return       <service position="{$careServicesRequest/requestParams/facility/service/@position}" entityID="{$srvc/@entityID}">{$srvc/*}</service>
	  }
	    </facility>
	  </facilities>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_bl:wrap_providers($provs3)
