import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/facility/@oid)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/facility/service/operatingHours)) then $provs1  else ()
let $provs3 := if (exists($careServicesRequest/id/@oid)) then csd_bl:filter_by_primary_id($provs2,$careServicesRequest/id) else ()
let $srvc := $provs3[1]/facilities/facility[@oid =$careServicesRequest/facility/@oid]/service[position() = $careServicesRequest/facility/service/@position]
return if (count($srvc) = 1) 
  then
  let $position := count($srvc/operatingHours)
  let $provs4:=  
  <provider oid="{$careServicesRequest/id/@oid}">
    <facilities>
      <facility oid="{$careServicesRequest/facility/@oid}">
	<service position="{$careServicesRequest/facility/service/@position}" oid="{$careServicesRequest/facility/service/@oid}">
	  <operatingHours position="{$position}" />
	</service>
      </facility>
    </facilities>
  </provider>
  return 
    (insert node $careServicesRequest/facility/service/operatingHours into $srvc[1] ,    
    csd_blu:wrap_updating_providers($provs4)
  )
else   csd_blu:wrap_updating_providers(())
      
