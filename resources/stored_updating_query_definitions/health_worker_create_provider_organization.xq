import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@entityID)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/organization/@entityID))  then $provs1 else ()
let $orgs0 := $provs2/organizations/organization[upper-case(@entityID) = upper-case($careServicesRequest/organization/@entityID)]
let $organizations := $provs2/organizations[1]
return  
  if ( count($provs2) = 1 and count($orgs0) = 0)  (:DO NOT ALLOW SAME ORG TWICE :)
    then
    let $provider:= $provs2[1]
    let $org :=  <organization entityID="{$careServicesRequest/organization/@entityID}"/>
    let $orgs_new :=  <organizations>{$org}</organizations>

    let $provs3:=  
    <provider entityID="{$provider/@entityID}">{$orgs_new}</provider>
    return 
      if (exists($organizations)) 
	then
	(insert node $org into $organizations, 
	csd_blu:wrap_updating_providers($provs3)
	)
      else
	(
	insert node $orgs_new into $provider,
	csd_blu:wrap_updating_providers($provs3)
	)

  else  csd_blu:wrap_updating_providers(())
      
