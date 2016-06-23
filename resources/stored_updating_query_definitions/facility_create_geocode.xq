import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:)   

let $fac0 := if (exists($careServicesRequest/id/@entityID)) then	csd_bl:filter_by_primary_id(/CSD/facilityDirectory/*,$careServicesRequest/id) else ()
let $fac1 := if (count($fac0) = 1) then $fac0 else ()
let $fac2 := if (exists($careServicesRequest/geocode) and count($fac1/geocode) = 0)  then $fac1 else ()
return  
  if ( count($fac2) = 1 )
    then
    let $facility:= $fac2[1]
    return
      let $fac3:=  
      <facility entityID="{$facility/@entityID}">
        <geocode/>
      </facility>
       return (
	   insert node
	   $careServicesRequest/geocode
	   into $facility
	   ,
	csd_blu:wrap_updating_facilities($fac3)
	)
  else  csd_blu:wrap_updating_facilities(())
      
