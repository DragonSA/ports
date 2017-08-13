--- install-mono-prefix.sh.orig	2017-08-03 13:42:29 UTC
+++ install-mono-prefix.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 set -e
 set -x
 if [ $# -ne 1 ]; then
@@ -45,7 +45,6 @@ cp $MSBUILD_OUT_DIR/Workflow* ${DESTDIR}
 cp $MSBUILD_OUT_DIR/*.dll ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}
 
 cp -r $MSBUILD_OUT_DIR/Roslyn ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}
-cp -r $MSBUILD_OUT_DIR/Extensions ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}
 
 # Deploy files meant for the default $(MSBuildExtensionsPath)
 cp -r mono/ExtensionsPath/ ${DESTDIR}${XBUILD_DIR}
@@ -54,12 +53,12 @@ cp -r mono/ExtensionsPath-ToolsVersion/ 
 mv ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/Microsoft.Common.props ${DESTDIR}${XBUILD_DIR}/$MSBUILD_TOOLSVERSION
 mv ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/Microsoft.VisualStudioVersion.v* ${DESTDIR}${XBUILD_DIR}/$MSBUILD_TOOLSVERSION
 
-rm ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/*UnitTests*
-rm ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/*xunit*
-rm ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/NuGet*
-rm ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/System.Runtime.InteropServices.RuntimeInformation.dll
-rm ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/Roslyn/System.Runtime.InteropServices.RuntimeInformation.dll
-rm ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/Roslyn/csc.exe*
+rm -f ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/*UnitTests*
+rm -f ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/*xunit*
+rm -f ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/NuGet*
+rm -f ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/System.Runtime.InteropServices.RuntimeInformation.dll
+rm -f ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/Roslyn/System.Runtime.InteropServices.RuntimeInformation.dll
+rm -f ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/Roslyn/csc.exe*
 
 FILES="\
     Dependency.dll \
@@ -67,7 +66,7 @@ FILES="\
     TaskWithDependency.dll \
     Xunit.NetCore.Extensions.dll"
 
-for f in $FILES; do rm ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/$f ; done
+for f in $FILES; do rm -f ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/$f ; done
 
 cp ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}/Roslyn/System.Reflection.Metadata.dll ${DESTDIR}${MSBUILD_INSTALL_BIN_DIR}
 
