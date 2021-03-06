import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 

let $facs0 := if (exists($careServicesRequest/organization/@entityID)) then /CSD/providerDirectory/*  else ()
let $facs1 := if (exists($careServicesRequest/organization/service/@position)) then $facs0  else ()
let $facs2 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($facs1,$careServicesRequest/id) else ()
let $facs3 := 
  if (count($facs2) = 1) 
    then 
    let $facility :=  $facs2[1] 
    return 
    <facility entityID="{$facility/@entityID}">
      {
	if (exists($careServicesRequest/organization/@entityID) and exists($careServicesRequest/organization/service/@position)) 
	  then 
	  <organizations>
	    <organization entityID="{$careServicesRequest/organization/@entityID}">
	    {
	      for $srvc in $facility/organizations/organization[upper-case(@entityID) = upper-case($careServicesRequest/organization/@entityID)]/service[position() = $careServicesRequest/organization/service/@position]
	      return       <service position="{$careServicesRequest/organization/service/@position}" entityID="{$srvc/@entityID}">{$srvc/*}</service>
	  }
	    </organization>
	  </organizations>
	else
	  ()
      }
      {$facility/record}
    </facility>
  else ()    
    
return csd_bl:wrap_facilities($facs3)
