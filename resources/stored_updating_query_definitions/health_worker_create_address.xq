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
let $provs2 := if (exists($careServicesRequest/address/@type))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $demo := $provider/demographic
    return if (exists($demo/address[@type = $careServicesRequest/address/@type])) 
      then
      csd_blu:wrap_updating_providers(()) (: Do not allow the same type to be created more than once:)
    else
      let $provs3:=  
      <provider oid="{$provider/@oid}">
        <demographic><address type="{$careServicesRequest/address/@type}"/></demographic>
      </provider>
       return (
	 if (not(exists($demo)))
	   then
	   insert node
	   <demographic>{$careServicesRequest/address}</demographic>
	   into $provider	
	 else	
	   insert node  $careServicesRequest/address into $demo
	   ,
	csd_blu:wrap_updating_providers($provs3)
	)
  else  csd_blu:wrap_updating_providers(())
      
