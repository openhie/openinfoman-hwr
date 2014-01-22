(:~
: This is a module contatining  stored queries for a Care Services Discovery compliant Provider registry
: @version 1.0
: @see https://github.com/his-interop/openinfoman @see http://ihe.net
:
:)
module namespace csd_orsq = "https://github.com/his-interop/openinfoman-pr/csd_orsq";

import module namespace csd = "urn:ihe:iti:csd:2013" at "csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";


declare variable $csd_orsq:stored_functions :=
(
    <function uuid='9fd81db0-8306-11e3-baa7-0800200c9a66'
              method='csd_orsq:get_oids'
 	     content-type='text/xml; charset=utf-8'      
	     />
);

(:Utility methods:)
declare function csd_orsq:wrap_organizations($organizations) 
{
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory>
  {$organizations}
  </organizationDirectory>
  <serviceDirectory/>
  <facilityDirectory/>
  <providerDirectory/>
</CSD>

};

declare updating function csd_orsq:wrap_updating_organizations($organizations) 
{
  db:output(
    (
    <rest:response>
      <http:response status="200" >
	<http:header name="Content-Type" value="text/xml"/>
      </http:response>
      </rest:response>,
      csd_orsq:wrap_organizations($organizations)
      )
     )
};



(:Top-Level Organization  methods:)
declare function csd_orsq:get_oids($requestParams, $doc) as element() 
{
  let $orgs0 := if (exists($requestParams/id)) then csd:filter_by_primary_id($doc/CSD/organizationDirectory/*,$requestParams/id) else $doc/CSD/organizationDirectory/*
  let $orgs1 := if (exists($requestParams/otherID)) then csd:filter_by_other_id($orgs0,$requestParams/otherID) else $orgs0
  let $orgs2 := if (exists($requestParams/codedType)) then csd:filter_by_coded_type($orgs1,$requestParams/codedType)    else $orgs1
  let $orgs3 := if (exists($requestParams/address/addressLine)) then csd:filter_by_address($orgs2, $requestParams/address/addressLine) else $orgs2
  let $orgs4 := if (exists($requestParams/record)) then csd:filter_by_record($orgs3,$requestParams/record) else $orgs3
  let $orgs5 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($orgs4,$requestParams/start,$requestParams/max) else $orgs4
  let $orgs6 := for $oid in $orgs5/@oid         
   return <organization oid="{$oid}"/>

  return csd_orsq:wrap_organizations(($orgs6))
};



