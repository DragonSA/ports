--- mono/utils/mono-proclib.c.orig	2017-05-18 19:41:08 UTC
+++ mono/utils/mono-proclib.c
@@ -126,11 +126,11 @@ mono_process_list (int *size)
 		mib [2] = KERN_PROC_ALL;
 		mib [3] = 0;
 
-		res = sysctl (mib, 4, NULL, &data_len, NULL, 0);
+		res = sysctl (mib, 3, NULL, &data_len, NULL, 0);
 		if (res)
 			return NULL;
 		processes = (struct kinfo_proc *) g_malloc (data_len);
-		res = sysctl (mib, 4, processes, &data_len, NULL, 0);
+		res = sysctl (mib, 3, processes, &data_len, NULL, 0);
 		if (res < 0) {
 			g_free (processes);
 			if (errno != ENOMEM)
