(:~
: This is a module contatining  stored queries for a Care Services Discovery compliant Provider registry
: @version 1.0
: @see https://github.com/openhie/openinfoman @see http://ihe.net
:
:)
module namespace csd_frsq = "https://github.com/openhie/openinfoman-pr/csd_frsq";

import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";


declare variable $csd_frsq:stored_functions :=
(
    <function uuid='aef23810-830d-11e3-baa7-0800200c9a66'
              method='csd_frsq:get_oids'
 	     content-type='text/xml; charset=utf-8'      
	     />
);

(:Utility methods:)
declare function csd_frsq:wrap_facilities($facilities) 
{
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory/>
  <serviceDirectory/>
  <facilityDirectory>
  {$facilities}
  </facilityDirectory>
  <providerDirectory/>
</CSD>

};

declare updating function csd_frsq:wrap_updating_facilities($facilities) 
{
  db:output(
    (
    <rest:response>
      <http:response status="200" >
	<http:header name="Content-Type" value="text/xml"/>
      </http:response>
      </rest:response>,
      csd_frsq:wrap_facilities($facilities)
      )
     )
};



(:Top-Level Facility  methods:)
declare function csd_frsq:get_oids($requestParams, $doc) as element() 
{
  let $facs0 := if (exists($requestParams/id)) then csd_bl:filter_by_primary_id($doc/CSD/facilityDirectory/*,$requestParams/id) else $doc/CSD/facilityDirectory/*
  let $facs1 := if (exists($requestParams/otherID)) then csd_bl:filter_by_other_id($facs0,$requestParams/otherID) else $facs0
  let $facs2 := if (exists($requestParams/codedType)) then csd_bl:filter_by_coded_type($facs1,$requestParams/codedType)    else $facs1
  let $facs3 := if (exists($requestParams/address/addressLine)) then csd_bl:filter_by_address($facs2, $requestParams/address/addressLine) else $facs2
  let $facs4 := if (exists($requestParams/record)) then csd_bl:filter_by_record($facs3,$requestParams/record) else $facs3
  let $facs5 := if (exists($requestParams/start) and exists($requestParams/max)) then csd_bl:limit_items($facs4,$requestParams/start,$requestParams/max) else $facs4
  let $facs6 := for $oid in $facs5/@oid         
   return <facility oid="{$oid}"/>

  return csd_frsq:wrap_facilities(($facs6))
};



