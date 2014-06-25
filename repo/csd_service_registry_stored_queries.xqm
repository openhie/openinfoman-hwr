(:~
: This is a module contatining  stored queries for a Care Services Discovery compliant Provider registry
: @version 1.0
: @see https://github.com/his-interop/openinfoman @see http://ihe.net
:
:)
module namespace csd_srsq = "https://github.com/his-interop/openinfoman-pr/csd_srsq";

import module namespace csd_bl = "https://github.com/his-interop/openinfoman/csd_bl";
declare default element  namespace   "urn:ihe:iti:csd:2013";


declare variable $csd_srsq:stored_functions :=
(
    <function uuid='0f117fc0-830f-11e3-baa7-0800200c9a66'
              method='csd_srsq:get_oids'
 	     content-type='text/xml; charset=utf-8'      
	     />
);

(:Utility methods:)
declare function csd_srsq:wrap_services($services) 
{
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory/>
  <serviceDirectory>
    {$services}
  </serviceDirectory>
  <facilityDirectory/>
  <providerDirectory/>
</CSD>

};

declare updating function csd_srsq:wrap_updating_services($services) 
{
  db:output(
    (
    <rest:response>
      <http:response status="200" >
	<http:header name="Content-Type" value="text/xml"/>
      </http:response>
      </rest:response>,
      csd_srsq:wrap_services($services)
      )
     )
};



(:Top-Level Service  methods:)
declare function csd_srsq:get_oids($requestParams, $doc) as element() 
{
  let $srvcs0 := if (exists($requestParams/id)) then csd_bl:filter_by_primary_id($doc/CSD/serviceDirectory/*,$requestParams/id) else $doc/CSD/serviceDirectory/*
  let $srvcs1 := if (exists($requestParams/codedType)) then csd_bl:filter_by_coded_type($srvcs0,$requestParams/codedType)    else $srvcs0
  let $srvcs2 := if (exists($requestParams/record)) then csd_bl:filter_by_record($srvcs1,$requestParams/record) else $srvcs1
  let $srvcs3 := if (exists($requestParams/start) and exists($requestParams/max)) then csd_bl:limit_items($srvcs2,$requestParams/start,$requestParams/max) else $srvcs2
  let $srvcs4 := for $oid in $srvcs3/@oid         
   return <service oid="{$oid}"/>

  return csd_srsq:wrap_services(($srvcs4))
};



