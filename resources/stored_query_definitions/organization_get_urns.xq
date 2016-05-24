import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
  let $orgs0 := if (exists($careServicesRequest/requestParams/id)) then csd_bl:filter_by_primary_id(/CSD/organizationDirectory/*,$careServicesRequest/requestParams/id) else /CSD/organizationDirectory/*
  let $orgs1 := if (exists($careServicesRequest/requestParams/otherID)) then csd_bl:filter_by_other_id($orgs0,$careServicesRequest/requestParams/otherID) else $orgs0
  let $orgs2 := if (exists($careServicesRequest/requestParams/codedType)) then csd_bl:filter_by_coded_type($orgs1,$careServicesRequest/requestParams/codedType)    else $orgs1
  let $orgs3 := if (exists($careServicesRequest/requestParams/address/addressLine)) then csd_bl:filter_by_address($orgs2, $careServicesRequest/requestParams/address/addressLine) else $orgs2
  let $orgs4 := if (exists($careServicesRequest/requestParams/record)) then csd_bl:filter_by_record($orgs3,$careServicesRequest/requestParams/record) else $orgs3
  let $orgs5 := if (exists($careServicesRequest/requestParams/start) and exists($careServicesRequest/requestParams/max)) then csd_bl:limit_items($orgs4,$careServicesRequest/requestParams/start,$careServicesRequest/requestParams/max) else $orgs4
  let $orgs6 := for $entityID in $orgs5/@entityID         
   return <organization entityID="{$entityID}"/>

  return csd_bl:wrap_organizations(($orgs6))
