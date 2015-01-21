import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $provs0 := if (exists($careServicesRequest/id/@entityID)) then	csd_bl:filter_by_primary_id(/CSD/providerDirectory/*,$careServicesRequest/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($careServicesRequest/credential/codedType/@code) and exists($careServicesRequest/credential/codedType/@codingScheme) ) then $provs1  else ()
let $cred_new := $careServicesRequest/credential
let $code:= $cred_new/codedType/@code
let $codingScheme:= $cred_new/codedType/@codingScheme
let $creds0 := $provs2/credential/codedType[@code = $code and @codingScheme = $codingScheme]
return  
  if ( count($provs2) = 1 and count($creds0) = 1)  (:Update only:)
    then
    let $cred_old := $creds0[1]/..
    let $provider:= $provs2[1]
    let $provs3 := 
      <provider entityID="{$provider/@entityID}">
	<credential>
	  <codedType code="{$code}" codingScheme="{$codingScheme}"/>
	</credential>
      </provider>


    return
      
      (
	csd_blu:bump_timestamp($provider),
	if (exists($cred_new/issuingAuthority)) then
	  (if (exists($cred_old/issuingAuthority)) then (delete node $cred_old/issuingAuthority) else (),
	  insert node $cred_new/issuingAuthority into $cred_old)
	else (),
	if (exists($cred_new/number)) then
	  (if (exists($cred_old/number)) then (delete node $cred_old/number) else (),
	  insert node $cred_new/number into $cred_old)
	else (),
	if (exists($cred_new/credentialIssueDate)) then
	  (if (exists($cred_old/credentialIssueDate)) then (delete node $cred_old/credentialIssueDate) else (),
	  insert node $cred_new/credentialIssueDate into $cred_old)
	else (),
	if (exists($cred_new/credentialRenewalDate)) then
	  (if (exists($cred_old/credentialRenewalDate)) then (delete node $cred_old/credentialRenewalDate) else (),
	  insert node $cred_new/credentialRenewalDate into $cred_old)
	else (),
	csd_blu:wrap_updating_providers($provs3)
       )
  else 	csd_blu:wrap_updating_providers(())
