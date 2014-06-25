import module namespace csd_bl = "https://github.com/his-interop/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $provs0 := 
    if (exists($careServicesRequest/id/@oid)) then 
      csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) 
    else (/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<facilities>
	  {
	    let $facs := 
	      if (exists($careServicesRequest/facility/@oid)) 
		then 
		$provider/facilities/facility[@oid = $careServicesRequest/facility/@oid]
	      else    $provider/facilities/facility
            for $fac in $facs
	      return 
	       <facility oid="{$fac/@oid}">
		  {
		    for $srvc at $pos in $fac/service
		    return <service position="{$pos}" oid="{$srvc/@oid}"/> 
		  }
		</facility>
	  }
	</facilities>
    </provider>
      
    return csd_bl:wrap_providers($provs1)
