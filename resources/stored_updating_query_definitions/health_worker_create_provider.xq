import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu" at "../repo/csd_base_library_updating.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
let $provs0 := if (exists($careServicesRequest/id/@oid)) then csd:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()  
return
  if (count($provs0) > 0) then (csd_blu:wrap_updating_providers(()))     (:do not allow duplicate OIDs:)
else
  let $oid := 
    if (exists($careServicesRequest/id/@oid) and not($careServicesRequest/id/@oid = '')) then $careServicesRequest/id/@oid
  else csd:uuid_as_oid()
  let $time :=current-dateTime()
  let $prov := 
  <provider oid="{$oid}">
    {(
      $careServicesRequest/codedType,
      <demographic>
	{(
	  $careServicesRequest/gender,
	  $careServicesRequest/dateOfBirth
	 )}
	 </demographic>,
	 $careServicesRequest/language,
         $careServicesRequest/specialty,
	 if ($careServicesRequest/status) 
	   then
	   <record created="{$time}" updated="{$time}" status="{$careServicesRequest/status}" sourceDirectory="{$careServicesRequest/sourceDirectory}"/>
	 else 
	   <record created="{$time}" updated="{$time}" status="Active" sourceDirectory="{$careServicesRequest/sourceDirectory}"/>
     )}
  </provider>
  
  return (
    insert node $prov into /CSD/providerDirectory,  
    csd_blu:wrap_updating_providers(<provider oid="{$oid}"/>)
  )

