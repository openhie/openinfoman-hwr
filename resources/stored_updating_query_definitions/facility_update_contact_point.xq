import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $fac0 := if (exists($careServicesRequest/contactPoint/@position)) then /CSD/facilityDirectory/*  else ()
let $fac1 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($fac0,$careServicesRequest/id) else ()
let $old_cp := $fac1[1]/contactPoint[position() = $careServicesRequest/contactPoint/@position]
return
  if (count($fac1) = 1 and exists($old_cp)) 
    then
    let $new_cp := $careServicesRequest/contactPoint
    let $fac2 := 
    <facility entityID="{$fac1[1]/@entityID}">
	  <contactPoint position="{$careServicesRequest/contactPoint/@position}"/>
    </facility>
    return
      (
	csd_blu:bump_timestamp($fac1[1]),
	if (exists($new_cp/codedType)) then (delete node $old_cp/codedType,insert node $new_cp/codedType into $old_cp) else (),
	if (exists($new_cp/equipment)) then (delete node $old_cp/equipment,insert node $new_cp/equipment into $old_cp) else (),
	if (exists($new_cp/purpose)) then (delete node $old_cp/purpose,insert node $new_cp/purpose into $old_cp) else (),
	if (exists($new_cp/certificate)) then (delete node $old_cp/certificate,insert node $new_cp/certificate into $old_cp) else (),
	csd_blu:wrap_updating_facilities($fac2)
     )
  else 	csd_blu:wrap_updating_facilities(())

