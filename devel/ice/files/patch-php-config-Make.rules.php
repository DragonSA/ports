--- php/config/Make.rules.php.orig	2017-09-13 13:20:00.000000000 +0200
+++ php/config/Make.rules.php	2017-09-13 13:20:00.000000000 +0200
@@ -81,13 +81,8 @@ ifeq ($(findstring /php/test/,$(abspath $(MAKEFILE_LIST))),)
         $(error $(PHP_CONFIG) not found review your PHP installation and ensure $(PHP_CONFIG) is in your PATH)
     endif
 
-    ifndef usr_dir_install
-        install_phpdir	= $(prefix)/php
-        install_libdir  	= $(prefix)/php
-    else
-        install_phpdir  	= $(prefix)/share/php
-        install_libdir  	= $(shell $(PHP_CONFIG) --extension-dir)
-    endif
+    install_phpdir         = $(prefix)/share/pear
+    install_libdir         = $(prefix)/lib/php/$(PHP_EXT_DIR)
 endif
 
 ifdef ice_src_dist
@@ -145,7 +140,8 @@ else
 endif
 
 ifeq ($(installphplib),)
-    installphplib	= $(INSTALL) $(1) $(2); \
+    installphplib	= mkdir -p $(2) ; \
+			  $(INSTALL) $(1) $(2); \
 			  chmod a+rx $(2)/$(notdir $(1))
 endif
 
