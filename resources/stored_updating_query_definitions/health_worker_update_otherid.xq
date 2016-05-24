import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/requestParams/otherID)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id($provs0,$careServicesRequest/requestParams/id) else ()
let $id := $provs1[1]/otherID[position() = $careServicesRequest/requestParams/otherID/@position]
return
  if (count($provs1) = 1 and exists($id)) 
    then
    let $provs2 := 
    <provider entityID="{$provs1[1]/@entityID}">
      <otherID position="{$careServicesRequest/requestParams/otherID/@position}"/>
    </provider>
    return
      (
	csd_blu:bump_timestamp($provs1[1]),
	if ($careServicesRequest/requestParams/otherID/@code) 
	  then 	    
	    if (exists($id/@code))
	      then  (replace value of node $id/@code with $careServicesRequest/requestParams/otherID/@code)
	      else (insert node  $careServicesRequest/requestParams/otherID/@code into $id)
	  else (),
	if (exists($careServicesRequest/requestParams/otherID/@assigningAuthorityName) )
	  then 
	    if (exists($id/@assigningAuthorityName))
	      then replace value of node $id/@assigningAuthorityName with $careServicesRequest/requestParams/otherID/@assigningAuthorityName
	      else insert node $careServicesRequest/requestParams/otherID/@assigningAuthorityName into $id		
	  else (),
	if (not(string($careServicesRequest/requestParams/otherID) = '')) 
	  then (replace value of node $id with string($careServicesRequest/requestParams/otherID))
	  else (),
	csd_blu:wrap_updating_providers($provs2)
     )
  else 	csd_blu:wrap_updating_providers(())

