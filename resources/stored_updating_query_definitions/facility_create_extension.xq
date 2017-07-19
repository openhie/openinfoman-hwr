import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare namespace csd = "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(:
   The query will be executed against the root element of the CSD document.

   The dynamic context of this query has $careServicesRequest set to contain any of the search
   and limit paramaters as sent by the Service Finder
:)

let $fac0 := if (exists($careServicesRequest/facility/@entityID)) then	csd_bl:filter_by_primary_id(/CSD/facilityDirectory/*,$careServicesRequest/facility) else ()
let $fac1 := if (count($fac0) = 1) then $fac0 else ()
let $fac2 := if (exists($careServicesRequest/facility/extension/@type) and exists($careServicesRequest/facility/extension/@urn))  then $fac1 else ()
return
  if ( count($fac2) = 1 )
    then
    let $facility:= $fac2[1]
    let $position := count($facility/extension) +1
    let $extension :=
      <csd:extension type="{$careServicesRequest/facility/extension/@type}" urn="{$careServicesRequest/facility/extension/@urn}">
        {$careServicesRequest/facility/extension/*}
      </csd:extension>
    let $fac3:=
    <facility entityID="{$facility/@entityID}">
      <csd:extension position="{$position}"/>
    </facility>
    return
      (insert node $extension into $facility ,
      csd_blu:wrap_updating_facilities($fac3)
      )
  else  csd_blu:wrap_updating_facilities(())
