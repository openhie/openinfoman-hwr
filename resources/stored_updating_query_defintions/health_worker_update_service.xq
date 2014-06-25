import module namespace csd_bl = "https://github.com/his-interop/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/facility/@oid)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/id/@oid)) then csd_bl:filter_by_primary_id($provs1,$careServicesRequest/id) else ()
let $old_srvc := $provs2[1]/facilities/facility[@oid =$careServicesRequest/facility/@oid]/service[position() = $careServicesRequest/facility/service/@position]
return
  if (count($provs2) = 1 and exists($old_srvc)) 
    then
    let $new_srvc := $careServicesRequest/facility/service
    let $provs3 := 
    <provider oid="{$provs1[1]/@oid}">
      <facilities>
	<facility oid="{$careServicesRequest/facility/@oid}">
	  <service position="{$careServicesRequest/facility/service/@position}" />
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

