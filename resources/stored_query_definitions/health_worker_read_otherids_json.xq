import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;




(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $provs1 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id( /CSD/providerDirectory/*,$careServicesRequest/requestParams/id) else ()
let $provider :=  $provs1[1] 
let $other_ids := 
  if ($careServicesRequest/requestParams/code/text())
  then $provider/otherID[@code = $careServicesRequest/requestParams/code/text()]
  else $provider/otherID
let $xml:= 
  <json  type="object">
    <entityID>{string($provider/@entityID)}</entityID>
    <otherID type="array">
      {
	for $id in $other_ids 
	return       
	  <_ type='object'>
	    <code>{string($id/@code)}</code>
	    <authority>{string($id/@assigningAuthorityName)}</authority>
	    <value>{$id/text()}</value>
	 </_>
      }
    </otherID>
  </json>
return json:serialize($xml,map{"format":"direct"})  
