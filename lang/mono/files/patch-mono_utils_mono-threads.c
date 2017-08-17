--- mono/utils/mono-threads.c.orig	2017-05-18 19:41:08 UTC
+++ mono/utils/mono-threads.c
@@ -1336,7 +1336,7 @@ mono_thread_info_sleep (guint32 ms, gboo
 		} while (1);
 	} else {
 		int ret;
-#if defined (__linux__) && !defined(PLATFORM_ANDROID)
+#if defined(HAVE_CLOCK_NANOSLEEP) && !defined(PLATFORM_ANDROID)
 		struct timespec start, target;
 
 		/* Use clock_nanosleep () to prevent time drifting problems when nanosleep () is interrupted by signals */
