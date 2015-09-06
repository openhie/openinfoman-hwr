pimport module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $orgs0 := if (exists($careServicesRequest/otherID/@position)) then /CSD/organizationDirectory/*  else ()
let $orgs1 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($orgs0,$careServicesRequest/id) else ()
let $orgs2 := 
  if (count($orgs1) = 1) 
    then 
    let $organization :=  $orgs1[1] 
    return 
    <organization entityID="{$organization/@entityID}">
      {(
	if (exists($careServicesRequest/otherID/@position))
	  then 
	  for $id in $organization/otherID[position() = $careServicesRequest/otherID/@position]
	  return       
	  <otherID 
	  position="{$careServicesRequest/otherID/@position}"
	  code="{$id/@code}"
	  assigningAuthorityName="{$id/@assigningAuthorityName}">{string($id)}</otherID>
	else
	  ()
        ,      
	$organization/record
	)}
    </organization>
  else ()    
    
return csd_bl:wrap_organizations($orgs2)
