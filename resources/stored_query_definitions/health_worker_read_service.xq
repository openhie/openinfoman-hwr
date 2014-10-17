import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $provs0 := if (exists($careServicesRequest/facility/@entityID)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($provs1,$careServicesRequest/id) else ()
let $provs3 := 
  if (count($provs2) = 1) 
    then 
    let $provider :=  $provs2[1] 
    return 
    <provider entityID="{$provider/@entityID}">
      {
	if (exists($careServicesRequest/facility/@entityID) and exists($careServicesRequest/facility/service/@position)) 
	  then 
	  <facilities>
	    <facility entityID="{$careServicesRequest/facility/@entityID}">
	    {
	      for $srvc in $provider/facilities/facility[upper-case(@entityID) = upper-case($careServicesRequest/facility/@entityID)]/service[position() = $careServicesRequest/facility/service/@position]
	      return       <service position="{$careServicesRequest/facility/service/@position}" entityID="{$srvc/@entityID}">{$srvc/*}</service>
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
