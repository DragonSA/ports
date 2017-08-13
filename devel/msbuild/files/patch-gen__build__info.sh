--- gen_build_info.sh.orig	2017-08-03 13:42:29 UTC
+++ gen_build_info.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 
 if [ $# -ne 1 ]; then
 	echo "Usage: $0 <filename.cs>"
