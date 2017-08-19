--- mono/profiler/ptestrunner.pl.orig	2017-08-19 07:41:37 UTC
+++ mono/profiler/ptestrunner.pl
@@ -103,8 +103,6 @@ check_alloc_traces ($report,
 );
 report_errors ();
 
-emit_nunit_report();
-
 exit ($global_errors ? 1 : 0);
 
 # utility functions
