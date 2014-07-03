import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@oid)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/facility/@oid))  then $provs1 else ()
let $provs3 := if (exists($careServicesRequest/facility/service/@oid))  then $provs2 else ()
let $provider:=   if ( count($provs3) = 1 ) then $provs3[1] else ()
let $facs := $provider/facilities/facility[@oid = $careServicesRequest/facility/@oid]
let $fac := if (count($facs) = 1) then $facs[1] else ()
return if (exists($fac))
  then
  let $position := count($fac/service) +1
  let $srvc := 
  <service oid="{$careServicesRequest/facility/service/@oid}">
    {(
      $careServicesRequest/facility/service/organization,
      $careServicesRequest/facility/service/language,
      $careServicesRequest/facility/service/freeBusyURI
     )}
  </service>
  let $provs3:=  
  <provider oid="{$provider/@oid}">
    <facilities>
      <facility oid="{$fac/@oid}">
	<service position="{$position}" oid="{$careServicesRequest/facility/service/@oid}"/>
      </facility>
    </facilities>
  </provider>
  return 
    (insert node $srvc into $fac ,    
    csd_blu:wrap_updating_providers($provs3)
  )
else   csd_blu:wrap_updating_providers(())
      
