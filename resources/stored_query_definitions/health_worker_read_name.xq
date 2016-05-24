import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $provs0 := if (exists($careServicesRequest/requestParams/name/@position)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id($provs0,$careServicesRequest/requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider entityID="{$provider/@entityID}">
      {
	if (exists($careServicesRequest/requestParams/name) and exists($careServicesRequest/requestParams/name/@position)) 
	  then 
	  <demographic>
	    {
	      for $name in $provider/demographic/name[position() = $careServicesRequest/requestParams/name/@position]
	      return       <name position="{$careServicesRequest/requestParams/name/@position}">{$name/*}</name>
	  }
	  </demographic>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_bl:wrap_providers($provs2)
