--- eglib/src/gfile-posix.c.orig	2017-07-20 18:10:59 UTC
+++ eglib/src/gfile-posix.c
@@ -170,7 +170,7 @@ g_get_current_dir (void)
 	do {
 		buffer = g_realloc (buffer, s);
 		r = getcwd (buffer, s);
-		fail = (r == NULL && errno == ERANGE);
+		fail = (r == NULL && (errno == ERANGE || errno == 0));
 		if (fail) {
 			s <<= 1;
 		}
