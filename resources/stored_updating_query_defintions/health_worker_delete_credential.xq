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
let $cred_new := $careServicesRequest/credential
let $code:= $cred_new/codedType/@code
let $codingSchema:= $cred_new/codedType/@codingSchema
let $creds0 := $provs2/credential[@code = $code and @codingSchema = $codingSchema]
return  
  if ( count($provs2) = 1 and count($creds0) = 1)  then
    delete node $creds0[1]
  else
    ()