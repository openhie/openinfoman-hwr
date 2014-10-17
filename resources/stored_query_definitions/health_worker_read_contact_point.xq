import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $provs0 := if (exists($careServicesRequest/contactPoint/@position)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($provs0,$careServicesRequest/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider entityID="{$provider/@entityID}">
      {
	if (exists($careServicesRequest/contactPoint) and exists($careServicesRequest/contactPoint/@position)) 
	  then 
	  <demographic>
	    {
	      for $cp in $provider/demographic/contactPoint[position() = $careServicesRequest/contactPoint/@position]
	      return       <contactPoint position="{$careServicesRequest/contactPoint/@position}">{$cp/*}</contactPoint>
	  }
	  </demographic>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_bl:wrap_providers($provs2)
