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
  let $provs3 := if (exists($requestParams/type)) then csd:filter_by_coded_type($provs2,$requestParams/type)    else $provs2
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




