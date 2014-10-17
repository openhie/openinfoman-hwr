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
let $provs2 := if (exists($careServicesRequest/address/@type))  then $provs1 else ()
let $provider:= $provs2[1]
let $demo := $provider/demographic
let $address:= $demo/address[@type = $careServicesRequest/address/@type]
return  
  if ( not(exists($address))) then
    csd_blu:wrap_updating_providers(()) (: Address does not exist.  Do not update:)
  else
    let $provs3:=  
    <provider entityID="{$provider/@entityID}">
      <demographic><address type="{$careServicesRequest/address/@type}"/></demographic>
    </provider>
    return (
      csd_blu:bump_timestamp($provider),
      replace  node  $address with $careServicesRequest/address
      ,
      csd_blu:wrap_updating_providers($provs3)
    )
