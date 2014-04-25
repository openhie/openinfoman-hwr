import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu" at "../repo/csd_base_library_updating.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@oid)) then	csd:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
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
    <provider oid="{$provider/@oid}">
      <otherID position="{$position}"/>
    </provider>
    return 
      (insert node $id into $provider ,    
      csd_blu:wrap_updating_providers($provs3)
      )
  else  csd_blu:wrap_updating_providers(())
      
