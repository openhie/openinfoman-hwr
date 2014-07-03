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
let $facs0 := $provs2/facilities/facility[@oid = $careServicesRequest/facility/@oid]
let $facilities := $provs2/facilities[1]
return  
  if ( count($provs2) = 1 and count($facs0) = 0)  (:DO NOT ALLOW SAME ORG TWICE :)
    then
    let $provider:= $provs2[1]
    let $fac :=  <facility oid="{$careServicesRequest/facility/@oid}"/>
    let $facs_new :=  <facilities>{$fac}</facilities>

    let $provs3:=  
    <provider oid="{$provider/@oid}">{$facs_new}</provider>
    return 
      if (exists($facilities)) 
	then
	(insert node $fac into $facilities, 
	csd_blu:wrap_updating_providers($provs3)
	)
      else
	(
	insert node $facs_new into $provider,
	csd_blu:wrap_updating_providers($provs3)
	)

  else  csd_blu:wrap_updating_providers(())
      
