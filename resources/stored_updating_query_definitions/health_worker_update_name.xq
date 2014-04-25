import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu" at "../repo/csd_base_library_updating.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   
let $provs0 := if (exists($careServicesRequest/name/@position)) then /CSD/providerDirectory/*  else ()
let $provs1 := if (exists($careServicesRequest/id/@oid)) then csd:filter_by_primary_id($provs0,$careServicesRequest/id) else ()
let $name := $provs1[1]/demographic/name[position() = $careServicesRequest/name/@position]
return
  if (count($provs1) = 1 and exists($name)) 
    then
    let $provs2 := 
    <provider oid="{$provs1[1]/@oid}">
      <demographic>
	<name position="{$careServicesRequest/name/@position}"/>
      </demographic>
    </provider>
    let $new_name := 
    <name>
     {$careServicesRequest/name/*}
    </name>
    return
      (
	csd_blu:bump_timestamp($provs1[1]),
	replace  node $name with $new_name,
	csd_blu:wrap_updating_providers($provs2)
     )
  else 	csd_blu:wrap_updating_providers(())

