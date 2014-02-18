OpenInfoMan - Health Worker Registry Library
=======================================

Library of Health Worker Registry Stored Functions to be used with the OpenInfoMan

OpenInfoMan
===========
The OpenInfoMan can be found here:
  https://github.com/his-interop/openinfoman

Installation
============
Once you have the OpenInfoMan installed, you can make the Health Worker Registry Library avaiable by:
- copying/linking everything under openinfoman-hwr/repo to the repo/ for BaseX
- editing repo/csd_webapp_config.xwm and uncommenting:
- (:import module namespace csd_prsq = "https://github.com/his-interop/openinfoman-hwr/csd_hwrsq" at  "csd_health_worker_registry_stored_queries.xqm";  :)
- (:  , $csd_hwrsq:stored_functions :)
- link the openinfoman-hwr/resources-hwr directory to resources-hwr/ in the same directory where you have the resources/ directory for openinfoman (otherwise you may need to edit webapp/test_csd.xqm)

