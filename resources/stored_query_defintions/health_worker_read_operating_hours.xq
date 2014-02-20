import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
let $provs0 := if (exists($careServicesRequest/facility/@oid)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/facility/service/operatingHours/@position)) then $provs1  else ()
let $provs3 := if (exists($careServicesRequest/id/@oid)) then csd:filter_by_primary_id($provs2,$careServicesRequest/id) else ()
let $srvc := $provs3[1]/facilities/facility[@oid =$careServicesRequest/facility/@oid]/service[position() = $careServicesRequest/facility/service/@position]
let  $provs4:=   
  if (count($srvc) = 1) 
    then
    let $oh := $srvc/operatingHours[position() = $careServicesRequest/facility/service/operatingHours/@position]
    return <provider oid="{$careServicesRequest/id/@oid}">
      <facilities>
	<facility oid="{$careServicesRequest/facility/@oid}">
	  <service position="{$careServicesRequest/facility/service/@position}" >
	    <operatingHours position="{$careServicesRequest/facility/service/operatingHours/@position}">{$oh/*}</operatingHours>
	  </service>
	</facility>
      </facilities>
      {$careServicesRequest}
    </provider>
  else ()


return csd:wrap_providers($provs4)
