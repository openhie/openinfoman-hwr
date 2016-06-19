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
let $orgs2 := if (exists($careServicesRequest/contactPoint))  then $orgs1 else ()
return  
  if ( count($orgs2) = 1 )
    then
    let $organization:= $orgs2[1]
    let $position := count($organization/contactPoint) +1
    let $cp := 
      <contactPoint>
	{(
	  if (exists($careServicesRequest/contactPoint/codedType)) then  $careServicesRequest/contactPoint/codedType else (),
	  if (exists($careServicesRequest/contactPoint/equipment)) then  $careServicesRequest/contactPoint/equipment else (),
	  if (exists($careServicesRequest/contactPoint/purpose)) then  $careServicesRequest/contactPoint/purpose else (),
	  if (exists($careServicesRequest/contactPoint/certificate)) then  $careServicesRequest/contactPoint/certificate else ()
	 )}
      </contactPoint>
    let $orgs3:=  
    <organization entityID="{$organization/@entityID}">
	<contactPoint position="{$position}"/>
    </organization>
    return 
      (insert node $cp into $organization ,    
      csd_blu:wrap_updating_organizations($orgs3)
      )
  else  csd_blu:wrap_updating_organizations(())
      
