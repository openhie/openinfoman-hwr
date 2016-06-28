import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
let $fac0 := if (exists($careServicesRequest/organization/@entityID)) then /CSD/facilityDirectory/*  else ()
let $fac1 := if (exists($careServicesRequest/organization/service/@position)) then $fac0  else ()
let $fac2 := if (exists($careServicesRequest/organization/service/operatingHours/@position)) then $fac1  else ()
let $fac3 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($fac2,$careServicesRequest/id) else ()
let $oh := $fac3[1]/organizations/organization[upper-case(@entityID) =upper-case($careServicesRequest/organization/@entityID)]/service[position() = $careServicesRequest/organization/service/@position]/operatingHours[position() = $careServicesRequest/organization/service/operatingHours/@position]
return
  if (count($oh) = 1)
    then (delete node $oh) else ()
