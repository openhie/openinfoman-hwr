import module namespace csd_bl = "https://github.com/his-interop/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@oid)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/organization/@oid))  then $provs1 else ()
let $provs3 := if (exists($careServicesRequest/organization/address/@type))  then $provs2 else ()
let $provider:= $provs3[1]
let $orgs := $provider/organizations/organization[@oid = $careServicesRequest/organization/@oid]
let $org := if(count($orgs) =1) then $orgs[1] else ()
let $address := $org/address[@type = $careServicesRequest/organization/address/@type]
return if (not(exists($org)) or exists($address))
  then   csd_blu:wrap_updating_providers(()) (:do not create an already existing one :)	  
else
  (
    insert node $careServicesRequest/organization/address into $org,
    csd_blu:wrap_updating_providers(    
	<provider oid="{$provider/@oid}">
	  <organizations>
	    <organization oid="{$org/@oid}">
	      <contactPoint position="{$careServicesRequest/organization/address/@type}"/>
	    </organization>
	  </organizations>
	</provider>
     )
)
