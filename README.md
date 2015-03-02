OpenInfoMan - Health Worker Registry Library
=======================================

Library of Health Worker Registry Stored Functions to be used with the OpenInfoMan

It makes use of the OpenInfoMan software https://github.com/openhie/openinfoman

Ubuntu Installation
===================
You can easily install on Ubuntu 14.04 and Ubuntu 14.10 using the following commands
<pre>
sudo add-apt-repository ppa:openhie/release
sudo apt-get update
sudo apt-get install openinfoman-fhir
</pre>



Manual Installation
===================


Assumes that you have installed BaseX and OpenInfoMan according to:
> https://github.com/openhie/openinfoman/wiki/Install-Instructions


Directions
----------
To get the libarary:
<pre>
cd ~/
git clone https://github.com/openhie/openinfoman-hwr
</pre>

Read-Only Library
-----------------
To install the read-only library you can do: 
<pre>
cd ~/basex/resources/stored_query_definitions
ln -sf ~/openinfoman-hwr/resources/stored_query_definitions/* .
</pre>

Be sure to reload the stored functions: 
> https://github.com/openhie/openinfoman/wiki/Install-Instructions#Loading_Stored_Queries


Updating Library
----------------
If you want to enable the stored queries with updating functions (e.g. for the CRUD operations for the provider directory) you can do so with:

<pre>
cd ~/basex/resources/stored_updating_query_definitions
ln -sf ~/openinfoman-hwr/resources/stored_updating_query_definitions/* .
</pre>


Be sure to reload the stored functions: 
> https://github.com/openhie/openinfoman/wiki/Install-Instructions#Loading_Stored_Queries
