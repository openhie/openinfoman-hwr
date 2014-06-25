import module namespace csd_bl = "https://github.com/his-interop/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  if (exists($careServicesRequest/facility/service/@position) and exists($careServicesRequest/facility/@oid)) 
    then 
    let $providers := if (exists($careServicesRequest/id/@oid)) then csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let $facs := $providers[1]/facilities/facility[@oid = $careServicesRequest/facility/@oid]
	return
	  if (count($facs) = 1) then
	    let  $srvc :=  $facs[1]/service[position() = $careServicesRequest/facility/service/@position]
	    return if (exists($srvc)) then (delete node $srvc) else ()
	  else () 
      else  ()
    else ()      
