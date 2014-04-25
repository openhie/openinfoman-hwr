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
  if (not (count($provs0) = 1)) 
    then ( csd_blu:wrap_updating_providers((<bad/>)))     (:do nothing :)
  else
    let $provider := $provs0[1]
    let $demo := $provider/demographic
    let $dob := $demo/dateOfBirth
    let $gender := $demo/gender
    return 
      (
	csd_blu:bump_timestamp($provider),
	delete node $provider/codedType,
	insert node $careServicesRequest/codedType into $provider,
	if (not(exists($demo)))
	  then
	  insert node
	  <demographic>
	    {($careServicesRequest/gender,$careServicesRequest/dateOfBirth)}
	  </demographic>
	  into $provider	
	else	
	  (
	    if (not(exists($dob))) then  insert node $careServicesRequest/dateOfBirth into $demo else replace value of node  $demo/dateOfBirth with $careServicesRequest/dateOfBirth,
	    if (not(exists($gender))) then  insert node $careServicesRequest/gender into $demo else replace value of node  $demo/gender with $careServicesRequest/gender
	),
	delete node $provider/language,
	insert node $careServicesRequest/language into $provider,
	delete node $provider/specialty,
	insert node $careServicesRequest/specialty into $provider,
	if (exists($provider/record/@status)) 
	  then replace value of node $provider/record/@status with $careServicesRequest/status 
	else insert node attribute { 'status' } { string($careServicesRequest/status) } into $provider/record,
	csd_blu:wrap_updating_providers(<provider oid="{$provider/@oid}" ok='1'/>)
    )

