(:~
: This is a module contatining  updating stored queries for a Care Services Discovery compliant Health Worker registry
: @version 1.0
: @see https://github.com/openhie/openinfoman @see http://ihe.net
:
:)
module namespace csd_hwru = "https://github.com/openhie/openinfoman-hwr/csd_hwru";
import module namespace csd_bl = "https://github.com/openhie/openinfoman/csd_bl";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu" ;
declare default element  namespace   "urn:ihe:iti:csd:2013";


declare updating function csd_hwru:health_worker_delete_provider($requestParams,$doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()  
return  if (count($provs0) = 1) then
  delete node $provs0[1] else ()
};

declare updating function csd_hwru:health_worker_create_provider($requestParams,$doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()  
return
  if (count($provs0) > 0) then (csd_blu:wrap_updating_providers(()))     (:do not allow duplicate OIDs:)
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
    csd_blu:wrap_updating_providers(<provider oid="{$oid}"/>)
  )

};

declare updating function csd_hwru:health_worker_update_provider($requestParams,$doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()  
return
  if (not (count($provs0) = 1)) 
    then ( csd_blu:wrap_updating_providers((<bad/>)))     (:do nothing :)
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
	csd_blu:wrap_updating_providers(<provider oid="{$provider/@oid}" ok='1'/>)
    )

};

declare updating function csd_hwru:health_worker_delete_name($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_name($requestParams, $doc) 
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
	  ,   csd_blu:wrap_updating_providers($provs3)
	)
  else  csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_name($requestParams, $doc) 
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
	csd_blu:wrap_updating_providers($provs2)
     )
  else 	csd_blu:wrap_updating_providers(())

};

declare updating function csd_hwru:health_worker_delete_address($requestParams, $doc) 
{

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/address/@type))  then $provs1 else ()
let $address:= $provs2[1]/demographic/address[@type = $requestParams/address/@type]
return if (exists($address)) then (delete node $address) else ()
};

declare updating function csd_hwru:health_worker_create_address($requestParams, $doc) 
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
      csd_blu:wrap_updating_providers(()) (: Do not allow the same type to be created more than once:)
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
	csd_blu:wrap_updating_providers($provs3)
	)
  else  csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_address($requestParams, $doc) 
{  
let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/address/@type))  then $provs1 else ()
let $provider:= $provs2[1]
let $demo := $provider/demographic
let $address:= $demo/address[@type = $requestParams/address/@type]
return  
  if ( not(exists($address))) then
    csd_blu:wrap_updating_providers(()) (: Address does not exist.  Do not update:)
  else
    let $provs3:=  
    <provider oid="{$provider/@oid}">
      <demographic><address type="{$requestParams/address/@type}"/></demographic>
    </provider>
    return (
      csd_blu:bump_timestamp($provider),
      replace  node  $address with $requestParams/address
      ,
      csd_blu:wrap_updating_providers($provs3)
    )
};

declare updating function csd_hwru:health_worker_delete_contact_point($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_contact_point($requestParams, $doc) 
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
      csd_blu:wrap_updating_providers($provs3)
      )
  else  csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_contact_point($requestParams, $doc) 
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
	csd_blu:wrap_updating_providers($provs2)
     )
  else 	csd_blu:wrap_updating_providers(())

};

declare updating function csd_hwru:health_worker_delete_credential($requestParams, $doc) 
{
let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/credential/codedType/@code) and exists($requestParams/credential/codedType/@codingScheme) ) then $provs1  else ()
let $cred_new := $requestParams/credential
let $code:= $cred_new/codedType/@code
let $codingScheme:= $cred_new/codedType/@codingScheme
let $creds0 := $provs2/credential[@code = $code and @codingScheme = $codingScheme]
return  
  if ( count($provs2) = 1 and count($creds0) = 1)  then
    delete node $creds0[1]
  else
    ()
};

