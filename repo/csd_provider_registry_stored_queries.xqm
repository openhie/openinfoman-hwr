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
	     (:Methods for Names:)
    <function uuid='e3cd7f80-7edb-11e3-baa7-0800200c9a66'
              method='csd_prsq:indices_name'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='d251f150-7edb-11e3-baa7-0800200c9a66'
              method='csd_prsq:read_name'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='4808be30-7f84-11e3-baa7-0800200c9a66'
              method='csd_prsq:delete_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='8c8a2080-7f84-11e3-baa7-0800200c9a66'
              method='csd_prsq:create_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='866455e0-7f84-11e3-baa7-0800200c9a66'
              method='csd_prsq:update_name'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,

	      (:Methods for Common Names:)
    <function uuid='26890a10-82ba-11e3-baa7-0800200c9a66'
              method='csd_prsq:indices_common_name'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='1d94b620-82ba-11e3-baa7-0800200c9a66'
              method='csd_prsq:read_common_name'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='155cd460-82ba-11e3-baa7-0800200c9a66'
              method='csd_prsq:delete_common_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='0ad4e820-82ba-11e3-baa7-0800200c9a66'
              method='csd_prsq:create_common_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='a8a05f90-82b9-11e3-baa7-0800200c9a66'
              method='csd_prsq:update_common_name'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,

	      (:Methods for Other Names:)
    <function uuid='26890a10-82ba-11e3-baa7-0800200c9a77'
              method='csd_prsq:indices_other_name'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='1d94b620-82ba-11e3-baa7-0800200c9a77'
              method='csd_prsq:read_other_name'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='155cd460-82ba-11e3-baa7-0800200c9a77'
              method='csd_prsq:delete_other_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='0ad4e820-82ba-11e3-baa7-0800200c9a77'
              method='csd_prsq:create_other_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='a8a05f90-82b9-11e3-baa7-0800200c9a77'
              method='csd_prsq:update_other_name'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,

	      (:Methods for Common Names:)
    <function uuid='26890a10-82ba-11e3-baa7-0800200c9a66'
              method='csd_prsq:indices_common_name'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='1d94b620-82ba-11e3-baa7-0800200c9a66'
              method='csd_prsq:read_common_name'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='155cd460-82ba-11e3-baa7-0800200c9a66'
              method='csd_prsq:delete_common_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='0ad4e820-82ba-11e3-baa7-0800200c9a66'
              method='csd_prsq:create_common_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='a8a05f90-82b9-11e3-baa7-0800200c9a66'
              method='csd_prsq:update_common_name'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,

	      (:Methods for Other Names:)
    <function uuid='26890a10-82ba-11e3-baa7-0800200c9a77'
              method='csd_prsq:indices_other_name'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='1d94b620-82ba-11e3-baa7-0800200c9a77'
              method='csd_prsq:read_other_name'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='155cd460-82ba-11e3-baa7-0800200c9a77'
              method='csd_prsq:delete_other_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='0ad4e820-82ba-11e3-baa7-0800200c9a77'
              method='csd_prsq:create_other_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='a8a05f90-82b9-11e3-baa7-0800200c9a77'
              method='csd_prsq:update_other_name'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,



	     (:Methods for Contact Point:)

    <function uuid='5a268fa0-8391-11e3-baa7-0800200c9a66'
              method='csd_prsq:indices_contact_point'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='5e338c60-8391-11e3-baa7-0800200c9a66'
              method='csd_prsq:read_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='6181cd00-8391-11e3-baa7-0800200c9a66'
              method='csd_prsq:delete_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='68d457d0-8391-11e3-baa7-0800200c9a66'
              method='csd_prsq:create_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='6cb318a0-8391-11e3-baa7-0800200c9a66'
              method='csd_prsq:update_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,

	     (:Methods for Credentials:)

    <function uuid='ecaeac3f-a4db-4407-9bec-12c47c853e65'
              method='csd_prsq:indices_credential'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='edb4316b-9408-4a6c-afde-74a6f0f7c706'
              method='csd_prsq:read_credential'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='d0a0992e-47c5-443f-b532-16f8b3a1d4a3'
              method='csd_prsq:delete_credential'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='d2657386-9dca-4fc7-a0ef-af0b0c892186'
              method='csd_prsq:create_credential'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='039fef0f-6e9c-4b71-bf6d-ce7c259a0f64'
              method='csd_prsq:update_credential'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,

	      (:Methods for Facility Affiliation:)
    <function uuid='a4544da0-831f-11e3-baa7-0800200c9a66'
              method='csd_prsq:indices_provider_facility'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='aa65a5e0-831f-11e3-baa7-0800200c9a66'
              method='csd_prsq:read_provider_facility'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='afcc3f30-831f-11e3-baa7-0800200c9a66'
              method='csd_prsq:delete_provider_facility'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='b6078da0-831f-11e3-baa7-0800200c9a66'
              method='csd_prsq:create_provider_facility'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='bc0a3fe0-831f-11e3-baa7-0800200c9a66'
              method='csd_prsq:update_provider_facility'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,
	      (:Methods for Organizational Affiliation:)
    <function uuid='cf97b490-8313-11e3-baa7-0800200c9a66'
              method='csd_prsq:indices_provider_organization'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='dd319bc0-8313-11e3-baa7-0800200c9a66'
              method='csd_prsq:read_provider_organization'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='e7007130-8313-11e3-baa7-0800200c9a66'
              method='csd_prsq:delete_provider_organization'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='f0908ff0-8313-11e3-baa7-0800200c9a66'
              method='csd_prsq:create_provider_organization'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='f5b36980-8313-11e3-baa7-0800200c9a66'
              method='csd_prsq:update_provider_organization'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,
	     (:Methods for Organizational Contact Point:)



    <function uuid='6ca9a7b2-e1c8-402c-9b45-8c3009c29492'
              method='csd_prsq:indices_org_contact_point'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='bf6e77e1-8908-4ffb-b322-f472bfd24a51'
              method='csd_prsq:read_org_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     />,

    <function uuid='90c71896-2991-4f27-a65d-0bd442e60567'
              method='csd_prsq:delete_org_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='82e65afd-a52a-49e0-92b4-292134c1699d'
              method='csd_prsq:create_org_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='5e4e6bca-451d-41a7-b82e-7dc017a3e3ff'
              method='csd_prsq:update_org_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,


	     (:Methods for Identification:)

    <function uuid='af556315-9e6f-4a90-b5be-ee0ca71cae26'
              method='csd_prsq:indices_otherid'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='e0e01b0d-8d18-4b65-a3ca-82229050709c'
              method='csd_prsq:read_otherid'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='ef194926-bdf9-4c80-80e3-cdbe6b73f0a9'
              method='csd_prsq:delete_otherid'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='a1772539-cfa2-4601-9c34-3c6c473a878a'
              method='csd_prsq:create_otherid'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='78680061-23c7-41cb-b128-abac3b26b8df'
              method='csd_prsq:update_otherid'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />


);


