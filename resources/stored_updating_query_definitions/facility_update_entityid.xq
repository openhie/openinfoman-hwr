import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $fac0 := if (exists($careServicesRequest/source/@entityID)) then /CSD/facilityDirectory/*  else ()
let $fac1 := if (exists($careServicesRequest/destination/@entityID)) then csd_bl:filter_by_primary_id($fac0,$careServicesRequest/source) else ()
let $new_node := <facility entityID="{$careServicesRequest/destination/@entityID}">
                   {$fac1/*}
                 </facility>
return 
   (
	csd_blu:bump_timestamp($fac1[1]),
	replace  node $fac1 with $new_node,
	csd_blu:wrap_updating_facilities($new_node)
   )