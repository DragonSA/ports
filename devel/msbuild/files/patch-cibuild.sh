--- cibuild.sh.orig	2017-08-03 13:42:29 UTC
+++ cibuild.sh
@@ -213,6 +213,12 @@ case $OS_NAME in
         EXTRA_ARGS="$EXTRA_ARGS /p:RuntimeSystem=$(get_current_linux_name)"
         ;;
 
+    FreeBSD)
+        OS_ARG="Unix"
+	OS_RELEASE=$(uname -r)
+	EXTRA_ARGS="$EXTRA_ARGS /p:RuntimeSystem=FreeBSD${OS_RELEASE%.*}"
+        ;;
+
     *)
         echo "Unsupported OS $OS_NAME detected, configuring as if for Linux"
         OS_ARG="Unix"
@@ -287,6 +293,8 @@ case $host in
         RUNTIME_HOST_ARGS=""
         MSBUILD_EXE="$TOOLS_DIR/MSBuild.exe"
         EXTRA_ARGS="$EXTRA_ARGS /m"
+        restoreBuildTools
+
         ;;
 
     Mono)
@@ -321,8 +329,6 @@ setHome
 #temporary workaround to this being set on wrench and breaking tests!
 unset FOO
 
-restoreBuildTools
-
 echo
 echo "** Rebuilding MSBuild with downloaded binaries"
 runMSBuildWith "$RUNTIME_HOST" "$RUNTIME_HOST_ARGS" "$MSBUILD_EXE" "/t:Rebuild $BUILD_MSBUILD_ARGS $CSC_ARGS" "$BOOTSTRAP_BUILD_LOG_PATH"
@@ -347,7 +353,6 @@ if [ "$host" = "Mono" ]; then
     MS_COMPILER_DIR="$PACKAGES_DIR/microsoft.net.compilers/2.0.0-rc3-61110-06/tools/"
     rm -f $MS_COMPILER_DIR/System.Runtime.InteropServices.RuntimeInformation.dll
 
-    CSC_ARGS="/p:CscToolExe=csc.exe /p:CscToolPath=$MS_COMPILER_DIR /p:DebugType=portable /p:CscDebugFileExt=.pdb"
 fi
 
 # The set of warnings to suppress for now
