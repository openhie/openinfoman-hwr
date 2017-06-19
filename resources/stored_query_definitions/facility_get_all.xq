import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(:
   The query will be executed against the root element of the CSD document.

   The dynamic context of this query has $careServicesRequest set to contain any of the search
   and limit paramaters as sent by the Service Finder
:)
  let $facs0 := if (exists($careServicesRequest/id)) then csd_bl:filter_by_primary_id(/CSD/facilityDirectory/*,$careServicesRequest/id) else /CSD/facilityDirectory/*
  let $facs1 := if (exists($careServicesRequest/otherID)) then csd_bl:filter_by_other_id($facs0,$careServicesRequest/otherID) else $facs0
  let $facs2 := if (exists($careServicesRequest/codedType)) then csd_bl:filter_by_coded_type($facs1,$careServicesRequest/codedType)    else $facs1
  let $facs3 := if (exists($careServicesRequest/address/addressLine)) then csd_bl:filter_by_address($facs2, $careServicesRequest/address/addressLine) else $facs2
  let $facs4 := if (exists($careServicesRequest/record)) then csd_bl:filter_by_record($facs3,$careServicesRequest/record) else $facs3
  let $facs5 := if (exists($careServicesRequest/start) and exists($careServicesRequest/max)) then csd_bl:limit_items($facs4,$careServicesRequest/start,$careServicesRequest/max) else $facs4

  return csd_bl:wrap_facilities(($facs5))
