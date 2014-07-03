import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $srvcs0 := if (exists($careServicesRequest/id)) then csd_bl:filter_by_primary_id(/CSD/serviceDirectory/*,$careServicesRequest/id) else /CSD/serviceDirectory/*
  let $srvcs1 := if (exists($careServicesRequest/codedType)) then csd_bl:filter_by_coded_type($srvcs0,$careServicesRequest/codedType)    else $srvcs0
  let $srvcs2 := if (exists($careServicesRequest/record)) then csd_bl:filter_by_record($srvcs1,$careServicesRequest/record) else $srvcs1
  let $srvcs3 := if (exists($careServicesRequest/start) and exists($careServicesRequest/max)) then csd_bl:limit_items($srvcs2,$careServicesRequest/start,$careServicesRequest/max) else $srvcs2
  let $srvcs4 := for $oid in $srvcs3/@oid         
   return <service oid="{$oid}"/>

  return csd_bl:wrap_services(($srvcs4))
