import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $facs0 := 
    if (exists($careServicesRequest/requestParams/id/@entityID)) then 
      csd_bl:filter_by_primary_id(/CSD/facilityDirectory/*,$careServicesRequest/requestParams/id) 
    else (/CSD/facilityDirectory/*)
  let $facs1:=     
      for $facility in  $facs0
      return
      <facility entityID="{$facility/@entityID}">
	<organizations>
          {
	    for $org in $facility/organizations/organization 
	    return
	    <organization entityID="{$org/@entityID}"></organization>
	  }
	</organizations>
      </facility>
      
    return csd_bl:wrap_facilities($facs1)
