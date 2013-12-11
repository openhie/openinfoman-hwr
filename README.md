OpenInfoMan - Provider Registry Library
=======================================

Library of Provider Registry Stored Functions to be used with the OpenInfoMan

OpenInfoMan
===========
The OpenInfoMan can be found here:
  https://github.com/his-interop/openinfoman

Installation
============
Once you have the OpenInfoMan installed, you can make the Provider Registry Library avaiable by:
- copying/linking everything under openinfoman-pr/repo to the repo/ for BaseX
- editing repo/csd_webapp_config.xwm and uncommenting:
- (:import module namespace csd_prsq = "https://github.com/his-interop/openinfoman-pr/csd_prsq" at  "csd_provider_registry_stored_queries.xqm";  :)
- (:  , $csd_prsq:stored_functions :)
- link the openinfoman-pr/resources-pr directory to resources-pr/ in the same directory where you have the resources/ directory for openinfoman (otherwise you may need to edit webapp/test_csd.xqm)

