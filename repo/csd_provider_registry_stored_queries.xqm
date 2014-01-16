(:~
: This is a module contatining  stored queries for a Care Services Discovery compliant Provider registry
: @version 1.0
: @see https://github.com/his-interop/openinfoman @see http://ihe.net
:
:)
module namespace csd_prsq = "https://github.com/his-interop/openinfoman-pr/csd_prsq";

import module namespace csd = "urn:ihe:iti:csd:2013" at "csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";


declare variable $csd_prsq:stored_functions :=
(
    <function uuid='fcbab300-6270-11e3-bd76-0002a5d5c51b'
              method='csd_prsq:oid_search_by_id'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='8a5df595-51ec-46e6-8a92-7db3c2484ee8'
              method='csd_prsq:get_oids'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='e3cd7f80-7edb-11e3-baa7-0800200c9a66'
              method='csd_prsq:get_name_indices'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='d251f150-7edb-11e3-baa7-0800200c9a66'
              method='csd_prsq:get_name'
 	     content-type='text/xml; charset=utf-8'      
	     />

);

declare function csd_prsq:get_oids($requestParams, $doc) as element() 
{
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory/>
  <serviceDirectory/>
  <facilityDirectory/>
  <providerDirectory>
    {
      let $provs0 := if (exists($requestParams/id)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else $doc/CSD/providerDirectory/*
      let $provs1 := if (exists($requestParams/otherID)) then csd:filter_by_other_id($provs0,$requestParams/otherID) else $provs0
      let $provs2 := if (exists($requestParams/commonName)) then csd:filter_by_common_name($provs1,$requestParams/commonName) else $provs1
      let $provs3 := if (exists($requestParams/type)) then csd:filter_by_coded_type($provs2,$requestParams/type)    else $provs2
      let $provs4 := if (exists($requestParams/address/addressLine)) then csd:filter_by_address($provs3, $requestParams/address/addressLine) else $provs3
      let $provs5 := if (exists($requestParams/record)) then csd:filter_by_record($provs4,$requestParams/record) else $provs4
      let $provs6 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($provs5,$requestParams/start,$requestParams/max) else $provs5
      for $oid in $provs6/@oid         
        return <provider oid="{$oid}"/>
    }     
  </providerDirectory>
</CSD>
};

declare function csd_prsq:get_name($requestParams, $doc) as element() 
{
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory/>
  <serviceDirectory/>
  <facilityDirectory/>
  <providerDirectory>
    {
      for $provider in  if (exists($requestParams/id)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
	return
	<provider oid="{$provider/@oid}">
	  <demographic>
	  {
	    if (exists($requestParams/nameIndex)) then 
	      for $name in $provider/demographic/name[position() = $requestParams/nameIndex]
	      return <name id="{$requestParams/nameIndex}">{$name/*}</name>
            else
	      ()
	  }
	  </demographic>
	  {$provider/record}
	</provider>
    }
  </providerDirectory>
</CSD>

};

declare function csd_prsq:get_name_indices($requestParams, $doc) as element() 
{
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory/>
  <serviceDirectory/>
  <facilityDirectory/>
  <providerDirectory>
    {
      let $providers := 
	if (exists($requestParams/id)) then 
	  csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
	else ($doc/CSD/providerDirectory/*)
      for $provider in  $providers
	return
	<provider oid="{$provider/@oid}">
	  <demographic>
	  {
	    for $name at $pos  in  $provider/demographic/name
	    return <name id="{$pos}"/> 
	  }
	  </demographic>
	</provider>
    }
  </providerDirectory>
</CSD>


};



declare function csd_prsq:oid_search_by_id($requestParams, $doc) as element() 
{
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory/>
  <serviceDirectory/>
  <facilityDirectory/>
  <providerDirectory>
    {
      let $provs0 := if (exists($requestParams/otherID)) then csd:filter_by_other_id($doc/CSD/providerDirectory/*,$requestParams/otherID) else ()
      let $provs1 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($provs0,$requestParams/start,$requestParams/max) else $provs0
      for $oid in $provs1/@oid     
       return <provider oid="{$oid}"/>
    }     
  </providerDirectory>
</CSD>

};


