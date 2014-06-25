(:~
: This is a module contatining  stored queries for a Care Services Discovery compliant Provider registry
: @version 1.0
: @see https://github.com/his-interop/openinfoman @see http://ihe.net
:
:)
module namespace csd_hwrsq = "https://github.com/his-interop/openinfoman-hwr/csd_hwrsq";

import module namespace csd_bl = "https://github.com/his-interop/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/his-interop/openinfoman/csd_blu";
declare default element  namespace   "urn:ihe:iti:csd:2013";


declare variable $csd_hwrsq:stored_functions :=
(
    <function uuid='fcbab300-6270-11e3-bd76-0002a5d5c51b'
              method='csd_hwrsq:oid_search_by_id'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='8a5df595-51ec-46e6-8a92-7db3c2484ee8'
              method='csd_hwrsq:get_oids'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='09b62156-32bf-48ab-b803-206efec0f7c3'
              method='csd_hwrsq:read_provider'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='f9bfe37f-95fc-4e74-8f07-2d3e7162e7a5'
              method='csd_hwrsq:delete_provider'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='dddb64c8-0eb1-49df-a2ad-b53e59f0bb7c'
              method='csd_hwrsq:create_provider'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='71d18ee0-6963-40c6-887a-a227ef302077'
              method='csd_hwrsq:update_provider'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,

	     (:Methods for Names:)
    <function uuid='e3cd7f80-7edb-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:indices_name'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='d251f150-7edb-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:read_name'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='4808be30-7f84-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:delete_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='8c8a2080-7f84-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:create_name'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='866455e0-7f84-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:update_name'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,




	     (:Methods for Address :)

    <function uuid='896b7bfd-d4c1-43c8-a109-9baa5c0328f7'
              method='csd_hwrsq:indices_address'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='cddd804b-1c2a-41c4-8937-91dcfadd04eb'
              method='csd_hwrsq:read_address'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='ff349aa8-e3e3-4f3d-8be1-dc157ccbeab1'
              method='csd_hwrsq:delete_address'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='d225d217-91c2-4d8d-a330-79c0e73de2e5'
              method='csd_hwrsq:create_address'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='8023e3c8-d36f-4ab2-b2c7-0ca36925e900'
              method='csd_hwrsq:update_address'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,


	     (:Methods for Contact Point:)

    <function uuid='5a268fa0-8391-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:indices_contact_point'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='5e338c60-8391-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:read_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='6181cd00-8391-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:delete_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='68d457d0-8391-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:create_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='6cb318a0-8391-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:update_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,

	     (:Methods for Credentials:)

    <function uuid='ecaeac3f-a4db-4407-9bec-12c47c853e65'
              method='csd_hwrsq:indices_credential'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='edb4316b-9408-4a6c-afde-74a6f0f7c706'
              method='csd_hwrsq:read_credential'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='d0a0992e-47c5-443f-b532-16f8b3a1d4a3'
              method='csd_hwrsq:delete_credential'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='d2657386-9dca-4fc7-a0ef-af0b0c892186'
              method='csd_hwrsq:create_credential'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='039fef0f-6e9c-4b71-bf6d-ce7c259a0f64'
              method='csd_hwrsq:update_credential'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,

	      (:Methods for Facility Affiliation:)
    <function uuid='a4544da0-831f-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:indices_provider_facility'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='aa65a5e0-831f-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:read_provider_facility'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='afcc3f30-831f-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:delete_provider_facility'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='b6078da0-831f-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:create_provider_facility'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='bc0a3fe0-831f-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:update_provider_facility'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,


	      (:Methods for Service:)
    <function uuid='584d0adc-2d80-414f-a7c9-0ad250c8b7c0'
              method='csd_hwrsq:indices_service'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='f5db6fa4-fec0-422c-a562-428f7dc9ebf3'
              method='csd_hwrsq:read_service'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='76f30efb-0b62-40b5-9b58-406cb55d63c4'
              method='csd_hwrsq:delete_service'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='1186ceea-a95f-4605-b427-303c38f2ce14'
              method='csd_hwrsq:create_service'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='a57f5668-6b4b-44a9-b7f2-64eb56270e6a'
              method='csd_hwrsq:update_service'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,


	      (:Methods for Operating Hours:)
    <function uuid='9c77ad44-73a9-4c85-bb3e-5a0a2cc23a99'
              method='csd_hwrsq:indices_operating_hours'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='ae26b85d-48cf-4127-97c6-e587587411f3'
              method='csd_hwrsq:read_operating_hours'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='acd3f03f-17cc-48de-bd99-9f6a9156b530'
              method='csd_hwrsq:delete_operating_hours'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='3c976647-c300-4a0f-bdc0-b218d335a3b7'
              method='csd_hwrsq:create_operating_hours'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='abea97b8-d0b2-46c3-aea0-fec960dbf1eb'
              method='csd_hwrsq:update_operating_hours'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,


	      (:Methods for Organizational Affiliation:)
    <function uuid='cf97b490-8313-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:indices_provider_organization'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='dd319bc0-8313-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:read_provider_organization'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='e7007130-8313-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:delete_provider_organization'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='f0908ff0-8313-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:create_provider_organization'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='f5b36980-8313-11e3-baa7-0800200c9a66'
              method='csd_hwrsq:update_provider_organization'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,
	     (:Methods for Organizational Contact Point:)



    <function uuid='6ca9a7b2-e1c8-402c-9b45-8c3009c29492'
              method='csd_hwrsq:indices_org_contact_point'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='bf6e77e1-8908-4ffb-b322-f472bfd24a51'
              method='csd_hwrsq:read_org_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     />,

    <function uuid='90c71896-2991-4f27-a65d-0bd442e60567'
              method='csd_hwrsq:delete_org_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='82e65afd-a52a-49e0-92b4-292134c1699d'
              method='csd_hwrsq:create_org_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='5e4e6bca-451d-41a7-b82e-7dc017a3e3ff'
              method='csd_hwrsq:update_org_contact_point'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,


	     (:Methods for Organiational Address :)

    <function uuid='10d8749c-866c-4df8-a3dd-49d0efee5ea4'
              method='csd_hwrsq:indices_org_address'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='5df2fffc-a0aa-489d-a3af-e09806b9e05f'
              method='csd_hwrsq:read_org_address'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='c96a5fe4-5ccf-460e-8f9f-d696800bc498'
              method='csd_hwrsq:delete_org_address'
 	      content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,
    <function uuid='91447349-e771-4b80-b467-934953f38ca1'
              method='csd_hwrsq:create_org_address'
 	      content-type='text/xml; charset=utf-8'      
	      updating='1'
	     />,
    <function uuid='26f230dd-0abf-42e4-883a-57cf7ec760d9'
              method='csd_hwrsq:update_org_address'
 	      content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />,



	     (:Methods for Identification:)

    <function uuid='af556315-9e6f-4a90-b5be-ee0ca71cae26'
              method='csd_hwrsq:indices_otherid'
 	      content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='e0e01b0d-8d18-4b65-a3ca-82229050709c'
              method='csd_hwrsq:read_otherid'
 	     content-type='text/xml; charset=utf-8'      
	     />,
    <function uuid='ef194926-bdf9-4c80-80e3-cdbe6b73f0a9'
              method='csd_hwrsq:delete_otherid'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='a1772539-cfa2-4601-9c34-3c6c473a878a'
              method='csd_hwrsq:create_otherid'
 	     content-type='text/xml; charset=utf-8'      
	     updating='1'
	     />,
    <function uuid='78680061-23c7-41cb-b128-abac3b26b8df'
              method='csd_hwrsq:update_otherid'
 	     content-type='text/xml; charset=utf-8'      
	      updating='1'
	      />


);


