--- mono/mini/mini-posix.c.orig	2017-05-18 19:41:08 UTC
+++ mono/mini/mini-posix.c
@@ -587,7 +587,7 @@ clock_init (void)
 		 * makes very little sense as we can only use nanosleep () to sleep on
 		 * real time.
 		 */
-		sampling_posix_clock = CLOCK_PROCESS_CPUTIME_ID;
+		sampling_posix_clock = CLOCK_MONOTONIC;
 		break;
 #endif
 	case MONO_PROFILER_STAT_MODE_REAL: sampling_posix_clock = CLOCK_MONOTONIC; break;
