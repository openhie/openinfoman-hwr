declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;




(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 


let $code := $careServicesRequest/code/text()
let $aa := $careServicesRequest/assigningAuthorityName/text()

let $xml:= 
  <json  type="object">
    <results type='array'>
      { 
      for $ent_id in $careServicesRequest/id
      let $req_id := upper-case(string($ent_id/@entityID))
      let $provider := (/CSD/providerDirectory/provider[upper-case(string(@entityID)) = $req_id])[1]
      let $other_ids_0 := 
	if ($code) 
	then $provider/otherID[@code = $code]
	else $provider/otherID
      let $other_ids_1 := 
	if ($aa) 
	then $other_ids_0[@assigningAuthorityName = $aa]
        else $other_ids_0

      return
	if (exists($provider) and count($other_ids_1) > 0)
	then
	  <_ type='object'>
	    <entityID>{string($provider/@entityID)}</entityID>	    
	    <otherID type="array">
	      {
		for $id in $other_ids_1
		return       
		  <_ type='object'>
		    <code>{string($id/@code)}</code>
		    <authority>{string($id/@assigningAuthorityName)}</authority>
		    <value>{$id/text()}</value>
		  </_>
	        }
	    </otherID>
	 </_>
	else ()
	      
      }
    </results>
  </json>
return json:serialize($xml,map{"format":"direct"})  
