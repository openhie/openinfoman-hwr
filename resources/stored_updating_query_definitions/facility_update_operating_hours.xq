import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $fac0 := if (exists($careServicesRequest/organization/@entityID)) then /CSD/facilityDirectory/*  else ()
let $fac1 := if (exists($careServicesRequest/organization/service/@position)) then $fac0  else ()
let $fac2 := if (exists($careServicesRequest/organization/service/operatingHours/@position)) then $fac1  else ()
let $fac3 := if (exists($careServicesRequest/id/@entityID)) then csd_bl:filter_by_primary_id($fac2,$careServicesRequest/id) else ()
let $oh := $fac3[1]/organizations/organization[upper-case(@entityID) =upper-case($careServicesRequest/organization/@entityID)]/service[position() = $careServicesRequest/organization/service/@position]/operatingHours[position() = $careServicesRequest/organization/service/operatingHours/@position]
return
  if (count($oh) = 1 and count($fac3) = 1)
    then
    let $new_oh := $careServicesRequest/organization/service/operatingHours
    let $fac4 := 
    <facility entityID="{$fac1[1]/@entityID}">
      <organizations>
	<organization entityID="{$careServicesRequest/organization/@entityID}">
	  <service position="{$careServicesRequest/organization/service/@position}" >
	    <operatingHours position="{$careServicesRequest/organization/service/operatingHours/@position}"/>
	  </service>
	</organization>
      </organizations>
    </facility>
    return
      (
	csd_blu:bump_timestamp($fac3[1]),
	if (exists($new_oh/openFlag)) then (delete node $oh/openFlag,insert node $new_oh/openFlag into $oh) else (),
	if (exists($new_oh/dayOfTheWeek)) then (delete node $oh/dayOfTheWeek,insert node $new_oh/dayOfTheWeek into $oh) else (),
	if (exists($new_oh/beginningHour)) then (delete node $oh/beginningHour,insert node $new_oh/beginningHour into $oh) else (),
	if (exists($new_oh/endingHour)) then (delete node $oh/endingHour,insert node $new_oh/endingHour into $oh) else (),
	if (exists($new_oh/beginEffectiveDate)) then (delete node $oh/beginEffectiveDate,insert node $new_oh/beginEffectiveDate into $oh) else (),
	if (exists($new_oh/endEffectiveDate)) then (delete node $oh/endEffectiveDate,insert node $new_oh/endEffectiveDate into $oh) else (),
	csd_blu:wrap_updating_facilities($fac4)
     )
  else 	csd_blu:wrap_updating_facilities(())

