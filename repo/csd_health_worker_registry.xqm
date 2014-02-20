(:~
: This is a module contatining  read only stored queries for a Care Services Discovery compliant Health Worker registry
: @version 1.0
: @see https://github.com/his-interop/openinfoman @see http://ihe.net
:
:)
module namespace csd_hwr = "https://github.com/his-interop/openinfoman-hwr/csd_hwr";
import module namespace csd = "urn:ihe:iti:csd:2013" at "csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";


declare function csd_hwr:facility_get_oids($requestParams, $doc) as element() 
{
  let $facs0 := if (exists($requestParams/id)) then csd:filter_by_primary_id($doc/CSD/facilityDirectory/*,$requestParams/id) else $doc/CSD/facilityDirectory/*
  let $facs1 := if (exists($requestParams/otherID)) then csd:filter_by_other_id($facs0,$requestParams/otherID) else $facs0
  let $facs2 := if (exists($requestParams/codedType)) then csd:filter_by_coded_type($facs1,$requestParams/codedType)    else $facs1
  let $facs3 := if (exists($requestParams/address/addressLine)) then csd:filter_by_address($facs2, $requestParams/address/addressLine) else $facs2
  let $facs4 := if (exists($requestParams/record)) then csd:filter_by_record($facs3,$requestParams/record) else $facs3
  let $facs5 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($facs4,$requestParams/start,$requestParams/max) else $facs4
  let $facs6 := for $oid in $facs5/@oid         
   return <facility oid="{$oid}"/>

  return csd:wrap_facilities(($facs6))
};

declare function csd_hwr:health_worker_oid_search_by_id($requestParams, $doc) as element() 
{
  let $provs0 := if (exists($requestParams/otherID)) then csd:filter_by_other_id($doc/CSD/providerDirectory/*,$requestParams/otherID) else ()
  let $provs1 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($provs0,$requestParams/start,$requestParams/max) else $provs0
  let $provs2:= for $oid in $provs1/@oid     
   return <provider oid="{$oid}"/>

  return csd:wrap_providers($provs2)
};

declare function csd_hwr:health_worker_get_oids($requestParams, $doc) as element() 
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

  return csd:wrap_providers($provs7)
};

declare function csd_hwr:health_worker_read_provider($requestParams,$doc) as element() 
{
let $provs0 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()  
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
  return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_indices_name($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_name($requestParams, $doc) as element() 
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
    
return csd:wrap_providers($provs2)
};

declare function csd_hwr:health_worker_indices_address($requestParams, $doc) as element() 
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
	    for $address in  $provider/demographic/address
	    return <address type="{$address/@type}"/> 
	  }
	</demographic>
    </provider>
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_address($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/address/@type)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
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
return csd:wrap_providers($provs2)
};

declare function csd_hwr:health_worker_indices_contact_point($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_contact_point($requestParams, $doc) as element() 
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
    
return csd:wrap_providers($provs2)
};

declare function csd_hwr:health_worker_indices_credential($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_credential($requestParams, $doc) as element() 
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
    
return csd:wrap_providers($provs2)
};

declare function csd_hwr:health_worker_indices_provider_facility($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_provider_facility($requestParams, $doc) as element() 
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
    
return csd:wrap_providers($provs2)
};

declare function csd_hwr:health_worker_indices_service($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_service($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs1,$requestParams/id) else ()
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
    
return csd:wrap_providers($provs3)
};

declare function csd_hwr:health_worker_indices_operating_hours($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_operating_hours($requestParams, $doc) as element() 
{
let $provs0 := if (exists($requestParams/facility/@oid)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/facility/service/@position)) then $provs0  else ()
let $provs2 := if (exists($requestParams/facility/service/operatingHours/@position)) then $provs1  else ()
let $provs3 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs2,$requestParams/id) else ()
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


return csd:wrap_providers($provs4)
};

declare function csd_hwr:health_worker_indices_provider_organization($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_provider_organization($requestParams, $doc) as element() 
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
    
return csd:wrap_providers($provs2)
};

declare function csd_hwr:health_worker_indices_org_contact_point($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_org_contact_point($requestParams, $doc) as element() 
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
    
return csd:wrap_providers($provs3)
};

declare function csd_hwr:health_worker_indices_org_address($requestParams, $doc) as element() 
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
		    for $address  in $org/address
		    return <address type="{$address/@type}"/> 
		  }
		</organization>
	  }
	</organizations>
    </provider>
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_org_address($requestParams, $doc) as element() 
{

let $provs0 := if (exists($requestParams/organization/@oid) and exists($requestParams/organization/address/@type)) then $doc/CSD/providerDirectory/*  else ()
let $provs1 := if (exists($requestParams/id/@oid)) then csd:filter_by_primary_id($provs0,$requestParams/id) else ()
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
return csd:wrap_providers($provs2)
};

declare function csd_hwr:health_worker_indices_otherid($requestParams, $doc) as element() 
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
      
    return csd:wrap_providers($provs1)
};

declare function csd_hwr:health_worker_read_otherid($requestParams, $doc) as element() 
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
    
return csd:wrap_providers($provs2)
};

declare function csd_hwr:organization_get_oids($requestParams, $doc) as element() 
{
  let $orgs0 := if (exists($requestParams/id)) then csd:filter_by_primary_id($doc/CSD/organizationDirectory/*,$requestParams/id) else $doc/CSD/organizationDirectory/*
  let $orgs1 := if (exists($requestParams/otherID)) then csd:filter_by_other_id($orgs0,$requestParams/otherID) else $orgs0
  let $orgs2 := if (exists($requestParams/codedType)) then csd:filter_by_coded_type($orgs1,$requestParams/codedType)    else $orgs1
  let $orgs3 := if (exists($requestParams/address/addressLine)) then csd:filter_by_address($orgs2, $requestParams/address/addressLine) else $orgs2
  let $orgs4 := if (exists($requestParams/record)) then csd:filter_by_record($orgs3,$requestParams/record) else $orgs3
  let $orgs5 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($orgs4,$requestParams/start,$requestParams/max) else $orgs4
  let $orgs6 := for $oid in $orgs5/@oid         
   return <organization oid="{$oid}"/>

  return csd:wrap_organizations(($orgs6))
};

declare function csd_hwr:service_get_oids($requestParams, $doc) as element() 
{
  let $srvcs0 := if (exists($requestParams/id)) then csd:filter_by_primary_id($doc/CSD/serviceDirectory/*,$requestParams/id) else $doc/CSD/serviceDirectory/*
  let $srvcs1 := if (exists($requestParams/codedType)) then csd:filter_by_coded_type($srvcs0,$requestParams/codedType)    else $srvcs0
  let $srvcs2 := if (exists($requestParams/record)) then csd:filter_by_record($srvcs1,$requestParams/record) else $srvcs1
  let $srvcs3 := if (exists($requestParams/start) and exists($requestParams/max)) then csd:limit_items($srvcs2,$requestParams/start,$requestParams/max) else $srvcs2
  let $srvcs4 := for $oid in $srvcs3/@oid         
   return <service oid="{$oid}"/>

  return csd:wrap_services(($srvcs4))
};