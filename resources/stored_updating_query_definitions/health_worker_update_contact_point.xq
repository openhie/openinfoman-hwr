import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/contactPoint/@position)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($provs0,$careServicesRequest/id) else ()
let $old_cp := $provs1[1]/demographic/contactPoint[position() = $careServicesRequest/contactPoint/@position]
return
  if (count($provs1) = 1 and exists($old_cp)) 
    then
    let $new_cp := $careServicesRequest/contactPoint
    let $provs2 := 
    <provider entityID="{$provs1[1]/@entityID}">
      <demographic>
	<contactPoint position="{$careServicesRequest/contactPoint/@position}"/>
      </demographic>
    </provider>
    return
      (
	csd_blu:bump_timestamp($provs1[1]),
	delete node $old_cp/codeType,
	if (exists($new_cp/codeType)) then insert node $new_cp/codeType into $old_cp else (),
	delete node $old_cp/equipment,
	if (exists($new_cp/equipment)) then insert node $new_cp/equipment into $old_cp else (),
	delete node $old_cp/purpose,
	if (exists($new_cp/purpose)) then insert node $new_cp/purpose into $old_cp else (),
	delete node $old_cp/certificate,
	if (exists($new_cp/certificate)) then insert node $new_cp/certificate into $old_cp else (),
	csd_blu:wrap_updating_providers($provs2)
     )
  else 	csd_blu:wrap_updating_providers(())

