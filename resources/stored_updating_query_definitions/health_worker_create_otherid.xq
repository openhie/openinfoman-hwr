import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@urn)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/otherID/@code))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $position := count($provider/otherID) +1
    let $id := 
      if (exists($careServicesRequest/otherID/@assigningAuthorityName)) then
      <otherID code="{$careServicesRequest/otherID/@code}" assigningAuthorityName="{$careServicesRequest/otherID/@assigningAuthorityName}">{string($careServicesRequest/otherID)}</otherID>
    else 
      <otherID code="{$careServicesRequest/otherID/@code}">{string($careServicesRequest/otherID)}</otherID>
    let $provs3:=  
    <provider urn="{$provider/@urn}">
      <otherID position="{$position}"/>
    </provider>
    return 
      (insert node $id into $provider ,    
      csd_blu:wrap_updating_providers($provs3)
      )
  else  csd_blu:wrap_updating_providers(())
      
