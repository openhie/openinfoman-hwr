import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $orgs0 := if (exists($careServicesRequest/id/@entityID)) then	csd_bl:filter_by_primary_id(/CSD/organizationDirectory/*,$careServicesRequest/id) else ()
let $orgs1 := if (count($orgs0) = 1) then $orgs0 else ()
let $orgs2 := if (exists($careServicesRequest/otherID/@code))  then $orgs1 else ()
return  
  if ( count($orgs2) = 1 )
    then
    let $organization:= $orgs2[1]
    let $position := count($organization/otherID) +1
    let $id := 
      if (exists($careServicesRequest/otherID/@assigningAuthorityName)) then
      <otherID code="{$careServicesRequest/otherID/@code}" assigningAuthorityName="{$careServicesRequest/otherID/@assigningAuthorityName}">{string($careServicesRequest/otherID)}</otherID>
    else 
      <otherID code="{$careServicesRequest/otherID/@code}">{string($careServicesRequest/otherID)}</otherID>
    let $orgs3:=  
    <organization entityID="{$organization/@entityID}">
      <otherID position="{$position}"/>
    </organization>
    return 
      (insert node $id into $organization ,    
      csd_blu:wrap_updating_organizations($orgs3)
      )
  else  csd_blu:wrap_updating_organizations(())
      
