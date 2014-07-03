import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $provs0 := if (exists($careServicesRequest/otherID)) then csd_bl:filter_by_other_id(/CSD/providerDirectory/*,$careServicesRequest/otherID) else ()
  let $provs1 := if (exists($careServicesRequest/start) and exists($careServicesRequest/max)) then csd_bl:limit_items($provs0,$careServicesRequest/start,$careServicesRequest/max) else $provs0
  let $provs2:= for $oid in $provs1/@oid     
   return <provider oid="{$oid}"/>

  return csd_bl:wrap_providers($provs2)
