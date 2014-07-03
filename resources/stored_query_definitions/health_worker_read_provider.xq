import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
let $provs0 := if (exists($careServicesRequest/id/@oid)) then csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()  
let $provs1 :=  if (count($provs0) = 1) then
  let $prov := $provs0[1]
  return 
  <provider oid="{$prov/@oid}">  
  {(
      $prov/codedType,
      <demographic>
      {(
	if (exists($prov/demographic/gender)) then $prov/demographic/gender else (),
	if (exists($prov/demographic/dateOfBirth)) then $prov/demographic/dateOfBirth else ()
      )}
      </demographic>,
      $prov/language,
      $prov/specialty,
      $prov/record
  )}
  </provider>
  else ()
  return csd_bl:wrap_providers($provs1)
