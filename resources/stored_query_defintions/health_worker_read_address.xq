import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $provs0 := if (exists($careServicesRequest/address/@type)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/id/@oid)) then csd:filter_by_primary_id($provs0,$careServicesRequest/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider oid="{$provider/@oid}">
      <demographic>
	{(
	  for $address in $provider/demographic/address[@type = $careServicesRequest/address/@type]
	  return $address
	 )}
      </demographic>
      {$provider/record}
    </provider>
  else ()        
return csd:wrap_providers($provs2)