(:Utility methods:)
declare function csd_prsq:wrap_providers($providers) 
{
<CSD xmlns:csd="urn:ihe:iti:csd:2013"  >
  <organizationDirectory/>
  <serviceDirectory/>
  <facilityDirectory/>
  <providerDirectory>
  {$providers}
  </providerDirectory>
</CSD>

};

declare updating function csd_prsq:wrap_updating_providers($providers) 
{
  db:output(
    (
    <rest:response>
      <http:response status="200" >
	<http:header name="Content-Type" value="text/xml"/>
      </http:response>
      </rest:response>,
      csd_prsq:wrap_providers($providers)
      )
     )
};


(:Top-Level Provider  methods:)
declare function csd_prsq:get_oids($requestParams, $doc) as element() 
{
  let $provs0 := if (exists($requestParams/id)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else $doc/CSD/providerDirectory/*
  let $provs1 := if (exists($requestParams/otherID)) then csd:filter_by_other_id($provs0,$requestParams/otherID) else $provs0
  let $provs2 := if (exists($requestParams/commonName)) then csd:filter_by_common_name($provs1,$requestParams/commonName) else $provs1
  let $provs3 := if (exists($requestParams/codedType)) then csd:filter_by_coded_type($provs2,$requestParams/codedType)    else $provs2
  let $provs4 := if (exists($requestParams/address/addressLine)) then csd:filter_by_address($provs3, $requestParams/address/addressLine) else $provs3
  let $provs5 := if (exists($requestParams/record)) then csd:filter_by_record($provs4,$requestParams/record) else $provs4
  let $provs6 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($provs5,$requestParams/start,$requestParams/max) else $provs5
  let $provs7 := for $oid in $provs6/@oid         
   return <provider oid="{$oid}"/>

  return csd_prsq:wrap_providers($provs7)
};


declare function csd_prsq:oid_search_by_id($requestParams, $doc) as element() 
{
  let $provs0 := if (exists($requestParams/otherID)) then csd:filter_by_other_id($doc/CSD/providerDirectory/*,$requestParams/otherID) else ()
  let $provs1 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($provs0,$requestParams/start,$requestParams/max) else $provs0
  let $provs2:= for $oid in $provs1/@oid     
   return <provider oid="{$oid}"/>

  return csd_prsq:wrap_providers($provs2)
};



(:Methods for Names:)
declare function csd_prsq:indices_name($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<demographic>
	  {
	    for $name at $pos  in  $provider/demographic/name
	    return <name position="{$pos}"/> 
	  }
	</demographic>
    </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_name($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/name/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider oid="{$provider/@oid}">
      {
	if (exists($requestParams/name) and exists($requestParams/name/@position)) 
	  then 
	  <demographic>
	    {
	      for $name in $provider/demographic/name[position() = $requestParams/name/@position]
	      return       <name position="{$requestParams/name/@position}">{$name/*}</name>
	  }
	  </demographic>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs2)
};





declare updating function csd_prsq:create_name($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/name))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $position := count($provider/demographic/name) +1
    let $name := 
      <name>
	{(
	  if (exists($requestParams/name/honorific)) then  $requestParams/name/honorific else (),
	  if (exists($requestParams/name/suffix)) then  $requestParams/name/suffix else (),
	  if (exists($requestParams/name/forename)) then  $requestParams/name/forename else (),
	  if (exists($requestParams/name/surname)) then  $requestParams/name/surname else ()
	 )}
      </name>
    let $provs3:=  
    <provider oid="{$provider/@oid}">
      <demographic>
	<name position="{$position}"/>
      </demographic>
    </provider>
    return 
      (insert node $name into $provider/demographic ,    
      csd_prsq:wrap_updating_providers($provs3)
      )
  else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_name($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/name/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $name := $provs1[1]/demographic/name[position() = $requestParams/name/@position]
return
  if (count($provs1) = 1 and exists($name)) 
    then
    let $provs2 := 
    <provider oid="{$provs1[1]/@oid}">
      <demographic>
	<name position="{$requestParams/name/@position}"/>
      </demographic>
    </provider>
    return
      (
	csd_prsq:update_name_parts($name,$requestParams/name),
	csd_prsq:wrap_updating_providers($provs2)
     )
  else 	csd_prsq:wrap_updating_providers(())

};


declare updating function csd_prsq:update_name_parts($old,$new) 
{
  (
    if (exists($new/honorific)) 
      then
      (if (exists($old/honorific)) then (delete node $old/honorific) else (),
      insert node $new/honorific into $old)
    else (),
    if (exists($new/surname)) 
      then
      (if (exists($old/surname)) then (delete node $old/surname) else (),
      insert node $new/surname into $old)
    else (),
    if (exists($new/forename)) then
      (if (exists($old/forename)) then (delete node $old/forename) else (),
      insert node $new/forename into $old)
    else (),
      if (exists($new/suffix)) then
	(if (exists($old/suffix)) then (delete node $old/suffix) else (),
	insert node $new/suffix into $old)
      else ()
  )
};


declare updating function csd_prsq:delete_name($requestParams, $doc) 
{
  if (exists($requestParams/name/@position)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $name :=  $providers[1]/demographic/name[position() = $requestParams/name/@position]
	return if (exists($name)) then (delete node $name) else ()
      else  ()
    else ()      
};



(:Methods for Common Names:)
declare function csd_prsq:indices_common_name($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<demographic>
	  {
	    for $name in  $provider/demographic/name[position() = $requestParams/name/@position]
	    return
	    <name position="{ $requestParams/name/@position}">
	      {for $common_name at $pos  in  $name/commonName
	      return <commonName position="{$pos}"/>
	      }
	    </name>
	  }
	</demographic>
    </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_common_name($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/name/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider oid="{$provider/@oid}">
      {
	if ( exists($requestParams/name/@position) and exists($requestParams/name/commonName/@position)) 
	  then 
	  <demographic>
	    {
	      for $common_name in $provider/demographic/name[position() = $requestParams/name/@position]/commonName[position() = $requestParams/name/commonName/@position]
	      return       
	      <name position="{$requestParams/name/@position}">
		<commonName position="{$requestParams/name/commonName/@position}" language="{$common_name/@language}">{string($common_name)}</commonName>
	      </name>
	  }
	  </demographic>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs2)
};


declare updating function csd_prsq:update_common_name_from_parts($old,$new)
{
(   
if (exists($new/@language)) then
  if (exists($old/@language))
    then (replace value of node $old/@language with $new/@language)
  else 
    (insert node $new/@language into $old)
  else ()
  ,
 replace value of node $old with $new
)
    
};


declare updating function csd_prsq:create_common_name($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/name/@position))  then $provs1 else ()
let $provs3 := if (exists($requestParams/name/commonName))  then $provs2 else ()
return  
  if ( count($provs3) = 1 )
    then
    let $provider:= $provs3[1]
    let $name := $provider/demographic/name[position() = $requestParams/name/@position]
    return if (count($name) =1 ) then
      let $position := count($name/commonName) +1
      let $common_name := if (not($requestParams/name/commonName/@language = '') )
	then
	<commonName language="{$requestParams/name/commonName/@language}">
	  {string($requestParams/name/commonName)}
	</commonName>
	else
	<commonName>
	  {string($requestParams/name/commonName)}
	</commonName>	
      let $provs4:=  
      <provider oid="{$provider/@oid}">
	<demographic>
	  <name position="{$requestParams/name/@position}">
	    <commonName position="{$position}"/>
	  </name>
	</demographic>
      </provider>
      return (
	insert node $common_name into $name,
	csd_prsq:wrap_updating_providers($provs4)
      )
    else
      csd_prsq:wrap_updating_providers(())
  else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_common_name($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/name/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $name := $provs1[1]/demographic/name[position() = $requestParams/name/@position]
let $common_name := $name/commonName[position() = $requestParams/name/commonName/@position]
return
  if (count($provs1) = 1 and count($name) = 1 and exists($common_name)) 
    then
    let $provs2 := 
    <provider oid="{$provs1[1]/@oid}" >
      <demographic>
	<name position="{$requestParams/name/@position}">
	  <commonName position="{$requestParams/name/commonName/@position}"/>
	  {$requestParams}
	</name>
      </demographic>
    </provider>
    return
      (
	csd_prsq:update_common_name_from_parts($common_name,$requestParams/name/commonName)
	,
	csd_prsq:wrap_updating_providers($provs2)
     )
  else 	csd_prsq:wrap_updating_providers(())

};



declare updating function csd_prsq:delete_common_name($requestParams, $doc) 
{
  if (exists($requestParams/name/@position) and exists($requestParams/name/commonName/@position))
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $name :=  $providers[1]/demographic/name[position() = $requestParams/name/@position]
	let  $common_name :=  $providers[1]/demographic/name/commonName[position() = $requestParams/name/commonName/@position]

	return if (exists($common_name)) then (delete node $common_name) else ()
      else  ()
    else ()      
};



(:Methods for Other Names:)
declare function csd_prsq:indices_other_name($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<demographic>
	  {
	    for $name in  $provider/demographic/name[position() = $requestParams/name/@position]
	    return
	    <name position="{ $requestParams/name/@position}">
	      {for $other_name at $pos  in  $name/otherNames
	      return <otherNames position="{$pos}"/>
	      }
	    </name>
	  }
	</demographic>
    </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_other_name($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/name/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider oid="{$provider/@oid}">
      {
	if ( exists($requestParams/name/@position) and exists($requestParams/name/otherNames/@position)) 
	  then 
	  <demographic>
	    {
	      for $other_name in $provider/demographic/name[position() = $requestParams/name/@position]/otherNames[position() = $requestParams/name/otherNames/@position]
	      return       
	      <name position="{$requestParams/name/@position}">
		<otherNames position="{$requestParams/name/otherNames/@position}" >{string($other_name)}</otherNames>
	      </name>
	  }
	  </demographic>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs2)
};


declare updating function csd_prsq:update_other_name_from_parts($old,$new)
{
(   
 replace value of node $old with $new
)
    
};


declare updating function csd_prsq:create_other_name($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/name/@position))  then $provs1 else ()
let $provs3 := if (exists($requestParams/name/otherNames))  then $provs2 else ()
return  
  if ( count($provs3) = 1 )
    then
    let $provider:= $provs3[1]
    let $name := $provider/demographic/name[position() = $requestParams/name/@position]
    return if (count($name) =1 ) then
      let $position := count($name/otherNames) +1
      let $other_name := 
      <otherNames>
      	{$requestParams/name/otherNames}
      </otherNames>
      let $provs4:=  
      <provider oid="{$provider/@oid}">
	<demographic>
	  <name position="{$requestParams/name/@position}">
	    <otherNames position="{$position}"/>
	  </name>
	</demographic>
      </provider>
      return (
	insert node $other_name into $name,
	csd_prsq:wrap_updating_providers($provs4)
      )
    else
      csd_prsq:wrap_updating_providers(())
  else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_other_name($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/name/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $name := $provs1[1]/demographic/name[position() = $requestParams/name/@position]
let $other_name := $name/otherNames[position() = $requestParams/name/otherNames/@position]
return
  if (count($provs1) = 1 and count($name) = 1 and exists($other_name)) 
    then
    let $provs2 := 
    <provider oid="{$provs1[1]/@oid}" >
      <demographic>
	<name position="{$requestParams/name/@position}">
	  <otherNames position="{$requestParams/name/otherNames/@position}"/>
	  {$requestParams}
	</name>
      </demographic>
    </provider>
    return
      (
	csd_prsq:update_other_name_from_parts($other_name,$requestParams/name/otherNames)
	,
	csd_prsq:wrap_updating_providers($provs2)
     )
  else 	csd_prsq:wrap_updating_providers(())

};



declare updating function csd_prsq:delete_other_name($requestParams, $doc) 
{
  if (exists($requestParams/name/@position) and exists($requestParams/name/otherNames/@position))
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $name :=  $providers[1]/demographic/name[position() = $requestParams/name/@position]
	let  $other_name :=  $providers[1]/demographic/name/otherNames[position() = $requestParams/name/otherNames/@position]

	return if (exists($other_name)) then (delete node $other_name) else ()
      else  ()
    else ()      
};






(:Methods for Contact Point:)
declare function csd_prsq:indices_contact_point($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<demographic>
	  {
	    for $cp at $pos  in  $provider/demographic/contactPoint
	    return <contactPoint position="{$pos}"/> 
	  }
	</demographic>
    </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_contact_point($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/contactPoint/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider oid="{$provider/@oid}">
      {
	if (exists($requestParams/contactPoint) and exists($requestParams/contactPoint/@position)) 
	  then 
	  <demographic>
	    {
	      for $cp in $provider/demographic/contactPoint[position() = $requestParams/contactPoint/@position]
	      return       <contactPoint position="{$requestParams/contactPoint/@position}">{$cp/*}</contactPoint>
	  }
	  </demographic>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs2)
};





declare updating function csd_prsq:create_contact_point($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/contactPoint))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $position := count($provider/demographic/contactPoint) +1
    let $cp := 
      <contactPoint>
	{(
	  if (exists($requestParams/contactPoint/codedType)) then  $requestParams/contactPoint/codedType else (),
	  if (exists($requestParams/contactPoint/equipment)) then  $requestParams/contactPoint/equipment else (),
	  if (exists($requestParams/contactPoint/purpose)) then  $requestParams/contactPoint/purpose else (),
	  if (exists($requestParams/contactPoint/certificate)) then  $requestParams/contactPoint/certificate else ()
	 )}
      </contactPoint>
    let $provs3:=  
    <provider oid="{$provider/@oid}">
      <demographic>
	<contactPoint position="{$position}"/>
      </demographic>
    </provider>
    return 
      (insert node $cp into $provider/demographic ,    
      csd_prsq:wrap_updating_providers($provs3)
      )
  else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_contact_point($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/contactPoint/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $old_cp := $provs1[1]/demographic/contactPoint[position() = $requestParams/contactPoint/@position]
return
  if (count($provs1) = 1 and exists($old_cp)) 
    then
    let $new_cp := $requestParams/contactPoint
    let $provs2 := 
    <provider oid="{$provs1[1]/@oid}">
      <demographic>
	<contactPoint position="{$requestParams/contactPoint/@position}"/>
      </demographic>
    </provider>
    return
      (
	if (exists($new_cp/codedType)) 
	  then
	  (if (exists($old_cp/codedType)) then (delete node $old_cp/codedType) else (),
	  insert node $new_cp/codedType into $old_cp)
	else (),
	if (exists($new_cp/equipment)) 
	  then
	  (if (exists($old_cp/equipment)) then (delete node $old_cp/equipment) else (),
	  insert node $new_cp/equipment into $old_cp)
	else (),
	if (exists($new_cp/purpose)) then
	  (if (exists($old_cp/purpose)) then (delete node $old_cp/purpose) else (),
	  insert node $new_cp/purpose into $old_cp)
	else (),
	if (exists($new_cp/certificate)) then
	  (if (exists($old_cp/certificate)) then (delete node $old_cp/certificate) else (),
	  insert node $new_cp/certificate into $old_cp)
	else (),
	csd_prsq:wrap_updating_providers($provs2)
     )
  else 	csd_prsq:wrap_updating_providers(())

};




declare updating function csd_prsq:delete_contact_point($requestParams, $doc) 
{
  if (exists($requestParams/contactPoint/@position)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $cp :=  $providers[1]/demographic/contactPoint[position() = $requestParams/contactPoint/@position]
	return if (exists($cp)) then (delete node $cp) else ()
      else  ()
    else ()      
};


(:Methods for Organizational Contact Point:)
declare function csd_prsq:indices_org_contact_point($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<organizations>
	  {
	    let $orgs := 
	      if (exists($requestParams/organization/@oid)) 
		then 
		$provider/organizations/organization[@oid = $requestParams/organization/@oid]
	      else    $provider/organizations/organization
            for $org in $orgs
	      return 
	       <organization oid="{$org/@oid}">
		  {
		    for $cp at $pos in $org/contactPoint
		    return <contactPoint position="{$pos}"/> 
		  }
		</organization>
	  }
	</organizations>
    </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_org_contact_point($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/organization/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/organization/contactPoint/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs1,$requestParams/id) else ()
let $provs3 := 
  if (count($provs2) = 1) 
    then 
    let $provider :=  $provs2[1] 
    return 
    <provider oid="{$provider/@oid}">
      {
	if (exists($requestParams/organization/@oid) and exists($requestParams/organization/contactPoint/@position)) 
	  then 
	  <organizations>
	    <organization oid="{$requestParams/organization/@oid}">
	    {
	      for $cp in $provider/organizations/organization[@oid = $requestParams/organization/@oid]/contactPoint[position() = $requestParams/organization/contactPoint/@position]
	      return       <contactPoint position="{$requestParams/organization/contactPoint/@position}">{$cp/*}</contactPoint>
	  }
	    </organization>
	  </organizations>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs3)
};





declare updating function csd_prsq:create_org_contact_point($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/organization/@oid))  then $provs1 else ()
let $provs3 := if (exists($requestParams/organization/contactPoint))  then $provs2 else ()
return  
  if ( count($provs3) = 1 )
    then
    let $provider:= $provs3[1]
    let $orgs := $provider/organizations/organization[@oid = $requestParams/organization/@oid]
    return 
      if (count($orgs) = 1) 
	then
	let $org := $orgs[1]
	let $position := count($org/contactPoint) +1
	let $new_cp := $requestParams/organization/contactPoint
	let $cp := 
	<contactPoint>
	  {(
	    if (exists($new_cp/codedType)) then  $new_cp/codedType else (),
            if (exists($new_cp/equipment)) then  $new_cp/equipment else (),
            if (exists($new_cp/purpose)) then  $new_cp/purpose else (),
            if (exists($new_cp/certificate)) then  $new_cp/certificate else ()
	   )}
	</contactPoint>
	let $provs3:=  
	<provider oid="{$provider/@oid}">
	  <organizations>
	    <organization>
	      <contactPoint position="{$position}"/>
	    </organization>
	  </organizations>
	</provider>
	return 
	  (insert node $cp into $org ,    
	  csd_prsq:wrap_updating_providers($provs3)
	)
      else   csd_prsq:wrap_updating_providers(())
    else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_org_contact_point($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/organization/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/organization/contactPoint/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs1,$requestParams/id) else ()
let $old_cp := $provs2[1]/organizations/organization[@oid =$requestParams/organization/@oid]/contactPoint[position() = $requestParams/organization/contactPoint/@position]
return
  if (count($provs2) = 1 and exists($old_cp)) 
    then
    let $new_cp := $requestParams/organization/contactPoint
    let $provs3 := 
    <provider oid="{$provs1[1]/@oid}">
      <organizations>
	<organization oid="{$requestParams/organization/@oid}">
	  <contactPoint position="{$requestParams/organization/contactPoint/@position}"/>
	</organization>
      </organizations>
    </provider>
    return
      (
	if (exists($new_cp/codedType)) 
	  then
	  (if (exists($old_cp/codedType)) then (delete node $old_cp/codedType) else (),
	  insert node $new_cp/codedType into $old_cp)
	else (),
	if (exists($new_cp/equipment)) 
	  then
	  (if (exists($old_cp/equipment)) then (delete node $old_cp/equipment) else (),
	  insert node $new_cp/equipment into $old_cp)
	else (),
	if (exists($new_cp/purpose)) then
	  (if (exists($old_cp/purpose)) then (delete node $old_cp/purpose) else (),
	  insert node $new_cp/purpose into $old_cp)
	else (),
	if (exists($new_cp/certificate)) then
	  (if (exists($old_cp/certificate)) then (delete node $old_cp/certificate) else (),
	  insert node $new_cp/certificate into $old_cp)
	else (),
	csd_prsq:wrap_updating_providers($provs3)
     )
  else 	csd_prsq:wrap_updating_providers(())

};




declare updating function csd_prsq:delete_org_contact_point($requestParams, $doc) 
{
  if (exists($requestParams/organization/contactPoint/@position) and exists($requestParams/organization/@oid)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let $orgs := $providers[1]/organizations/organization[@oid = $requestParams/organization/@oid]
	return
	  if (count($orgs) = 1) then
	    let  $cp :=  $orgs[1]/contactPoint[position() = $requestParams/organization/contactPoint/@position]
	    return if (exists($cp)) then (delete node $cp) else ()
	  else () 
      else  ()
    else ()      
};




(:Methods for Provider Organization:)
declare function csd_prsq:indices_provider_organization($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<organizations>
          {
	    for $org in $provider/organizations/organization 
	    return
	    <organization oid="{$org/@oid}"></organization>
	  }
	</organizations>
      </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_provider_organization($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/organization/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
      <provider oid="{$provider/@oid}">
	  {
	    (
	    <organizations>
	      {
		for $org in $provider/organizations/organization[@oid = $requestParams/organization/@oid  ]
		return
		<organization oid="{$org/@oid}"></organization>
	      }
	    </organizations>
	       
	      ,
	      $provider/record
	    )
	  }
      </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs2)
};





declare updating function csd_prsq:create_provider_organization($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/organization/@oid))  then $provs1 else ()
let $orgs0 := $provs2/organizations/organization[@oid = $requestParams/organization/@oid]
let $organizations := $provs2/organizations[1]
return  
  if ( count($provs2) = 1 and count($orgs0) = 0)  (:DO NOT ALLOW SAME ORG TWICE :)
    then
    let $provider:= $provs2[1]
    let $org :=  <organization oid="{$requestParams/organization/@oid}"/>
    let $orgs_new :=  <organizations>{$org}</organizations>

    let $provs3:=  
    <provider oid="{$provider/@oid}">{$orgs_new}</provider>
    return 
      if (exists($organizations)) 
	then
	(insert node $org into $organizations, 
	csd_prsq:wrap_updating_providers($provs3)
	)
      else
	(
	insert node $orgs_new into $provider,
	csd_prsq:wrap_updating_providers($provs3)
	)

  else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_provider_organization($requestParams, $doc) 
{  
() (: does nothing:)
};



declare updating function csd_prsq:delete_provider_organization($requestParams, $doc) 
{
  if (exists($requestParams/organization/@oid)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $org :=  $providers[1]/organizations/organization[@oid = $requestParams/organization/@oid]
	return if (exists($org)) then (delete node $org) else ()
      else  ()
    else ()      
};




(:Methods for Provider Credential:)
declare function csd_prsq:indices_credential($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
        {
	  for $cred in $provider/credential
	  return
	  <credential >{$cred/codedType}</credential>
	}
      </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_credential($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/credential/codedType/@code) and exists($requestParams/credential/codedType/@codingSchema) ) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    let $code:= $requestParams/credential/codedType/@code
    let $codingSchema:= $requestParams/credential/codedType/@codingSchema
    return 
      <provider oid="{$provider/@oid}">
	  {
	    (
	      $provider/credential/codedType[@code = $code and @codingSchema = $codingSchema]/..
	      ,
	      $provider/record
	    )
	  }
      </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs2)
};





declare updating function csd_prsq:create_credential($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/credential/codedType/@code) and exists($requestParams/credential/codedType/@codingSchema) ) then $provs1  else ()
let $cred_request := $requestParams/credential
let $code:= $cred_request/codedType/@code
let $codingSchema:= $cred_request/codedType/@codingSchema
let $creds0 := $provs2/credential[@code = $code and @codingSchema = $codingSchema]
return  
  if ( count($provs2) = 1 and count($creds0) = 0)  (:DO NOT ALLOW SAME CRED TWICE :)
    then
    let $provider:= $provs2[1]
    let $cred_rec :=
    <credential>
      <codedType code="{$code}" codingSchema="{$codingSchema}"/>
    </credential>
    let $cred_new :=
    <credential>
      <codedType code="{$code}" codingSchema="{$codingSchema}"/>
      {(
	if (exists($cred_request/number)) then $cred_request/number else (),
	if (exists($cred_request/issuingAuthority)) then $cred_request/issuingAuthority else (),
	if (exists($cred_request/credentialIssueDate)) then $cred_request/credentialIssueDate else (),
        if (exists($cred_request/credentialRenewalDate)) then $cred_request/credentialRenewalDate else ()
      )}
    </credential>
    let $provs3:=  
    <provider oid="{$provider/@oid}">{$cred_rec}</provider>
    return 
	(
	insert node $cred_new into $provider,
	csd_prsq:wrap_updating_providers($provs3)
	)

  else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_credential($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/credential/codedType/@code) and exists($requestParams/credential/codedType/@codingSchema) ) then $provs1  else ()
let $cred_new := $requestParams/credential
let $code:= $cred_new/codedType/@code
let $codingSchema:= $cred_new/codedType/@codingSchema
let $creds0 := $provs2/credential/codedType[@code = $code and @codingSchema = $codingSchema]
return  
  if ( count($provs2) = 1 and count($creds0) = 1)  (:Update only:)
    then
    let $cred_old := $creds0[1]/..
    let $provider:= $provs2[1]
    let $provs3 := 
      <provider oid="{$provider/@oid}">
	<credential>
	  <codedType code="{$code}" codingSchema="{$codingSchema}"/>
	</credential>
      </provider>


    return
      
      (
	if (exists($cred_new/issuingAuthority)) then
	  (if (exists($cred_old/issuingAuthority)) then (delete node $cred_old/issuingAuthority) else (),
	  insert node $cred_new/issuingAuthority into $cred_old)
	else (),
	if (exists($cred_new/number)) then
	  (if (exists($cred_old/number)) then (delete node $cred_old/number) else (),
	  insert node $cred_new/number into $cred_old)
	else (),
	if (exists($cred_new/credentialIssueDate)) then
	  (if (exists($cred_old/credentialIssueDate)) then (delete node $cred_old/credentialIssueDate) else (),
	  insert node $cred_new/credentialIssueDate into $cred_old)
	else (),
	if (exists($cred_new/credentialRenewalDate)) then
	  (if (exists($cred_old/credentialRenewalDate)) then (delete node $cred_old/credentialRenewalDate) else (),
	  insert node $cred_new/credentialRenewalDate into $cred_old)
	else (),
	csd_prsq:wrap_updating_providers($provs3)
       )
  else 	csd_prsq:wrap_updating_providers((<bad cs="{$codingSchema}" c="{$code}"></bad>,count($provs2), count($creds0)))
};



declare updating function csd_prsq:delete_credential($requestParams, $doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/credential/codedType/@code) and exists($requestParams/credential/codedType/@codingSchema) ) then $provs1  else ()
let $cred_new := $requestParams/credential
let $code:= $cred_new/codedType/@code
let $codingSchema:= $cred_new/codedType/@codingSchema
let $creds0 := $provs2/credential[@code = $code and @codingSchema = $codingSchema]
return  
  if ( count($provs2) = 1 and count($creds0) = 1)  then
    delete node $creds0[1]
  else
    ()
};







(:Methods for Provider Facility:)
declare function csd_prsq:indices_provider_facility($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<facilities>
          {
	    for $fac in $provider/facilities/facility 
	    return
	    <facility oid="{$fac/@oid}"></facility>
	  }
	</facilities>
      </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_provider_facility($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
      <provider oid="{$provider/@oid}">
	  {
	    (
	    <facilities>
	      {
		for $fac in $provider/facilities/facility[@oid = $requestParams/facility/@oid  ]
		return
		<facility oid="{$fac/@oid}"></facility>
	      }
	    </facilities>
	       
	      ,
	      $provider/record
	    )
	  }
      </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs2)
};





declare updating function csd_prsq:create_provider_facility($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/facility/@oid))  then $provs1 else ()
let $facs0 := $provs2/facilities/facility[@oid = $requestParams/facility/@oid]
let $facilities := $provs2/facilities[1]
return  
  if ( count($provs2) = 1 and count($facs0) = 0)  (:DO NOT ALLOW SAME ORG TWICE :)
    then
    let $provider:= $provs2[1]
    let $fac :=  <facility oid="{$requestParams/facility/@oid}"/>
    let $facs_new :=  <facilities>{$fac}</facilities>

    let $provs3:=  
    <provider oid="{$provider/@oid}">{$facs_new}</provider>
    return 
      if (exists($facilities)) 
	then
	(insert node $fac into $facilities, 
	csd_prsq:wrap_updating_providers($provs3)
	)
      else
	(
	insert node $facs_new into $provider,
	csd_prsq:wrap_updating_providers($provs3)
	)

  else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_provider_facility($requestParams, $doc) 
{  
() (: does nothing:)
};



declare updating function csd_prsq:delete_provider_facility($requestParams, $doc) 
{
  if (exists($requestParams/facility/@oid)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $fac :=  $providers[1]/facilities/facility[@oid = $requestParams/facility/@oid]
	return if (exists($fac)) then (delete node $fac) else ()
      else  ()
    else ()      
};




(:Methods for Provider Other ID:)
declare function csd_prsq:indices_otherid($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	{
	  for $id at $pos  in  $provider/otherID
	  return <otherID position="{$pos}"/> 
	}
    </provider>
      
    return csd_prsq:wrap_providers($provs1)
};

declare function csd_prsq:read_otherid($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/otherID/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider oid="{$provider/@oid}">
      {(
	if (exists($requestParams/otherID/@position))
	  then 
	  for $id in $provider/otherID[position() = $requestParams/otherID/@position]
	  return       
	  <otherID 
	  position="{$requestParams/otherID/@position}"
	  code="{$id/@code}"
	  assigningAuthorityName="{$id/@assigningAuthorityName}">{string($id)}</otherID>
	else
	  ()
        ,      
	$provider/record
	)}
    </provider>
  else ()    
    
return csd_prsq:wrap_providers($provs2)
};





declare updating function csd_prsq:create_otherid($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/otherID/@code))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $position := count($provider/otherID) +1
    let $id := 
      if (exists($requestParams/otherID/@assigningAuthorityName)) then
      <otherID code="{$requestParams/otherID/@code}" assigningAuthorityName="{$requestParams/otherID/@assigningAuthorityName}">{string($requestParams/otherID)}</otherID>
    else 
      <otherID code="{$requestParams/otherID/@code}">{string($requestParams/otherID)}</otherID>
    let $provs3:=  
    <provider oid="{$provider/@oid}">
      <otherID position="{$position}"/>
    </provider>
    return 
      (insert node $id into $provider ,    
      csd_prsq:wrap_updating_providers($provs3)
      )
  else  csd_prsq:wrap_updating_providers(())
      
};


declare updating function csd_prsq:update_otherid($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/otherID)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
let $id := $provs1[1]/otherID[position() = $requestParams/otherID/@position]
return
  if (count($provs1) = 1 and exists($id)) 
    then
    let $provs2 := 
    <provider oid="{$provs1[1]/@oid}">
      <otherID position="{$requestParams/name/@position}"/>
    </provider>
    return
      (
	if ($requestParams/otherID/@code) 
	  then 	    
	    if (exists($id/@code))
	      then  (replace value of node $id/@code with $requestParams/otherID/@code)
	      else (insert node  $requestParams/otherID/@code into $id)
	  else (),
	if (exists($requestParams/otherID/@assigningAuthorityName) )
	  then 
	    if (exists($id/@assigningAuthorityName))
	      then replace value of node $id/@assigningAuthorityName with $requestParams/otherID/@assigningAuthorityName
	      else insert node $requestParams/otherID/@assigningAuthorityName into $id		
	  else (),
	if (not(string($requestParams/otherID) = '')) 
	  then (replace value of node $id with string($requestParams/otherID))
	  else (),
	csd_prsq:wrap_updating_providers($provs2)
     )
  else 	csd_prsq:wrap_updating_providers(())

};


declare updating function csd_prsq:delete_otherid($requestParams, $doc) 
{
  if (exists($requestParams/otherID/@position)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $id :=  $providers[1]/otherID[position() = $requestParams/otherID/@position]
	return if (exists($id)) then (delete node $id) else ()
      else  ()
    else ()      
};

