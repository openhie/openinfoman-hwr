import module namespace csd_bl = "https://github.com/his-interop/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@oid)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/credential/codedType/@code) and exists($careServicesRequest/credential/codedType/@codingSchema) ) then $provs1  else ()
let $cred_request := $careServicesRequest/credential
let $code:= $cred_request/codedType/@code
let $codingSchema:= $cred_request/codedType/@codingSchema
let $creds0 := $provs2/credential[@code = $code and @codingSchema = $codingSchema]
return  
  if ( count($provs2) = 1 and count($creds0) = 0)  (:DO NOT ALLOW SAME CRED TWICE :)
    then
    let $provider:= $provs2[1]
    let $cred_rec :=
    <credential>
      <codedType code="{$code}" codingSchema="{$codingSchema}"/>
    </credential>
    let $cred_new :=
    <credential>
      <codedType code="{$code}" codingSchema="{$codingSchema}"/>
      {(
	if (exists($cred_request/number)) then $cred_request/number else (),
	if (exists($cred_request/issuingAuthority)) then $cred_request/issuingAuthority else (),
	if (exists($cred_request/credentialIssueDate)) then $cred_request/credentialIssueDate else (),
        if (exists($cred_request/credentialRenewalDate)) then $cred_request/credentialRenewalDate else ()
      )}
    </credential>
    let $provs3:=  
    <provider oid="{$provider/@oid}">{$cred_rec}</provider>
    return 
	(
	insert node $cred_new into $provider,
	csd_blu:wrap_updating_providers($provs3)
	)

  else  csd_blu:wrap_updating_providers(())
      
