<?php

$updating_functions = array();
$nonupdating_functions = array();
$files = glob('csd_*_registry_stored_queries*.xqm');
foreach ($files as $file) {
    $src = file_get_contents($file);
    $parts = array();
    preg_match('/^csd_(.*)_registry_stored_queries/',$file,$parts);
    if (count($parts) != 2) {
	continue;
    }
    $root = $parts[1];
    echo "LIBRARY = $root\n";
    $funcs = array();

    $metas = array();
    preg_match_all('/<function\s+(.*?)\s*\\/>/ism',$src,$metas);
    $datas = array();
    foreach ($metas[1] as $meta) {
	$comps = preg_split("/\s+/", $meta,-1,PREG_SPLIT_NO_EMPTY);
	$data = array();
	foreach ($comps as $comp) {
	    list($key,$value) = array_pad(explode('=',$comp,2),2,'');
	    $data[$key] = trim($value,'\'"');
	}
	$datas[] = $data;
    }
    $funcs = array();
    preg_match_all('/^\s*declare\s*(updating)?\s+function\s+(.*?)[\s\(].*?{(.*?)\}\s*;/ism',$src,$funcs,PREG_SET_ORDER);
    $all_funcs = array();
    foreach ($funcs as $details) {
	$updating = $details[1] == 'updating';
	$method = trim($details[2]);	

	if ($updating) {
	    $def = 'import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu" at "../repo/csd_base_library_updating.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) ' 
	    . $details[3];
	}else{
	$def = 'import module namespace csd = "urn:ihe:iti:csd:2013" at "../repo/csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";
declare variable $careServicesRequest as item() external;

(: 
   The query will be executed against the root element of the CSD document.
   
   The dynamic context of this query has $careServicesRequest set to contain any of the search 
   and limit paramaters as sent by the Service Finder
:) ' 
	    . $details[3];
	}
	$def = str_replace('$doc','',$def);
	$def = preg_replace('/csd_.*?:wrap_updating_/','csd_blu:wrap_updating_',$def);
	$def = preg_replace('/csd_.*?:wrap_([a-z]+)\(/','csd:wrap_$1(',$def);
	$def = str_replace('csd_hwrsq:bump','csd_blu:bump',$def);
	$def = str_replace('$requestParams','$careServicesRequest',$def);

	$orig = $details[0];
	$orig = preg_replace('/csd_.*?:wrap_updating_/','csd_blu:wrap_updating_',$orig);
	$orig = preg_replace('/csd_.*?:wrap_([a-z]+)\(/','csd:wrap_$1(',$orig);
	$orig = str_replace('csd_hwrsq:bump','csd_blu:bump',$orig);

	$all_funcs[$method] = array('updating'=>$updating,'definition'=>$def,'orig_definition'=>$orig);

    }

    foreach ($datas as $data) {
	if (!array_key_exists($data['method'],$all_funcs)) {
	    echo "No " . $data['method'] . "\n";
	    continue;
	}
	list($ns,$name) = explode(':',$data['method']);
	$func = $all_funcs[$data['method']];
	if ($func['updating']) {
	    $dir = "../resources/stored_updating_query_defintions/";
	} else {
	    $dir = "../resources/stored_query_defintions/";
	}
	$name = $root . '_' . $name;
	$xq_file =   $name . '.xq';
	$xml_file =  $name . '.xml';
	echo "Making\t$xq_file\n\t$xml_file \n";
	file_put_contents($dir . $xq_file,$func['definition']);
	$xml = '<?xml version="1.0" encoding="UTF-8"?>
<careServicesFunction xmlns:ev="http://www.w3.org/2001/xml-events"
  xmlns="urn:ihe:iti:csd:2013"
  xmlns:xforms="http://www.w3.org/2002/xforms"
  xmlns:hfp="http://www.w3.org/2001/XMLSchema-hasFacetAndProperty"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:csd="urn:ihe:iti:csd:2013" 
  uuid="' . $data['uuid']  . '">
  <description>' . $name . '</description>
';
	$xml .= '<definition method="csd_hwru:' . $name . '"><xi:include parse="text" href="'. $xq_file .'"/></definition>
';
	$xml .='
  <xforms:instance>
    <careServicesRequest>
      <!-- FILL ME IN-->
    </careServicesRequest>
  </xforms:instance>
</careServicesFunction>

';

	file_put_contents($dir . $xml_file,$xml);
	$orig = $func['orig_definition'];
	$parts = array();
	preg_match_all('/^\s*(declare\s*(updating)?\s+function\s+)(.*?)([\s\(].*?{(.*?)\}\s*;)/ism',$orig,$parts,PREG_SET_ORDER);
	if ($func['updating']) {
	    $parts[0][3] = 'csd_hwru:' . $name;
	    $updating_functions[] = $parts[0][1] . $parts[0][3] . $parts[0][4]; 
	} else {
	    $parts[0][3] = 'csd_hwr:' . $name;
	    $nonupdating_functions[] = $parts[0][1] . $parts[0][3] . $parts[0][4]; 
	}
	
    }
    
}
$updating = '(:~
: This is a module contatining  updating stored queries for a Care Services Discovery compliant Health Worker registry
: @version 1.0
: @see https://github.com/openhie/openinfoman @see http://ihe.net
:
:)
module namespace csd_hwru = "https://github.com/openhie/openinfoman-hwr/csd_hwru";
import module namespace csd = "urn:ihe:iti:csd:2013" at "csd_base_library.xqm";
import module namespace csd_blu = "https://github.com/openhie/openinfoman/csd_blu" at "csd_base_library_updating.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";


';
$updating .= implode("\n\n",$updating_functions);
file_put_contents('csd_health_worker_registry_updating.xqm',$updating);

$nonupdating = '(:~
: This is a module contatining  read only stored queries for a Care Services Discovery compliant Health Worker registry
: @version 1.0
: @see https://github.com/openhie/openinfoman @see http://ihe.net
:
:)
module namespace csd_hwr = "https://github.com/openhie/openinfoman-hwr/csd_hwr";
import module namespace csd = "urn:ihe:iti:csd:2013" at "csd_base_library.xqm";
declare default element  namespace   "urn:ihe:iti:csd:2013";


';
$nonupdating .= implode("\n\n",$nonupdating_functions);
file_put_contents('csd_health_worker_registry.xqm',$nonupdating);