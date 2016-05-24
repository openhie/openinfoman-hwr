import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $orgs0 := 
    if (exists($careServicesRequest/requestParams/id/@entityID)) then 
      csd_bl:filter_by_primary_id(/CSD/organizationDirectory/*,$careServicesRequest/requestParams/id) 
    else (/CSD/organizationDirectory/*)
  let $orgs1:=     
      for $organization in  $orgs0
      return
      <organization entityID="{$organization/@entityID}">
	{
	  for $id at $pos  in  $organization/otherID
	  return <otherID position="{$pos}"/> 
	}
    </organization>
      
    return csd_bl:wrap_organizations($orgs1)
