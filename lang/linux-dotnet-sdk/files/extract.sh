#!/bin/sh
#
# Extract the NuGet offline cache, recreating the nupkg zip files.
#

set -e

. "${dp_SCRIPTSDIR}/functions.sh"

validate_env dp_LN dp_LZMA dp_MKDIR dp_MV dp_RM dp_RMDIR dp_TR dp_UNZIP

set -u

ARCHIVE="$1"
DESTDIR="$2"

$dp_MKDIR $DESTDIR/.archive
( $dp_LZMA d $ARCHIVE /dev/stderr > /dev/null ) 2>&1 | $dp_UNZIP -qd $DESTDIR/.archive -
archives=""
while read line; do
	target="${line%|*}"
	source="${line#*|}"
	rel_path="${target%%::*}"
	entry_name="${target#*::}"
	first_extract="NO"
	if [ "$rel_path" != "$entry_name" ]; then
		if [ -z "${entry_name##*/}" ]; then
			entry_name="$entry_name${source##*/}"
		fi
		target="${rel_path%/*}/$entry_name"
	fi
	if [ ! -f $DESTDIR/$target ]; then
		first_extract="YES"
		$dp_MKDIR $DESTDIR/${target%/*}
		$dp_LN $DESTDIR/.archive/$source $DESTDIR/$target
	fi
	if [ "$rel_path" != "$entry_name" ]; then
		target="${rel_path%/*}/$entry_name"
		cd $DESTDIR/${rel_path%/*}
	       	zip -q9 ${rel_path##*/} $entry_name
		if [ $first_extract == "YES" ]; then
			$dp_RM $entry_name
			$dp_RMDIR -p ${entry_name%/*} 2> /dev/null || true
		fi
	fi
done <<-EOF
	$($dp_TR -d '\015' < $DESTDIR/.archive/index.txt)
EOF
$dp_RM -r $DESTDIR/.archive
