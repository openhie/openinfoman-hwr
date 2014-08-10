import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $provs0 := 
    if (exists($careServicesRequest/id/@urn)) then 
      csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) 
    else (/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider urn="{$provider/@urn}">
	<facilities>
	  {
	    let $facs := 
	      if (exists($careServicesRequest/facility/@urn)) 
		then 
		$provider/facilities/facility[@urn = $careServicesRequest/facility/@urn]
	      else    $provider/facilities/facility
            for $fac in $facs
	      return 
	       <facility urn="{$fac/@urn}">
		  {
		    for $srvc at $pos in $fac/service
		    return <service position="{$pos}" urn="{$srvc/@urn}"/> 
		  }
		</facility>
	  }
	</facilities>
    </provider>
      
    return csd_bl:wrap_providers($provs1)
