import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@urn)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/organization/@urn))  then $provs1 else ()
let $provs3 := if (exists($careServicesRequest/organization/address/@type))  then $provs2 else ()
let $provider:= $provs3[1]
let $org_container := $provider/organizations[1]
let $orgs := $provider/organizations/organization[@urn = $careServicesRequest/organization/@urn]
let $org := if(count($orgs) =1) then $orgs[1] else ()
let $address := $org/address[@type = $careServicesRequest/organization/address/@type]
return if (not(exists($address)))
  then   csd_blu:wrap_updating_providers((<bad0/>,$careServicesRequest)) (:do not update an non-existent one :)
else
  (
    csd_blu:bump_timestamp($provider),
    replace node $address with  $careServicesRequest/organization/address ,
     csd_blu:wrap_updating_providers(    
       <provider urn="{$provider/@urn}">
	 <organizations>
	   <organization urn="{$org/@urn}">
	     <contactPoint position="{$address/@type}"/>
	   </organization>
	 </organizations>
       </provider>
    )
)
