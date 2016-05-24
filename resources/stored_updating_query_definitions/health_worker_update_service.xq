import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/requestParams/facility/@entityID)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/requestParams/id/@entityID)) then csd_bl:filter_by_primary_id($provs1,$careServicesRequest/requestParams/id) else ()
let $old_srvc := $provs2[1]/facilities/facility[upper-case(@entityID) =upper-case($careServicesRequest/requestParams/facility/@entityID)]/service[position() = $careServicesRequest/requestParams/facility/service/@position]
return
  if (count($provs2) = 1 and exists($old_srvc)) 
    then
    let $new_srvc := $careServicesRequest/requestParams/facility/service
    let $provs3 := 
    <provider entityID="{$provs1[1]/@entityID}">
      <facilities>
	<facility entityID="{$careServicesRequest/requestParams/facility/@entityID}">
	  <service position="{$careServicesRequest/requestParams/facility/service/@position}" />
	</facility>
      </facilities>
    </provider>
    return
      (
	csd_blu:bump_timestamp($provs2[1]),
	delete node $old_srvc/freeBusyURI,
	if (exists($new_srvc/freeBusyURI)) then insert node $new_srvc/freeBusyURI into $old_srvc else (),
	delete node $old_srvc/organization,
	if (exists($new_srvc/organization)) then insert node $new_srvc/organization into $old_srvc else (),
	delete node $old_srvc/language,
	if (exists($new_srvc/language)) then insert node $new_srvc/language into $old_srvc else (),
	csd_blu:wrap_updating_providers($provs3)
     )
  else 	csd_blu:wrap_updating_providers(())

