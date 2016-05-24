import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $facs0 := if (exists($careServicesRequest/requestParams/contactPoint/@position)) then /CSD/facilityDirectory/*  else ()
let $facs1 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id($facs0,$careServicesRequest/requestParams/id) else ()
let $facs2 := 
  if (count($facs1) = 1) 
    then 
    let $facility :=  $facs1[1] 
    return 
    <facility entityID="{$facility/@entityID}">
      {
	if (exists($careServicesRequest/requestParams/contactPoint) and exists($careServicesRequest/requestParams/contactPoint/@position)) 
	  then 
	      for $cp in $facility/contactPoint[position() = $careServicesRequest/requestParams/contactPoint/@position]
	      return       <contactPoint position="{$careServicesRequest/requestParams/contactPoint/@position}">{$cp/*}</contactPoint>
	else
	  ()
      }
      {$facility/record}
    </facility>
  else ()    
    
return csd_bl:wrap_facilities($facs2)
