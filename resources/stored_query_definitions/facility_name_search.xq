import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare  variable $careServicesRequest as item() external;



(: 
   The query will be executed against the root element of the CSD document.
    
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) 
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory/>
  <serviceDirectory/>
  <facilityDirectory>
    {
      let $facs0 := if (exists($careServicesRequest/id))
	then csd:filter_by_primary_id(/CSD/facilityDirectory/*,$careServicesRequest/id)
      else /CSD/facilityDirectory/*
         
      let $facs1 := if (exists($careServicesRequest/primaryName))
	then csd:filter_by_primary_name($facs0,$careServicesRequest/primaryName)
      else $facs0
         
      let $facs2 := if (exists($careServicesRequest/name))
	then csd:filter_by_name($facs1,$careServicesRequest/name)
      else $facs1
    
      let $facs3 := if(exists($careServicesRequest/codedType))
	then csd:filter_by_coded_type($facs2,$careServicesRequest/codedType) 
      else $facs2
   
      let $facs4 := if(exists($careServicesRequest/address/addressLine))
	then csd:filter_by_address($facs3, $careServicesRequest/address/addressLine) 
      else $facs3

      let $facs5 := if (exists($careServicesRequest/record))
	then csd:filter_by_record($facs4,$careServicesRequest/record)      
      else $facs4

      let $facs6 := if(exists($careServicesRequest/otherID))
	then csd:filter_by_other_id($facs5,$careServicesRequest/otherID)      
      else $facs5

      let $facs7:= if (exists($careServicesRequest/start)) then
	if (exists($careServicesRequest/max)) 
	  then csd:limit_items($facs6,$careServicesRequest/start,$careServicesRequest/max)         
	else csd:limit_items($facs6,$careServicesRequest/start,<max/>)         
      else
	if (exists($careServicesRequest/max)) 
	  then csd:limit_items($facs6,<start/>,$careServicesRequest/max)         
	else $facs6

      return for $fac in $facs7
        return 
	 <facility oid='{$fac/@oid}'>
	   {$fac/primaryName}
	 </facility>


    }     
  </facilityDirectory>
  <providerDirectory/>
</CSD>
    