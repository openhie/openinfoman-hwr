import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $provs0 := 
    if (exists($careServicesRequest/id/@oid)) then 
      csd:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) 
    else (/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<organizations>
	  {
	    let $orgs := 
	      if (exists($careServicesRequest/organization/@oid)) 
		then 
		$provider/organizations/organization[@oid = $careServicesRequest/organization/@oid]
	      else    $provider/organizations/organization
            for $org in $orgs
	      return 
	       <organization oid="{$org/@oid}">
		  {
		    for $cp at $pos in $org/contactPoint
		    return <contactPoint position="{$pos}"/> 
		  }
		</organization>
	  }
	</organizations>
    </provider>
      
    return csd:wrap_providers($provs1)
