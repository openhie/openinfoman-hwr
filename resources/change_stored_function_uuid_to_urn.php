<?php

foreach ( glob('*xml') as $file) {
    $doc = new DOMDocument();
    $doc->loadXML(file_get_contents($file));
    $xpath = new DOMXPath( $doc );
    $xpath->registerNamespace('csd','urn:ihe:iti:csd:2013');
    foreach ( $xpath->query('/csd:careServicesFunction') as $node) {
	$node->setAttribute('urn','urn:openhie.org:openinfoman-hwr:stored-function:' . basename($file,'.xml'));
	$node->removeAttribute('uuid');
    }
    file_put_contents($file, $doc->saveXML());
  }