(:Utility methods:)
declare function csd_hwrsq:wrap_providers($providers) 
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

declare updating function csd_hwrsq:wrap_updating_providers($providers) 
{
  db:output(
    (
    <rest:response>
      <http:response status="200" >
	<http:header name="Content-Type" value="text/xml"/>
      </http:response>
      </rest:response>,
      csd_hwrsq:wrap_providers($providers)
      )
     )
};

(:Top-Level Provider  methods:)
declare function csd_hwrsq:get_oids($requestParams, $doc) as element() 
{
  let $provs0 := if (exists($requestParams/id)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else $doc/CSD/providerDirectory/*
  let $provs1 := if (exists($requestParams/otherID)) then csd_bl:filter_by_other_id($provs0,$requestParams/otherID) else $provs0
  let $provs2 := if (exists($requestParams/commonName)) then csd_bl:filter_by_common_name($provs1,$requestParams/commonName) else $provs1
  let $provs3 := if (exists($requestParams/codedType)) then csd_bl:filter_by_coded_type($provs2,$requestParams/codedType)    else $provs2
  let $provs4 := if (exists($requestParams/address/addressLine)) then csd_bl:filter_by_address($provs3, $requestParams/address/addressLine) else $provs3
  let $provs5 := if (exists($requestParams/record)) then csd_bl:filter_by_record($provs4,$requestParams/record) else $provs4
  let $provs6 := if (exists($requestParams/start) and exists($requestParams/max)) then csd_bl:limit_items($provs5,$requestParams/start,$requestParams/max) else $provs5
  let $provs7 := for $oid in $provs6/@oid         
   return <provider oid="{$oid}"/>

  return csd_hwrsq:wrap_providers($provs7)
};


declare function csd_hwrsq:oid_search_by_id($requestParams, $doc) as element() 
{
  let $provs0 := if (exists($requestParams/otherID)) then csd_bl:filter_by_other_id($doc/CSD/providerDirectory/*,$requestParams/otherID) else ()
  let $provs1 := if (exists($requestParams/start) and exists($requestParams/max)) then csd_bl:limit_items($provs0,$requestParams/start,$requestParams/max) else $provs0
  let $provs2:= for $oid in $provs1/@oid     
   return <provider oid="{$oid}"/>

  return csd_hwrsq:wrap_providers($provs2)
};


declare function csd_hwrsq:read_provider($requestParams,$doc) as element() 
{
let $provs0 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()  
let $provs1 :=  if (count($provs0) = 1) then
  let $prov := $provs0[1]
  return 
  <provider oid="{$prov/@oid}">  
  {(
      $prov/codedType,
      <demographic>
      {(
	if (exists($prov/demographic/gender)) then $prov/demographic/gender else (),
	if (exists($prov/demographic/dateOfBirth)) then $prov/demographic/dateOfBirth else ()
      )}
      </demographic>,
      $prov/language,
      $prov/specialty,
      $prov/record
  )}
  </provider>
  else ()
  return csd_hwrsq:wrap_providers($provs1)
};




declare updating function csd_hwrsq:create_provider($requestParams,$doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()  
return
  if (count($provs0) > 0) then (csd_hwrsq:wrap_updating_providers(()))     (:do not allow duplicate OIDs:)
else
  let $oid := 
    if (exists($requestParams/id/@oid) and not($requestParams/id/@oid = '')) then $requestParams/id/@oid
  else csd_bl:uuid_as_oid()
  let $time :=current-dateTime()
  let $prov := 
  <provider oid="{$oid}">
    {(
      $requestParams/codedType,
      <demographic>
	{(
	  $requestParams/gender,
	  $requestParams/dateOfBirth
	 )}
	 </demographic>,
	 $requestParams/language,
         $requestParams/specialty,
	 if ($requestParams/status) 
	   then
	   <record created="{$time}" updated="{$time}" status="{$requestParams/status}" sourceDirectory="{$requestParams/sourceDirectory}"/>
	 else 
	   <record created="{$time}" updated="{$time}" status="Active" sourceDirectory="{$requestParams/sourceDirectory}"/>
     )}
  </provider>
  
  return (
    insert node $prov into $doc/CSD/providerDirectory,  
    csd_hwrsq:wrap_updating_providers(<provider oid="{$oid}"/>)
  )

};


declare updating function csd_hwrsq:update_provider($requestParams,$doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()  
return
  if (not (count($provs0) = 1)) 
    then ( csd_hwrsq:wrap_updating_providers((<bad/>)))     (:do nothing :)
  else
    let $provider := $provs0[1]
    let $demo := $provider/demographic
    let $dob := $demo/dateOfBirth
    let $gender := $demo/gender
    return 
      (
	csd_blu:bump_timestamp($provider),
	delete node $provider/codedType,
	insert node $requestParams/codedType into $provider,
	if (not(exists($demo)))
	  then
	  insert node
	  <demographic>
	    {($requestParams/gender,$requestParams/dateOfBirth)}
	  </demographic>
	  into $provider	
	else	
	  (
	    if (not(exists($dob))) then  insert node $requestParams/dateOfBirth into $demo else replace value of node  $demo/dateOfBirth with $requestParams/dateOfBirth,
	    if (not(exists($gender))) then  insert node $requestParams/gender into $demo else replace value of node  $demo/gender with $requestParams/gender
	),
	delete node $provider/language,
	insert node $requestParams/language into $provider,
	delete node $provider/specialty,
	insert node $requestParams/specialty into $provider,
	if (exists($provider/record/@status)) 
	  then replace value of node $provider/record/@status with $requestParams/status 
	else insert node attribute { 'status' } { string($requestParams/status) } into $provider/record,
	csd_hwrsq:wrap_updating_providers(<provider oid="{$provider/@oid}" ok='1'/>)
    )

};



declare updating function csd_hwrsq:delete_provider($requestParams,$doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()  
return  if (count($provs0) = 1) then
  delete node $provs0[1] else ()
};


(:Methods for Names:)
declare function csd_hwrsq:indices_name($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
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
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_name($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/name/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
    
return csd_hwrsq:wrap_providers($provs2)
};





declare updating function csd_hwrsq:create_name($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/name))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $position := count($provider/demographic/name) +1
    let $provs3:=  
    <provider oid="{$provider/@oid}">
      <demographic>
	<name position="{$position}"/>
      </demographic>
    </provider>
    return 
      (
	if (exists($provider/demographic))
	  then insert node $requestParams/name into $provider/demographic 
	else
	  insert node <demographic>{$requestParams/name}</demographic> into $provider
	  ,   csd_hwrsq:wrap_updating_providers($provs3)
	)
  else  csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_name($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/name/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
    let $new_name := 
    <name>
     {$requestParams/name/*}
    </name>
    return
      (
	csd_blu:bump_timestamp($provs1[1]),
	replace  node $name with $new_name,
	csd_hwrsq:wrap_updating_providers($provs2)
     )
  else 	csd_hwrsq:wrap_updating_providers(())

};



declare updating function csd_hwrsq:delete_name($requestParams, $doc) 
{
  if (exists($requestParams/name/@position)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $name :=  $providers[1]/demographic/name[position() = $requestParams/name/@position]
	return if (exists($name)) then (delete node $name) else ()
      else  ()
    else ()      
};







(:Methods for Contact Point:)
declare function csd_hwrsq:indices_contact_point($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
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
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_contact_point($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/contactPoint/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
    
return csd_hwrsq:wrap_providers($provs2)
};





declare updating function csd_hwrsq:create_contact_point($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
      csd_hwrsq:wrap_updating_providers($provs3)
      )
  else  csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_contact_point($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/contactPoint/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
	csd_blu:bump_timestamp($provs1[1]),
	delete node $old_cp/codeType,
	if (exists($new_cp/codeType)) then insert node $new_cp/codeType into $old_cp else (),
	delete node $old_cp/equipment,
	if (exists($new_cp/equipment)) then insert node $new_cp/equipment into $old_cp else (),
	delete node $old_cp/purpose,
	if (exists($new_cp/purpose)) then insert node $new_cp/purpose into $old_cp else (),
	delete node $old_cp/certificate,
	if (exists($new_cp/certificate)) then insert node $new_cp/certificate into $old_cp else (),
	csd_hwrsq:wrap_updating_providers($provs2)
     )
  else 	csd_hwrsq:wrap_updating_providers(())

};




declare updating function csd_hwrsq:delete_contact_point($requestParams, $doc) 
{
  if (exists($requestParams/contactPoint/@position)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $cp :=  $providers[1]/demographic/contactPoint[position() = $requestParams/contactPoint/@position]
	return if (exists($cp)) then (delete node $cp) else ()
      else  ()
    else ()      
};


(:Methods for Organizational Contact Point:)
declare function csd_hwrsq:indices_org_contact_point($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
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
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_org_contact_point($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/organization/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/organization/contactPoint/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs1,$requestParams/id) else ()
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
    
return csd_hwrsq:wrap_providers($provs3)
};





declare updating function csd_hwrsq:create_org_contact_point($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
	    <organization oid="{$org/@oid}">
	      <contactPoint position="{$position}"/>
	    </organization>
	  </organizations>
	</provider>
	return 
	  (insert node $cp into $org ,    
	  csd_hwrsq:wrap_updating_providers($provs3)
	)
      else   csd_hwrsq:wrap_updating_providers(())
    else  csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_org_contact_point($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/organization/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/organization/contactPoint/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs1,$requestParams/id) else ()
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
	csd_blu:bump_timestamp($provs2[1]),
	delete node $old_cp/codeType,
	if (exists($new_cp/codeType)) then insert node $new_cp/codeType into $old_cp else (),
	delete node $old_cp/equipment,
	if (exists($new_cp/equipment)) then insert node $new_cp/equipment into $old_cp else (),
	delete node $old_cp/purpose,
	if (exists($new_cp/purpose)) then insert node $new_cp/purpose into $old_cp else (),
	delete node $old_cp/certificate,
	if (exists($new_cp/certificate)) then insert node $new_cp/certificate into $old_cp else (),
	csd_hwrsq:wrap_updating_providers($provs3)
     )
  else 	csd_hwrsq:wrap_updating_providers(())

};




declare updating function csd_hwrsq:delete_org_contact_point($requestParams, $doc) 
{
  if (exists($requestParams/organization/contactPoint/@position) and exists($requestParams/organization/@oid)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
declare function csd_hwrsq:indices_provider_organization($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
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
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_provider_organization($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/organization/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
    
return csd_hwrsq:wrap_providers($provs2)
};





declare updating function csd_hwrsq:create_provider_organization($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
	csd_hwrsq:wrap_updating_providers($provs3)
	)
      else
	(
	insert node $orgs_new into $provider,
	csd_hwrsq:wrap_updating_providers($provs3)
	)

  else  csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_provider_organization($requestParams, $doc) 
{  
() (: does nothing:)
};



declare updating function csd_hwrsq:delete_provider_organization($requestParams, $doc) 
{
  if (exists($requestParams/organization/@oid)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $org :=  $providers[1]/organizations/organization[@oid = $requestParams/organization/@oid]
	return if (exists($org)) then (delete node $org) else ()
      else  ()
    else ()      
};




(:Methods for Provider Credential:)
declare function csd_hwrsq:indices_credential($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
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
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_credential($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/credential/codedType/@code) and exists($requestParams/credential/codedType/@codingSchema) ) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
    
return csd_hwrsq:wrap_providers($provs2)
};





declare updating function csd_hwrsq:create_credential($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
	csd_hwrsq:wrap_updating_providers($provs3)
	)

  else  csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_credential($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
	csd_blu:bump_timestamp($provider),
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
	csd_hwrsq:wrap_updating_providers($provs3)
       )
  else 	csd_hwrsq:wrap_updating_providers((<bad cs="{$codingSchema}" c="{$code}"></bad>,count($provs2), count($creds0)))
};



declare updating function csd_hwrsq:delete_credential($requestParams, $doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
declare function csd_hwrsq:indices_provider_facility($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
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
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_provider_facility($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
    
return csd_hwrsq:wrap_providers($provs2)
};





declare updating function csd_hwrsq:create_provider_facility($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
	csd_hwrsq:wrap_updating_providers($provs3)
	)
      else
	(
	insert node $facs_new into $provider,
	csd_hwrsq:wrap_updating_providers($provs3)
	)

  else  csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_provider_facility($requestParams, $doc) 
{  
() (: does nothing:)
};



declare updating function csd_hwrsq:delete_provider_facility($requestParams, $doc) 
{
  if (exists($requestParams/facility/@oid)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $fac :=  $providers[1]/facilities/facility[@oid = $requestParams/facility/@oid]
	return if (exists($fac)) then (delete node $fac) else ()
      else  ()
    else ()      
};




(:Methods for Provider Other ID:)
declare function csd_hwrsq:indices_otherid($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
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
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_otherid($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/otherID/@position)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
    
return csd_hwrsq:wrap_providers($provs2)
};





declare updating function csd_hwrsq:create_otherid($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
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
      csd_hwrsq:wrap_updating_providers($provs3)
      )
  else  csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_otherid($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/otherID)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
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
	csd_blu:bump_timestamp($provs1[1]),
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
	csd_hwrsq:wrap_updating_providers($provs2)
     )
  else 	csd_hwrsq:wrap_updating_providers(())

};


declare updating function csd_hwrsq:delete_otherid($requestParams, $doc) 
{
  if (exists($requestParams/otherID/@position)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let  $id :=  $providers[1]/otherID[position() = $requestParams/otherID/@position]
	return if (exists($id)) then (delete node $id) else ()
      else  ()
    else ()      
};









(:Methods for Provider Address:)
declare function csd_hwrsq:indices_address($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<demographic>
	  {
	    for $address in  $provider/demographic/address
	    return <address type="{$address/@type}"/> 
	  }
	</demographic>
    </provider>
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_address($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/address/@type)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider oid="{$provider/@oid}">
      <demographic>
	{(
	  for $address in $provider/demographic/address[@type = $requestParams/address/@type]
	  return $address
	 )}
      </demographic>
      {$provider/record}
    </provider>
  else ()        
return csd_hwrsq:wrap_providers($provs2)
};





declare updating function csd_hwrsq:create_address($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/address/@type))  then $provs1 else ()
return  
  if ( count($provs2) = 1 )
    then
    let $provider:= $provs2[1]
    let $demo := $provider/demographic
    return if (exists($demo/address[@type = $requestParams/address/@type])) 
      then
      csd_hwrsq:wrap_updating_providers(()) (: Do not allow the same type to be created more than once:)
    else
      let $provs3:=  
      <provider oid="{$provider/@oid}">
        <demographic><address type="{$requestParams/address/@type}"/></demographic>
      </provider>
       return (
	 if (not(exists($demo)))
	   then
	   insert node
	   <demographic>{$requestParams/address}</demographic>
	   into $provider	
	 else	
	   insert node  $requestParams/address into $demo
	   ,
	csd_hwrsq:wrap_updating_providers($provs3)
	)
  else  csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_address($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/address/@type))  then $provs1 else ()
let $provider:= $provs2[1]
let $demo := $provider/demographic
let $address:= $demo/address[@type = $requestParams/address/@type]
return  
  if ( not(exists($address))) then
    csd_hwrsq:wrap_updating_providers(()) (: Address does not exist.  Do not update:)
  else
    let $provs3:=  
    <provider oid="{$provider/@oid}">
      <demographic><address type="{$requestParams/address/@type}"/></demographic>
    </provider>
    return (
      csd_blu:bump_timestamp($provider),
      replace  node  $address with $requestParams/address
      ,
      csd_hwrsq:wrap_updating_providers($provs3)
    )
};

declare updating function csd_hwrsq:delete_address($requestParams, $doc) 
{

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/address/@type))  then $provs1 else ()
let $address:= $provs2[1]/demographic/address[@type = $requestParams/address/@type]
return if (exists($address)) then (delete node $address) else ()
};








(:Methods for Provider's Organizational Address:)
declare function csd_hwrsq:indices_org_address($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
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
		    for $address  in $org/address
		    return <address type="{$address/@type}"/> 
		  }
		</organization>
	  }
	</organizations>
    </provider>
      
    return csd_hwrsq:wrap_providers($provs1)
};




declare function csd_hwrsq:read_org_address($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/organization/@oid) and exists($requestParams/organization/address/@type)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs0,$requestParams/id) else ()
let $provs2 := 
  if (count($provs1) = 1) 
    then 
    let $provider :=  $provs1[1] 
    return 
    <provider oid="{$provider/@oid}">
      <organizations>
	<organization oid="{$requestParams/organization/@oid}">
	  {
	    $provider/organizations/organization[@oid = $requestParams/organization/@oid]/address[@type = $requestParams/organization/address/@type]
	  }
	</organization>
      </organizations>
      {$provider/record}
    </provider>
  else ()        
return csd_hwrsq:wrap_providers($provs2)
};




declare updating function csd_hwrsq:create_org_address($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/organization/@oid))  then $provs1 else ()
let $provs3 := if (exists($requestParams/organization/address/@type))  then $provs2 else ()
let $provider:= $provs3[1]
let $orgs := $provider/organizations/organization[@oid = $requestParams/organization/@oid]
let $org := if(count($orgs) =1) then $orgs[1] else ()
let $address := $org/address[@type = $requestParams/organization/address/@type]
return if (not(exists($org)) or exists($address))
  then   csd_hwrsq:wrap_updating_providers(()) (:do not create an already existing one :)	  
else
  (
    insert node $requestParams/organization/address into $org,
    csd_hwrsq:wrap_updating_providers(    
	<provider oid="{$provider/@oid}">
	  <organizations>
	    <organization oid="{$org/@oid}">
	      <contactPoint position="{$requestParams/organization/address/@type}"/>
	    </organization>
	  </organizations>
	</provider>
     )
)
};



declare updating function csd_hwrsq:update_org_address($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/organization/@oid))  then $provs1 else ()
let $provs3 := if (exists($requestParams/organization/address/@type))  then $provs2 else ()
let $provider:= $provs3[1]
let $org_container := $provider/organizations[1]
let $orgs := $provider/organizations/organization[@oid = $requestParams/organization/@oid]
let $org := if(count($orgs) =1) then $orgs[1] else ()
let $address := $org/address[@type = $requestParams/organization/address/@type]
return if (not(exists($address)))
  then   csd_hwrsq:wrap_updating_providers((<bad0/>,$requestParams)) (:do not update an non-existent one :)
else
  (
    csd_blu:bump_timestamp($provider),
    replace node $address with  $requestParams/organization/address ,
     csd_hwrsq:wrap_updating_providers(    
       <provider oid="{$provider/@oid}">
	 <organizations>
	   <organization oid="{$org/@oid}">
	     <contactPoint position="{$address/@type}"/>
	   </organization>
	 </organizations>
       </provider>
    )
)
};



declare updating function csd_hwrsq:delete_org_address($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/organization/@oid))  then $provs1 else ()
let $provs3 := if (exists($requestParams/organization/address/@type))  then $provs2 else ()
let $provider:= $provs3[1]
let $orgs := $provider/organizations/organization[@oid = $requestParams/organization/@oid]
let $org := if(count($orgs) =1) then $orgs[1] else ()
let $address := $org/address[@type = $requestParams/organization/address/@type]
return if (exists($address)) then (delete node $address) else ()
};




(:Methods for Provider's Service :)
declare function csd_hwrsq:indices_service($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<facilities>
	  {
	    let $facs := 
	      if (exists($requestParams/facility/@oid)) 
		then 
		$provider/facilities/facility[@oid = $requestParams/facility/@oid]
	      else    $provider/facilities/facility
            for $fac in $facs
	      return 
	       <facility oid="{$fac/@oid}">
		  {
		    for $srvc at $pos in $fac/service
		    return <service position="{$pos}" oid="{$srvc/@oid}"/> 
		  }
		</facility>
	  }
	</facilities>
    </provider>
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_service($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs1,$requestParams/id) else ()
let $provs3 := 
  if (count($provs2) = 1) 
    then 
    let $provider :=  $provs2[1] 
    return 
    <provider oid="{$provider/@oid}">
      {
	if (exists($requestParams/facility/@oid) and exists($requestParams/facility/service/@position)) 
	  then 
	  <facilities>
	    <facility oid="{$requestParams/facility/@oid}">
	    {
	      for $srvc in $provider/facilities/facility[@oid = $requestParams/facility/@oid]/service[position() = $requestParams/facility/service/@position]
	      return       <service position="{$requestParams/facility/service/@position}" oid="{$srvc/@oid}">{$srvc/*}</service>
	  }
	    </facility>
	  </facilities>
	else
	  ()
      }
      {$provider/record}
    </provider>
  else ()    
    
return csd_hwrsq:wrap_providers($provs3)
};





declare updating function csd_hwrsq:create_service($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/facility/@oid))  then $provs1 else ()
let $provs3 := if (exists($requestParams/facility/service/@oid))  then $provs2 else ()
let $provider:=   if ( count($provs3) = 1 ) then $provs3[1] else ()
let $facs := $provider/facilities/facility[@oid = $requestParams/facility/@oid]
let $fac := if (count($facs) = 1) then $facs[1] else ()
return if (exists($fac))
  then
  let $position := count($fac/service) +1
  let $srvc := 
  <service oid="{$requestParams/facility/service/@oid}">
    {(
      $requestParams/facility/service/organization,
      $requestParams/facility/service/language,
      $requestParams/facility/service/freeBusyURI
     )}
  </service>
  let $provs3:=  
  <provider oid="{$provider/@oid}">
    <facilities>
      <facility oid="{$fac/@oid}">
	<service position="{$position}" oid="{$requestParams/facility/service/@oid}"/>
      </facility>
    </facilities>
  </provider>
  return 
    (insert node $srvc into $fac ,    
    csd_hwrsq:wrap_updating_providers($provs3)
  )
else   csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_service($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs1,$requestParams/id) else ()
let $old_srvc := $provs2[1]/facilities/facility[@oid =$requestParams/facility/@oid]/service[position() = $requestParams/facility/service/@position]
return
  if (count($provs2) = 1 and exists($old_srvc)) 
    then
    let $new_srvc := $requestParams/facility/service
    let $provs3 := 
    <provider oid="{$provs1[1]/@oid}">
      <facilities>
	<facility oid="{$requestParams/facility/@oid}">
	  <service position="{$requestParams/facility/service/@position}" />
	</facility>
      </facilities>
    </provider>
    return
      (
	csd_blu:bump_timestamp($provs2[1]),
	delete node $old_srvc/freeBusyURI,
	if (exists($new_srvc/freeBusyURI)) then insert node $new_srvc/freeBusyURI into $old_srvc else (),
	delete node $old_srvc/organization,
	if (exists($new_srvc/organization)) then insert node $new_srvc/organization into $old_srvc else (),
	delete node $old_srvc/language,
	if (exists($new_srvc/language)) then insert node $new_srvc/language into $old_srvc else (),
	csd_hwrsq:wrap_updating_providers($provs3)
     )
  else 	csd_hwrsq:wrap_updating_providers(())

};




declare updating function csd_hwrsq:delete_service($requestParams, $doc) 
{
  if (exists($requestParams/facility/service/@position) and exists($requestParams/facility/@oid)) 
    then 
    let $providers := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
    return
      if ( count($providers) = 1 )
	then
	let $facs := $providers[1]/facilities/facility[@oid = $requestParams/facility/@oid]
	return
	  if (count($facs) = 1) then
	    let  $srvc :=  $facs[1]/service[position() = $requestParams/facility/service/@position]
	    return if (exists($srvc)) then (delete node $srvc) else ()
	  else () 
      else  ()
    else ()      
};







(:Methods for Provider's Operating Hours :)
declare function csd_hwrsq:indices_operating_hours($requestParams, $doc) as element() 
{
  let $provs0 := 
    if (exists($requestParams/id/@oid)) then 
      csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) 
    else ($doc/CSD/providerDirectory/*)
  let $provs1:=     
      for $provider in  $provs0
      return
      <provider oid="{$provider/@oid}">
	<facilities>
	  {
	    let $facs := 
	      if (exists($requestParams/facility/@oid)) 
		then 
		$provider/facilities/facility[@oid = $requestParams/facility/@oid]
	      else    $provider/facilities/facility
            for $fac in $facs
	      return 
	       <facility oid="{$fac/@oid}">
		  {
		    if ($requestParams/facility/service/@position) 
		      then
			for $srvc in $fac/service[position()= $requestParams/facility/service/@position] 
			return 
			<service position="{$requestParams/facility/service/@position}">
			  {for $oh at $ohpos in $srvc/operatingHours return <operatingHours position="{$ohpos}"/>}
			</service>
		    else 
		      for $srvc at $spos in $fac/service
			return 
			<service position="{$spos}">
			  {for $oh at $ohpos in $srvc/operatingHours return <operaingHours position="{$ohpos}"/>}
			</service>
		  }
		</facility>
	  }
	</facilities>
    </provider>
      
    return csd_hwrsq:wrap_providers($provs1)
};

declare function csd_hwrsq:read_operating_hours($requestParams, $doc) as element() 
{
let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/facility/service/operatingHours/@position)) then $provs1  else ()
let $provs3 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs2,$requestParams/id) else ()
let $srvc := $provs3[1]/facilities/facility[@oid =$requestParams/facility/@oid]/service[position() = $requestParams/facility/service/@position]
let  $provs4:=   
  if (count($srvc) = 1) 
    then
    let $oh := $srvc/operatingHours[position() = $requestParams/facility/service/operatingHours/@position]
    return <provider oid="{$requestParams/id/@oid}">
      <facilities>
	<facility oid="{$requestParams/facility/@oid}">
	  <service position="{$requestParams/facility/service/@position}" >
	    <operatingHours position="{$requestParams/facility/service/operatingHours/@position}">{$oh/*}</operatingHours>
	  </service>
	</facility>
      </facilities>
      {$requestParams}
    </provider>
  else ()


return csd_hwrsq:wrap_providers($provs4)
};




declare updating function csd_hwrsq:create_operating_hours($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/facility/service/operatingHours)) then $provs1  else ()
let $provs3 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs2,$requestParams/id) else ()
let $srvc := $provs3[1]/facilities/facility[@oid =$requestParams/facility/@oid]/service[position() = $requestParams/facility/service/@position]
return if (count($srvc) = 1) 
  then
  let $position := count($srvc/operatingHours)
  let $provs4:=  
  <provider oid="{$requestParams/id/@oid}">
    <facilities>
      <facility oid="{$requestParams/facility/@oid}">
	<service position="{$requestParams/facility/service/@position}" oid="{$requestParams/facility/service/@oid}">
	  <operatingHours position="{$position}" />
	</service>
      </facility>
    </facilities>
  </provider>
  return 
    (insert node $requestParams/facility/service/operatingHours into $srvc[1] ,    
    csd_hwrsq:wrap_updating_providers($provs4)
  )
else   csd_hwrsq:wrap_updating_providers(())
      
};


declare updating function csd_hwrsq:update_operating_hours($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/facility/service/operatingHours/@position)) then $provs1  else ()
let $provs3 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs2,$requestParams/id) else ()
let $oh := $provs3[1]/facilities/facility[@oid =$requestParams/facility/@oid]/service[position() = $requestParams/facility/service/@position]/operatingHours[position() = $requestParams/facility/service/operatingHours/@position]
return
  if (count($oh) = 1 and count($provs3) = 1)
    then
    let $new_oh := $requestParams/facility/service/operatingHours
    let $provs4 := 
    <provider oid="{$provs1[1]/@oid}">
      <facilities>
	<facility oid="{$requestParams/facility/@oid}">
	  <service position="{$requestParams/facility/service/@position}" >
	    <operatingHours position="{$requestParams/facility/service/operatingHours/@position}"/>
	  </service>
	</facility>
      </facilities>
    </provider>
    return
      (
	csd_blu:bump_timestamp($provs3[1]),
	delete node $oh/openFlag,
	if (exists($new_oh/openFlag)) then insert node $new_oh/openFlag into $oh else (),
	delete node $oh/dayOfTheWeek,
	if (exists($new_oh/dayOfTheWeek)) then insert node $new_oh/dayOfTheWeek into $oh else (),
	delete node $oh/beginningHour,
	if (exists($new_oh/beginningHour)) then insert node $new_oh/beginningHour into $oh else (),
	delete node $oh/endingHour,
	if (exists($new_oh/endingHour)) then insert node $new_oh/endingHour into $oh else (),
	delete node $oh/beginEffectiveDate,
	if (exists($new_oh/beginEffectiveDate)) then insert node $new_oh/beginEffectiveDate into $oh else (),
	delete node $oh/endEffectiveDate,
	if (exists($new_oh/endEffectiveDate)) then insert node $new_oh/endEffectiveDate into $oh else (),
	csd_hwrsq:wrap_updating_providers($provs4)
     )
  else 	csd_hwrsq:wrap_updating_providers(())

};




declare updating function csd_hwrsq:delete_operating_hours($requestParams, $doc) 
{
let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/facility/service/operatingHours/@position)) then $provs1  else ()
let $provs3 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($provs2,$requestParams/id) else ()
let $oh := $provs3[1]/facilities/facility[@oid =$requestParams/facility/@oid]/service[position() = $requestParams/facility/service/@position]/operatingHours[position() = $requestParams/facility/service/operatingHours/@position]
return
  if (count($oh) = 1)
    then (delete node $oh) else ()
};

