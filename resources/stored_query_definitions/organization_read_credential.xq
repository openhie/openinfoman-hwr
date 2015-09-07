import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $orgs0 := if (exists($careServicesRequest/credential/codedType/@code) and exists($careServicesRequest/credential/codedType/@codingScheme) ) then /CSD/organizationDirectory/*  else ()
let $orgs1 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($orgs0,$careServicesRequest/id) else ()
let $orgs2 := 
  if (count($orgs1) = 1) 
    then 
    let $organization :=  $orgs1[1] 
    let $code:= $careServicesRequest/credential/codedType/@code
    let $codingScheme:= $careServicesRequest/credential/codedType/@codingScheme
    return 
      <organization entityID="{$organization/@entityID}">
	  {
	    (
	      $organization/credential/codedType[@code = $code and @codingScheme = $codingScheme]/..
	      ,
	      $organization/record
	    )
	  }
      </organization>
  else ()    
    
return csd_bl:wrap_organizations($orgs2)
