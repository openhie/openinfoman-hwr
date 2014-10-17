import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/facility/@entityID)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($careServicesRequest/facility/service/operatingHours/@position)) then $provs1  else ()
let $provs3 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($provs2,$careServicesRequest/id) else ()
let $oh := $provs3[1]/facilities/facility[upper-case(@entityID) =upper-case($careServicesRequest/facility/@entityID)]/service[position() = $careServicesRequest/facility/service/@position]/operatingHours[position() = $careServicesRequest/facility/service/operatingHours/@position]
return
  if (count($oh) = 1 and count($provs3) = 1)
    then
    let $new_oh := $careServicesRequest/facility/service/operatingHours
    let $provs4 := 
    <provider entityID="{$provs1[1]/@entityID}">
      <facilities>
	<facility entityID="{$careServicesRequest/facility/@entityID}">
	  <service position="{$careServicesRequest/facility/service/@position}" >
	    <operatingHours position="{$careServicesRequest/facility/service/operatingHours/@position}"/>
	  </service>
	</facility>
      </facilities>
    </provider>
    return
      (
	csd_blu:bump_timestamp($provs3[1]),
	delete node $oh/openFlag,
	if (exists($new_oh/openFlag)) then insert node $new_oh/openFlag into $oh else (),
	delete node $oh/dayOfTheWeek,
	if (exists($new_oh/dayOfTheWeek)) then insert node $new_oh/dayOfTheWeek into $oh else (),
	delete node $oh/beginningHour,
	if (exists($new_oh/beginningHour)) then insert node $new_oh/beginningHour into $oh else (),
	delete node $oh/endingHour,
	if (exists($new_oh/endingHour)) then insert node $new_oh/endingHour into $oh else (),
	delete node $oh/beginEffectiveDate,
	if (exists($new_oh/beginEffectiveDate)) then insert node $new_oh/beginEffectiveDate into $oh else (),
	delete node $oh/endEffectiveDate,
	if (exists($new_oh/endEffectiveDate)) then insert node $new_oh/endEffectiveDate into $oh else (),
	csd_blu:wrap_updating_providers($provs4)
     )
  else 	csd_blu:wrap_updating_providers(())

