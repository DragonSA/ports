--- build/cmake/macros/SystemSpecificInformations.cmake.orig	2017-07-06 19:22:42 UTC
+++ build/cmake/macros/SystemSpecificInformations.cmake
@@ -265,6 +265,8 @@ if(UNIX)
     set( SYSTEM_NAME "freebsd_${FREEBSD_RELEASE}" )
     set( CONDOR_FREEBSD ON )
     set( BSD_UNIX ON )
+    # FreeBSD 8 and later just use CONDOR_FREEBSD
+    # FreeBSD 9 and later require utmpx
     if(FREEBSD_MAJOR MATCHES "4" )
       set( CONDOR_FREEBSD4 ON )
     elseif(FREEBSD_MAJOR MATCHES "5" )
@@ -273,16 +275,7 @@ if(UNIX)
       set( CONDOR_FREEBSD6 ON )
     elseif(FREEBSD_MAJOR MATCHES "7" )
       set( CONDOR_FREEBSD7 ON )
-    elseif(FREEBSD_MAJOR MATCHES "8" )
-      set( CONDOR_FREEBSD8 ON )
-    elseif(FREEBSD_MAJOR MATCHES "9" )
-      set( CONDOR_FREEBSD9 ON )
-      set( CONDOR_UTMPX ON )
-    elseif(FREEBSD_MAJOR MATCHES "10" )
-      set( CONDOR_FREEBSD10 ON )
-      set( CONDOR_UTMPX ON )
-    elseif(FREEBSD_MAJOR MATCHES "11" )
-      set( CONDOR_FREEBSD11 ON )
+    elseif(FREEBSD_MAJOR GREATER "8" )
       set( CONDOR_UTMPX ON )
     endif()
     if( CMAKE_SYSTEM_PROCESSOR MATCHES "amd64" )
