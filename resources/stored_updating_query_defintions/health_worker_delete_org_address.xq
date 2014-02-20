import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu" at "../repo/csd_base_library_updating.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@oid)) then	csd:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/organization/@oid))  then $provs1 else ()
let $provs3 := if (exists($careServicesRequest/organization/address/@type))  then $provs2 else ()
let $provider:= $provs3[1]
let $orgs := $provider/organizations/organization[@oid = $careServicesRequest/organization/@oid]
let $org := if(count($orgs) =1) then $orgs[1] else ()
let $address := $org/address[@type = $careServicesRequest/organization/address/@type]
return if (exists($address)) then (delete node $address) else ()
