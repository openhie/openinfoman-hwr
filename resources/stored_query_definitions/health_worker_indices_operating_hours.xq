import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $provs0 := 
    if (exists($careServicesRequest/id/@entityID)) then 
      csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) 
    else (/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider entityID="{$provider/@entityID}">
	<facilities>
	  {
	    let $facs := 
	      if (exists($careServicesRequest/facility/@entityID)) 
		then 
		$provider/facilities/facility[upper-case(@entityID) = upper-case($careServicesRequest/facility/@entityID)]
	      else    $provider/facilities/facility
            for $fac in $facs
	      return 
	       <facility entityID="{$fac/@entityID}">
		  {
		    if ($careServicesRequest/facility/service/@position) 
		      then
			for $srvc in $fac/service[position()= $careServicesRequest/facility/service/@position] 
			return 
			<service position="{$careServicesRequest/facility/service/@position}">
			  {for $oh at $ohpos in $srvc/operatingHours return <operatingHours position="{$ohpos}"/>}
			</service>
		    else 
		      for $srvc at $spos in $fac/service
			return 
			<service position="{$spos}">
			  {for $oh at $ohpos in $srvc/operatingHours return <operaingHours position="{$ohpos}"/>}
			</service>
		  }
		</facility>
	  }
	</facilities>
    </provider>
      
    return csd_bl:wrap_providers($provs1)