declare updating function csd_hwru:health_worker_create_credential($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/credential/codedType/@code) and exists($requestParams/credential/codedType/@codingScheme) ) then $provs1  else ()
let $cred_request := $requestParams/credential
let $code:= $cred_request/codedType/@code
let $codingScheme:= $cred_request/codedType/@codingScheme
let $creds0 := $provs2/credential[@code = $code and @codingScheme = $codingScheme]
return  
  if ( count($provs2) = 1 and count($creds0) = 0)  (:DO NOT ALLOW SAME CRED TWICE :)
    then
    let $provider:= $provs2[1]
    let $cred_rec :=
    <credential>
      <codedType code="{$code}" codingScheme="{$codingScheme}"/>
    </credential>
    let $cred_new :=
    <credential>
      <codedType code="{$code}" codingScheme="{$codingScheme}"/>
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
	csd_blu:wrap_updating_providers($provs3)
	)

  else  csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_credential($requestParams, $doc) 
{  

let $provs0 := if (exists($requestParams/id/@oid)) then	csd_bl:filter_by_primary_id($doc/CSD/providerDirectory/*,$requestParams/id) else ()
let $provs1 := if (count($provs0) = 1) then $provs0 else ()
let $provs2 := if (exists($requestParams/credential/codedType/@code) and exists($requestParams/credential/codedType/@codingScheme) ) then $provs1  else ()
let $cred_new := $requestParams/credential
let $code:= $cred_new/codedType/@code
let $codingScheme:= $cred_new/codedType/@codingScheme
let $creds0 := $provs2/credential/codedType[@code = $code and @codingScheme = $codingScheme]
return  
  if ( count($provs2) = 1 and count($creds0) = 1)  (:Update only:)
    then
    let $cred_old := $creds0[1]/..
    let $provider:= $provs2[1]
    let $provs3 := 
      <provider oid="{$provider/@oid}">
	<credential>
	  <codedType code="{$code}" codingScheme="{$codingScheme}"/>
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
	csd_blu:wrap_updating_providers($provs3)
       )
  else 	csd_blu:wrap_updating_providers((<bad cs="{$codingScheme}" c="{$code}"></bad>,count($provs2), count($creds0)))
};

declare updating function csd_hwru:health_worker_delete_provider_facility($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_provider_facility($requestParams, $doc) 
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
	csd_blu:wrap_updating_providers($provs3)
	)
      else
	(
	insert node $facs_new into $provider,
	csd_blu:wrap_updating_providers($provs3)
	)

  else  csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_provider_facility($requestParams, $doc) 
{  
() (: does nothing:)
};

declare updating function csd_hwru:health_worker_delete_service($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_service($requestParams, $doc) 
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
    csd_blu:wrap_updating_providers($provs3)
  )
else   csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_service($requestParams, $doc) 
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
	csd_blu:wrap_updating_providers($provs3)
     )
  else 	csd_blu:wrap_updating_providers(())

};

declare updating function csd_hwru:health_worker_delete_operating_hours($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_operating_hours($requestParams, $doc) 
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
    csd_blu:wrap_updating_providers($provs4)
  )
else   csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_operating_hours($requestParams, $doc) 
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
	csd_blu:wrap_updating_providers($provs4)
     )
  else 	csd_blu:wrap_updating_providers(())

};

declare updating function csd_hwru:health_worker_delete_provider_organization($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_provider_organization($requestParams, $doc) 
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
	csd_blu:wrap_updating_providers($provs3)
	)
      else
	(
	insert node $orgs_new into $provider,
	csd_blu:wrap_updating_providers($provs3)
	)

  else  csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_provider_organization($requestParams, $doc) 
{  
() (: does nothing:)
};

declare updating function csd_hwru:health_worker_delete_org_contact_point($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_org_contact_point($requestParams, $doc) 
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
	  csd_blu:wrap_updating_providers($provs3)
	)
      else   csd_blu:wrap_updating_providers(())
    else  csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_org_contact_point($requestParams, $doc) 
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
	csd_blu:wrap_updating_providers($provs3)
     )
  else 	csd_blu:wrap_updating_providers(())

};

declare updating function csd_hwru:health_worker_delete_org_address($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_org_address($requestParams, $doc) 
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
  then   csd_blu:wrap_updating_providers(()) (:do not create an already existing one :)	  
else
  (
    insert node $requestParams/organization/address into $org,
    csd_blu:wrap_updating_providers(    
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

declare updating function csd_hwru:health_worker_update_org_address($requestParams, $doc) 
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
  then   csd_blu:wrap_updating_providers((<bad0/>,$requestParams)) (:do not update an non-existent one :)
else
  (
    csd_blu:bump_timestamp($provider),
    replace node $address with  $requestParams/organization/address ,
     csd_blu:wrap_updating_providers(    
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

declare updating function csd_hwru:health_worker_delete_otherid($requestParams, $doc) 
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

declare updating function csd_hwru:health_worker_create_otherid($requestParams, $doc) 
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
      csd_blu:wrap_updating_providers($provs3)
      )
  else  csd_blu:wrap_updating_providers(())
      
};

declare updating function csd_hwru:health_worker_update_otherid($requestParams, $doc) 
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
	csd_blu:wrap_updating_providers($provs2)
     )
  else 	csd_blu:wrap_updating_providers(())

};