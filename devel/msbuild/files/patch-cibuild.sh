--- cibuild.sh.orig	2017-08-03 13:42:29 UTC
+++ cibuild.sh
@@ -150,7 +150,6 @@ BOOTSTRAP_FILE_ARG='"'"$THIS_SCRIPT_PATH
 
 # Default msbuild arguments
 TARGET_ARG="Build"
-EXTRA_ARGS=""
 CSC_ARGS=""
 PROJECT_CONFIG=Debug
 
@@ -213,6 +212,12 @@ case $OS_NAME in
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
@@ -287,13 +292,15 @@ case $host in
         RUNTIME_HOST_ARGS=""
         MSBUILD_EXE="$TOOLS_DIR/MSBuild.exe"
         EXTRA_ARGS="$EXTRA_ARGS /m"
+        restoreBuildTools
+
         ;;
 
     Mono)
         setMonoDir
         RUNTIME_HOST="${MONO_BIN_DIR}mono"
         MSBUILD_EXE="$PACKAGES_DIR/msbuild/MSBuild.exe"
-        CSC_ARGS="/p:CscToolExe=csc.exe /p:CscToolPath=$PACKAGES_DIR/msbuild/ /p:DebugType=portable"
+        CSC_ARGS="/p:CscToolExe=$ScsToolExe /p:CscToolPath=$CscToolPath /p:DebugType=portable"
 
         if [[ "$MONO_BIN_DIR" != "" ]]; then
             echo "** Using mono from $RUNTIME_HOST"
@@ -314,15 +321,13 @@ LOCAL_BUILD_LOG_PATH="$THIS_SCRIPT_PATH"
 LOCAL_BUILD_BINLOG_PATH="$THIS_SCRIPT_PATH"/msbuild_rebuild-"$host".binlog
 MOVE_LOG_PATH="$THIS_SCRIPT_PATH"/msbuild_move_bootstrap-"$host".log
 
-BUILD_MSBUILD_ARGS="$PROJECT_FILE_ARG /p:OS=$OS_ARG /p:Configuration=$CONFIGURATION /p:OverrideToolHost=$RUNTIME_HOST /verbosity:minimal $EXTRA_ARGS"
+BUILD_MSBUILD_ARGS="$PROJECT_FILE_ARG /p:OS=$OS_ARG /p:Configuration=$CONFIGURATION /p:OverrideToolHost=$RUNTIME_HOST $EXTRA_ARGS"
 
 setHome
 
 #temporary workaround to this being set on wrench and breaking tests!
 unset FOO
 
-restoreBuildTools
-
 echo
 echo "** Rebuilding MSBuild with downloaded binaries"
 runMSBuildWith "$RUNTIME_HOST" "$RUNTIME_HOST_ARGS" "$MSBUILD_EXE" "/t:Rebuild $BUILD_MSBUILD_ARGS $CSC_ARGS" "$BOOTSTRAP_BUILD_LOG_PATH"
@@ -347,7 +352,6 @@ if [ "$host" = "Mono" ]; then
     MS_COMPILER_DIR="$PACKAGES_DIR/microsoft.net.compilers/2.0.0-rc3-61110-06/tools/"
     rm -f $MS_COMPILER_DIR/System.Runtime.InteropServices.RuntimeInformation.dll
 
-    CSC_ARGS="/p:CscToolExe=csc.exe /p:CscToolPath=$MS_COMPILER_DIR /p:DebugType=portable /p:CscDebugFileExt=.pdb"
 fi
 
 # The set of warnings to suppress for now
