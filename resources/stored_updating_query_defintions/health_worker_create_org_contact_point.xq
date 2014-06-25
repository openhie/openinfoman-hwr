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
let $provs3 := if (exists($careServicesRequest/organization/contactPoint))  then $provs2 else ()
return  
  if ( count($provs3) = 1 )
    then
    let $provider:= $provs3[1]
    let $orgs := $provider/organizations/organization[@oid = $careServicesRequest/organization/@oid]
    return 
      if (count($orgs) = 1) 
	then
	let $org := $orgs[1]
	let $position := count($org/contactPoint) +1
	let $new_cp := $careServicesRequest/organization/contactPoint
	let $cp := 
	<contactPoint>
	  {(
	    if (exists($new_cp/codedType)) then  $new_cp/codedType else (),
            if (exists($new_cp/equipment)) then  $new_cp/equipment else (),
            if (exists($new_cp/purpose)) then  $new_cp/purpose else (),
            if (exists($new_cp/certificate)) then  $new_cp/certificate else ()
	   )}
	</contactPoint>
	let $provs3:=  
	<provider oid="{$provider/@oid}">
	  <organizations>
	    <organization oid="{$org/@oid}">
	      <contactPoint position="{$position}"/>
	    </organization>
	  </organizations>
	</provider>
	return 
	  (insert node $cp into $org ,    
	  csd_blu:wrap_updating_providers($provs3)
	)
      else   csd_blu:wrap_updating_providers(())
    else  csd_blu:wrap_updating_providers(())
      
