import module namespace csd_bl = "https://github.com/his-interop/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  if (exists($careServicesRequest/organization/@oid)) 
    then 
    let $providers := if (exists($careServicesRequest/id/@oid)) then csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $org :=  $providers[1]/organizations/organization[@oid = $careServicesRequest/organization/@oid]
	return if (exists($org)) then (delete node $org) else ()
      else  ()
    else ()      