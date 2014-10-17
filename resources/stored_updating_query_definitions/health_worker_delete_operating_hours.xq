import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
let $provs0 := if (exists($careServicesRequest/facility/@entityID)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/facility/service/operatingHours/@position)) then $provs1  else ()
let $provs3 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($provs2,$careServicesRequest/id) else ()
let $oh := $provs3[1]/facilities/facility[upper-case(@entityID) =upper-case($careServicesRequest/facility/@entityID)]/service[position() = $careServicesRequest/facility/service/@position]/operatingHours[position() = $careServicesRequest/facility/service/operatingHours/@position]
return
  if (count($oh) = 1)
    then (delete node $oh) else ()
