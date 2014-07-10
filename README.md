OpenInfoMan - Health Worker Registry Library
=======================================

Library of Health Worker Registry Stored Functions to be used with the OpenInfoMan


Prerequisites
=============

Assumes that you have installed BaseX and OpenInfoMan according to:
> https://github.com/openhie/openinfoman/wiki/Install-Instructions


Directions
==========
<pre>
cd ~/
git clone https://github.com/openhie/openinfoman-hwr
cd ~/basex/resources/stored_query_definitions
ln -sf ~/openinfoman-hwr/resources/stored_query_definitions/* .
cd ~/basex/resources/stored_updating_query_definitions
ln -sf ~/openinfoman-hwr/resources/stored_updating_query_definitions/* .
</pre>
