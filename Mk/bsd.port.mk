#-*- tab-width: 4; -*-
# ex:ts=4
#
# $FreeBSD: head/Mk/bsd.port.mk 486551 2018-12-03 20:03:02Z sunpoet $
#	$NetBSD: $
#
#	bsd.port.mk - 940820 Jordan K. Hubbard.
#	This file is in the public domain.
#
# Please view me with 4 column tabs!

# This is the master file for the most common elements to all port
# Makefile in the ports system.  For a more general overview of its
# use and importance, see the Porter's Handbook.

# There are two different types of "maintainers" in the ports framework.
# The maintainer alias of the bsd.port.mk file is listed below in the
# FreeBSD_MAINTAINER entry.  You should consult them if you have any
# questions/suggestions regarding this file.
#
# DO NOT COMMIT CHANGES TO THIS FILE BY YOURSELF, EVEN IF YOU DID NOT GET
# A RESPONSE FROM THE MAINTAINER(S) WITHIN A REASONABLE TIMEFRAME! ALL
# UNAUTHORISED CHANGES WILL BE UNCONDITIONALLY REVERTED!

FreeBSD_MAINTAINER=	portmgr@FreeBSD.org

# For each port, the MAINTAINER variable is what you should consult for
# contact information on the person(s) to contact if you have questions/
# suggestions about that specific port.  By default (if no MAINTAINER
# is listed), a port is maintained by the subscribers of the ports@FreeBSD.org
# mailing list, and any correspondence should be directed there.
#
# MAINTAINER	- The e-mail address of the contact person for this port.
#				  Default: ports@FreeBSD.org
#
# These are meta-variables that are automatically set to the system
# you are running on.  These are provided in case you need to take
# different actions for different values.
#
# ARCH			- The architecture of the target machine, such as would be
#				  returned by "uname -p".
# OPSYS			- Portability clause.  This is the operating system the
#				  makefile is being used on.  Automatically set to
#				  "FreeBSD," "NetBSD," or "OpenBSD" as appropriate.
# OSREL			- The release version (numeric) of the operating system.
# OSVERSION		- The value of __FreeBSD_version.
#
# This is the beginning of the list of all variables that need to be
# defined in a port, listed in order that they should be included
# to fit in with existing conventions.  (Exception: MAINTAINER actually
# should appear after EXTRACT_ONLY and before MASTER_SITE_BACKUP).
#
# These variables are used to identify your port.
#
# PORTNAME		- Name of software.  Mandatory.
# PORTVERSION	- Version of software.  Mandatory when no DISTVERSION is given.
# PORTREVISION	- Version of port.  Optional.  Commonly used to indicate
#				  that an update has happened that affects the port
#				  framework itself, but not the distributed software
#				  (e.g., local patches or Makefile changes).
# PORTEPOCH		- Optional.  In certain odd cases, the PORTREVISION logic
#				  can be fooled by ports that appear to go backwards
#				  numerically (e.g. if port-0.3 is newer than port-1998).
#				  In this case, incrementing PORTEPOCH forces the revision.
#				  Default: 0 (no effect).
# PKGNAME		- Always defined as
#				  ${PKGNAMEPREFIX}${PORTNAME}${PKGNAMESUFFIX}-${PORTVERSION}.
#				  Do not define this in your Makefile.
# PKGNAMEPREFIX	- Prefix to specify that port is language-specific, etc.
#				  Optional.
# PKGNAMESUFFIX	- Suffix to specify compilation options or a version
#				  designator (in case there are different versions of
#				  one port as is the case for Tcl).
#				  Optional.
# PKGVERSION	- Always defined as ${PORTVERSION}.
#				  Do not define this in your Makefile.
# DISTVERSION	- Vendor version of the distribution.
#				  Default: ${PORTVERSION}
# DISTNAME		- Name of port or distribution used in generating
#				  WRKSRC and DISTFILES below.
#				  Default:
#				  ${PORTNAME}-${DISTVERSIONPREFIX}${DISTVERSION}${DISTVERSIONSUFFIX}
# CATEGORIES	- A list of descriptive categories into which this port falls.
#				  Mandatory.
#
# These variable describe how to fetch files required for building the port.
#
# DISTFILES		- Name(s) of archive file(s) containing distribution.
#				  Set this to an empty string if the port doesn't require it.
#				  Default: ${DISTNAME}${EXTRACT_SUFX}
# EXTRACT_SUFX	- Suffix for archive names
#				  You never have to set both DISTFILES and EXTRACT_SUFX.
#				  Default: .tar.bz2 if USES=tar:bzip2 is set, .tar.xz if
#				  USES=tar:xz USE_XZ is set, .tar.gz otherwise).
# MASTER_SITES	- Primary location(s) for distribution files if not found
#				  locally.  See bsd.sites.mk for common choices for
#				  MASTER_SITES.
# MASTER_SITE_SUBDIR
#				- Subdirectory of MASTER_SITES. Will sometimes need to be
#				  set to ${PORTNAME} for (e.g.) MASTER_SITE_SOURCEFORGE.
#				  Only guaranteed to work for choices of ${MASTER_SITES}
#				  defined in bsd.sites.mk.
#				  Default: not set.
# PATCHFILES	- Name(s) of additional files that contain distribution
#				  patches. Make will look for them at PATCH_SITES (see below).
#				  They will automatically be uncompressed before patching if
#				  the names end with ".gz", ".bz2" or ".Z".
#				  For each file you can optionally specify a strip
#				  flag of patch(1) after a colon if it has a different
#				  base directory, e.g. "file1 file2:-p1 file3".
#				  You can also use a :group at the end for matching up to
#				  dist file groups. See Porters Handbook for more information.
#				  Syntax: PATCHFILES= patch[:-pX][:group]
#				  Default: not set.
# PATCH_SITES	- Primary location(s) for distribution patch files
#				  if not found locally.
# DIST_SUBDIR	- Suffix to ${DISTDIR}.  If set, all ${DISTFILES} and
#				  ${PATCHFILES} will be put in this subdirectory of
#				  ${DISTDIR} (see below).  Also they will be fetched in this
#				  subdirectory from FreeBSD mirror sites.
# ALLFILES		- All of ${DISTFILES} and ${PATCHFILES}.
# NOFETCHFILES	- If set, don't download these files from the ${MASTER_SITES}
#				  or ${MASTER_SITE_BACKUP} (but do from
#				  ${MASTER_SITE_OVERRIDE})
# EXTRACT_ONLY	- If set, a subset of ${DISTFILES} you want to
#				  actually extract.
#
# (NOTE: by convention, the MAINTAINER entry (see above) should go here.)
#
# These variables are typically set in /etc/make.conf to indicate
# the user's preferred location to fetch files from.  You should
# rarely need to set these.
#
# MASTER_SITE_BACKUP
#				- Backup location(s) for distribution files and patch
#				  files if not found locally and ${MASTER_SITES}/${PATCH_SITES}.
#				  This should *not* be changed.
#				  Default:
#				  http://distcache.FreeBSD.org/ports-distfiles/${DIST_SUBDIR}/
# MASTER_SITE_OVERRIDE
#				- If set, prepend the MASTER_SITES setting with this value.
# MASTER_SITE_FREEBSD
#				- If set, prepend ${MASTER_SITE_BACKUP} in MASTER_SITES.
#
# Set these if your port should not be built under certain circumstances.
# These are string variables; you should set them to the reason why
# they are necessary.
#
# RESTRICTED	- Prevent the distribution of distfiles and packages to
#				  the FTP sites or on CDROM (e.g. forbidden by license
#				  considerations).
# NO_CDROM		- Packages and distfiles may not go on CDROM (e.g. must
#				  not be re-sold) but can go on FTP sites.
# NO_PACKAGE	- Port should not be packaged for ftp sites or CDROMs,
#				  but distfiles can be put on ftp sites and CDROMs.
# FORBIDDEN		- Package build should not be attempted because of
#				  security vulnerabilities.
# LEGAL_TEXT	- Port has legal issues (e.g., special permission to distribute, lacks a license).
# LEGAL_PACKAGE - Port has no legal issues but defines NO_PACKAGE
# IGNORE		- Package build should be skipped entirely (e.g.
#				  because of serious unfixable problems in the build,
#				  because it cannot be manually fetched, etc).  Error
#				  logs will not appear on pointyhat, so this should be
#				  used sparingly.
# IGNORE_${ARCH} - Port should be ignored on ${ARCH}.
# IGNORE_${OPSYS} - Port should be ignored on ${OPSYS}.
# IGNORE_${OPSYS}_${OSREL:R} -  Port should be ignored on a single
#				  release of ${OPSYS}, e.g IGNORE_FreeBSD_8
#				  would affect all point releases of FreeBSD 8.
# IGNORE_${OPSYS}_${OSREL:R}_${ARCH} -  Port should be ignored on a
#				  single release of ${OPSYS} and specific architecture,
#				  e.g IGNORE_FreeBSD_8_i386 would affect all point
#				  releases of FreeBSD 8 in i386.
# BROKEN		- Port is believed to be broken.  Package builds can
# 				  still be attempted using TRYBROKEN to test this
#				  assumption.
# BROKEN_${ARCH} - Port is believed to be broken on ${ARCH}. Package builds
#				  can still be attempted using TRYBROKEN to
#				  test this assumption.
# BROKEN_${OPSYS} - Port is believed to be broken on ${OPSYS}. Package builds
#				  can still be attempted using TRYBROKEN to
#				  test this assumption.
# BROKEN_${OPSYS}_${OSREL:R} -  Port is believed to be broken on a single
#				  release of ${OPSYS}, e.g BROKEN_FreeBSD_8
#				  would affect all point releases of FreeBSD 8
#				  unless TRYBROKEN is also set.
# BROKEN_${OPSYS}_${OSREL:R}_${ARCH} -  Port is believed to be broken on a
#				  single release of ${OPSYS} and specific architecture,
#				  e.g BROKEN_FreeBSD_8_i386 would affect all point
#				  releases of FreeBSD 8 in i386
#				  unless TRYBROKEN is also set.
# DEPRECATED	- Port is deprecated to install. Advisory only.
# EXPIRATION_DATE
#				- If DEPRECATED is set, determines a date when
#				  the port is planed to remove. The date format is
#				  ISO 8601 (YYYY-MM-DD).
#
# DISABLE_VULNERABILITIES
#				- If set, do not check if the port is listed in the
#				  vulnerabilities database.
#
# In addition to RESTRICTED or NO_CDROM, if only a subset of distfiles
# or patchfiles have redistribution restrictions, set the following
# to the list of such files.
#
# RESTRICTED_FILES
#				- List of files that cannot be redistributed.
#				  Default: "${DISTFILES} ${PATCHFILES}" if RESTRICTED
#				  or NO_CDROM is set, empty otherwise.
#
# These variables are booleans, so you don't need to set them to the reason.
#
# IS_INTERACTIVE
#				- Set this if your port needs to interact with the user
#				  during any step in a package build.  User can then decide
#				  to skip this port by setting ${BATCH}, or compiling only
#				  the interactive ports by setting ${INTERACTIVE}.
#				  Default: not set.
# USE_SUBMAKE	- Set this if you want that each of the port's main 7 targets
#				  (extract, patch, configure, build, stage, install and
#				  package) to be executed in a separate make(1) process.
#				  Useful when one of the stages needs to influence make(1)
#				  variables of the later stages using ${WRKDIR}/Makefile.inc
#				  generated on the fly.
#				  Default: not set.
#
# NO_ARCH			- Set this if port is architecture neutral.
#
# NO_ARCH_IGNORE		- Set this to a list files to ignore when NO_ARCH is checked
# 				  in stage-qa (i.e. architecture specific files that are
# 				  'bundled' with the port).
#
# Set these if your port only makes sense to certain architectures.
# They are lists containing names for them (e.g., "amd64 i386").
# (Defaults: not set.)
#
# ONLY_FOR_ARCHS
#				- Only build ports if ${ARCH} matches one of these.
# NOT_FOR_ARCHS	- Only build ports if ${ARCH} doesn't match one of these.
# ONLY_FOR_ARCHS_REASON
# ONLY_FOR_ARCHS_REASON_${ARCH}
#				- Reason why it's only for ${ONLY_FOR_ARCHS}s
# NOT_FOR_ARCHS_REASON
# NOT_FOR_ARCHS_REASON_${ARCH}
#				- Reason why it's not for ${NOT_FOR_ARCHS}s
# IA32_BINARY_PORT
#				- Set this instead of ONLY_FOR_ARCHS if the given port
#				  fetches and installs compiled i386 binaries.
#
# Dependency checking.  Use these if your port requires another port
# not in the list below.  (Default: empty.)
#
# EXTRACT_DEPENDS
#				- A list of "path:dir[:target]" tuples of other ports this
#				  package depends on in the "extract" stage.  "path" is
#				  the name of a file if it starts with a slash (/), an
#				  executable otherwise.  make will test for the existence
#				  (if it is a full pathname) or search for it in your
#				  $PATH (if it is an executable) and go into "dir" to do
#				  a "make all install" if it's not found.  If the third
#				  field ("target") exists, it will be used instead of
#				  ${DEPENDS_TARGET}.  The first field also supports a
#				  package name with a version range, in the form package>=1.2
#				  if a particular version is desired.
# PATCH_DEPENDS	- A list of "path:dir[:target]" tuples of other ports this
#				  package depends on in the "patch" stage.  "path" is the
#				  name of a file if it starts with a slash (/), an
#				  executable otherwise.  make will test for the existence
#				  (if it is a full pathname) or search for it in your
#				  $PATH (if it is an executable) and go into "dir" to do
#				  a "make all install" if it's not found.  If the third
#				  field ("target") exists, it will be used instead of
#				  ${DEPENDS_TARGET}.  The first field also supports a
#				  package name with a version range, in the form package>=1.2
#				  if a particular version is desired.
# FETCH_DEPENDS	- A list of "path:dir[:target]" tuples of other ports this
#				  package depends in the "fetch" stage.  "path" is the
#				  name of a file if it starts with a slash (/), an
#				  executable otherwise.  make will test for the
#				  existence (if it is a full pathname) or search for
#				  it in your $PATH (if it is an executable) and go
#				  into "dir" to do a "make all install" if it's not
#				  found.  If the third field ("target") exists, it will
#				  be used instead of ${DEPENDS_TARGET}.  The first field
#				  also supports a package name with a version range, in
#				  the form package>=1.2 if a particular version is desired.
# BUILD_DEPENDS	- A list of "path:dir[:target]" tuples of other ports this
#				  package depends to build (between the "extract" and
#				  "build" stages, inclusive).  The test done to
#				  determine the existence of the dependency is the
#				  same as FETCH_DEPENDS.  If the third field ("target")
#				  exists, it will be used instead of ${DEPENDS_TARGET}.
# RUN_DEPENDS	- A list of "path:dir[:target]" tuples of other ports this
#				  package depends to run.  The test done to determine
#				  the existence of the dependency is the same as
#				  FETCH_DEPENDS.  This will be checked during the
#				  "install" stage and the name of the dependency will
#				  be put into the package as well.  If the third field
#				  ("target") exists, it will be used instead of
#				  ${DEPENDS_TARGET}.  The first field also supports a
#				  package name with a version range, in the form package>=1.2
#				  if a particular version is desired.
# LIB_DEPENDS	- A list of "lib:dir[:target]" tuples of other ports this
#				  package depends on.  "lib" is the name of a shared library.
# TEST_DEPENDS	- A list of "path:dir[:target]" tuples of other ports this
#				  package depends on in the "test" stage.  "path" is the
#				  name of a file if it starts with a slash (/), an
#				  executable otherwise.  make will test for the existence
#				  (if it is a full pathname) or search for it in your
#				  $PATH (if it is an executable) and go into "dir" to do
#				  a "make all install" if it's not found.  If the third
#				  field ("target") exists, it will be used instead of
#				  ${DEPENDS_TARGET}.  The first field also supports a
#				  package name with a version range, in the form package>=1.2
#				  if a particular version is desired.
# DEPENDS_TARGET
#				- The default target to execute when a port is calling a
#				  dependency.
#				  Default: install
#
# These variables control options about how a port gets built and/or
# are shorthand notations for common sets of dependencies.
# Use these if your port uses some of the common software packages. By
# convention these should be set to 'yes', although they only need to be
# defined. Defaults: not set, unless explicitly indicated below.
#
# Note: the distinction between the USE_* and WANT_* variables, and the
# WITH_* and WITHOUT_* variables, are that the former are restricted to
# usage inside the ports framework, and the latter are reserved for user-
# settable options.  (Setting USE_* in /etc/make.conf is always wrong).
#
# WITH_DEBUG            - If set, debugging flags are added to CFLAGS and the
#                         binaries don't get stripped by INSTALL_PROGRAM or
#                         INSTALL_LIB. Besides, individual ports might
#                         add their specific to produce binaries for debugging
#                         purposes. You can override the debug flags that are
#                         passed to the compiler by setting DEBUG_FLAGS. It is
#                         set to "-g" at default.
#
#			  NOTE: to override a globally defined WITH_DEBUG at a
#			        later time ".undef WITH_DEBUG" can be used
#
# WITH_DEBUG_PORTS		- A list of origins for which WITH_DEBUG will be set
#
# WITHOUT_SSP	- Disable SSP.
#
# SSP_CFLAGS	- Defaults to -fstack-protector. This value
#				  is added to CFLAGS and the necessary flags
#				  are added to LDFLAGS. Note that SSP_UNSAFE
#				  can be used in Makefiles by port maintainers
#				  if a port breaks with it (it should be
#				  extremely rare).
##
# USE_LOCALE	- LANG and LC_ALL are set to the value of this variable in
#				  CONFIGURE_ENV and MAKE_ENV.  Example: USE_LOCALE=en_US.UTF-8
##
# USE_GCC		- If set, this port requires this version of gcc, either in
#				  the system or installed from a port.
# USE_CSTD		- Override the default C language standard (gnu89, gnu99)
# USE_CXXSTD	  Override the default C++ language standard
# USE_BINUTILS	- Use binutils suite from port instead of the version in base.
# CFLAGS_${ARCH}  Append the cflags to CFLAGS only on the specified architecture
# CXXFLAGS_${ARCH}
#				 Append the cxxflags to CXXFLAGS only on the specified architecture
##
# LDFLAGS_${ARCH} Append the ldflags to LDFLAGS only on the specified architecture
# USE_SDL		- If set, this port uses the sdl libraries.
#				  See bsd.sdl.mk for more information.
##
# USE_OPENLDAP	- If set, this port uses the OpenLDAP libraries.
#				  Implies: WANT_OPENLDAP_VER?=24
# WANT_OPENLDAP_VER
#				- Legal values are: 23, 24
#				  If set to an unknown value, the port is marked BROKEN.
# WANT_OPENLDAP_SASL
#				- If set, the system should use OpenLDAP libraries
#				  with SASL support.
##
# USE_JAVA		- If set, this port relies on the Java language.
#				  Implies inclusion of bsd.java.mk.  (Also see
#				  that file for more information on USE_JAVA_*).
# USE_OCAML		- If set, this port relies on the OCaml language.
#				  Implies inclusion of bsd.ocaml.mk.  (Also see
#				  that file for more information on USE_OCAML*).
# USE_RUBY		- If set, this port relies on the Ruby language.
#				  Implies inclusion of bsd.ruby.mk.  (Also see
#				  that file for more information on USE_RUBY_*).
##
# USE_GECKO		- If set, this port uses the Gecko/Mozilla product.
#				  See bsd.gecko.mk for more details.
##
# USE_WX		- If set, this port uses the WxWidgets library and related
#				  components. See bsd.wx.mk for more details.
##
#
# USE_QT4		- A list of the Qt 4 dependencies the port has (e.g,
#				  corelib, webkit).  Implies that the port needs Qt.
#				  Implies the inclusion of bsd.qt.mk.  See bsd.qt.mk
#				  for more details.
#
# USE_QT5		- A list of the Qt 5 dependencies the port has (e.g,
#				  core, webkit).  Implies that the port needs Qt.
#				  Implies the inclusion of bsd.qt.mk.  See bsd.qt.mk
#				  for more details.
##
# USE_LINUX_PREFIX
#				- Controls the action of PREFIX (see above).  Only use this
#				  if the port is a Linux infrastructure port (e.g. contains libs
#				  or a sound server which supports the FreeBSD native one),
#				  use the default prefix if it's a leaf port (e.g. a game or
#				  program).
#				  Implies NO_LICENSES_INSTALL=yes, NO_MTREE=yes, and causes
#				  Linux ldconfig to be used when USE_LDCONFIG is defined.
##
# USE_XORG			- Set to a list of X.org module dependencies.
#				  Implies inclusion of bsd.xorg.mk.
##
# USE_TEX			- A list of the TeX dependencies the port has.
#
##
# USE_RC_SUBR	- If set, the ports startup/shutdown script uses the common
#				  routines found in /etc/rc.subr.
#				  If this is set to a list of files, these files will be
#				  automatically added to ${SUB_FILES}, some %%VAR%%'s will
#				  automatically be expanded, they will be installed in
#				  ${PREFIX}/etc/rc.d if ${PREFIX} is not /usr, otherwise they
#				  will be installed in /etc/rc.d/ and added to the packing list.
##
# Conflict checking.  Use if your port cannot be installed at the same time as
# another package.
#
# CONFLICTS		- A list of package name patterns that the port conflicts
#				  with, separated by blanks.  The names may include shell
#				  pattern meta-characters "*", "?", "[", "]", and "!".
#				  Example: apache*-1.2* apache*-1.3.[012345] apache-*+ssl_*
#
# CONFLICTS_BUILD
#				- Check conflict prior to the build.
#
# CONFLICTS_INSTALL
#				- Check conflict prior to the installation stage.
#
# Various directory definitions and variables to control them.
# You rarely need to redefine any of these except WRKSRC and NO_WRKSUBDIR.
#
# LOCALBASE		- Where ports install things.
#				  Default: /usr/local
# LINUXBASE		- Where Linux ports install things.
#				  Default: /compat/linux
# PREFIX		- Where *this* port installs its files.
#				  Default: ${LINUXBASE} if USE_LINUX_PREFIX is set,
#				  otherwise ${LOCALBASE}
#
# IGNORE_PATH_CHECKS
#				- There are some sanity checks against PREFIX.
#				  You can disable these checks with defining
#				  this variable, but this is not recommended!
#				  Only do this if you really know what you are
#				  doing.  These sanity checks are the following:
#				    - PREFIX has to be an absolute path.
#				    - PREFIX can't have a trailing slash.
#
# BUNDLE_LIBS	  Teach pkg(8) to not automatically add all shared libraries
# 				  installed by a port as shared libraries "provided" for
#				  other packages (i.e., do not expose them in the solver).
#				  This has to be used for ports that bundle third party
#				  libraries for internal usage.
# MASTERDIR		- Where the port finds patches, package files, etc.  Define
#				  this is you have two or more ports that share most of the
#				  files.
#				  Default: ${.CURDIR}
# PORTSDIR		- The root of the ports tree.
#				  Default: /usr/ports
# DISTDIR		- Where to search for and store copies of original sources
#				  Default: ${PORTSDIR}/distfiles
# PACKAGES		- A top level directory where all packages go (rather than
#				  going locally to each port).
#				  Default: ${PORTSDIR}/packages
# WRKDIRPREFIX	- The place to root the temporary working directory
#				  hierarchy. This path must *not* end in '/'.
#				  Default: none
# WRKDIR		- A temporary working directory that gets *clobbered* on clean
#				  Default: ${WRKDIRPREFIX}${.CURDIR}/work
# WRKSRC		- A subdirectory of ${WRKDIR} where the distribution actually
#				  unpacks to.
#				  Default: ${WRKDIR}/${DISTNAME}
# WRKSRC_SUBDIR	- A subdirectory of ${WRKSRC} where the distribution actually
#				  builds in.
#				  Default: not set
# NO_WRKSUBDIR	- Assume port unpacks without a subdirectory, and extract it in
# 				  ${WRKSRC} instead of ${WRKDIR}.
# PATCHDIR		- A directory containing any additional patches you made
#				  to port this software to FreeBSD.
#				  Default: ${MASTERDIR}/files
# SCRIPTDIR		- A directory containing any auxiliary scripts
#				  Default: ${MASTERDIR}/scripts
# FILESDIR		- A directory containing any miscellaneous additional files.
#				  Default: ${MASTERDIR}/files
# PKGDIR		- A directory containing any package creation files.
#				  Default: ${MASTERDIR}
# SRC_BASE		- The root of the src tree.  (Some ports require this to get
#				  kernel sources).  Default: /usr/src
# UID_FILES		- A list of files containing information about registered UIDs.
# 				  Note that files have decreasing priority.
# GID_FILES		- A list of files containing information about registered GIDs.
# 				  Note that files have decreasing priority.
#
# Variables that serve as convenient "aliases" for your *-install targets.
# Use these like: "${INSTALL_PROGRAM} ${WRKSRC}/prog ${PREFIX}/bin".
#
# INSTALL_PROGRAM
#				- A command to install binary executables.  (By
#				  default, also strips them, unless ${STRIP} is
#				  overridden to be the empty string).
# INSTALL_KLD	- As INSTALL_PROGRAM, but without the STRIP.
# INSTALL_LIB	- As INSTALL_DATA, but also strips the file.
# INSTALL_SCRIPT
#				- A command to install executable scripts.
# INSTALL_DATA	- A command to install sharable data and static libs.
# INSTALL_MAN	- A command to install manpages and documentation.
# COPYTREE_BIN
# COPYTREE_SHARE
#				- Similiar to INSTALL_PROGRAM and INSTALL_DATA commands but
#				  working on whole trees of directories, takes 3 arguments,
#				  last one is find(1) arguments and optional.
#				  Example use: 
#				  cd ${WRKSRC}/doc && ${COPYTREE_SHARE} . ${DOCSDIR} "! -name *\.bak"
#
#				  Installs all directories and files from ${WRKSRC}/doc
#				  to ${DOCSDIR} except sed(1) backup files.
#
# MANPREFIX		- The directory prefix for manual pages.
#				  Default: ${PREFIX}
# MAN<sect>PREFIX
#				- If manual pages of some sections install in different
#				  locations than others, use these.
#				  Default: ${MANPREFIX}
#
# Set the following to specify all .info files your port installs.
#
# INFO			- A list of .info files (omitting the trailing ".info");
#				  only one entry per document! These files are listed in
#				  the path relative to ${INFO_PATH}.
# INFO_PATH		- Path, where all .info files will be installed by your
#				  port, relative to ${PREFIX}
#
# Set the following to specify all documentation your port installs into
# ${DOCSDIR}
#
# PORTDOCS		- A list of files and directories relative to DOCSDIR.
#				  Shell glob patterns can be used, directories include
#				  the entire subtree of contained files and directories.
#				  Should not be set when no documentation files are
#				  installed.
#				  Useful for dynamically generated documentation.
#
# Set the following to specify all documentation your port installs into
# ${EXAMPLESDIR}
#
# PORTEXAMPLES		- A list of files and directories relative to EXAMPLESDIR.
#				  Shell glob patterns can be used, directories include
#				  the entire subtree of contained files and directories.
#				  Should not be set when no examples files are
#				  installed.
#				  Useful for dynamically generated examples.
#
# Set the following to specify all files and directories your port installs into
# ${DATADIR}
#
# PORTDATA		- A list of files and directories relative to DATADIR.
#				  Shell glob patterns can be used, directories include
#				  the entire subtree of contained files and directories.
#				  Should not be set when no data files are
#				  installed.
#				  Useful for dynamically generated data files.
#
# Default targets and their behaviors:
#
# fetch			- Retrieves missing ${DISTFILES} and ${PATCHFILES} for this
#				  port.
# fetch-list	- Show list of commands to retrieve missing ${DISTFILES} and
#				  ${PATCHFILES} for this port.
# fetch-recursive
#				- Retrieves missing ${DISTFILES} and ${PATCHFILES} for this
#				  port and dependencies.
# fetch-recursive-list
#				- Show list of commands to retrieve missing ${DISTFILES} and
#				  ${PATCHFILES} for this port and dependencies.
# fetch-required
#				- Retrieves missing ${DISTFILES} and ${PATCHFILES} for this
#				  port and dependencies.
# fetch-required-list
#				- Show list of commands to retrieve missing ${DISTFILES} and
#				  ${PATCHFILES} for this port and dependencies.
# fetch-url-list
#				- Show list of URLS to retrieve missing ${DISTFILES} and
#				  ${PATCHFILES} for this port.
# fetch-urlall-list
#				- Show list of URLS to retrieve ${DISTFILES} and
#				  ${PATCHFILES} for this port.
#
# all-depends-list
#				- Show all directories which are dependencies
#				  for this port.
# build-depends-list
#				- Show all directories which are build-dependencies
#				  for this port.
# package-depends-list
#				- Show all directories which are package-dependencies
#				  for this port. This is based upon the dependency
#				  tree as recorded in the Makefiles of the ports
#				  collection, not as recorded in the currently
#				  installed ports.
# actual-package-depends
#				- Like package-depends-list but with the difference
#				  that the dependencies of the currently installed
#				  ports are used instead of the dependencies as
#				  recorded in the ports collection.
# run-depends-list
#				- Show all directories which are run-dependencies
#				  for this port.
# test-depends-list
#				- Show all directories which are test-dependencies
#				  for this port.
#
# extract		- Unpacks ${DISTFILES} into ${WRKDIR}.
# patch			- Apply any provided patches to the source.
# configure		- Runs either GNU configure, one or more local configure
#				  scripts or nothing, depending on what's available.
# build			- Actually compile the sources.
# install		- Install the results of a build.
# reinstall		- Install the results of a build, ignoring "already installed"
#				  flag.
# deinstall		- Remove the installation.
# deinstall-all	- Remove all installations with the same PKGORIGIN.
# test			- Run tests for the port.
# package		- Create a package from an _installed_ port.
# package-recursive
#				- Create a package for a port and _all_ of its dependencies.
# describe		- Try to generate a one-line description for each port for
#				  use in INDEX files and the like.
# check-plist		- Checks for files missing from the plist, and files in the plist
#				  that are not installed by the port.
# check-sanity		- Perform some basic checks of the port layout.
# checkpatch	- Do a "patch -C" instead of a "patch".  Note that it may
#				  give incorrect results if multiple patches deal with
#				  the same file.
# checksum		- Use distinfo to ensure that your distfiles are valid.
# checksum-recursive
#				- Run checksum in this port and all dependencies.
# makesum		- Generate distinfo (only do this for your own ports!).
# clean			- Remove ${WRKDIR} and other temporary files used for building.
# clean-depends	- Do a "make clean" for all dependencies.
# config		- Configure options for this port (using ${DIALOG}).
#				  Automatically run prior to extract, patch, configure, build,
#				  install, and package.
# config-recursive
#				- Configure options for this port for a port and all its
#				  dependencies.
# showconfig	- Display options config for this port.
# showconfig-recursive
#				- Display options config for this port and all its
#				  dependencies.
# rmconfig		- Remove the options config for this port.
# rmconfig-recursive
#				- Remove the options config for this port and all its
#				  dependencies.
#
# Default sequence for "all" is:
#
#		check-sanity fetch checksum extract patch configure build
#
# Please read the comments in the targets section below; you
# should be able to use the pre-* or post-* targets/scripts
# (which are available for every stage except checksum) or
# override the do-* targets to do pretty much anything you want.
#
# The TARGET_ORDER_OVERRIDE variable can be set to multiple <priority>:<target>
# to change the ordering of targets, have a look at the _SEQ variables at the
# end of this file for the default order and priorities.
#
# NEVER override the "regular" targets unless you want to open
# a major can of worms.
#
# Set these variables if your port doesn't need some of the steps.
# Note that there are no NO_PATCH or NO_CONFIGURE variables because
# those steps are empty by default.  NO_EXTRACT is not allowed anymore
# since we need to at least create ${WRKDIR}.  Also, NO_CHECKSUM is a user
# variable and is not to be set in a port's Makefile.  See above for NO_PACKAGE.
#
# NO_BUILD		- Use a dummy (do-nothing) build target.
# NO_INSTALL	- Use a dummy (do-nothing) install target.
# NO_TEST		- Use a dummy (do-nothing) test target.
#
# Here are some variables used in various stages.
#
# For options see bsd.options.mk
#
# For fetch:
#
# FETCH_BINARY	- Path to ftp/http fetch command if not in $PATH.
#				  Default: "/usr/bin/fetch"
# FETCH_ARGS	- Arguments to ftp/http fetch command.
#				  Default: "-Fpr"
# FETCH_CMD		- ftp/http fetch command.
#				  Default: ${FETCH_BINARY} ${FETCH_ARGS}
# FETCH_BEFORE_ARGS
#				- Arguments to ${FETCH_CMD} before filename.
#				  Default: none
# FETCH_AFTER_ARGS
#				- Arguments to ${FETCH_CMD} following filename.
#				  Default: none
# FETCH_ENV		- Environment to pass to ${FETCH_CMD}.
#				  Default: none
# FETCH_REGET	- Times to retry fetching of files on checksum errors.
#				  Default: 1
# CLEAN_FETCH_ENV
#				- Disable package dependency in fetch target for mass
#				  fetching.  User settable.
#
# For extract:
#
# EXTRACT_CMD	- Command for extracting archive
#				  Default: ${TAR}
# EXTRACT_BEFORE_ARGS
#				- Arguments to ${EXTRACT_CMD} before filename.
#				  Default: "-xf"
# EXTRACT_AFTER_ARGS
#				- Arguments to ${EXTRACT_CMD} following filename.
#				  Default: "--no-same-owner --no-same-permissions"
# For patch:
#
# EXTRA_PATCHES	- Define this variable if you have patches not in
#				  ${PATCHDIR}.  This usually happens when you need to
#				  do some pre-processing before some distribution
#				  patches can be applied.  In that case, fetch them as
#				  extra distfiles, put the processed results in
#				  ${WRKDIR}, then point EXTRA_PATCHES to them.
#				  The patches specified by this variable will be
#				  applied after the normal distribution patches but
#				  before those in ${PATCHDIR}.  This can also contain
#				  directories, all the files named patch-* in those directories
#				  will be applied.
# EXTRA_PATCH_TREE - where to find extra 'out-of-tree' patches
#				  Points to a directory hierarchy with the same layout
#				  as the ports tree, where local patches can be found.
#				  This allows a third party to keep their patches in
#				  some other source control system if needed.
# PATCH_WRKSRC	- Directory to apply patches in.
#				  Default: ${WRKSRC}
#
# For configure:
#
# HAS_CONFIGURE	- If set, this port has its own configure script.  The
#				  configure stage will not do anything if this is not set.
# GNU_CONFIGURE	- If set, you are using GNU configure (optional).  Implies
#				  HAS_CONFIGURE.
# CONFIGURE_OUTSOURCE - If set, this port builds in an empty ${CONFIGURE_WRKSRC}
#				  not being under ${WRKSRC}.
# CONFIGURE_WRKSRC
#				- Directory to run configure in.
#				  Default: ${WRKSRC}
# CONFIGURE_SCRIPT
#				- Name of configure script, relative to ${CONFIGURE_WRKSRC}.
#				  Default: "Makefile.PL" if USES=perl5 and USE_PERL5=configure
#				  are set, "configure" otherwise.
# CONFIGURE_TARGET
#				- The name of target to call when GNU_CONFIGURE is
#				  defined.
#				  Default: ${ARCH}-portbld-${OPSYS:tl}${OSREL}
# GNU_CONFIGURE_PREFIX
#				- The directory passed as prefix to the configure script if
#				  GNU_CONFIGURE is set.
#				  Default: ${PREFIX}
# CONFIGURE_ARGS
#				- Pass these args to configure if ${HAS_CONFIGURE} is set.
#				  Default: "--prefix=${GNU_CONFIGURE_PREFIX}
#				  --infodir=${PREFIX}/${INFO_PATH} --localstatedir=/var
#				  --mandir=${MANPREFIX}/man --build=${CONFIGURE_TARGET}" if
#				  GNU_CONFIGURE is set, "CC=${CC} CFLAGS=${CFLAGS}
#				  PREFIX=${PREFIX} INSTALLPRIVLIB=${PREFIX}/lib
#				  INSTALLARCHLIB=${PREFIX}/lib" if USES=perl5 and
#				  USE_PERL5=configure are set, empty otherwise.
# CONFIGURE_ENV	- Pass these env (shell-like) to configure if
#				  ${HAS_CONFIGURE} is set.
# CONFIGURE_LOG	- The name of configure log file. It will be printed to
#				  the screen if configure fails.
#				  Default: config.log
# CONFIGURE_FAIL_MESSAGE
#				- A message displayed to users when configure
#				  fails (note: this assumes the do-configure
#				  target has not been overwritten).  This message
#				  will be passed through /usr/bin/fmt before
#				  being shown to the user.
#
# WITHOUT_FBSD10_FIX		  Disable FreeBSD 10.0 autotools workaround.
#
# For build and install:
#
# MAKEFILE		- Name of the makefile.
#				  Default: Makefile
# ALL_TARGET	- Default target for sub-make in build stage.
#				  Default: all
# BUILD_WRKSRC	- Directory to do build in (default: ${WRKSRC}).
# MAKE_ENV		- Additional environment vars passed to sub-make in build
#				  and install stages.
#				  Default: see below
# MAKE_ARGS		- Any extra arguments to sub-make in build and install stages.
#				  Default: none
##
# MAKE_JOBS_UNSAFE
#				- Disallow multiple jobs even when user set a global override.
#				  To be used with known bad ports.
# DISABLE_MAKE_JOBS
#				- Set to disable the multiple jobs feature.  User settable.
# MAKE_JOBS_NUMBER
#				- Override the number of make jobs to be used.  User settable.
# MAKE_JOBS_NUMBER_LIMIT
#				- Set a limit for maximum number of make jobs allowed to be
#				  used.
## cacche
#
# WITH_CCACHE_BUILD
# 				- Enable CCACHE support (devel/ccache).  User settable.
# CCACHE_DIR
# 				- Which directory to use for ccache (default: $HOME/.ccache)
# NO_CCACHE
#				- Disable CCACHE support for example for certain ports if
#				  CCACHE is enabled.  User settable.
#
# For test:
#
# TEST_TARGET	- Target for sub-make in test stage. If not defined,
#				  no default test target is provided.
#				  Default: (none)
# TEST_WRKSRC	- Directory to do test in (default: ${WRKSRC}).
# TEST_ENV		- Additional environment vars passed to sub-make in test
#				  stage
#				  Default: ${MAKE_ENV}
# TEST_ARGS		- Any extra arguments to sub-make in test stage
#				  Default: ${MAKE_ARGS}
#
# For install:
#
# INSTALL_TARGET
#				- Default target for sub-make in install stage.
#				  Default: install
# INSTALL_WRKSRC
#				- Directory to install from
#				  Default: ${WRKSRC}
# NO_MTREE		- If set, will not invoke mtree from bsd.port.mk from
#				  the "install" target.
# MTREE_FILE	- The name of the mtree file.
#				  Default: ${PORTSDIR}/Templates/BSD.local.dist or
#				  /etc/mtree/BSD.usr.dist if ${PREFIX} == "/usr".
# PLIST_DIRS	- Directories to be added to packing list
# PLIST_FILES	- Files and symbolic links to be added to packing list
#
# PLIST			- Name of the `packing list' file.
#				  Change this to ${WRKDIR}/PLIST or something if you
#				  need to write to it.  (It is not a good idea for a port
#				  to write to any file outside ${WRKDIR} during a normal
#				  build.)
#				  Default: ${PKGDIR}/pkg-plist
# TMPPLIST		- Name of the `packing list' file after processing
#				  Default: ${WRKDIR}/.PLIST.mktmp
# PLIST_SUB		- List of "variable=value" pair for substitution in ${PLIST}
#				  Default: see below
#
# SUB_FILES		- Files that should be passed through sed(1) and redirected to
#				  ${WRKDIR}.
#				- For each file specified in SUB_FILES, there must be a
#				  corresponding file in ${FILESDIR} whose suffix is ".in". For
#				  instance, if the Makefile specifies "SUB_FILES= pkg-message"
#				  then there must be a file called pkg-message.in in
#				  ${FILESDIR}.
#				- The substitution process is the same as PLIST_FILES, as
#				  described below except that any line beginning with @comment
#				  is deleted.
# SUB_LIST		- List of "variable=value" pair for substitution in ${SUB_FILES}
#				  Some pairs are added by default: eg. PREFIX=${PREFIX}
#
# USE_LDCONFIG  - If set to "yes", this adds ${PREFIX}/lib to the list of
#				  directories to be searched for shared libraries.
#				  Otherwise, this is a list of directories to be added to that
#				  list. The directory names are written to
#				  ${LOCALBASE}/libdata/ldconfig/${PKGBASE} which is then
#				  used by the ldconfig startup script.
#				  This mechanism replaces ldconfig scripts installed by some
#				  ports, often under such names as 000.${UNQUENAME}.sh.
#				  If USE_LINUX_PREFIX is defined, the Linux version of
#				  ldconfig will be used instead of the native FreeBSD
#				  version, and the directory list given will be ignored.
# USE_LDCONFIG32
# 				- Same as USE_LDCONFIG but the target file is
# 				  ${LOCALBASE}/libdata/ldconfig32/${PKGBASE} instead.
# 				  Note: that should only be used on 64-bit architectures.
#
# DOCSDIR		- Name of the directory to install the packages docs in.
#				  Default: ${PREFIX}/share/doc/${PORTNAME}
# DOCSDIR_REL	- The DOCSDIR relative to ${PREFIX}
# EXAMPLESDIR	- Name of the directory to install the packages examples in.
#				  Default: ${PREFIX}/share/examples/${PORTNAME}
# EXAMPLESDIR_REL
#				- The EXAMPLESDIR relative to ${PREFIX}
# DATADIR		- Name of the directory to install the packages shared data in.
#				  Default: ${PREFIX}/share/${PORTNAME}
# DATADIR_REL	- The DATADIR relative to ${PREFIX}
#
# WWWDIR		- Name of the directory to install the packages www data in.
#				  Default: ${PREFIX}/www/${PORTNAME}
# WWWDIR_REL	- The WWWDIR relative to ${PREFIX}
#
# USERS			- List of users to create at install time. Each login must
# 				  have a corresponding entry in ${UID_FILES}.
# GROUPS		- List of groups to create at install time. Each group must
# 				  have a corresponding entry in ${GID_FILES}.
#
# DESKTOPDIR	- Name of the directory to install ${DESKTOP_ENTRIES} in.
#				  Default: ${PREFIX}/share/applications
# DESKTOP_ENTRIES
#				- List of desktop entry files to generate and install in
#				  ${DESKTOPDIR}. The format is
#				  "Name" "Comment" "Icon" "Exec" "Categories" StartupNotify
#				  Rules:
#					* Only add desktop entries for applications which do not
#					  require a terminal (ie. X applications).
#					* If the upstream distribution already installs .desktop
#					  files, you do not need to use this.
#					* If you require a more elaborate .desktop file than this
#					  variable permits, write it yourself and install it
#					  in ${DESKTOPDIR}.
#				  Notes:
#					* Comment, Icon and StartupNotify may be empty
#					  strings (""). Categories may be an empty string in some
#					  cases (see below). The other fields are mandatory.
#					* If Comment is an empty string, port ${COMMENT} will be
#					  used.
#					* If set, Icon must be either absolute path (usually
#					  ${PREFIX}/share/pixmaps/${PORTNAME}.png) or icon name
#					  without extension if installed icons follow Icon Theme
#					  Specification.
#					* If Categories is an empty string, bsd.port.mk will try
#					  to deduce a default value using the CATEGORIES variable.
#					  If the deduction fails, you will have to set Categories
#					  manually. You should check the generated value using
#					  "make desktop-categories", and override it if necessary.
#					* Exec will also be used to name the .desktop file.
#					* StartupNotify may be true, false or empty (see Desktop
#					  Entry Specification for details).
#					* The files will be automatically added to ${PLIST}.
#				  Example:
#					"X Window Information" \
#					"Get information about X windows" \
#					"${PREFIX}/share/pixmaps/wininfo.png" \
#					"${PREFIX}/bin/wininfo" \
#					"System;" \
#					""
#				  See http://standards.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html
#				  for an explanation of the fields. If you need to create more
#				  than one file, just chain them into a single variable.
#
# Note that the install target will automatically add manpages (see
# above) and also substitute special sequences of characters (delimited
# by "%%") as defined in PLIST_SUB to generate ${TMPPLIST}.  For
# instance, "OSREL=${OSREL}" in PLIST_SUB causes all occurrences of
# "%%OSREL%%" in ${PLIST} to be substituted by the value of OSREL.
# ${TMPPLIST} is generated before the do-install stage.  If you are
# generating the packing list on-the-fly, make sure it's generated before
# do-install is called!
#
# This is used in all stages:
#
# SCRIPTS_ENV	- Additional environment vars passed to scripts in
#				  ${SCRIPTDIR} executed by bsd.port.mk.
#				  Default: see below
#
# Finally, variables to change if you want a special behavior.  These
# are for debugging purposes.  Don't set them in your Makefile.
#
# ECHO_MSG		- Used to print all the '===>' style prompts - override this
#				  to turn them off.
#				  Default: ${ECHO_CMD}
# PATCH_DEBUG	- If set, print out more information about the patches as
#				  it attempts to apply them.
# PKG_DBDIR		- Where package installation is recorded; this directory
#				  must not contain anything else.
#				  Default: /var/db/pkg
# PORT_DBDIR	- Where port configuration options are recorded.
#				  Default: /var/db/ports
# NO_PKG_REGISTER
#				- Don't register a port installation as a package.
# FORCE_PKG_REGISTER
#				- If set, it will overwrite any existing package
#				  registration information in ${PKG_DBDIR}/${PKGNAME}.
# NO_DEPENDS	- Don't verify build of dependencies.
# STRICT_DEPENDS
#				- Verify dependencies but consider missing dependencies as
#				  fatal.
# CHECKSUM_ALGORITHMS
#				- Different checksum algorithms to check for verifying the
#				  integrity of the distfiles. The absence of the algorithm
#				  in distinfo doesn't make it fail.
#				  Default: sha256
# NO_CHECKSUM	- Don't verify the checksum.  Typically used when
#				  when you noticed the distfile you just fetched has
#				  a different checksum and you intend to verify if
#				  the port still works with it.
# USE_PACKAGE_DEPENDS
#				- Try to install dependencies from existing packages instead
#				  of building the port from scratch. Fallback on source
#				  if an existing package is not present.
# USE_PACKAGE_DEPENDS_ONLY
#				- Like USE_PACKAGE_DEPENDS, but do not fallback on source.
# INSTALL_AS_USER
#				- Define this to install as the current user, intended
#				  for systems where you have no root access.
# DISABLE_SIZE	- Do not check the size of a distfile even if the SIZE field
#				  has been specified in distinfo.  This is useful
#				  when using an alternate FETCH_CMD.
#
# PKG_CREATE_VERBOSE		- If set, pass the -v option to pkg create which
#				  ensures periodic output during packaging and
#				  will help prevent timeouts by build monitors
#
# End of the list of all variables that need to be defined in a port.
# Most port authors should not need to understand anything after this point.
#

LANG=		C
LC_ALL=		C
.export		LANG LC_ALL

# These need to be absolute since we don't know how deep in the ports
# tree we are and thus can't go relative.  They can, of course, be overridden
# by individual Makefiles or local system make configuration.
PORTSDIR?=		/usr/ports
LOCALBASE?=		/usr/local
LINUXBASE?=		/compat/linux
DISTDIR?=		${PORTSDIR}/distfiles
_DISTDIR?=		${DISTDIR}/${DIST_SUBDIR}
INDEXDIR?=		${PORTSDIR}
SRC_BASE?=		/usr/src
USESDIR?=		${PORTSDIR}/Mk/Uses
SCRIPTSDIR?=	${PORTSDIR}/Mk/Scripts
LIB_DIRS?=		/lib /usr/lib ${LOCALBASE}/lib
STAGEDIR?=	${WRKDIR}/stage
NOTPHONY?=
FLAVORS?=
FLAVOR?=
# Disallow forced FLAVOR as make argument since we cannot change it to the
# proper default.
.if empty(FLAVOR) && !empty(.MAKEOVERRIDES:MFLAVOR)
.error FLAVOR may not be passed empty as a make argument.
.endif
# Store env FLAVOR for later
.if !defined(_FLAVOR)
_FLAVOR:=	${FLAVOR}
.endif
PORTS_FEATURES+=	FLAVORS
MINIMAL_PKG_VERSION=	1.6.0

_PORTS_DIRECTORIES+=	${PKG_DBDIR} ${PREFIX} ${WRKDIR} ${EXTRACT_WRKDIR} \
						${STAGEDIR}${PREFIX} ${WRKDIR}/pkg ${BINARY_LINKDIR}

# Ensure .CURDIR contains an absolute path without a trailing slash.  Failed
# builds can occur when PORTSDIR is a symbolic link, or with something like
# make -C /usr/ports/category/port/.
.CURDIR:=		${.CURDIR:tA}

# make sure bmake treats -V as expected
.MAKE.EXPAND_VARIABLES= yes

.include "${PORTSDIR}/Mk/bsd.commands.mk"

# Do not leak flavors to childs make
.MAKEOVERRIDES:=	${.MAKEOVERRIDES:NFLAVOR}

.if defined(CROSS_TOOLCHAIN)
.if !defined(CROSS_SYSROOT)
IGNORE=	CROSS_SYSROOT should be defined
.endif
.include "${LOCALBASE}/share/toolchains/${CROSS_TOOLCHAIN}.mk"
# Do not define CPP on purpose
.if !defined(HOSTCC)
HOSTCC:=	${CC}
HOSTCXX:=	${CXX}
.endif
.if !defined(CC_FOR_BUILD)
CC_FOR_BUILD:=	${HOSTCC}
CXX_FOR_BUILD:=	${HOSTCXX}
.endif
CONFIGURE_ENV+= HOSTCC="${HOSTCC}" HOSTCXX="${HOSTCXX}" CC_FOR_BUILD="${CC_FOR_BUILD}" CXX_FOR_BUILD="${CXX_FOR_BUILD}"

CC=		${XCC} --sysroot=${CROSS_SYSROOT}
CXX=		${XCXX} --sysroot=${CROSS_SYSROOT}
CPP=		${XCPP} --sysroot=${CROSS_SYSROOT}
.for _tool in AS AR LD NM OBJCOPY RANLIB SIZE STRINGS
${_tool}=	${CROSS_BINUTILS_PREFIX}${tool:tl}
.endfor
LD+=		--sysroot=${CROSS_SYSROOT}
STRIP_CMD=	${CROSS_BINUTILS_PREFIX}strip
# only bmake support the below
STRIPBIN=	${STRIP_CMD}
.export.env STRIPBIN
.endif

#
# DESTDIR section to start a chrooted process if invoked with DESTDIR set
#

.if defined(DESTDIR) && !empty(DESTDIR) && !defined(CHROOTED) && \
	!defined(BEFOREPORTMK) && !defined(INOPTIONSMK)

.include "${PORTSDIR}/Mk/bsd.destdir.mk"

.else

.if !target(makepatch)
makepatch:
	@${SETENV} WRKDIR=${WRKDIR} PATCHDIR=${PATCHDIR} \
		PATCH_WRKSRC=${PATCH_WRKSRC} \
		STRIP_COMPONENTS="${PATCH_STRIP:S/-p//}" \
		${SH} ${SCRIPTSDIR}/smart_makepatch.sh
.endif


# Start of options section
.if defined(INOPTIONSMK) || ( !defined(USEOPTIONSMK) && !defined(AFTERPORTMK) )


# Get the default maintainer
MAINTAINER?=	ports@FreeBSD.org

# Get the architecture
.if !defined(ARCH)
ARCH!=	${UNAME} -p
.endif
HOSTARCH:=	${ARCH}
.if defined(CROSS_TOOLCHAIN)
ARCH=	${CROSS_TOOLCHAIN:C,-.*$,,}
.endif
_EXPORTED_VARS+=	ARCH

# Get operating system versions for a cross build
.if defined(CROSS_SYSROOT)
.if !exists(${CROSS_SYSROOT}/usr/include/sys/param.h)
.error CROSS_SYSROOT does not include /usr/include/sys/param.h.
.endif
OSVERSION!=	${AWK} '/^\#define[[:blank:]]__FreeBSD_version/ {print $$3}' < ${CROSS_SYSROOT}/usr/include/sys/param.h
_OSRELEASE!= ${AWK} -v version=${OSVERSION} 'END { printf("%d.%d-CROSS", version / 100000, version / 1000 % 100) }' < /dev/null
.endif

# Get the operating system type
.if !defined(OPSYS)
OPSYS!=	${UNAME} -s
.endif
_EXPORTED_VARS+=	OPSYS

.if !defined(_OSRELEASE)
_OSRELEASE!=	${UNAME} -r
.endif
_EXPORTED_VARS+=	_OSRELEASE

# Get the operating system revision
OSREL?=	${_OSRELEASE:C/-.*//}
_EXPORTED_VARS+=	OSREL

# Get __FreeBSD_version
.if !defined(OSVERSION)
.if exists(/usr/include/sys/param.h)
OSVERSION!=	${AWK} '/^\#define[[:blank:]]__FreeBSD_version/ {print $$3}' < /usr/include/sys/param.h
.elif exists(${SRC_BASE}/sys/sys/param.h)
OSVERSION!=	${AWK} '/^\#define[[:blank:]]__FreeBSD_version/ {print $$3}' < ${SRC_BASE}/sys/sys/param.h
.else
.error Unable to determine OS version.  Either define OSVERSION, install /usr/include/sys/param.h or define SRC_BASE.
.endif
.endif
_EXPORTED_VARS+=	OSVERSION

.if (${OPSYS} == FreeBSD && ${OSVERSION} < 1102000) || \
    (${OPSYS} == DragonFly && ${DFLYVERSION} < 400400)
_UNSUPPORTED_SYSTEM_MESSAGE=	Ports Collection support for your ${OPSYS} version has ended, and no ports\
								are guaranteed to build on this system. Please upgrade to a supported release.
. if defined(ALLOW_UNSUPPORTED_SYSTEM)
WARNING+=			"${_UNSUPPORTED_SYSTEM_MESSAGE}"
. else
show-unsupported-system-error:
	@${ECHO_MSG} "/!\\ ERROR: /!\\"
	@${ECHO_MSG}
	@${ECHO_MSG} "${_UNSUPPORTED_SYSTEM_MESSAGE}" | ${FMT_80}
	@${ECHO_MSG}
	@${ECHO_MSG} "No support will be provided if you silence this message by defining ALLOW_UNSUPPORTED_SYSTEM." | ${FMT_80}
	@${ECHO_MSG}
	@${FALSE}
. endif
.endif

# Convert OSVERSION to major release number
_OSVERSION_MAJOR=	${OSVERSION:C/([0-9]?[0-9])([0-9][0-9])[0-9]{3}/\1/}
# Sanity checks for chroot/jail building.
# Skip if OSVERSION specified on cmdline for testing. Only works for bmake.
.if !defined(.MAKEOVERRIDES) || !${.MAKEOVERRIDES:MOSVERSION}
.if ${_OSVERSION_MAJOR} != ${_OSRELEASE:R}
.error UNAME_r (${_OSRELEASE}) and OSVERSION (${OSVERSION}) do not agree on major version number.
.elif ${_OSVERSION_MAJOR} != ${OSREL:R}
.error OSREL (${OSREL}) and OSVERSION (${OSVERSION}) do not agree on major version number.
.endif
.endif

# Only define tools here (for transition period with between pkg tools)
.include "${PORTSDIR}/Mk/bsd.commands.mk"

.if !defined(_PKG_CHECKED) && !defined(PACKAGE_BUILDING) && exists(${PKG_BIN})
.if !defined(_PKG_VERSION)
_PKG_VERSION!=	${PKG_BIN} -v
.endif
_PKG_STATUS!=	${PKG_BIN} version -t ${_PKG_VERSION:C/-.*//g} ${MINIMAL_PKG_VERSION}
.if ${_PKG_STATUS} == "<"
IGNORE=		pkg(8) must be version ${MINIMAL_PKG_VERSION} or greater, but you have ${_PKG_VERSION}. You must upgrade the ${PKG_ORIGIN} port first
.endif
_PKG_CHECKED=	1
.endif
_EXPORTED_VARS+=	_PKG_CHECKED

MASTERDIR?=	${.CURDIR}

.if ${MASTERDIR} != ${.CURDIR}
SLAVE_PORT?=	yes
MASTER_PORT?=${MASTERDIR:C/[^\/]+\/\.\.\///:C/[^\/]+\/\.\.\///:C/^.*\/([^\/]+\/[^\/]+)$/\\1/}
.else
SLAVE_PORT?=	no
MASTER_PORT?=
.endif

# If they exist, include Makefile.inc, then architecture/operating
# system specific Makefiles, then local Makefile.local.

.if ${MASTERDIR} != ${.CURDIR} && exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
USE_SUBMAKE=	yes
.endif

.if exists(${MASTERDIR}/../Makefile.inc)
.include "${MASTERDIR}/../Makefile.inc"
USE_SUBMAKE=	yes
.endif

.if exists(${MASTERDIR}/Makefile.${ARCH}-${OPSYS})
.include "${MASTERDIR}/Makefile.${ARCH}-${OPSYS}"
USE_SUBMAKE=	yes
.elif exists(${MASTERDIR}/Makefile.${OPSYS})
.include "${MASTERDIR}/Makefile.${OPSYS}"
USE_SUBMAKE=	yes
.elif exists(${MASTERDIR}/Makefile.${ARCH})
.include "${MASTERDIR}/Makefile.${ARCH}"
USE_SUBMAKE=	yes
.endif

.if exists(${MASTERDIR}/Makefile.local)
.include "${MASTERDIR}/Makefile.local"
USE_SUBMAKE=	yes
.elif ${MASTERDIR} != ${.CURDIR} && exists(${.CURDIR}/Makefile.local)
.include "${.CURDIR}/Makefile.local"
USE_SUBMAKE=	yes
.endif

.for _CATEGORY in ${CATEGORIES}
PKGCATEGORY?=	${_CATEGORY}
.endfor
_PORTDIRNAME=	${.CURDIR:T}
PORTDIRNAME?=	${_PORTDIRNAME}
PKGORIGIN?=		${PKGCATEGORY}/${PORTDIRNAME}

# where 'make config' records user configuration options
PORT_DBDIR?=	/var/db/ports

UID_FILES?=	${PORTSDIR}/UIDs
GID_FILES?=	${PORTSDIR}/GIDs
UID_OFFSET?=	0
GID_OFFSET?=	0

# predefined accounts from src/etc/master.passwd
# alpha numeric sort order
USERS_BLACKLIST=	_dhcp _pflogd _ypldap auditdistd bin bind daemon games hast kmem mailnull man news nobody operator pop proxy root smmsp sshd toor tty unbound uucp www

# predefined accounts from src/etc/group
# alpha numeric sort order
GROUPS_BLACKLIST=	_dhcp _pflogd _ypldap audit authpf bin bind daemon dialer ftp games guest hast kmem mail mailnull man network news nobody nogroup operator proxy smmsp sshd staff sys tty unbound uucp wheel www

LDCONFIG_DIR=	libdata/ldconfig
LDCONFIG32_DIR=	libdata/ldconfig32

# At least KDE needs TMPDIR for the package building,
# so we're setting it to the known default value.
.if defined(PACKAGE_BUILDING)
TMPDIR?=	/tmp
.endif # defined(PACKAGE_BUILDING)

.if defined(WITH_DEBUG_PORTS)
.if ${WITH_DEBUG_PORTS:M${PKGORIGIN}}
WITH_DEBUG=	yes
.endif
.endif

.include "${PORTSDIR}/Mk/bsd.default-versions.mk"
.include "${PORTSDIR}/Mk/bsd.options.mk"

.endif
# End of options section.

# Start of pre-makefile section.
.if !defined(AFTERPORTMK) && !defined(INOPTIONSMK)

.if defined(_PREMKINCLUDED)
DEV_ERROR+=	"you cannot include bsd.port[.pre].mk twice"
.endif

_PREMKINCLUDED=	yes

.if defined(PORTVERSION)
.if ${PORTVERSION:M*[-_,]*}x != x
IGNORE=			PORTVERSION ${PORTVERSION} may not contain '-' '_' or ','
.endif
.if defined(DISTVERSION)
DEV_ERROR+=	"Defining both PORTVERSION and DISTVERSION is wrong, only set one, if necessary, set DISTNAME"
.endif
DISTVERSION?=	${PORTVERSION:S/:/::/g}
.elif defined(DISTVERSION)
PORTVERSION=	${DISTVERSION:tl:C/([a-z])[a-z]+/\1/g:C/([0-9])([a-z])/\1.\2/g:C/:(.)/\1/g:C/[^a-z0-9+]+/./g}
.endif

PORTREVISION?=	0
.if ${PORTREVISION} != 0
_SUF1=	_${PORTREVISION}
.endif

PORTEPOCH?=		0
.if ${PORTEPOCH} != 0
_SUF2=	,${PORTEPOCH}
.endif

PKGVERSION=	${PORTVERSION:C/[-_,]/./g}${_SUF1}${_SUF2}
PKGNAME=	${PKGNAMEPREFIX}${PORTNAME}${PKGNAMESUFFIX}-${PKGVERSION}
DISTVERSIONFULL=	${DISTVERSIONPREFIX}${DISTVERSION:C/:(.)/\1/g}${DISTVERSIONSUFFIX}
.if defined(USE_GITHUB) && empty(MASTER_SITES:MGHC) && empty(USE_GITHUB:Mnodefault)
.  if empty(DISTNAME)
_GITHUB_MUST_SET_DISTNAME=		yes
.  else
DEV_WARNING+=	"You are using USE_GITHUB and DISTNAME is set which is wrong.  Set GH_ACCOUNT/GH_PROJECT/GH_TAGNAME correctly and remove WRKSRC entirely."
.  endif
.else
DISTNAME?=	${PORTNAME}-${DISTVERSIONFULL}
.endif

INDEXFILE?=		INDEX-${OSVERSION:C/([0-9]*)[0-9]{5}/\1/}

.if defined(USE_XORG) || defined(XORG_CAT)
.include "${PORTSDIR}/Mk/bsd.xorg.mk"
.endif

PACKAGES?=		${PORTSDIR}/packages
TEMPLATES?=		${PORTSDIR}/Templates
KEYWORDS?=		${PORTSDIR}/Keywords

PATCHDIR?=		${MASTERDIR}/files
FILESDIR?=		${MASTERDIR}/files
SCRIPTDIR?=		${MASTERDIR}/scripts
PKGDIR?=		${MASTERDIR}

PREFIX?=		${LOCALBASE}

PKGCOMPATDIR?=		${LOCALBASE}/lib/compat/pkg

.if defined(USE_LOCAL_MK)
.include "${PORTSDIR}/Mk/bsd.local.mk"
.endif

.if defined(USE_PHP) && (!defined(USES) || ( defined(USES) && !${USES:Mphp*} ))
DEV_WARNING+=		"Using USE_PHP alone is deprecated, please use USES=php"
USES+=	php
.endif

.if defined(USE_JAVA)
.include "${PORTSDIR}/Mk/bsd.java.mk"
.endif

.if defined(USE_RUBY) || defined(USE_LIBRUBY)
.include "${PORTSDIR}/Mk/bsd.ruby.mk"
.endif

.if defined(USE_OCAML)
.include "${PORTSDIR}/Mk/bsd.ocaml.mk"
.endif

.if defined(USE_APACHE_BUILD)
USES+=	apache:build,${USE_APACHE_BUILD:C/2([0-9])/2.\1/g}
.elif defined(USE_APACHE_RUN)
USES+=	apache:run,${USE_APACHE_RUN:C/2([0-9])/2.\1/g}
.elif defined(USE_APACHE)
USE_APACHE:=	${USE_APACHE:S/common/server,/}
USES+=	apache:${USE_APACHE:C/2([0-9])/2.\1/g}
.endif

.if defined(USE_TEX)
.include "${PORTSDIR}/Mk/bsd.tex.mk"
.endif

.if defined(USE_GECKO)
.include "${PORTSDIR}/Mk/bsd.gecko.mk"
.endif

.if (defined(USE_GNOME) || defined(INSTALLS_ICONS)) && empty(USES:Mgnome)
DEV_WARNING+=	"Using USE_GNOME alone is deprecated, please add USES=gnome."
USES+=	gnome
.endif

.if defined(USE_MATE) && empty(USES:Mmate)
DEV_WARNING+=	"Using USE_MATE alone is deprecated, please add USES=mate."
USES+=	mate
.endif

.if defined(USE_GL) && (!defined(USES) || !${USES:Mgl})
DEV_WARNING+=	"Using USE_GL alone is deprecated, please add USES=gl."
USES+=	gl
.endif

.if defined(USE_MYSQL)
USE_MYSQL:=		${USE_MYSQL:N[yY][eE][sS]:Nclient}
.if defined(WANT_MYSQL_VER)
.if empty(USE_MYSQL)
USE_MYSQL:=${WANT_MYSQL_VER}
.else
USE_MYSQL:=${USE_MYSQL},${WANT_MYSQL_VER}
.endif
.endif
USES+=mysql:${USE_MYSQL}
.endif

.if defined(WANT_WX) || defined(USE_WX) || defined(USE_WX_NOT)
.include "${PORTSDIR}/Mk/bsd.wx.mk"
.endif

.if defined(WANT_GSTREAMER) || defined(USE_GSTREAMER) || defined(USE_GSTREAMER1)
.include "${PORTSDIR}/Mk/bsd.gstreamer.mk"
.endif

.if defined(USE_SDL)
.include "${PORTSDIR}/Mk/bsd.sdl.mk"
.endif

.if !defined(UID)
UID!=	${ID} -u
.endif

DESTDIRNAME?=	DESTDIR

# setup empty variables for USES targets
.for target in sanity fetch extract patch configure build install test package stage
_USES_${target}?=
.endfor

# Loading features
.for f in ${USES}
_f:=		${f:C/\:.*//}
.if !defined(${_f}_ARGS)
${_f}_ARGS:=	${f:C/^[^\:]*(\:|\$)//:S/,/ /g}
.endif
.endfor
.for f in ${USES}
.include "${USESDIR}/${f:C/\:.*//}.mk"
.endfor

.if !empty(FLAVORS)
.  if ${FLAVORS:Mall}
DEV_ERROR+=		"FLAVORS cannot contain 'all', it is a reserved value"
.  endif
.  for f in ${FLAVORS}
.    if ${f:C/[[:lower:][:digit:]_]//g}
_BAD_FLAVOR_NAMES+=		${f}
.    endif
.  endfor
.  if !empty(_BAD_FLAVOR_NAMES)
DEV_ERROR+=		"FLAVORS contains flavors that are not all [a-z0-9_]: ${_BAD_FLAVOR_NAMES}"
.  endif
.endif

.if !empty(FLAVOR)
.  if empty(FLAVORS)
IGNORE=	FLAVOR is defined (to ${FLAVOR}) while this port does not have FLAVORS.
.  elif ! ${FLAVORS:M${FLAVOR}}
IGNORE=	Unknown flavor '${FLAVOR}', possible flavors: ${FLAVORS}.
.  endif
.endif

.if !empty(FLAVORS) && empty(FLAVOR)
FLAVOR=	${FLAVORS:[1]}
.endif

# Reorder FLAVORS so the default is first if set by the port.
.if empty(_FLAVOR) && !empty(FLAVORS) && !empty(FLAVOR)
FLAVORS:=	${FLAVOR} ${FLAVORS:N${FLAVOR}}
.endif

.if !empty(FLAVOR) && !defined(_DID_FLAVORS_HELPERS)
_DID_FLAVORS_HELPERS=	yes
_FLAVOR_HELPERS_OVERRIDE=	DESCR PLIST PKGNAMEPREFIX PKGNAMESUFFIX \
							DEPRECATED EXPIRATION_DATE
_FLAVOR_HELPERS_APPEND=	 	CONFLICTS CONFLICTS_BUILD CONFLICTS_INSTALL \
							PKG_DEPENDS EXTRACT_DEPENDS PATCH_DEPENDS \
							FETCH_DEPENDS BUILD_DEPENDS LIB_DEPENDS \
							RUN_DEPENDS TEST_DEPENDS
# These overwrite the current value
.for v in ${_FLAVOR_HELPERS_OVERRIDE}
.if defined(${FLAVOR}_${v})
${v}=	${${FLAVOR}_${v}}
.endif
.endfor

# These append to the current value
.for v in ${_FLAVOR_HELPERS_APPEND}
.if defined(${FLAVOR}_${v})
${v}+=	${${FLAVOR}_${v}}
.endif
.endfor

.for v in BROKEN IGNORE
.if defined(${FLAVOR}_${v})
${v}=	flavor "${FLAVOR}" ${${FLAVOR}_${v}}
.endif
.endfor
.endif # defined(${FLAVOR})


EXTRACT_SUFX?=			.tar.gz

.if defined(USE_LINUX_PREFIX)
PREFIX=					${LINUXBASE}
DATADIR?=				${PREFIX}/usr/share/${PORTNAME}
DOCSDIR?=				${PREFIX}/usr/share/doc/${PORTNAME}-${PORTVERSION}
NO_LICENSES_INSTALL=	yes
NO_MTREE=				yes
.endif

# You can force skipping these test by defining IGNORE_PATH_CHECKS
.if !defined(IGNORE_PATH_CHECKS)
.if ! ${PREFIX:M/*}
.BEGIN:
	@${ECHO_MSG} "PREFIX must be defined as an absolute path so that when 'make'"
	@${ECHO_MSG} "is invoked in the work area PREFIX points to the right place."
	@${FALSE}
.endif
.endif

DATADIR?=		${PREFIX}/share/${PORTNAME}
DOCSDIR?=		${PREFIX}/share/doc/${PORTNAME}
ETCDIR?=		${PREFIX}/etc/${PORTNAME}
EXAMPLESDIR?=	${PREFIX}/share/examples/${PORTNAME}
WWWDIR?=		${PREFIX}/www/${PORTNAME}

# Owner and group of the WWW user
WWWOWN?=	www
WWWGRP?=	www

# Keep PKGNG_ORIGIN/WITH_PKGNG for compat with scripts which are looking for it
PKG_ORIGIN?=	ports-mgmt/pkg
PKGNG_ORIGIN=	${PKG_ORIGIN}
WITH_PKGNG?=	yes
WITH_PKG?=	${WITH_PKGNG}

.endif
# End of pre-makefile section.

# Start of post-makefile section.
.if !defined(BEFOREPORTMK) && !defined(INOPTIONSMK)

.if defined(_POSTMKINCLUDED)
DEV_ERROR+=	"${PKGNAME}: Makefile error: you cannot include bsd.port[.post].mk twice"
	@${FALSE}
.endif

_POSTMKINCLUDED=	yes

.if defined(BUNDLE_LIBS)
PKG_NOTES+=	no_provide_shlib
PKG_NOTE_no_provide_shlib=	yes
.endif

.if defined(DEPRECATED)
PKG_NOTES+=	deprecated
PKG_NOTE_deprecated=${DEPRECATED}
.endif

.if defined(EXPIRATION_DATE)
PKG_NOTES+=	expiration_date
PKG_NOTE_expiration_date=	${EXPIRATION_DATE}
.endif

.if !empty(FLAVOR)
PKG_NOTES+=	flavor
PKG_NOTE_flavor=	${FLAVOR}
.endif

TEST_ARGS?=		${MAKE_ARGS}
TEST_ENV?=		${MAKE_ENV}

PKG_ENV+=		PORTSDIR=${PORTSDIR}
CONFIGURE_ENV+=	XDG_DATA_HOME=${WRKDIR} \
				XDG_CONFIG_HOME=${WRKDIR} \
				HOME=${WRKDIR}
MAKE_ENV+=		XDG_DATA_HOME=${WRKDIR} \
				XDG_CONFIG_HOME=${WRKDIR} \
				HOME=${WRKDIR}
# Respect TMPDIR passed via make.conf or similar and pass it down
# to configure and make.
.if defined(TMPDIR)
MAKE_ENV+=		TMPDIR="${TMPDIR}"
CONFIGURE_ENV+=	TMPDIR="${TMPDIR}"
.endif # defined(TMPDIR)

QA_ENV+=		STAGEDIR=${STAGEDIR} \
				PREFIX=${PREFIX} \
				LINUXBASE=${LINUXBASE} \
				LOCALBASE=${LOCALBASE} \
				"STRIP=${STRIP}" \
				TMPPLIST=${TMPPLIST} \
				CURDIR='${.CURDIR}' \
				FLAVOR=${FLAVOR} \
				FLAVORS='${FLAVORS}' \
				BUNDLE_LIBS=${BUNDLE_LIBS} \
				LDCONFIG_DIR="${LDCONFIG_DIR}" \
				PKGORIGIN=${PKGORIGIN} \
				LIB_RUN_DEPENDS='${_LIB_RUN_DEPENDS:C,[^:]*:([^:]*):?.*,\1,}' \
				UNIFIED_DEPENDS=${_UNIFIED_DEPENDS:C,([^:]*:[^:]*):?.*,\1,:O:u:Q} \
				PKGBASE=${PKGBASE} \
				LICENSE="${LICENSE}" \
				LICENSE_PERMS="${_LICENSE_PERMS}" \
				DISABLE_LICENSES="${DISABLE_LICENSES:Dyes}" \
				PORTNAME=${PORTNAME} \
				NO_ARCH=${NO_ARCH} \
				"NO_ARCH_IGNORE=${NO_ARCH_IGNORE}" \
				USE_RUBY=${USE_RUBY}
.if !empty(USES:Mssl)
QA_ENV+=		USESSSL=yes
.endif
.if !empty(USES:Mdesktop-file-utils)
QA_ENV+=		USESDESKTOPFILEUTILS=yes
.endif
.if !empty(USES:Mlibtool*)
QA_ENV+=		USESLIBTOOL=yes
.endif
.if !empty(USES:Mshared-mime-info)
QA_ENV+=		USESSHAREDMIMEINFO=yes
.endif
.if !empty(USES:Mterminfo)
QA_ENV+=		USESTERMINFO=yes
.endif

CO_ENV+=		STAGEDIR=${STAGEDIR} \
				PREFIX=${PREFIX} \
				LOCALBASE=${LOCALBASE} \
				WRKDIR=${WRKDIR} \
				WRKSRC=${WRKSRC} \
				MTREE_FILE=${MTREE_FILE} \
				TMPPLIST=${TMPPLIST} \
				SCRIPTSDIR=${SCRIPTSDIR} \
				PLIST_SUB_SED="${PLIST_SUB_SED}" \
				PORT_OPTIONS="${PORT_OPTIONS}" \
				PORTSDIR="${PORTSDIR}"

.if defined(CROSS_SYSROOT)
PKG_ENV+=		ABI_FILE=${CROSS_SYSROOT}/bin/sh
MAKE_ENV+=		NM=${NM} \
				STRIPBIN=${STRIPBIN} \
				PKG_CONFIG_SYSROOT_DIR="${CROSS_SYSROOT}"
CONFIGURE_ENV+=	PKG_CONFIG_SYSROOT_DIR="${CROSS_SYSROOT}"
.endif

.if empty(FLAVOR)
_WRKDIR=	work
.else
_WRKDIR=	work-${FLAVOR}
.endif

WRKDIR?=		${WRKDIRPREFIX}${.CURDIR}/${_WRKDIR}
BINARY_LINKDIR=	${WRKDIR}/.bin
PATH:=			${BINARY_LINKDIR}:${PATH}
.if !${MAKE_ENV:MPATH=*} && !${CONFIGURE_ENV:MPATH=*}
MAKE_ENV+=			PATH=${PATH}
CONFIGURE_ENV+=		PATH=${PATH}
.endif

.if !defined(IGNORE_MASTER_SITE_GITHUB) && defined(USE_GITHUB) && empty(USE_GITHUB:Mnodefault)
.if defined(WRKSRC)
DEV_WARNING+=	"You are using USE_GITHUB and WRKSRC is set which is wrong.  Set GH_PROJECT correctly, set WRKSRC_SUBDIR or remove WRKSRC entirely."
.endif
WRKSRC?=		${WRKDIR}/${GH_PROJECT}-${GH_TAGNAME_EXTRACT}
.endif

.if !default(IGNORE_MASTER_SITE_GITLAB) && defined(USE_GITLAB) && empty(USE_GITLAB:Mnodefault)
WRKSRC?=		${WRKDIR}/${GL_PROJECT}-${GL_COMMIT}-${GL_COMMIT}
.endif

# If the distname is not extracting into a specific subdirectory, have the
# ports framework force extract into a subdirectory so that metadata files
# do not get in the way of the build, and vice-versa.
.if defined(NO_WRKSUBDIR)
# Some ports have DISTNAME=PORTNAME, and USE_RC_SUBR=PORTNAME, in those case,
# the rc file will conflict with WRKSRC, as WRKSRC is artificial, make it the
# most unlikely to conflict as we can.
WRKSRC?=			${WRKDIR}/${PKGNAME}
EXTRACT_WRKDIR:=		${WRKSRC}
.else
WRKSRC?=		${WRKDIR}/${DISTNAME}
EXTRACT_WRKDIR:=		${WRKDIR}
.endif
.if defined(WRKSRC_SUBDIR)
WRKSRC:=		${WRKSRC}/${WRKSRC_SUBDIR}
.endif

.if defined(CONFIGURE_OUTSOURCE)
CONFIGURE_CMD?=		${WRKSRC}/${CONFIGURE_SCRIPT}
CONFIGURE_WRKSRC?=	${WRKDIR}/.build
BUILD_WRKSRC?=		${CONFIGURE_WRKSRC}
INSTALL_WRKSRC?=	${CONFIGURE_WRKSRC}
TEST_WRKSRC?=		${CONFIGURE_WRKSRC}
.endif

PATCH_WRKSRC?=	${WRKSRC}
CONFIGURE_WRKSRC?=	${WRKSRC}
BUILD_WRKSRC?=	${WRKSRC}
INSTALL_WRKSRC?=${WRKSRC}
TEST_WRKSRC?=	${WRKSRC}

PLIST_SUB+=	OSREL=${OSREL} PREFIX=%D LOCALBASE=${LOCALBASE} \
			RESETPREFIX=${PREFIX}
SUB_LIST+=	PREFIX=${PREFIX} LOCALBASE=${LOCALBASE} \
		DATADIR=${DATADIR} DOCSDIR=${DOCSDIR} EXAMPLESDIR=${EXAMPLESDIR} \
		WWWDIR=${WWWDIR} ETCDIR=${ETCDIR}
# This is used for check-stagedir.sh and check_leftover.sh to replace
# directories/files with PLIST_SUB %%KEYS%%.
# Remove VARS which values are PLIST_SUB_SED_MIN long or shorter
PLIST_SUB_SED_MIN?=	2
PLIST_SUB_SED_tmp1= ${PLIST_SUB:C/.*=.{1,${PLIST_SUB_SED_MIN}}$//g}
#  Remove VARS that are too generic
#  Remove empty values
#  Remove @comment values
PLIST_SUB_SED_tmp2= ${PLIST_SUB_SED_tmp1:NEXTRACT_SUFX=*:NOSREL=*:NLIB32DIR=*:NPREFIX=*:NLOCALBASE=*:NRESETPREFIX=*:N*="":N*="@comment*}
#  Handle VARS for which there is a _regex entry
PLIST_SUB_SED_tmp3?= ${PLIST_SUB_SED_tmp2:C/(${PLIST_SUB:M*_regex=*:C/_regex=.*/=.*/:Q:S/\\ /|/g:S/\\//g})//:C/(.*)_regex=(.*)/\1=\2/}
#  Remove quotes
#  Replace . with \. for later sed(1) usage
PLIST_SUB_SED?= ${PLIST_SUB_SED_tmp3:C/([^=]*)="?([^"]*)"?/s!\2!%%\1%%!g;/g:C/\./\\./g}

# kludge to strip trailing whitespace from CFLAGS;
# sub-configure will not # survive double space
CFLAGS:=	${CFLAGS:C/ $//}

.if defined(WITHOUT_CPU_CFLAGS)
.if defined(_CPUCFLAGS)
.if !empty(_CPUCFLAGS)
CFLAGS:=	${CFLAGS:C/${_CPUCFLAGS}//}
.endif
.endif
.endif

# Reset value from bsd.own.mk.
.if defined(WITH_DEBUG)
.if !defined(INSTALL_STRIPPED)
STRIP=	#none
MAKE_ENV+=	DONTSTRIP=yes
STRIP_CMD=	${TRUE}
.endif
DEBUG_FLAGS?=	-g
CFLAGS:=		${CFLAGS:N-O*:N-fno-strict*} ${DEBUG_FLAGS}
.if defined(INSTALL_TARGET)
INSTALL_TARGET:=	${INSTALL_TARGET:S/^install-strip$/install/g}
.endif
.endif

.if !defined(WITHOUT_SSP)
.include "${PORTSDIR}/Mk/bsd.ssp.mk"
.endif

# XXX PIE support to be added here
MAKE_ENV+=	NO_PIE=yes
# We will control debug files.  Don't let builds that use /usr/share/mk
# split out debug symbols since the plist won't know to expect it.
MAKE_ENV+=	MK_DEBUG_FILES=no
MAKE_ENV+=	MK_KERNEL_SYMBOLS=no

CONFIGURE_SHELL?=	${SH}
MAKE_SHELL?=	${SH}

CONFIGURE_ENV+=	SHELL=${CONFIGURE_SHELL} CONFIG_SHELL=${CONFIGURE_SHELL}
MAKE_ENV+=		SHELL=${MAKE_SHELL} NO_LINT=YES

.if defined(PATCHFILES) && ${PATCHFILES:M*.zip}
PATCH_DEPENDS+=		${LOCALBASE}/bin/unzip:archivers/unzip
.endif

# Check the compatibility layer for amd64/ia64

.if ${ARCH} == "amd64" || ${ARCH} =="ia64"
.if exists(/usr/lib32)
HAVE_COMPAT_IA32_LIBS?=  YES
.endif
.if !defined(HAVE_COMPAT_IA32_KERN)
HAVE_COMPAT_IA32_KERN!= if ${SYSCTL} -n compat.ia32.maxvmem >/dev/null 2>&1; then echo YES; fi; echo
.if empty(HAVE_COMPAT_IA32_KERN)
.undef HAVE_COMPAT_IA32_KERN
.endif
.endif
.endif
_EXPORTED_VARS+=	HAVE_COMPAT_IA32_KERN

.if defined(IA32_BINARY_PORT) && ${ARCH} != "i386"
.if ${ARCH} == "amd64" || ${ARCH} == "ia64"
.if !defined(HAVE_COMPAT_IA32_KERN)
IGNORE=		requires a kernel with compiled-in IA32 compatibility
.elif !defined(HAVE_COMPAT_IA32_LIBS)
IGNORE=		requires 32-bit libraries installed under /usr/lib32
.endif
_LDCONFIG_FLAGS=-32
LIB32DIR=	lib32
.else
IGNORE=		requires i386 (or compatible) platform to run
.endif
.else
LIB32DIR=	lib
.endif
PLIST_SUB+=	LIB32DIR=${LIB32DIR}

.if ${WITH_PKG} == devel
PKG_ORIGIN=		ports-mgmt/pkg-devel
.endif

.if !defined(PKG_DEPENDS) && !defined(CLEAN_FETCH_ENV)
PKG_DEPENDS+=	${LOCALBASE}/sbin/pkg:${PKG_ORIGIN}
.endif

.if defined(USE_GCC)
.include "${PORTSDIR}/Mk/bsd.gcc.mk"
.endif

.if defined(LLD_UNSAFE) && ${/usr/bin/ld:L:tA} == /usr/bin/ld.lld
LDFLAGS+=	-fuse-ld=bfd
BINARY_ALIAS+=	ld=${LD}
.  if !defined(USE_BINUTILS)
.    if exists(/usr/bin/ld.bfd)
LD=	/usr/bin/ld.bfd
CONFIGURE_ENV+=	LD=${LD}
MAKE_ENV+=	LD=${LD}
.    else
USE_BINUTILS=	yes
.    endif
.  endif
.endif

.if defined(USE_BINUTILS) && !defined(DISABLE_BINUTILS)
BUILD_DEPENDS+=	${LOCALBASE}/bin/as:devel/binutils
BINUTILS?=	ADDR2LINE AR AS CPPFILT GPROF LD NM OBJCOPY OBJDUMP RANLIB \
	READELF SIZE STRINGS
BINUTILS_NO_MAKE_ENV?=
. for b in ${BINUTILS}
${b}=	${LOCALBASE}/bin/${b:C/PP/++/:tl}
.  if defined(GNU_CONFIGURE) || defined(BINUTILS_CONFIGURE)
CONFIGURE_ENV+=	${b}="${${b}}"
.  endif
.  if ${BINUTILS_NO_MAKE_ENV:M${b}} == ""
MAKE_ENV+=	${b}="${${b}}"
.  endif
. endfor
.endif

.if defined(USE_OPENLDAP) || defined(WANT_OPENLDAP_VER)
.include "${PORTSDIR}/Mk/bsd.ldap.mk"
.endif

.if defined(USE_RC_SUBR)
SUB_FILES+=	${USE_RC_SUBR}
.endif

.if defined(USE_LDCONFIG) && ${USE_LDCONFIG:tl} == "yes"
USE_LDCONFIG=	${PREFIX}/lib
.endif
.if defined(USE_LDCONFIG32) && ${USE_LDCONFIG32:tl} == "yes"
IGNORE=			has USE_LDCONFIG32 set to yes, which is not correct
.endif

PKG_IGNORE_DEPENDS?=		'this_port_does_not_exist'

.if defined(_DESTDIR_VIA_ENV)
MAKE_ENV+=	${DESTDIRNAME}=${STAGEDIR}
.else
MAKE_ARGS+=	${DESTDIRNAME}=${STAGEDIR}
.endif

.if defined(NO_PREFIX_RMDIR)
CO_ENV+=	NO_PREFIX_RMDIR=1
.else
CO_ENV+=	NO_PREFIX_RMDIR=0
.endif


METADIR=		${WRKDIR}/.metadir

PKGPREINSTALL?=		${PKGDIR}/pkg-pre-install
PKGPOSTINSTALL?=	${PKGDIR}/pkg-post-install
PKGPREDEINSTALL?=	${PKGDIR}/pkg-pre-deinstall
PKGPOSTDEINSTALL?=	${PKGDIR}/pkg-post-deinstall
PKGPREUPGRADE?=		${PKGDIR}/pkg-pre-upgrade
PKGPOSTUPGRADE?=	${PKGDIR}/pkg-post-upgrade
PKGUPGRADE?=		${PKGDIR}/pkg-upgrade

_FORCE_POST_PATTERNS=	rmdir kldxref mkfontscale mkfontdir fc-cache \
						fonts.dir fonts.scale gtk-update-icon-cache \
						gio-querymodules \
						gtk-query-immodules \
						ldconfig \
						load-octave-pkg \
						ocamlfind \
						update-desktop-database update-mime-database \
						gdk-pixbuf-query-loaders catalog.ports \
						glib-compile-schemas \
						ccache-update-links

.if defined(USE_LOCAL_MK)
.include "${PORTSDIR}/Mk/bsd.local.mk"
.endif

.if defined(USE_XORG) || defined(XORG_CAT)
.include "${PORTSDIR}/Mk/bsd.xorg.mk"
.endif

.if defined(WANT_GSTREAMER) || defined(USE_GSTREAMER) || defined(USE_GSTREAMER1)
.include "${PORTSDIR}/Mk/bsd.gstreamer.mk"
.endif

.if defined(USE_JAVA)
.include "${PORTSDIR}/Mk/bsd.java.mk"
.endif

.if defined(USE_OCAML)
.include "${PORTSDIR}/Mk/bsd.ocaml.mk"
.endif

.if defined(USE_SDL)
.include "${PORTSDIR}/Mk/bsd.sdl.mk"
.endif

.if defined(USE_PHP) && (!defined(USES) || ( defined(USES) && !${USES:Mphp*} ))
DEV_WARNING+=		"Using USE_PHP alone is deprecated, please use USES=php"
_USES_POST+=	php
.endif

.if defined(USE_WX) || defined(USE_WX_NOT)
.include "${PORTSDIR}/Mk/bsd.wx.mk"
.endif

.if defined(USE_GECKO)
.include "${PORTSDIR}/Mk/bsd.gecko.mk"
.endif

.if exists(${PORTSDIR}/Makefile.inc)
.include "${PORTSDIR}/Makefile.inc"
USE_SUBMAKE=	yes
.endif

# Loading features
.for f in ${_USES_POST}
_f:=		${f:C/\:.*//}
.if !defined(${_f}_ARGS)
${_f}_ARGS:=	${f:C/^[^\:]*(\:|\$)//:S/,/ /g}
.endif
.endfor
.for f in ${_USES_POST}
.include "${USESDIR}/${f:C/\:.*//}.mk"
.endfor

.if defined(PORTNAME)
.include "${PORTSDIR}/Mk/bsd.sanity.mk"
.endif

.if defined(USE_LOCALE)
CONFIGURE_ENV+=	LANG=${USE_LOCALE} LC_ALL=${USE_LOCALE}
MAKE_ENV+=		LANG=${USE_LOCALE} LC_ALL=${USE_LOCALE}
.endif

.if defined(USE_XORG)
# Add explicit X options to avoid problems with false positives in configure
.if defined(GNU_CONFIGURE)
CONFIGURE_ARGS+=--x-libraries=${LOCALBASE}/lib --x-includes=${LOCALBASE}/include
.endif
.endif

# Macro for doing in-place file editing using regexps
REINPLACE_ARGS?=	-i.bak
REINPLACE_CMD?=	${SED} ${REINPLACE_ARGS}

# Names of cookies used to skip already completed stages
EXTRACT_COOKIE?=	${WRKDIR}/.extract_done.${PORTNAME}.${PREFIX:S/\//_/g}
CONFIGURE_COOKIE?=	${WRKDIR}/.configure_done.${PORTNAME}.${PREFIX:S/\//_/g}
INSTALL_COOKIE?=	${WRKDIR}/.install_done.${PORTNAME}.${PREFIX:S/\//_/g}
BUILD_COOKIE?=		${WRKDIR}/.build_done.${PORTNAME}.${PREFIX:S/\//_/g}
PATCH_COOKIE?=		${WRKDIR}/.patch_done.${PORTNAME}.${PREFIX:S/\//_/g}
PACKAGE_COOKIE?=	${WRKDIR}/.package_done.${PORTNAME}.${PREFIX:S/\//_/g}
STAGE_COOKIE?=		${WRKDIR}/.stage_done.${PORTNAME}.${PREFIX:S/\//_/g}

# How to do nothing.  Override if you, for some strange reason, would rather
# do something.
DO_NADA?=		${TRUE}

# Use this as the first operand to always build dependency.
NONEXISTENT?=	/nonexistent

CHECKSUM_ALGORITHMS?= sha256

DISTINFO_FILE?=		${MASTERDIR}/distinfo

MAKE_FLAGS?=	-f
MAKEFILE?=		Makefile
MAKE_CMD?=		${BSDMAKE}
MAKE_ENV+=		PREFIX=${PREFIX} \
			LOCALBASE=${LOCALBASE} \
			CC="${CC}" CFLAGS="${CFLAGS}" \
			CPP="${CPP}" CPPFLAGS="${CPPFLAGS}" \
			LDFLAGS="${LDFLAGS}" LIBS="${LIBS}" \
			CXX="${CXX}" CXXFLAGS="${CXXFLAGS}" \
			MANPREFIX="${MANPREFIX}"

# Add -fno-strict-aliasing to CFLAGS with optimization level -O2 or higher.
# gcc 4.x enable strict aliasing optimization with -O2 which is known to break
# a lot of ports.
.if !defined(WITHOUT_NO_STRICT_ALIASING)
.if ${CC} != "icc"
.if empty(CFLAGS:M-fno-strict-aliasing)
CFLAGS+=       -fno-strict-aliasing
.endif
.endif
.endif

.for lang in C CXX
.if defined(USE_${lang}STD)
${lang}FLAGS:=	${${lang}FLAGS:N-std=*} -std=${USE_${lang}STD}
.endif

${lang}FLAGS+=	${${lang}FLAGS_${ARCH}}
.endfor

LDFLAGS+=	${LDFLAGS_${ARCH}}

# Multiple make jobs support
.if defined(DISABLE_MAKE_JOBS) || defined(MAKE_JOBS_UNSAFE)
_MAKE_JOBS?=		#
MAKE_JOBS_NUMBER=	1
.else
.if defined(MAKE_JOBS_NUMBER)
_MAKE_JOBS_NUMBER:=	${MAKE_JOBS_NUMBER}
.else
.if !defined(_SMP_CPUS)
_SMP_CPUS!=		${SYSCTL} -n kern.smp.cpus
.endif
_EXPORTED_VARS+=	_SMP_CPUS
_MAKE_JOBS_NUMBER=	${_SMP_CPUS}
.endif
.if defined(MAKE_JOBS_NUMBER_LIMIT) && ( ${MAKE_JOBS_NUMBER_LIMIT} < ${_MAKE_JOBS_NUMBER} )
MAKE_JOBS_NUMBER=	${MAKE_JOBS_NUMBER_LIMIT}
.else
MAKE_JOBS_NUMBER=	${_MAKE_JOBS_NUMBER}
.endif
_MAKE_JOBS?=		-j${MAKE_JOBS_NUMBER}
BUILD_FAIL_MESSAGE+=	Try to set MAKE_JOBS_UNSAFE=yes and rebuild before reporting the failure to the maintainer.
.endif

.include "${PORTSDIR}/Mk/bsd.ccache.mk"

.if !make(makesum)
FETCH_ENV?=		SSL_NO_VERIFY_PEER=1 SSL_NO_VERIFY_HOSTNAME=1
.endif
FETCH_BINARY?=	/usr/bin/fetch
FETCH_ARGS?=	-Fpr
FETCH_REGET?=	1
FETCH_CMD?=		${FETCH_BINARY} ${FETCH_ARGS}

.if defined(RANDOMIZE_MASTER_SITES)
.if exists(/usr/games/random)
RANDOM_CMD?=	/usr/games/random
.elif exists(/usr/bin/random)
RANDOM_CMD?=	/usr/bin/random
.endif
.if defined(RANDOM_CMD) && !empty(RANDOM_CMD)
RANDOM_ARGS?=	-w -f -
_RANDOMIZE_SITES=	 ${RANDOM_CMD} ${RANDOM_ARGS}
.endif
.endif

TOUCH?=			/usr/bin/touch
TOUCH_FLAGS?=	-f

DISTORIG?=	.bak.orig
PATCH?=			/usr/bin/patch
PATCH_STRIP?=	-p0
PATCH_DIST_STRIP?=	-p0
.if defined(PATCH_DEBUG)
PATCH_DEBUG_TMP=	yes
PATCH_ARGS?=	--forward -E ${PATCH_STRIP}
PATCH_DIST_ARGS?=	--suffix ${DISTORIG} --forward -E ${PATCH_DIST_STRIP}
.else
PATCH_ARGS?=	--forward --quiet -E ${PATCH_STRIP}
PATCH_DIST_ARGS?=	--suffix ${DISTORIG} --forward --quiet -E ${PATCH_DIST_STRIP}
.endif
.if !defined(QUIET)
PATCH_SILENT=		PATCH_SILENT=yes
.endif
.if defined(BATCH)
PATCH_ARGS+=		--batch
PATCH_DIST_ARGS+=	--batch
.endif

# Prevent breakage with VERSION_CONTROL=numbered
PATCH_ARGS+=	-V simple
PATCH_DIST_ARGS+=		-V simple

.if defined(PATCH_CHECK_ONLY)
PATCH_ARGS+=	-C
PATCH_DIST_ARGS+=	-C
.endif

.if ${PATCH} == "/usr/bin/patch"
PATCH_ARGS+=	--suffix .orig
PATCH_DIST_ARGS+=	--suffix .orig
.endif

TAR?=	/usr/bin/tar

# EXTRACT_SUFX is defined in .pre.mk section
EXTRACT_CMD?=	${TAR}
EXTRACT_BEFORE_ARGS?=	-xf
EXTRACT_AFTER_ARGS?=	--no-same-owner --no-same-permissions

# Figure out where the local mtree file is
.if !defined(MTREE_FILE) && !defined(NO_MTREE)
.if ${PREFIX} == /usr
MTREE_FILE=	/etc/mtree/BSD.usr.dist
.else
MTREE_FILE=	${PORTSDIR}/Templates/BSD.local.dist
.endif
.endif
MTREE_CMD?=	/usr/sbin/mtree
MTREE_ARGS?=	-U ${MTREE_FOLLOWS_SYMLINKS} -f ${MTREE_FILE} -d -e -p

_SHAREMODE?=	0644

# A few aliases for *-install targets
INSTALL_PROGRAM=	${INSTALL} ${COPY} ${STRIP} -m ${BINMODE}
INSTALL_KLD=	${INSTALL} ${COPY} -m ${BINMODE}
INSTALL_LIB=	${INSTALL} ${COPY} ${STRIP} -m ${_SHAREMODE}
INSTALL_SCRIPT=	${INSTALL} ${COPY} -m ${BINMODE}
INSTALL_DATA=	${INSTALL} ${COPY} -m ${_SHAREMODE}
INSTALL_MAN=	${INSTALL} ${COPY} -m ${MANMODE}

INSTALL_MACROS=	BSD_INSTALL_PROGRAM="${INSTALL_PROGRAM}" \
			BSD_INSTALL_LIB="${INSTALL_LIB}" \
			BSD_INSTALL_SCRIPT="${INSTALL_SCRIPT}" \
			BSD_INSTALL_DATA="${INSTALL_DATA}" \
			BSD_INSTALL_MAN="${INSTALL_MAN}"
MAKE_ENV+=	${INSTALL_MACROS}
SCRIPTS_ENV+=	${INSTALL_MACROS}

# Macro for copying entire directory tree with correct permissions
# In the -exec shell commands, we add add a . as the first argument, it would
# end up being $0 aka the script name, which is not part of $@, so we force it
# to be able to use $@ directly.
COPYTREE_BIN=	${SH} -c '(${FIND} -Ed $$1 $$3 | ${CPIO} -dumpl $$2 >/dev/null 2>&1) && \
						   ${FIND} -Ed $$1 $$3 \(   -type d -exec ${SH} -c '\''cd '\''$$2'\'' && chmod 755 "$$@"'\'' . {} + \
												 -o -type f -exec ${SH} -c '\''cd '\''$$2'\'' && chmod ${BINMODE} "$$@"'\'' . {} + \)' COPYTREE_BIN
COPYTREE_SHARE=	${SH} -c '(${FIND} -Ed $$1 $$3 | ${CPIO} -dumpl $$2 >/dev/null 2>&1) && \
						   ${FIND} -Ed $$1 $$3 \(   -type d -exec ${SH} -c '\''cd '\''$$2'\'' && chmod 755 "$$@"'\'' . {} + \
												 -o -type f -exec ${SH} -c '\''cd '\''$$2'\'' && chmod ${_SHAREMODE} "$$@"'\'' . {} + \)' COPYTREE_SHARE

# The user can override the NO_PACKAGE by specifying this from
# the make command line
.if defined(FORCE_PACKAGE)
.undef NO_PACKAGE
.endif

DESCR?=			${PKGDIR}/pkg-descr
PLIST?=			${PKGDIR}/pkg-plist
PKGHELP?=		${PKGDIR}/pkg-help
PKGINSTALL?=	${PKGDIR}/pkg-install
PKGDEINSTALL?=	${PKGDIR}/pkg-deinstall
PKGMESSAGE?=	${PKGDIR}/pkg-message
_PKGMESSAGES+=	${PKGMESSAGE}

TMPPLIST?=	${WRKDIR}/.PLIST.mktmp

.if defined(PKG_NOCOMPRESS)
PKG_SUFX?=		.tar
.else
PKG_SUFX?=		.txz
.endif
# where pkg(8) stores its data
PKG_DBDIR?=		/var/db/pkg

ALL_TARGET?=		all
INSTALL_TARGET?=	install
INSTALL_TARGET+=	${LATE_INSTALL_ARGS}

# Integrate with the license auditing framework
.if !defined (DISABLE_LICENSES)
.include "${PORTSDIR}/Mk/bsd.licenses.mk"
.endif

# Popular master sites
.include "${PORTSDIR}/Mk/bsd.sites.mk"

# Empty declaration to avoid "variable MASTER_SITES recursive" error
MASTER_SITES?=
PATCH_SITES?=
_MASTER_SITES_DEFAULT?=
_PATCH_SITES_DEFAULT?=

# Feed internal _{MASTER,PATCH}_SITES_n where n is a group designation
# as per grouping rules (:something)
# Organize _{MASTER,PATCH}_SITES_{DEFAULT,[^/:]+} according to grouping
# rules (:something)
.for _S in ${MASTER_SITES}
_S_TEMP=	${_S:S/^${_S:C@/?:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
_G_TEMP=	${_group}
.			if ${_G_TEMP:C/[a-zA-Z0-9_]//g}
check-makevars::
				@${ECHO_MSG} "The ${_S} MASTER_SITES line has"
				@${ECHO_MSG} "a group with invalid characters, only use [a-zA-Z0-9_]"
				@${FALSE}
.			endif
.			if ${_G_TEMP} == all || ${_G_TEMP} == ALL || ${_G_TEMP} == default
check-makevars::
				@${ECHO_MSG} "Makefile error: the words all, ALL and default are reserved and cannot be"
				@${ECHO_MSG} "used in group definitions. Please fix your MASTER_SITES"
				@${FALSE}
.			endif
_MASTER_SITES_${_group}+=	${_S:C@^(.*/):[^/:]+$@\1@}
.		endfor
.	else
_MASTER_SITES_DEFAULT+=	${_S:C@^(.*/):[^/:]+$@\1@}
.	endif
.endfor
.for _S in ${PATCH_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
_G_TEMP=	${_group}
.			if ${_G_TEMP:C/[a-zA-Z0-9_]//g}
check-makevars::
				@${ECHO_MSG} "The ${_S} PATCH_SITES line has"
				@${ECHO_MSG} "a group with invalid characters, only use [a-zA-Z0-9_]"
				@${FALSE}
.			endif
.			if ${_G_TEMP} == all || ${_G_TEMP} == ALL || ${_G_TEMP} == default
check-makevars::
				@${ECHO_MSG} "The words all, ALL and default are reserved and cannot be"
				@${ECHO_MSG} "used in group definitions. Please fix your PATCH_SITES"
				@${FALSE}
.			endif
_PATCH_SITES_${_group}+=	${_S:C@^(.*/):[^/:]+$@\1@}
.		endfor
.	else
_PATCH_SITES_DEFAULT+=	${_S:C@^(.*/):[^/:]+$@\1@}
.	endif
.endfor

# Feed internal _{MASTER,PATCH}_SITE_SUBDIR_n where n is a group designation
# as per grouping rules (:something)
# Organize _{MASTER,PATCH}_SITE_SUBDIR_{DEFAULT,[^/:]+} according to grouping
# rules (:something)
.for _S in ${MASTER_SITE_SUBDIR}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
_G_TEMP=	${_group}
.			if ${_G_TEMP} == all || ${_G_TEMP} == ALL || ${_G_TEMP} == default
check-makevars::
				@${ECHO_MSG} "Makefile error: the words all, ALL and default are reserved and cannot be"
				@${ECHO_MSG} "used in group definitions. Please fix your MASTER_SITE_SUBDIR"
				@${FALSE}
.			endif
.			if defined(_MASTER_SITES_${_group})
_MASTER_SITE_SUBDIR_${_group}+= ${_S:C@^(.*)/:[^/:]+$@\1@}
.			endif
.		endfor
.	else
.		if defined(_MASTER_SITES_DEFAULT)
_MASTER_SITE_SUBDIR_DEFAULT+=	${_S:C@^(.*)/:[^/:]+$@\1@}
.		endif
.	endif
.endfor
.for _S in ${PATCH_SITE_SUBDIR}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
_G_TEMP=	${_group}
.			if ${_G_TEMP} == all || ${_G_TEMP} == ALL || ${_G_TEMP} == default
check-makevars::
				@${ECHO_MSG} "Makefile error: the words all, ALL and default are reserved and cannot be"
				@${ECHO_MSG} "used in group definitions. Please fix your PATCH_SITE_SUBDIR"
				@${FALSE}
.			endif
.			if defined(_PATCH_SITES_${_group})
_PATCH_SITE_SUBDIR_${_group}+= ${_S:C@^(.*)/:[^/:]+$@\1@}
.			endif
.		endfor
.	else
.		if defined(_PATCH_SITES_DEFAULT)
_PATCH_SITE_SUBDIR_DEFAULT+=	${_S:C@^(.*)/:[^/:]+$@\1@}
.		endif
.	endif
.endfor

# Substitute subdirectory names
# XXX simpler/faster solution but not the best space wise, suggestions please
.for _S in ${MASTER_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
.			if !defined(_MASTER_SITE_SUBDIR_${_group})
MASTER_SITES_TMP=	${_MASTER_SITES_${_group}:S^%SUBDIR%/^^}
.			else
_S_TEMP_TEMP=		${_MASTER_SITES_${_group}:M*%SUBDIR%/*}
.				if empty(_S_TEMP_TEMP)
MASTER_SITES_TMP=	${_MASTER_SITES_${_group}}
.				else
MASTER_SITES_TMP=
.					for site in ${_MASTER_SITES_${_group}}
_S_TEMP_TEMP=	${site:M*%SUBDIR%/*}
.						if empty(_S_TEMP_TEMP)
MASTER_SITES_TMP+=	${site}
.						else
.							for dir in ${_MASTER_SITE_SUBDIR_${_group}}
MASTER_SITES_TMP+=	${site:S^%SUBDIR%^\${dir}^}
.							endfor
.						endif
.					endfor
.				endif
.			endif
_MASTER_SITES_${_group}:=	${MASTER_SITES_TMP}
.		endfor
.	endif
.endfor
.if defined(_MASTER_SITE_SUBDIR_DEFAULT)
_S_TEMP=	${_MASTER_SITES_DEFAULT:M*%SUBDIR%/*}
.	if empty(_S_TEMP)
MASTER_SITES_TMP=	${_MASTER_SITES_DEFAULT}
.	else
MASTER_SITES_TMP=
.		for site in ${_MASTER_SITES_DEFAULT}
_S_TEMP_TEMP=		${site:M*%SUBDIR%/*}
.			if empty(_S_TEMP_TEMP)
MASTER_SITES_TMP+=	${site}
.			else
.				for dir in ${_MASTER_SITE_SUBDIR_DEFAULT}
MASTER_SITES_TMP+=	${site:S^%SUBDIR%^\${dir}^}
.				endfor
.			endif
.		endfor
.	endif
.else
MASTER_SITES_TMP=	${_MASTER_SITES_DEFAULT:S^%SUBDIR%/^^}
.endif
_MASTER_SITES_DEFAULT:=	${MASTER_SITES_TMP}
MASTER_SITES_TMP=
.for _S in ${PATCH_SITES}
_S_TEMP=	${_S:S/^${_S:C@/:[^/:]+$@/@}//:S/^://}
.	if !empty(_S_TEMP)
.		for _group in ${_S_TEMP:S/,/ /g}
.			if !defined(_PATCH_SITE_SUBDIR_${_group})
PATCH_SITES_TMP=	${_PATCH_SITES_${_group}:S^%SUBDIR%/^^}
.			else
_S_TEMP_TEMP=		${_PATCH_SITES_${_group}:M*%SUBDIR%/*}
.				if empty(_S_TEMP_TEMP)
PATCH_SITES_TMP=	${_PATCH_SITES_${_group}}
.				else
PATCH_SITES_TMP=
.					for site in ${_PATCH_SITES_${_group}}
_S_TEMP_TEMP=	${site:M*%SUBDIR%/*}
.						if empty(_S_TEMP_TEMP)
PATCH_SITES_TMP+=	${site}
.						else
.							for dir in ${_PATCH_SITE_SUBDIR_${_group}}
PATCH_SITES_TMP+=	${site:S^%SUBDIR%^\${dir}^}
.							endfor
.						endif
.					endfor
.				endif
.			endif
_PATCH_SITES_${_group}:=	${PATCH_SITES_TMP}
.		endfor
.	endif
.endfor
.if defined(_PATCH_SITE_SUBDIR_DEFAULT)
_S_TEMP=	${_PATCH_SITES_DEFAULT:M*%SUBDIR%/*}
.	if empty(_S_TEMP)
PATCH_SITES_TMP=	${_PATCH_SITES_DEFAULT}
.	else
PATCH_SITES_TMP=
.		for site in ${_PATCH_SITES_DEFAULT}
_S_TEMP_TEMP=		${site:M*%SUBDIR%/*}
.			if empty(_S_TEMP_TEMP)
PATCH_SITES_TMP+=	${site}
.			else
.				for dir in ${_PATCH_SITE_SUBDIR_DEFAULT}
PATCH_SITES_TMP+=	${site:S^%SUBDIR%^\${dir}^}
.				endfor
.			endif
.		endfor
.	endif
.else
PATCH_SITES_TMP=	${_PATCH_SITES_DEFAULT:S^%SUBDIR%/^^}
.endif
_PATCH_SITES_DEFAULT:=	${PATCH_SITES_TMP}
PATCH_SITES_TMP=

# The primary backup site.
MASTER_SITE_BACKUP?=	\
	http://distcache.FreeBSD.org/ports-distfiles/${DIST_SUBDIR}/
MASTER_SITE_BACKUP:=	${MASTER_SITE_BACKUP:S^\${DIST_SUBDIR}/^^}

# If the user has MASTER_SITE_FREEBSD set, go to the FreeBSD repository
# for everything, but don't search it twice by appending it to the end.
.if defined(MASTER_SITE_FREEBSD)
_MASTER_SITE_OVERRIDE:=	${MASTER_SITE_BACKUP}
_MASTER_SITE_BACKUP:=	# empty
.else
_MASTER_SITE_OVERRIDE=	${MASTER_SITE_OVERRIDE}
_MASTER_SITE_BACKUP=	${MASTER_SITE_BACKUP}
.endif

NOFETCHFILES?=

# Organize DISTFILES, PATCHFILES, _MASTER_SITES_ALL, _PATCH_SITES_ALL
# according to grouping rules (:something)
DISTFILES?=		${DISTNAME}${EXTRACT_SUFX}
_MASTER_SITES_ALL=	${_MASTER_SITES_DEFAULT}
_PATCH_SITES_ALL=	${_PATCH_SITES_DEFAULT}
_G_TEMP=	DEFAULT
.for _D in ${DISTFILES}
_D_TEMP=	${_D:S/^${_D:C/:[^:]+$//}//}
.	if !empty(_D_TEMP)
.		for _group in ${_D_TEMP:S/^://:S/,/ /g}
.			if !defined(_MASTER_SITES_${_group})
_G_TEMP_TEMP=	${_G_TEMP:M/${_group}/}
.				if empty(_G_TEMP_TEMP)
_G_TEMP+=	${_group}
_MASTER_SITES_ALL+=	${_MASTER_SITES_${_group}}
.				endif
.			endif
.		endfor
_DISTFILES+=	${_D:C/:[^:]+$//}
.	else
_DISTFILES+=	${_D}
.	endif
.endfor
_G_TEMP=	DEFAULT
.for _P in ${PATCHFILES}
_P_TEMP=	${_P:C/:[^-:][^:]*$//}
_P_groups=	${_P:S/^${_P:C/:[^:]+$//}//:S/^://}
_P_file=	${_P_TEMP:C/:-[^:]+$//}
_P_strip=	${_P_TEMP:S/^${_P_TEMP:C/:-[^:]*$//}//:S/^://}
.	if !empty(_P_groups)
.		for _group in ${_P_groups:S/,/ /g}
.			if !defined(_PATCH_SITES_${_group})
_G_TEMP_TEMP=	${_G_TEMP:M/${_group}/}
.				if empty(_G_TEMP_TEMP)
_G_TEMP+=	${_group}
_PATCH_SITES_ALL+=	${_PATCH_SITES_${_group}}
.				endif
.			endif
.		endfor
.	endif
_PATCHFILES:=	${_PATCHFILES} ${_P_file}
.	if empty(_P_strip)
_PATCHFILES2:=	${_PATCHFILES2} ${_P_file}
.	else
_PATCHFILES2:=	${_PATCHFILES2} ${_P_file}:${_P_strip}
.	endif
.endfor
_P_groups=
_P_file=
_P_strip=
_G_TEMP=
_G_TEMP_TEMP=
ALLFILES?=	${_DISTFILES} ${_PATCHFILES}

#
# Sort the master site list according to the patterns in MASTER_SORT
#
MASTER_SORT?=
MASTER_SORT_REGEX?=
MASTER_SORT_REGEX+=	${MASTER_SORT:S|.|\\.|g:S|^|://[^/]*|:S|$|/|}

MASTER_SORT_AWK=	BEGIN { RS = " "; ORS = " "; IGNORECASE = 1 ; gl = "${MASTER_SORT_REGEX:S|\\|\\\\|g}"; }
.for srt in ${MASTER_SORT_REGEX}
MASTER_SORT_AWK+=	/${srt:S|/|\\/|g}/ { good["${srt:S|\\|\\\\|g}"] = good["${srt:S|\\|\\\\|g}"] " " $$0 ; next; }
.endfor
MASTER_SORT_AWK+=	{ rest = rest " " $$0; } END { n=split(gl, gla); for(i=1;i<=n;i++) { print good[gla[i]]; } print rest; }

#
# Hackery to enable simple fetch targets with several dynamic MASTER_SITES
#
_MASTER_SITES_ENV=	_MASTER_SITES_DEFAULT=${_MASTER_SITES_DEFAULT:Q}
.for _F in ${DISTFILES}
_F_TEMP=	${_F:S/^${_F:C/:[^:]+$//}//:S/^://}
.	if !empty(_F_TEMP)
.		for _group in ${_F_TEMP:S/,/ /g}
.			if defined(_MASTER_SITES_${_group})
_MASTER_SITES_ENV+=	_MASTER_SITES_${_group}=${_MASTER_SITES_${_group}:Q}
.			endif
.		endfor
.	endif
.endfor
_PATCH_SITES_ENV=	_PATCH_SITES_DEFAULT=${_PATCH_SITES_DEFAULT:Q}
.for _F in ${PATCHFILES}
_F_TEMP=	${_F:S/^${_F:C/:[^-:][^:]*$//}//:S/^://}
.	if !empty(_F_TEMP)
.		for _group in ${_F_TEMP:S/,/ /g}
.			if defined(_PATCH_SITES_${_group})
_PATCH_SITES_ENV+=	_PATCH_SITES_${_group}=${_PATCH_SITES_${_group}:Q}
.			endif
.		endfor
.	endif
.endfor

CKSUMFILES=		${ALLFILES}

# List of all files, with ${DIST_SUBDIR} in front.  Used for checksum.
.if defined(DIST_SUBDIR)
.if defined(CKSUMFILES) && ${CKSUMFILES}!=""
_CKSUMFILES?=	${CKSUMFILES:S/^/${DIST_SUBDIR}\//}
.endif
.else
_CKSUMFILES?=	${CKSUMFILES}
.endif

# This is what is actually going to be extracted, and is overridable
#  by user.
EXTRACT_ONLY?=	${_DISTFILES}

.if !target(maintainer)
maintainer:
	@${ECHO_CMD} "${MAINTAINER}"
.endif

.if !defined(CATEGORIES)
check-categories:
	@${ECHO_MSG} "${PKGNAME}: Makefile error: CATEGORIES is mandatory."
	@${FALSE}
.else

VALID_CATEGORIES+= accessibility afterstep arabic archivers astro audio \
	benchmarks biology cad chinese comms converters databases \
	deskutils devel docs dns editors elisp emulators enlightenment finance french ftp \
	games geography german gnome gnustep graphics hamradio haskell hebrew hungarian \
	ipv6 irc japanese java kde ${_KDE_CATEGORIES_SUPPORTED} kld korean lang linux lisp \
	mail mate math mbone misc multimedia net net-im net-mgmt net-p2p news \
	palm parallel pear perl5 plan9 polish portuguese ports-mgmt \
	print python ruby rubygems russian \
	scheme science security shells spanish sysutils \
	tcl textproc tk \
	ukrainian vietnamese windowmaker wayland www \
	x11 x11-clocks x11-drivers x11-fm x11-fonts x11-servers x11-themes \
	x11-toolkits x11-wm xfce zope base

check-categories:
.for cat in ${CATEGORIES}
.	if empty(VALID_CATEGORIES:M${cat})
		@${ECHO_MSG} "${PKGNAME}: Makefile error: category ${cat} not in list of valid categories."; \
		${FALSE};
.	endif
.endfor
.endif

PKGREPOSITORYSUBDIR?=	All
PKGREPOSITORY?=		${PACKAGES}/${PKGREPOSITORYSUBDIR}
.if exists(${PACKAGES})
PACKAGES:=	${PACKAGES:S/:/\:/g}
_HAVE_PACKAGES=	yes
PKGFILE?=		${PKGREPOSITORY}/${PKGNAME}${PKG_SUFX}
.else
PKGFILE?=		${.CURDIR}/${PKGNAME}${PKG_SUFX}
.endif
WRKDIR_PKGFILE=	${WRKDIR}/pkg/${PKGNAME}${PKG_SUFX}

# The "latest version" link -- ${PKGNAME} minus everthing after the last '-'
PKGLATESTREPOSITORY?=	${PACKAGES}/Latest
PKGBASE?=			${PKGNAMEPREFIX}${PORTNAME}${PKGNAMESUFFIX}
PKGLATESTFILE=		${PKGLATESTREPOSITORY}/${PKGBASE}${PKG_SUFX}

CONFIGURE_SCRIPT?=	configure
CONFIGURE_CMD?=		./${CONFIGURE_SCRIPT}
CONFIGURE_TARGET?=	${HOSTARCH}-portbld-${OPSYS:tl}${OSREL}
CONFIGURE_TARGET:=	${CONFIGURE_TARGET:S/--build=//}
CONFIGURE_LOG?=		config.log

# A default message to print if do-configure fails.
CONFIGURE_FAIL_MESSAGE?=	"Please report the problem to ${MAINTAINER} [maintainer] and attach the \"${CONFIGURE_WRKSRC}/${CONFIGURE_LOG}\" including the output of the failure of your make command. Also, it might be a good idea to provide an overview of all packages installed on your system (e.g. a ${PKG_INFO} -Ea)."

CONFIG_SITE?=		${PORTSDIR}/Templates/config.site
.if defined(GNU_CONFIGURE)
# Maximum command line length
.if !defined(CONFIGURE_MAX_CMD_LEN)
CONFIGURE_MAX_CMD_LEN!=	${SYSCTL} -n kern.argmax
.endif
_EXPORTED_VARS+=	CONFIGURE_MAX_CMD_LEN
GNU_CONFIGURE_PREFIX?=	${PREFIX}
GNU_CONFIGURE_MANPREFIX?=	${MANPREFIX}
CONFIGURE_ARGS+=	--prefix=${GNU_CONFIGURE_PREFIX} $${_LATE_CONFIGURE_ARGS}
.if defined(CROSS_TOOLCHAIN)
CROSS_HOST=		${ARCH:S/amd64/x86_64/}-unknown-${OPSYS:tl}${OSREL}
CONFIGURE_ARGS+=	--host=${CROSS_HOST}
.endif
CONFIGURE_ENV+=		CONFIG_SITE=${CONFIG_SITE} lt_cv_sys_max_cmd_len=${CONFIGURE_MAX_CMD_LEN}
HAS_CONFIGURE=		yes

SET_LATE_CONFIGURE_ARGS= \
     _LATE_CONFIGURE_ARGS="" ; \
	if [ -z "${CONFIGURE_ARGS:M--localstatedir=*:Q}" ] && \
	   ${CONFIGURE_CMD} --help 2>&1 | ${GREP} -- --localstatedir > /dev/null; then \
	    _LATE_CONFIGURE_ARGS="$${_LATE_CONFIGURE_ARGS} --localstatedir=/var" ; \
	fi ; \
	if [ ! -z "`${CONFIGURE_CMD} --help 2>&1 | ${GREP} -- '--mandir'`" ]; then \
	    _LATE_CONFIGURE_ARGS="$${_LATE_CONFIGURE_ARGS} --mandir=${GNU_CONFIGURE_MANPREFIX}/man" ; \
	fi ; \
	if [ ! -z "`${CONFIGURE_CMD} --help 2>&1 | ${GREP} -- '--disable-silent-rules'`" ]; then \
	    _LATE_CONFIGURE_ARGS="$${_LATE_CONFIGURE_ARGS} --disable-silent-rules" ; \
	fi ; \
	if [ ! -z "`${CONFIGURE_CMD} --help 2>&1 | ${GREP} -- '--enable-jobserver\[.*\#\]'`" ]; then \
	    _LATE_CONFIGURE_ARGS="$${_LATE_CONFIGURE_ARGS} --enable-jobserver=${MAKE_JOBS_NUMBER}" ; \
	fi ; \
	if [ ! -z "`${CONFIGURE_CMD} --help 2>&1 | ${GREP} -- '--infodir'`" ]; then \
	    _LATE_CONFIGURE_ARGS="$${_LATE_CONFIGURE_ARGS} --infodir=${GNU_CONFIGURE_PREFIX}/${INFO_PATH}/${INFO_SUBDIR}" ; \
	fi ; \
	if [ -z "`${CONFIGURE_CMD} --version 2>&1 | ${EGREP} -i '(autoconf.*2\.13|Unrecognized option)'`" ]; then \
		_LATE_CONFIGURE_ARGS="$${_LATE_CONFIGURE_ARGS} --build=${CONFIGURE_TARGET}" ; \
	else \
		_LATE_CONFIGURE_ARGS="$${_LATE_CONFIGURE_ARGS} ${CONFIGURE_TARGET}" ; \
	fi ;
.endif

# Passed to most of script invocations
SCRIPTS_ENV+=	CURDIR=${MASTERDIR} DISTDIR=${DISTDIR} \
		  WRKDIR=${WRKDIR} WRKSRC=${WRKSRC} PATCHDIR=${PATCHDIR} \
		  SCRIPTDIR=${SCRIPTDIR} FILESDIR=${FILESDIR} \
		  PORTSDIR=${PORTSDIR} PREFIX=${PREFIX} LOCALBASE=${LOCALBASE}

.if defined(BATCH)
SCRIPTS_ENV+=	BATCH=yes
.endif

.if ${PREFIX} == /usr
MANPREFIX?=	/usr/share
.else
MANPREFIX?=	${PREFIX}
.endif

MANDIRS+=	${MANPREFIX}/man
.for sect in 1 2 3 4 5 6 7 8 9
MAN${sect}PREFIX?=	${MANPREFIX}
.endfor
MANLPREFIX?=	${MANPREFIX}
MANNPREFIX?=	${MANPREFIX}
INFO_PATH?=	share/info

.if defined(INFO)
RUN_DEPENDS+=	indexinfo:print/indexinfo

. for D in ${INFO:H}
RD:=	${D}
.  if ${RD} != "."
.   if !defined(INFO_SUBDIR)
INFO_SUBDIR:=	${RD}
.   elif ${INFO_SUBDIR} != ${RD}
BROKEN=		only one subdirectory in INFO is allowed
.   endif
.  endif
.undef RD
. endfor
.endif

DOCSDIR_REL?=	${DOCSDIR:S,^${PREFIX}/,,}
EXAMPLESDIR_REL?=	${EXAMPLESDIR:S,^${PREFIX}/,,}
DATADIR_REL?=	${DATADIR:S,^${PREFIX}/,,}
WWWDIR_REL?=	${WWWDIR:S,^${PREFIX}/,,}
ETCDIR_REL?=	${ETCDIR:S,^${PREFIX}/,,}

PLIST_SUB+=	DOCSDIR="${DOCSDIR_REL}" \
		EXAMPLESDIR="${EXAMPLESDIR_REL}" \
		DATADIR="${DATADIR_REL}" \
		WWWDIR="${WWWDIR_REL}" \
		ETCDIR="${ETCDIR_REL}"

DESKTOPDIR?=		${PREFIX}/share/applications

.MAIN: all

################################################################
# Many ways to disable a port.
#
# If we're in BATCH mode and the port is interactive, or we're
# in interactive mode and the port is non-interactive, skip all
# the important targets.  The reason we have two modes is that
# one might want to leave a build in BATCH mode running
# overnight, then come back in the morning and do _only_ the
# interactive ones that required your intervention.
#
# Ignore ports that can't be resold if building for a CDROM.
#
# Don't build a port if it's restricted and we don't want to get
# into that.
#
# Don't build a port if it's broken, unless we're running a parallel
# build (in case it's fixed).
#
# Don't build a port if it's forbidden for whatever reason.
#
# Don't build a port if the system is too old.
################################################################

# Check the machine architectures
.if defined(ONLY_FOR_ARCHS)
.for __ARCH in ${ONLY_FOR_ARCHS}
.if ${ARCH:M${__ARCH}} != ""
__ARCH_OK?=		1
.endif
.endfor
.else
__ARCH_OK?=		1
.endif

.if defined(NOT_FOR_ARCHS)
.for __NARCH in ${NOT_FOR_ARCHS}
.if ${ARCH:M${__NARCH}} != ""
.undef __ARCH_OK
.endif
.endfor
.endif

.if !defined(__ARCH_OK)
.if defined(ONLY_FOR_ARCHS)
IGNORE=		is only for ${ONLY_FOR_ARCHS:O},
.else # defined(NOT_FOR_ARCHS)
IGNORE=		does not run on ${NOT_FOR_ARCHS:O},
.endif
IGNORE+=	while you are running ${ARCH}

.if defined(ONLY_FOR_ARCHS_REASON_${ARCH})
IGNORE+=	(reason: ${ONLY_FOR_ARCHS_REASON_${ARCH}})
.elif defined(ONLY_FOR_ARCHS_REASON)
IGNORE+=	(reason: ${ONLY_FOR_ARCHS_REASON})
.endif

.if defined(NOT_FOR_ARCHS_REASON_${ARCH})
IGNORE+=	(reason: ${NOT_FOR_ARCHS_REASON_${ARCH}})
.elif defined(NOT_FOR_ARCHS_REASON)
IGNORE+=	(reason: ${NOT_FOR_ARCHS_REASON})
.endif

.endif

# Check the user interaction and legal issues
.if !defined(NO_IGNORE)
.if (defined(IS_INTERACTIVE) && defined(BATCH))
IGNORE=		is an interactive port
.elif (!defined(IS_INTERACTIVE) && defined(INTERACTIVE))
IGNORE=		is not an interactive port
.elif (defined(NO_CDROM) && defined(FOR_CDROM))
IGNORE=		may not be placed on a CDROM: ${NO_CDROM}
.elif (defined(RESTRICTED) && defined(NO_RESTRICTED))
IGNORE=		is restricted: ${RESTRICTED}
.elif (defined(NO_PACKAGE) && defined(PACKAGE_BUILDING))
IGNORE=		may not be packaged: ${NO_PACKAGE}
.elif defined(IGNORE_${ARCH})
IGNORE=		${IGNORE_${ARCH}}
.elif defined(IGNORE_${OPSYS}_${OSREL:R}_${ARCH})
IGNORE=		${IGNORE_${OPSYS}_${OSREL:R}_${ARCH}}
.elif defined(IGNORE_${OPSYS}_${OSREL:R})
IGNORE=		${IGNORE_${OPSYS}_${OSREL:R}}
.elif defined(IGNORE_${OPSYS})
IGNORE=		${IGNORE_${OPSYS}}
.elif defined(BROKEN)
.if !defined(TRYBROKEN)
IGNORE=		is marked as broken: ${BROKEN}
.endif
.elif defined(BROKEN_${ARCH})
.if !defined(TRYBROKEN)
IGNORE=		is marked as broken on ${ARCH}: ${BROKEN_${ARCH}}
.endif
.elif defined(BROKEN_${OPSYS}_${OSREL:R}_${ARCH})
.if !defined(TRYBROKEN)
IGNORE=		is marked as broken on ${OPSYS} ${OSREL} ${ARCH}: ${BROKEN_${OPSYS}_${OSREL:R}_${ARCH}}
.endif
.elif defined(BROKEN_${OPSYS}_${OSREL:R})
.if !defined(TRYBROKEN)
IGNORE=		is marked as broken on ${OPSYS} ${OSREL}: ${BROKEN_${OPSYS}_${OSREL:R}}
.endif
.elif defined(BROKEN_${OPSYS})
.if !defined(TRYBROKEN)
IGNORE=		is marked as broken on ${OPSYS}: ${BROKEN_${OPSYS}}
.endif
.elif defined(FORBIDDEN)
IGNORE=		is forbidden: ${FORBIDDEN}
.endif

# Define the text to be output to LEGAL
.if defined(LEGAL_TEXT)
LEGAL= ${LEGAL_TEXT}
.elif defined(RESTRICTED)
LEGAL= ${RESTRICTED}
.elif defined(NO_CDROM)
LEGAL= ${NO_CDROM}
.elif defined(NO_PACKAGE) && ! defined(LEGAL_PACKAGE)
LEGAL= ${NO_PACKAGE}
.endif

.if (defined(MANUAL_PACKAGE_BUILD) && defined(PACKAGE_BUILDING))
IGNORE=		has to be built manually: ${MANUAL_PACKAGE_BUILD}
clean:
	@${IGNORECMD}
.endif

.if defined(IGNORE)
.if defined(IGNORE_SILENT)
IGNORECMD=	${DO_NADA}
.else
IGNORECMD=	${ECHO_MSG} "===>  ${PKGNAME} "${IGNORE:Q}. | ${FMT_80} ; exit 1
.endif

_TARGETS=	check-sanity fetch checksum extract patch configure all build \
			install reinstall test package stage restage

.for target in ${_TARGETS}
.if !target(${target})
${target}:
	@${IGNORECMD}
.if defined(INSTALLS_DEPENDS)
	@${FALSE}
.endif
.endif
.endfor

.endif

.endif # !defined(NO_IGNORE)

ignorelist:
.if defined(IGNORE) || defined(NO_PACKAGE)
ignorelist: package-name
.endif

ignorelist-verbose:
.if defined(IGNORE)
	@${ECHO_CMD} "${PKGNAME}|IGNORE: "${IGNORE:Q}
.elif defined(NO_PACKAGE)
	@${ECHO_CMD} "${PKGNAME}|NO_PACKAGE: "${NO_PACKAGE:Q}
.endif

################################################################
# Clean directories for ftp or CDROM.
################################################################

.if !defined(LICENSE)

.if defined(RESTRICTED)
clean-restricted:	delete-distfiles delete-package
clean-restricted-list: delete-distfiles-list delete-package-list
RESTRICTED_FILES?=	${_DISTFILES} ${_PATCHFILES}
.else
clean-restricted:
clean-restricted-list:
.endif

.if defined(NO_CDROM)
clean-for-cdrom:	delete-distfiles delete-package
clean-for-cdrom-list:	delete-distfiles-list delete-package-list
RESTRICTED_FILES?=	${_DISTFILES} ${_PATCHFILES}
.else
clean-for-cdrom:
clean-for-cdrom-list:
.endif

.endif # !defined(LICENSE)

.if defined(ALL_HOOK)
all:
	@cd ${.CURDIR} && ${SETENV} CURDIR=${.CURDIR} DISTNAME=${DISTNAME} \
	  DISTDIR=${DISTDIR} WRKDIR=${WRKDIR} WRKSRC=${WRKSRC} \
	  PATCHDIR=${PATCHDIR} SCRIPTDIR=${SCRIPTDIR} \
	  FILESDIR=${FILESDIR} PORTSDIR=${PORTSDIR} PREFIX=${PREFIX} \
	  BUILD_DEPENDS="${BUILD_DEPENDS}" RUN_DEPENDS="${RUN_DEPENDS}" \
	  CONFLICTS="${CONFLICTS}" \
	${ALL_HOOK}
.endif

.if !target(all)
all: stage
.endif

.if !defined(DEPENDS_TARGET)
.if defined(DEPENDS_PRECLEAN)
DEPENDS_TARGET=	clean
DEPENDS_ARGS=	NOCLEANDEPENDS=yes
.endif
.if make(reinstall)
DEPENDS_TARGET+=	reinstall
.else
DEPENDS_TARGET+=	install
.endif
.if defined(DEPENDS_CLEAN)
DEPENDS_TARGET+=	clean
DEPENDS_ARGS+=	NOCLEANDEPENDS=yes
.endif
.endif

.if defined(USE_GITLAB) && !${USE_GITLAB:Mnodefault} && empty(GL_COMMIT_DEFAULT)
check-makevars::
	@${ECHO_MSG} "GL_COMMIT is a required 40 character hash for use USE_GITLAB"
	@${FALSE}
.endif

################################################################
#
# Do preliminary work to detect if we need to run the config
# target or not.
#
################################################################
.if ((!defined(OPTIONS_DEFINE) && !defined(OPTIONS_SINGLE) && !defined(OPTIONS_MULTI)) \
	&& !defined(OPTIONS_GROUP) && !defined(OPTIONS_RADIO) \
	|| defined(CONFIG_DONE_${PKGBASE:tu}) || \
	defined(PACKAGE_BUILDING) || defined(BATCH))
_OPTIONS_OK=yes
.endif

################################################################
# The following are used to create easy dummy targets for
# disabling some bit of default target behavior you don't want.
# They still check to see if the target exists, and if so don't
# do anything, since you might want to set this globally for a
# group of ports in a Makefile.inc, but still be able to
# override from an individual Makefile.
################################################################

# Disable build
.if defined(NO_BUILD) && !target(build)
build: configure
	@${TOUCH} ${TOUCH_FLAGS} ${BUILD_COOKIE}
.endif

# Disable package
.if defined(NO_PACKAGE) && !target(package)
package:
.if !defined(IGNORE_SILENT)
	@${ECHO_MSG} "===>  ${PKGNAME} may not be packaged: "${NO_PACKAGE:Q}.
.endif
.endif

################################################################
# More standard targets start here.
#
# These are the body of the build/install framework.  If you are
# not happy with the default actions, and you can't solve it by
# adding pre-* or post-* targets/scripts, override these.
################################################################

.if defined(TRYBROKEN) && defined(BROKEN)
buildanyway-message:
	@${ECHO_MSG} "Trying build of ${PKGNAME} even though it is marked BROKEN."
.endif

# Warn user about deprecated packages.  Advisory only.

.if !target(check-deprecated)
# Try and keep these messages in sync with the ones in Mk/Scripts/create-manifest.sh
check-deprecated:
.if ${MAINTAINER} == "ports@FreeBSD.org"
	@${ECHO_MSG} "===>   NOTICE:"
	@${ECHO_MSG}
	@${ECHO_MSG} "The ${PORTNAME} port currently does not have a maintainer. As a result, it is"
	@${ECHO_MSG} "more likely to have unresolved issues, not be up-to-date, or even be removed in"
	@${ECHO_MSG} "the future. To volunteer to maintain this port, please create an issue at:"
	@${ECHO_MSG}
	@${ECHO_MSG} "https://bugs.freebsd.org/bugzilla"
	@${ECHO_MSG}
	@${ECHO_MSG} "More information about port maintainership is available at:"
	@${ECHO_MSG}
	@${ECHO_MSG} "https://www.freebsd.org/doc/en/articles/contributing/ports-contributing.html#maintain-port"
	@${ECHO_MSG}
.endif
.if defined(DEPRECATED)
	@${ECHO_MSG} "===>   NOTICE:"
	@${ECHO_MSG}
	@${ECHO_MSG} "This port is deprecated; you may wish to reconsider installing it:"
	@${ECHO_MSG}
	@${ECHO_MSG} ${DEPRECATED:Q}.
	@${ECHO_MSG}
.if defined(EXPIRATION_DATE)
	@${ECHO_MSG} "It is scheduled to be removed on or after ${EXPIRATION_DATE}."
	@${ECHO_MSG}
.endif
.endif
.endif

# Check if the port is listed in the vulnerability database

AUDITFILE?=		${PKG_DBDIR}/vuln.xml

check-vulnerable:
.if !defined(DISABLE_VULNERABILITIES) && !defined(PACKAGE_BUILDING) \
		&& exists(${AUDITFILE})
	@${SETENV} \
			dp_ECHO_MSG="${ECHO_MSG}" \
			dp_PKG_BIN="${PKG_BIN}" \
			dp_PORTNAME="${PORTNAME}" \
			dp_PKGNAME="${PKGNAME}" \
			dp_SCRIPTSDIR="${SCRIPTSDIR}" \
			${SH} ${SCRIPTSDIR}/check-vulnerable.sh
.endif

# Quote simply quote all variables, except FETCH_ENV, some ports are creative
# with it, and it needs to be quoted twice to pass through the echo/eval in
# do-fetch.
_DO_FETCH_ENV= \
			dp_DISABLE_SIZE='${DISABLE_SIZE}' \
			dp_DISTDIR='${_DISTDIR}' \
			dp_DISTINFO_FILE='${DISTINFO_FILE}' \
			dp_DIST_SUBDIR='${DIST_SUBDIR}' \
			dp_ECHO_MSG='${ECHO_MSG}' \
			dp_FETCH_AFTER_ARGS='${FETCH_AFTER_ARGS}' \
			dp_FETCH_BEFORE_ARGS='${FETCH_BEFORE_ARGS}' \
			dp_FETCH_CMD='${FETCH_CMD}' \
			dp_FETCH_ENV=${FETCH_ENV:Q} \
			dp_FORCE_FETCH_ALL='${FORCE_FETCH_ALL}' \
			dp_FORCE_FETCH_LIST='${FORCE_FETCH_LIST}' \
			dp_MASTER_SITE_BACKUP='${_MASTER_SITE_BACKUP}' \
			dp_MASTER_SITE_OVERRIDE='${_MASTER_SITE_OVERRIDE}' \
			dp_MASTER_SORT_AWK='${MASTER_SORT_AWK}' \
			dp_NO_CHECKSUM='${NO_CHECKSUM}' \
			dp_RANDOMIZE_SITES='${_RANDOMIZE_SITES}' \
			dp_SCRIPTSDIR='${SCRIPTSDIR}' \
			dp_TARGET='${.TARGET}'
.if defined(DEVELOPER)
_DO_FETCH_ENV+= dp_DEVELOPER=yes
.else
_DO_FETCH_ENV+= dp_DEVELOPER=
.endif

# Fetch

.if !target(do-fetch)
do-fetch:
.if !empty(DISTFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_MASTER_SITES_ENV} \
			dp_SITE_FLAVOR=MASTER \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${DISTFILES:C/.*/'&'/}
.endif
.if defined(PATCHFILES) && !empty(PATCHFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_PATCH_SITES_ENV} \
			dp_SITE_FLAVOR=PATCH \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${PATCHFILES:C/:-p[0-9]//:C/.*/'&'/}
.endif
.endif
#
# Prints out a list of files to fetch (useful to do a batch fetch)

.if !target(fetch-list)
fetch-list:
.if !empty(DISTFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_MASTER_SITES_ENV} \
			dp_SITE_FLAVOR=MASTER \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${DISTFILES:C/.*/'&'/}
.endif
.if defined(PATCHFILES) && !empty(PATCHFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_PATCH_SITES_ENV} \
			dp_SITE_FLAVOR=PATCH \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${PATCHFILES:C/:-p[0-9]//:C/.*/'&'/}
.endif
.endif

# Used by fetch-urlall-list and fetch-url-list

.if !target(fetch-url-list-int)
fetch-url-list-int:
.if !empty(DISTFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_MASTER_SITES_ENV} \
			dp_SITE_FLAVOR=MASTER \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${DISTFILES:C/.*/'&'/}
.endif
.if defined(PATCHFILES) && !empty(PATCHFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_PATCH_SITES_ENV} \
			dp_SITE_FLAVOR=PATCH \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${PATCHFILES:C/:-p[0-9]//:C/.*/'&'/}
.endif
.endif

# Prints out all the URL for all the DISTFILES and PATCHFILES.

.if !target(fetch-urlall-list)
fetch-urlall-list:
	@cd ${.CURDIR} && ${SETENV} FORCE_FETCH_ALL=yes ${MAKE} fetch-url-list-int
.endif

# Prints the URL for all the DISTFILES and PATCHFILES that are not here

.if !target(fetch-url-list)
fetch-url-list: fetch-url-list-int
.endif


# Extract

clean-wrkdir:
	@${RM} -r ${WRKDIR}

.if !target(do-extract)
do-extract: ${EXTRACT_WRKDIR}
	@for file in ${EXTRACT_ONLY}; do \
		if ! (cd ${EXTRACT_WRKDIR} && ${EXTRACT_CMD} ${EXTRACT_BEFORE_ARGS} ${_DISTDIR}/$$file ${EXTRACT_AFTER_ARGS});\
		then \
			exit 1; \
		fi; \
	done
	@if [ ${UID} = 0 ]; then \
		${CHMOD} -R ug-s ${WRKDIR}; \
		${CHOWN} -R 0:0 ${WRKDIR}; \
	fi
.endif

# Patch

.if !target(do-patch)
do-patch:
	@${SETENV} \
			dp_BZCAT="${BZCAT}" \
			dp_CAT="${CAT}" \
			dp_DISTDIR="${_DISTDIR}" \
			dp_ECHO_MSG="${ECHO_MSG}" \
			dp_EXTRA_PATCHES="${EXTRA_PATCHES}" \
			dp_EXTRA_PATCH_TREE="${EXTRA_PATCH_TREE}" \
			dp_GZCAT="${GZCAT}" \
			dp_OPSYS="${OPSYS}" \
			dp_PATCH="${PATCH}" \
			dp_PATCHDIR="${PATCHDIR}" \
			dp_PATCHFILES="${_PATCHFILES2}" \
			dp_PATCH_ARGS=${PATCH_ARGS:Q} \
			dp_PATCH_DEBUG_TMP="${PATCH_DEBUG_TMP}" \
			dp_PATCH_DIST_ARGS="${PATCH_DIST_ARGS}" \
			dp_PATCH_SILENT="${PATCH_SILENT}" \
			dp_PATCH_WRKSRC=${PATCH_WRKSRC} \
			dp_PKGNAME="${PKGNAME}" \
			dp_PKGORIGIN="${PKGORIGIN}" \
			dp_SCRIPTSDIR="${SCRIPTSDIR}" \
			dp_UNZIP_NATIVE_CMD="${UNZIP_NATIVE_CMD}" \
			dp_XZCAT="${XZCAT}" \
			${SH} ${SCRIPTSDIR}/do-patch.sh
.endif

.if !target(run-autotools-fixup)
run-autotools-fixup:
# Work around an issue where FreeBSD 10.0 is detected as FreeBSD 1.x.
.if !defined(WITHOUT_FBSD10_FIX)
	-@for f in `${FIND} ${WRKDIR} -type f \( -name config.libpath -o \
		-name config.rpath -o -name configure -o -name libtool.m4 -o \
		-name ltconfig -o -name libtool -o -name aclocal.m4 -o \
		-name acinclude.m4 \)` ; do \
			${SED} -i.fbsd10bak \
				-e 's|freebsd1\*)|freebsd1.\*)|g' \
				-e 's|freebsd\[12\]\*)|freebsd[12].*)|g' \
				-e 's|freebsd\[123\]\*)|freebsd[123].*)|g' \
				-e 's|freebsd\[\[12\]\]\*)|freebsd[[12]].*)|g' \
				-e 's|freebsd\[\[123\]\]\*)|freebsd[[123]].*)|g' \
					$${f} ; \
			cmp -s $${f}.fbsd10bak $${f} || \
			${ECHO_MSG} "===>   FreeBSD 10 autotools fix applied to $${f}"; \
			${TOUCH} ${TOUCH_FLAGS} -mr $${f}.fbsd10bak $${f} ; \
			${RM} $${f}.fbsd10bak ; \
		done
.endif
.endif

# Configure

.if !target(do-configure)
do-configure:
	@if [ -f ${SCRIPTDIR}/configure ]; then \
		cd ${.CURDIR} && ${SETENV} ${SCRIPTS_ENV} ${SH} \
		  ${SCRIPTDIR}/configure; \
	fi
.if defined(GNU_CONFIGURE)
	@CONFIG_GUESS_DIRS=$$(${FIND} ${WRKDIR} -name config.guess -o -name config.sub \
		| ${XARGS} -n 1 ${DIRNAME}); \
	for _D in $${CONFIG_GUESS_DIRS}; do \
		${RM} $${_D}/config.guess; \
		${CP} ${TEMPLATES}/config.guess $${_D}/config.guess; \
		${CHMOD} a+rx $${_D}/config.guess; \
		${RM} $${_D}/config.sub; \
		${CP} ${TEMPLATES}/config.sub $${_D}/config.sub; \
		${CHMOD} a+rx $${_D}/config.sub; \
	done
.endif
.if defined(HAS_CONFIGURE)
	@${MKDIR} ${CONFIGURE_WRKSRC}
	@(cd ${CONFIGURE_WRKSRC} && \
	    ${SET_LATE_CONFIGURE_ARGS} \
		if ! ${SETENV} CC="${CC}" CPP="${CPP}" CXX="${CXX}" \
	    CFLAGS="${CFLAGS}" CPPFLAGS="${CPPFLAGS}" CXXFLAGS="${CXXFLAGS}" \
	    LDFLAGS="${LDFLAGS}" LIBS="${LIBS}" \
	    INSTALL="/usr/bin/install -c" \
	    INSTALL_DATA="${INSTALL_DATA}" \
	    INSTALL_LIB="${INSTALL_LIB}" \
	    INSTALL_PROGRAM="${INSTALL_PROGRAM}" \
	    INSTALL_SCRIPT="${INSTALL_SCRIPT}" \
	    ${CONFIGURE_ENV} ${CONFIGURE_CMD} ${CONFIGURE_ARGS}; then \
			 ${ECHO_MSG} "===>  Script \"${CONFIGURE_SCRIPT}\" failed unexpectedly."; \
			 (${ECHO_CMD} ${CONFIGURE_FAIL_MESSAGE}) | ${FMT_80} ; \
			 ${FALSE}; \
		fi)
.endif
.endif

# Build
# XXX: ${MAKE_ARGS:N${DESTDIRNAME}=*} would be easier but it is not valid with the old fmake
DO_MAKE_BUILD?=	${SETENV} ${MAKE_ENV} ${MAKE_CMD} ${MAKE_FLAGS} ${MAKEFILE} ${_MAKE_JOBS} ${MAKE_ARGS:C,^${DESTDIRNAME}=.*,,g}
.if !target(do-build)
do-build:
	@(cd ${BUILD_WRKSRC}; if ! ${DO_MAKE_BUILD} ${ALL_TARGET}; then \
		if [ -n "${BUILD_FAIL_MESSAGE}" ] ; then \
			${ECHO_MSG} "===> Compilation failed unexpectedly."; \
			(${ECHO_CMD} "${BUILD_FAIL_MESSAGE}") | ${FMT_80} ; \
			fi; \
		${FALSE}; \
		fi)
.endif

# Check conflicts

.if !target(check-conflicts)
check-conflicts: check-build-conflicts check-install-conflicts
.endif

.if !target(check-build-conflicts)
check-build-conflicts:
.if ( defined(CONFLICTS) || defined(CONFLICTS_BUILD) ) && !defined(DISABLE_CONFLICTS) && !defined(DEFER_CONFLICTS_CHECK)
	@conflicts_with=$$( \
	{ ${PKG_QUERY} -g "%n-%v %p %o" ${CONFLICTS:C/.+/'&'/} ${CONFLICTS_BUILD:C/.+/'&'/} 2>/dev/null || : ; } \
		| while read pkgname prfx orgn; do \
		if [ "/${PREFIX}" = "/$${prfx}" -a "/${PKGORIGIN}" != "/$${orgn}" ]; then \
			${ECHO_CMD} -n " $${pkgname}"; \
		fi; \
	done); \
	if [ -n "$${conflicts_with}" ]; then \
		${ECHO_MSG}; \
		${ECHO_MSG} "===>  ${PKGNAME} conflicts with installed package(s): "; \
		for entry in $${conflicts_with}; do \
			${ECHO_MSG} "      $${entry}"; \
		done; \
		${ECHO_MSG}; \
		${ECHO_MSG} "      They will not build together."; \
		${ECHO_MSG} "      Please remove them first with pkg delete."; \
		exit 1;\
	fi
.endif
.endif

.if !target(identify-install-conflicts)
identify-install-conflicts:
.if ( defined(CONFLICTS) || defined(CONFLICTS_INSTALL) ) && !defined(DISABLE_CONFLICTS)
	@conflicts_with=$$( \
	{ ${PKG_QUERY} -g "%n-%v %p %o" ${CONFLICTS:C/.+/'&'/} ${CONFLICTS_INSTALL:C/.+/'&'/} 2>/dev/null || : ; } \
		| while read pkgname prfx orgn; do \
		if [ "/${PREFIX}" = "/$${prfx}" -a "/${PKGORIGIN}" != "/$${orgn}" ]; then \
			${ECHO_CMD} -n " $${pkgname}"; \
		fi; \
	done); \
	if [ -n "$${conflicts_with}" ]; then \
		${ECHO_MSG}; \
		${ECHO_MSG} "===>  ${PKGNAME} conflicts with installed package(s): "; \
		for entry in $${conflicts_with}; do \
			${ECHO_MSG} "      $${entry}"; \
		done; \
		${ECHO_MSG}; \
		${ECHO_MSG} "      They install files into the same place."; \
		${ECHO_MSG} "      You may want to stop build with Ctrl + C."; \
		sleep 10; \
	fi
.endif
.endif

.if !target(check-install-conflicts)
check-install-conflicts:
.if ( defined(CONFLICTS) || defined(CONFLICTS_INSTALL) || ( defined(CONFLICTS_BUILD) && defined(DEFER_CONFLICTS_CHECK) ) ) && !defined(DISABLE_CONFLICTS) 
.if defined(DEFER_CONFLICTS_CHECK)
	@conflicts_with=$$( \
	{ ${PKG_QUERY} -g "%n-%v %p %o" ${CONFLICTS:C/.+/'&'/} ${CONFLICTS_BUILD:C/.+/'&'/} ${CONFLICTS_INSTALL:C/.+/'&'/} 2>/dev/null || : ; } \
			| while read pkgname prfx orgn; do \
		if [ "/${PREFIX}" = "/$${prfx}" -a "/${PKGORIGIN}" != "/$${orgn}" ]; then \
			${ECHO_CMD} -n " $${pkgname}"; \
		fi; \
	done); \
	if [ -n "$${conflicts_with}" ]; then \
		${ECHO_MSG}; \
		${ECHO_MSG} "===>  ${PKGNAME} conflicts with installed package(s): "; \
		for entry in $${conflicts_with}; do \
			${ECHO_MSG} "      $${entry}"; \
		done; \
		${ECHO_MSG}; \
		${ECHO_MSG} "      Please remove them first with pkg delete."; \
		exit 1; \
	fi
.else
	@conflicts_with=$$( \
	{ ${PKG_QUERY} -g "%n-%v %p %o" ${CONFLICTS:C/.+/'&'/} ${CONFLICTS_INSTALL:C/.+/'&'/} 2>/dev/null || : ; } \
			| while read pkgname prfx orgn; do \
		if [ "/${PREFIX}" = "/$${prfx}" -a "/${PKGORIGIN}" != "/$${orgn}" ]; then \
			${ECHO_CMD} -n " $${pkgname}"; \
		fi; \
	done); \
	if [ -n "$${conflicts_with}" ]; then \
		${ECHO_MSG}; \
		${ECHO_MSG} "===>  ${PKGNAME} conflicts with installed package(s): "; \
		for entry in $${conflicts_with}; do \
			${ECHO_MSG} "      $${entry}"; \
		done; \
		${ECHO_MSG}; \
		${ECHO_MSG} "      They install files into the same place."; \
		${ECHO_MSG} "      Please remove them first with pkg delete."; \
		exit 1; \
	fi
.endif # defined(DEFER_CONFLICTS_CHECK)
.endif
.endif

# Install

.if !target(do-install) && !defined(NO_INSTALL)
do-install:
	@(cd ${INSTALL_WRKSRC} && ${SETENV} ${MAKE_ENV} ${FAKEROOT} ${MAKE_CMD} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} ${INSTALL_TARGET})
.endif

# Test

.if !target(do-test) && defined(TEST_TARGET)
DO_MAKE_TEST?=	${SETENV} ${TEST_ENV} ${MAKE_CMD} ${MAKE_FLAGS} ${MAKEFILE} ${TEST_ARGS:C,^${DESTDIRNAME}=.*,,g}
do-test:
	@(cd ${TEST_WRKSRC}; if ! ${DO_MAKE_TEST} ${TEST_TARGET}; then \
		if [ -n "${TEST_FAIL_MESSAGE}" ] ; then \
			${ECHO_MSG} "===> Tests failed unexpectedly."; \
			(${ECHO_CMD} "${TEST_FAIL_MESSAGE}") | ${FMT_80} ; \
			fi; \
		${FALSE}; \
		fi)
.endif

# Package

.if defined(_HAVE_PACKAGES)
_EXTRA_PACKAGE_TARGET_DEP+= ${PKGFILE}
_PORTS_DIRECTORIES+=	${PKGREPOSITORY}

${PKGFILE}: ${WRKDIR_PKGFILE} ${PKGREPOSITORY}
	@${LN} -f ${WRKDIR_PKGFILE} ${PKGFILE} 2>/dev/null \
			|| ${CP} -f ${WRKDIR_PKGFILE} ${PKGFILE}

.  if ${PKGORIGIN} == "ports-mgmt/pkg" || ${PKGORIGIN} == "ports-mgmt/pkg-devel"
_EXTRA_PACKAGE_TARGET_DEP+=	${PKGLATESTREPOSITORY}
_PORTS_DIRECTORIES+=	${PKGLATESTREPOSITORY}
_EXTRA_PACKAGE_TARGET_DEP+=	${PKGLATESTFILE}

${PKGLATESTFILE}: ${PKGFILE} ${PKGLATESTREPOSITORY}
	${INSTALL} -l rs ${PKGFILE} ${PKGLATESTFILE}
.  endif

.endif

# from here this will become a loop for subpackages
${WRKDIR_PKGFILE}: ${TMPPLIST} create-manifest ${WRKDIR}/pkg
	@if ! ${SETENV} ${PKG_ENV} FORCE_POST="${_FORCE_POST_PATTERNS}" ${PKG_CREATE} ${PKG_CREATE_ARGS} -m ${METADIR} -p ${TMPPLIST} -f ${PKG_SUFX:S/.//} -o ${WRKDIR}/pkg ${PKGNAME}; then \
		cd ${.CURDIR} && eval ${MAKE} delete-package >/dev/null; \
		exit 1; \
	fi
	#
# Temporary will be later dynamically added per subpackages
_EXTRA_PACKAGE_TARGET_DEP+=	${WRKDIR_PKGFILE}
# This will be the end of the loop

.if !target(do-package)
PKG_CREATE_ARGS=	-r ${STAGEDIR}
.  if defined(PKG_CREATE_VERBOSE)
PKG_CREATE_ARGS+=	-v
.  endif
do-package: ${_EXTRA_PACKAGE_TARGET_DEP} ${WRKDIR}/pkg
.endif

.if !target(delete-package)
delete-package:
	@${ECHO_MSG} "===>  Deleting package for ${PKGNAME}"
# When staging, the package may only be in the workdir if not root
	@${RM} ${PKGFILE} ${WRKDIR_PKGFILE} 2>/dev/null || :
.endif

.if !target(delete-package-list)
delete-package-list:
	@${ECHO_CMD} "[ -f ${PKGFILE} ] && (${ECHO_CMD} deleting ${PKGFILE}; ${RM} ${PKGFILE})"
.endif

# Used by scripts and users to install a package from local repository.
# Poudriere -i uses this, please keep.
.if !target(install-package)
.if defined(FORCE_PKG_REGISTER)
_INSTALL_PKG_ARGS=	-f
.endif
.if defined(INSTALLS_DEPENDS)
_INSTALL_PKG_ARGS+=	-A
.endif
install-package:
	@if [ -f "${WRKDIR}/pkg/${PKGNAME}${PKG_SUFX}" ]; then \
	    _pkgfile="${WRKDIR_PKGFILE}"; \
	else \
	    _pkgfile="${PKGFILE}"; \
	fi; \
	${PKG_ADD} ${_INSTALL_PKG_ARGS} $${_pkgfile}
.endif


# Utility targets follow

.if !target(check-already-installed)
.if !defined(NO_PKG_REGISTER) && !defined(FORCE_PKG_REGISTER)
check-already-installed:
		@${ECHO_MSG} "===>  Checking if ${PKGBASE} already installed"; \
		pkgname=`${PKG_INFO} -q -O ${PKGBASE}`; \
		if [ -n "$${pkgname}" ]; then \
			v=`${PKG_VERSION} -t $${pkgname} ${PKGNAME}`; \
			if [ "$${v}" = "<" ]; then \
				${ECHO_CMD} "===>   An older version of ${PKGBASE} is already installed ($${pkgname})"; \
			else \
				${ECHO_CMD} "===>   ${PKGNAME} is already installed"; \
			fi; \
			${ECHO_MSG} "      You may wish to \`\`make deinstall'' and install this port again"; \
			${ECHO_MSG} "      by \`\`make reinstall'' to upgrade it properly."; \
			${ECHO_MSG} "      If you really wish to overwrite the old port of ${PKGBASE}"; \
			${ECHO_MSG} "      without deleting it first, set the variable \"FORCE_PKG_REGISTER\""; \
			${ECHO_MSG} "      in your environment or the \"make install\" command line."; \
			exit 1; \
		fi
.endif
.endif

.if !target(check-umask)
check-umask:
	@if [ `${SH} -c umask` != 0022 ]; then \
		${ECHO_MSG} "===>  Warning: your umask is \"`${SH} -c umask`"\".; \
		${ECHO_MSG} "      If this is not desired, set it to an appropriate value"; \
		${ECHO_MSG} "      and install this port again by \`\`make reinstall''."; \
	fi
.endif

# Needed for poudriere wait for at least a year before removing
# XXX 2017-04-09
.if !target(install-mtree)
install-mtree:
.endif

.if !target(install-ldconfig-file)
install-ldconfig-file:
.  if defined(USE_LDCONFIG) || defined(USE_LDCONFIG32)
.    if defined(USE_LDCONFIG)
.      if !defined(USE_LINUX_PREFIX)
.        if ${USE_LDCONFIG} != "${LOCALBASE}/lib" && !defined(INSTALL_AS_USER)
	@${ECHO_MSG} "===>   Installing ldconfig configuration file"
.          if defined(NO_MTREE) || ${PREFIX} != ${LOCALBASE}
	@${MKDIR} ${STAGEDIR}${LOCALBASE}/${LDCONFIG_DIR}
.          endif
	@${ECHO_CMD} ${USE_LDCONFIG} | ${TR} ' ' '\n' \
		> ${STAGEDIR}${LOCALBASE}/${LDCONFIG_DIR}/${PKGBASE}
	@${ECHO_CMD} ${LOCALBASE}/${LDCONFIG_DIR}/${PKGBASE} >> ${TMPPLIST}
.          if ${PREFIX} != ${LOCALBASE}
	@${ECHO_CMD} "@dir ${LOCALBASE}/${LDCONFIG_DIR}" >> ${TMPPLIST}
.          endif
.        endif
.      endif
.    endif
.    if defined(USE_LDCONFIG32)
.      if !defined(INSTALL_AS_USER)
	@${ECHO_MSG} "===>   Installing 32-bit ldconfig configuration file"
.        if defined(NO_MTREE) || ${PREFIX} != ${LOCALBASE}
	@${MKDIR} ${STAGEDIR}${LOCALBASE}/${LDCONFIG32_DIR}
.        endif
	@${ECHO_CMD} ${USE_LDCONFIG32} | ${TR} ' ' '\n' \
		> ${STAGEDIR}${LOCALBASE}/${LDCONFIG32_DIR}/${PKGBASE}
	@${ECHO_CMD} ${LOCALBASE}/${LDCONFIG32_DIR}/${PKGBASE} >> ${TMPPLIST}
.        if ${PREFIX} != ${LOCALBASE}
	@${ECHO_CMD} "@dir ${LOCALBASE}/${LDCONFIG32_DIR}" >> ${TMPPLIST}
.        endif
.      endif
.    endif
.  endif
.endif

.if !defined(USE_LINUX_PREFIX)
.  if !target(fixup-lib-pkgconfig)
fixup-lib-pkgconfig:
	@if [ -d ${STAGEDIR}${PREFIX}/lib/pkgconfig ]; then \
		if [ -z "$$(${FIND} ${STAGEDIR}${PREFIX}/lib/pkgconfig -maxdepth 0 -empty)" ]; then \
			${MKDIR} ${STAGEDIR}${PREFIX}/libdata/pkgconfig; \
			${MV} ${STAGEDIR}${PREFIX}/lib/pkgconfig/* ${STAGEDIR}${PREFIX}/libdata/pkgconfig; \
		fi; \
		${RMDIR} ${STAGEDIR}${PREFIX}/lib/pkgconfig; \
	fi
.  endif
.endif

.if !target(create-users-groups)
.if defined(GROUPS) || defined(USERS)
_UG_INSTALL=	${WRKDIR}/users-groups-install.sh
_UG_DEINSTALL=	${WRKDIR}/users-groups-deinstall.sh
PKGPREINSTALL+=	${_UG_INSTALL}
PKGPOSTDEINSTALL+=	${_UG_DEINSTALL}
create-users-groups:
	@${SETENV} \
			dp_ECHO_MSG="${ECHO_MSG}" \
			dp_GID_FILES="${GID_FILES}" \
			dp_GID_OFFSET="${GID_OFFSET}" \
			dp_GROUPS_BLACKLIST="${GROUPS_BLACKLIST}" \
			dp_INSTALL="${INSTALL}" \
			dp_OPSYS="${OPSYS}" \
			dp_OSVERSION="${OSVERSION}" \
			dp_PREFIX="${PREFIX}" \
			dp_PW="${PW}" \
			dp_SCRIPTSDIR="${SCRIPTSDIR}" \
			dp_UG_DEINSTALL="${_UG_DEINSTALL}" \
			dp_UG_INSTALL="${_UG_INSTALL}" \
			dp_UID_FILES="${UID_FILES}" \
			dp_UID_OFFSET="${UID_OFFSET}" \
			dp_USERS_BLACKLIST="${USERS_BLACKLIST}" \
			${SH} ${SCRIPTSDIR}/do-users-groups.sh "${USERS}" "${GROUPS}"
.endif
.endif

.if !defined(DISABLE_SECURITY_CHECK)
.if !target(security-check)
security-check: ${TMPPLIST}
# Scan PLIST for:
#   1.  setugid files
#   2.  accept()/recvfrom() which indicates network listening capability
#   3.  insecure functions (gets/mktemp/tempnam/[XXX])
#   4.  startup scripts, in conjunction with 2.
#   5.  world-writable files/dirs
#
#  The ${NONEXISTENT} argument of ${READELF} is there so that there are always
#  at least two file arguments, and forces it to always output the "File: foo"
#  header lines.
#
	-@${RM} ${WRKDIR}/.PLIST.setuid ${WRKDIR}/.PLIST.writable ${WRKDIR}/.PLIST.readelf; \
	${AWK} -v prefix='${PREFIX}' ' \
		match($$0, /^@cwd /) { prefix = substr($$0, RSTART + RLENGTH); if (prefix == "/") prefix=""; next; } \
		/^@/ { next; } \
		/^\// { print; next; } \
		{ print prefix "/" $$0; } \
	' ${TMPPLIST} > ${WRKDIR}/.PLIST.flattened; \
	${TR} '\n' '\0' < ${WRKDIR}/.PLIST.flattened \
	| ${XARGS} -0 -J % ${FIND} % -prune ! -type l -type f \( -perm -4000 -o -perm -2000 \) \( -perm -0010 -o -perm -0001 \) 2> /dev/null > ${WRKDIR}/.PLIST.setuid; \
	${TR} '\n' '\0' < ${WRKDIR}/.PLIST.flattened \
	| ${XARGS} -0 -J % ${FIND} % -prune -perm -0002 \! -type l 2> /dev/null > ${WRKDIR}/.PLIST.writable; \
	${TR} '\n' '\0' < ${WRKDIR}/.PLIST.flattened \
	| ${XARGS} -0 -J % ${FIND} % -prune ! -type l -type f -print0 2> /dev/null \
	| ${XARGS} -0 ${READELF} -r ${NONEXISTENT} 2> /dev/null > ${WRKDIR}/.PLIST.readelf; \
	if \
		! ${AWK} -v audit="$${PORTS_AUDIT}" -f ${SCRIPTSDIR}/security-check.awk \
		  ${WRKDIR}/.PLIST.flattened ${WRKDIR}/.PLIST.readelf ${WRKDIR}/.PLIST.setuid ${WRKDIR}/.PLIST.writable; \
	then \
		www_site=$$(cd ${.CURDIR} && ${MAKE} www-site); \
	    if [ ! -z "$${www_site}" ]; then \
			${ECHO_MSG}; \
			${ECHO_MSG} "      For more information, and contact details about the security"; \
			${ECHO_MSG} "      status of this software, see the following webpage: "; \
			${ECHO_MSG} "$${www_site}"; \
		fi; \
	fi
.endif
.else # i.e. defined(DISABLE_SECURITY_CHECK)
security-check:
	@${ECHO_MSG} "      WARNING: Security check has been disabled."
.endif # !defined(DISABLE_SECURITY_CHECK)

################################################################
# Skeleton targets start here
#
# You shouldn't have to change these.  Either add the pre-* or
# post-* targets/scripts or redefine the do-* targets.  These
# targets don't do anything other than checking for cookies and
# call the necessary targets/scripts.
################################################################

extract-message:
	@${ECHO_MSG} "===>  Extracting for ${PKGNAME}"
patch-message:
	@${ECHO_MSG} "===>  Patching for ${PKGNAME}"
configure-message:
	@${ECHO_MSG} "===>  Configuring for ${PKGNAME}"
build-message:
	@${ECHO_MSG} "===>  Building for ${PKGNAME}"
stage-message:
	@${ECHO_MSG} "===>  Staging for ${PKGNAME}"
install-message:
	@${ECHO_MSG} "===>  Installing for ${PKGNAME}"
test-message:
	@${ECHO_MSG} "===>  Testing for ${PKGNAME}"
package-message:
	@${ECHO_MSG} "===>  Building package for ${PKGNAME}"

# Empty pre-* and post-* targets

.if exists(${SCRIPTDIR})
.for stage in pre post
.for name in pkg check-sanity fetch extract patch configure build stage install package

.if !target(${stage}-${name}-script)
.if exists(${SCRIPTDIR}/${stage}-${name})
${stage}-${name}-script:
	@ cd ${.CURDIR} && ${SETENV} ${SCRIPTS_ENV} ${SH} \
			${SCRIPTDIR}/${.TARGET:S/-script$//}
.endif
.endif

.endfor
.endfor
.endif

.if !target(pretty-print-www-site)
pretty-print-www-site:
	@www_site=$$(cd ${.CURDIR} && ${MAKE} www-site); \
	if [ -n "$${www_site}" ]; then \
		${ECHO_MSG} -n " and/or visit the "; \
		${ECHO_MSG} -n "<a href=\"$${www_site}\">web site</a>"; \
		${ECHO_MSG} " for further information"; \
	fi
.endif

################################################################
# Some more targets supplied for users' convenience
################################################################

# Checkpatch
#
# Special target to verify patches

.if !target(checkpatch)
checkpatch:
	@cd ${.CURDIR} && ${MAKE} ${PATCH_SILENT} PATCH_CHECK_ONLY=yes ${_PATCH_DEP} ${_PATCH_REAL_SEQ}
.endif

# Reinstall
#
# Special target to re-run install

.if !target(reinstall)
reinstall:
	@${RM} ${INSTALL_COOKIE} ${PACKAGE_COOKIE}
	@cd ${.CURDIR} && DEPENDS_TARGET="${DEPENDS_TARGET}" ${MAKE} -DFORCE_PKG_REGISTER install
.endif

.if !target(restage)
restage:
	@${RM} -r ${STAGEDIR} ${STAGE_COOKIE} ${INSTALL_COOKIE} ${PACKAGE_COOKIE}
	@cd ${.CURDIR} && ${MAKE} stage
.endif

# Deinstall
#
# Special target to remove installation

.if !target(deinstall)
deinstall:
.if defined(UID) && ${UID} != 0 && !defined(INSTALL_AS_USER)
	@${ECHO_MSG} "===>  Switching to root credentials for '${.TARGET}' target"
	@cd ${.CURDIR} && \
		${SU_CMD} "${MAKE} ${.TARGET}"
	@${ECHO_MSG} "===>  Returning to user credentials"
.else
	@${ECHO_MSG} "===>  Deinstalling for ${PKGBASE}"
	@if ${PKG_INFO} -e ${PKGBASE}; then \
		p=`${PKG_INFO} -q -O ${PKGBASE}`; \
		${ECHO_MSG} "===>   Deinstalling $${p}"; \
		${PKG_DELETE} -f ${PKGBASE} ; \
	else \
		${ECHO_MSG} "===>   ${PKGBASE} not installed, skipping"; \
	fi
	@${RM} ${INSTALL_COOKIE} ${PACKAGE_COOKIE}
.endif
.endif

# Deinstall-all
#
# Special target to remove installation of all ports of the same origin

.if !target(deinstall-all)
deinstall-all:
.if ${UID} != 0 && !defined(INSTALL_AS_USER)
	@${ECHO_MSG} "===>  Switching to root credentials for '${.TARGET}' target"
	@cd ${.CURDIR} && \
		${SU_CMD} "${MAKE} ${.TARGET}"
	@${ECHO_MSG} "===>  Returning to user credentials"
.else
	@${ECHO_MSG} "===>  Deinstalling for ${PKGORIGIN}"
	@deinstall_names=`${PKG_INFO} -q -O ${PKGORIGIN}`; \
	for oldpkgorigin in $$(${GREP} "|${PKGORIGIN}|" ${PORTSDIR}/MOVED | ${CUT} -f 1 -d '|' | ${SORT} -u); do \
		deinstall_names="$${deinstall_names} $$(${PKG_INFO} -q -O $${oldpkgorigin})"; \
	done; \
	if [ -n "$${deinstall_names}" ]; then \
		for d in $${deinstall_names}; do \
			${ECHO_MSG} "===>   Deinstalling $${d}"; \
			${PKG_DELETE} -f $${d}; \
		done; \
	else \
		${ECHO_MSG} "===>   ${PKGORIGIN} not installed, skipping"; \
	fi; \
	${RM} ${INSTALL_COOKIE} ${PACKAGE_COOKIE}
.endif
.endif

# Cleaning up

.if !target(do-clean)
do-clean:
	@if [ -d ${WRKDIR} ]; then \
		if [ -w ${WRKDIR} ]; then \
			${RM} -r ${WRKDIR}; \
		else \
			${ECHO_MSG} "===>   ${WRKDIR} not writable, skipping"; \
		fi; \
	fi
.endif

.if !target(clean)
pre-clean: clean-msg
clean-msg:
	@${ECHO_MSG} "===>  Cleaning for ${PKGNAME}"

.if empty(FLAVORS)
CLEAN_DEPENDENCIES=
.if !defined(NOCLEANDEPENDS)
CLEAN_DEPENDENCIES+=	limited-clean-depends-noflavor
limited-clean-depends-noflavor:
	@cd ${.CURDIR} && ${MAKE} limited-clean-depends
.endif
.if target(pre-clean)
CLEAN_DEPENDENCIES+=	pre-clean-noflavor
pre-clean-noflavor:
	@cd ${.CURDIR} && ${SETENV} ${MAKE} pre-clean
.endif
CLEAN_DEPENDENCIES+=	do-clean-noflavor
do-clean-noflavor:
	@cd ${.CURDIR} && ${SETENV} ${MAKE} do-clean
.if target(post-clean)
CLEAN_DEPENDENCIES+=	post-clean-noflavor
post-clean-noflavor:
	@cd ${.CURDIR} &&  ${SETENV} ${MAKE} post-clean
.endif
.ORDER: ${CLEAN_DEPENDENCIES}
clean: ${CLEAN_DEPENDENCIES}
.endif

.if !empty(_FLAVOR)
_CLEANFLAVORS=	${_FLAVOR}
.else
_CLEANFLAVORS=	${FLAVORS}
.endif
.for _f in ${_CLEANFLAVORS}
CLEAN_DEPENDENCIES=
.if !defined(NOCLEANDEPENDS)
CLEAN_DEPENDENCIES+=	limited-clean-depends-${_f}
limited-clean-depends-${_f}:
	@cd ${.CURDIR} && ${SETENV} FLAVOR=${_f} ${MAKE} limited-clean-depends
.endif
.if target(pre-clean)
CLEAN_DEPENDENCIES+=	pre-clean-${_f}
pre-clean-${_f}:
	@cd ${.CURDIR} && ${SETENV} FLAVOR=${_f} ${MAKE} pre-clean
.endif
CLEAN_DEPENDENCIES+=	do-clean-${_f}
do-clean-${_f}:
	@cd ${.CURDIR} && ${SETENV} FLAVOR=${_f} ${MAKE} do-clean
.if target(post-clean)
CLEAN_DEPENDENCIES+=	post-clean-${_f}
post-clean-${_f}:
	@cd ${.CURDIR} &&  ${SETENV} FLAVOR=${_f} ${MAKE} post-clean
.endif
.ORDER: ${CLEAN_DEPENDENCIES}
clean: ${CLEAN_DEPENDENCIES}
.endfor
.endif

.if !target(distclean)
distclean: clean
	@cd ${.CURDIR} && ${MAKE} delete-distfiles RESTRICTED_FILES="${_DISTFILES:Q} ${_PATCHFILES:Q}"
.endif

.if !target(delete-distfiles)
delete-distfiles:
	@${ECHO_MSG} "===>  Deleting distfiles for ${PKGNAME}"
	@(if [ "X${RESTRICTED_FILES}" != "X" -a -d ${_DISTDIR} ]; then \
		cd ${_DISTDIR}; \
		for file in ${RESTRICTED_FILES}; do \
			${RM} $${file}; \
			dir=$${file%/*}; \
			if [ "$${dir}" != "$${file}" ]; then \
				${RMDIR} -p $${dir} >/dev/null 2>&1 || :; \
			fi; \
		done; \
	fi)
.if defined(DIST_SUBDIR)
	-@${RMDIR} ${_DISTDIR} >/dev/null 2>&1 || ${TRUE}
.endif
.endif

.if !target(delete-distfiles-list)
delete-distfiles-list:
	@${ECHO_CMD} "# ${PKGNAME}"
	@if [ "X${RESTRICTED_FILES}" != "X" ]; then \
		for file in ${RESTRICTED_FILES}; do \
			${ECHO_CMD} "[ -f ${_DISTDIR}/$$file ] && (${ECHO_CMD} deleting ${_DISTDIR}/$$file; ${RM} ${_DISTDIR}/$$file)"; \
			dir=$${file%/*}; \
			if [ "$${dir}" != "$${file}" ]; then \
				${ECHO_CMD} "(cd ${_DISTDIR} && ${RMDIR} -p $${dir} 2>/dev/null)"; \
			fi; \
		done; \
	fi
.if defined(DIST_SUBDIR)
	@${ECHO_CMD} "${RMDIR} ${_DISTDIR} 2>/dev/null || ${TRUE}"
.endif
.endif

# Generates patches.

update-patches:
	@toedit=`PATCH_WRKSRC=${PATCH_WRKSRC} \
		PATCHDIR=${PATCHDIR} \
		PATCH_LIST=${PATCHDIR}/patch-* \
		DIFF_ARGS=${DIFF_ARGS} \
		DISTORIG=${DISTORIG} \
		${SH} ${PORTSDIR}/Tools/scripts/update-patches`; \
	case $$toedit in "");; \
	*) ${ECHO_CMD} -n 'edit patches: '; read i; \
	cd ${PATCHDIR} && $${VISUAL:-$${EDIT:-/usr/bin/vi}} $$toedit;; esac

# Checksumming utilities

# List all algorithms here, all the variables name must begin with dp_
_CHECKSUM_INIT_ENV= \
	dp_SHA256=${SHA256}

.if !target(makesum)
# Some port change the options with OPTIONS_*_FORCE when make(makesum) to be
# able to add all distfiles in one go.
# For this to work, we need to call the do-fetch script directly here so that
# the options consistent when fetching and when makesum'ing.
# As we're fetching new distfiles, that are not in the distinfo file, disable
# checksum and sizes checks.
makesum:
.if !empty(DISTFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_MASTER_SITES_ENV} \
			dp_NO_CHECKSUM=yes dp_DISABLE_SIZE=yes \
			dp_SITE_FLAVOR=MASTER \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${DISTFILES:C/.*/'&'/}
.endif
.if defined(PATCHFILES) && !empty(PATCHFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_PATCH_SITES_ENV} \
			dp_NO_CHECKSUM=yes dp_DISABLE_SIZE=yes \
			dp_SITE_FLAVOR=PATCH \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${PATCHFILES:C/:-p[0-9]//:C/.*/'&'/}
.endif
	@${SETENV} \
			${_CHECKSUM_INIT_ENV} \
			dp_CHECKSUM_ALGORITHMS='${CHECKSUM_ALGORITHMS:tu}' \
			dp_CKSUMFILES='${_CKSUMFILES}' \
			dp_DISTDIR='${DISTDIR}' \
			dp_DISTINFO_FILE='${DISTINFO_FILE}' \
			dp_ECHO_MSG='${ECHO_MSG}' \
			dp_SCRIPTSDIR='${SCRIPTSDIR}' \
			${SH} ${SCRIPTSDIR}/makesum.sh ${DISTFILES:C/.*/'&'/}
.endif

.if !target(checksum)
checksum: fetch
.if !empty(_CKSUMFILES) && !defined(NO_CHECKSUM)
	@${SETENV} \
			${_CHECKSUM_INIT_ENV} \
			dp_CHECKSUM_ALGORITHMS='${CHECKSUM_ALGORITHMS:tu}' \
			dp_CURDIR='${.CURDIR}' \
			dp_DISTDIR='${DISTDIR}' \
			dp_DISTINFO_FILE='${DISTINFO_FILE}' \
			dp_DIST_SUBDIR='${DIST_SUBDIR}' \
			dp_ECHO_MSG='${ECHO_MSG}' \
			dp_FETCH_REGET='${FETCH_REGET}' \
			dp_MAKE='${MAKE}' \
			dp_MAKEFLAGS='${.MAKEFLAGS}' \
			dp_SCRIPTSDIR='${SCRIPTSDIR}' \
			dp_DISABLE_SIZE='${DISABLE_SIZE}' \
			dp_NO_CHECKSUM='${NO_CHECKSUM}' \
			${SH} ${SCRIPTSDIR}/checksum.sh ${_CKSUMFILES:C/.*/'&'/}
.endif
.endif

# Some port's archives contains files modes that are a bit too restrictive for
# some usage.  For example:
# BUILD_DEPENDS=		${NONEXISTENT}:foo/bar:configure
# When building as a regular user, dependencies are installed/built as root, so
# if the archive contains files that have a mode of, say, 600, they will not be
# readable by the port requesting the dependency.
# This will also fix broken distribution files where directories don't have the
# executable bit on.
extract-fixup-modes:
	@${CHMOD} -R u+w,a+rX ${WRKDIR}

################################################################
# The special package-building targets
# You probably won't need to touch these
################################################################

# Nobody should want to override this unless PKGNAME is simply bogus.

.if !target(package-name)
package-name:
	@${ECHO_CMD} ${PKGNAME}
.endif

# Build a package but don't check the package cookie

.if !target(repackage)
repackage: pre-repackage package

pre-repackage:
	@${RM} ${PACKAGE_COOKIE}
.endif

# Build a package but don't check the cookie for installation, also don't
# install package cookie

.if !target(package-noinstall)
package-noinstall: package
.endif

################################################################
# Dependency checking
################################################################

.if !target(depends)
depends: pkg-depends extract-depends patch-depends lib-depends fetch-depends build-depends run-depends

.for deptype in PKG EXTRACT PATCH FETCH BUILD LIB RUN TEST
${deptype:tl}-depends:
.if defined(${deptype}_DEPENDS) && !defined(NO_DEPENDS)
	@${SETENV} \
		dp_RAWDEPENDS="${${deptype}_DEPENDS}" \
		dp_DEPTYPE="${deptype}_DEPENDS" \
		dp_DEPENDS_TARGET="${DEPENDS_TARGET}" \
		dp_DEPENDS_PRECLEAN="${DEPENDS_PRECLEAN}" \
		dp_DEPENDS_CLEAN="${DEPENDS_CLEAN}" \
		dp_DEPENDS_ARGS="${DEPENDS_ARGS}" \
		dp_USE_PACKAGE_DEPENDS="${USE_PACKAGE_DEPENDS}" \
		dp_USE_PACKAGE_DEPENDS_ONLY="${USE_PACKAGE_DEPENDS_ONLY}" \
		dp_PKG_ADD="${PKG_ADD}" \
		dp_PKG_INFO="${PKG_INFO}" \
		dp_WRKDIR="${WRKDIR}" \
		dp_PKGNAME="${PKGNAME}" \
		dp_STRICT_DEPENDS="${STRICT_DEPENDS}" \
		dp_LOCALBASE="${LOCALBASE}" \
		dp_LIB_DIRS="${LIB_DIRS}" \
		dp_SH="${SH}" \
		dp_SCRIPTSDIR="${SCRIPTSDIR}" \
		PORTSDIR="${PORTSDIR}" \
		dp_MAKE="${MAKE}" \
		dp_MAKEFLAGS='${.MAKEFLAGS}' \
		${SH} ${SCRIPTSDIR}/do-depends.sh
.endif
.endfor

.endif

# Dependency lists: both build and runtime, recursive.  Print out directory names.

_UNIFIED_DEPENDS=${PKG_DEPENDS} ${EXTRACT_DEPENDS} ${PATCH_DEPENDS} ${FETCH_DEPENDS} ${BUILD_DEPENDS} ${LIB_DEPENDS} ${RUN_DEPENDS} ${TEST_DEPENDS}
_DEPEND_SPECIALS=	${_UNIFIED_DEPENDS:M*\:*\:*:C,^[^:]*:([^:]*):.*$,\1,}

.for d in ${_UNIFIED_DEPENDS:M*\:/*}
_PORTSDIR_STR=	$${PORTSDIR}/
DEV_WARNING+=	"It looks like the ${d} depends line has an absolute port origin, make sure to remove \$${_PORTSDIR_STR} from it."
.endfor

all-depends-list:
	@${ALL-DEPENDS-LIST}

_FLAVOR_RECURSIVE_SH= \
	if [ -z "$${recursive_cmd}" ]; then \
		${ECHO_MSG} "_FLAVOR_RECURSIVE_SH requires recursive_cmd to be set to the recursive make target to run." >&2; \
		${FALSE}; \
	fi; \
	if [ "$${recursive_dirs-null}" = "null" ]; then \
		${ECHO_MSG} "_FLAVOR_RECURSIVE_SH requires recursive_dirs to be set to the directories to recurse." >&2; \
		${FALSE}; \
	fi; \
	for dir in $${recursive_dirs}; do \
		unset flavor; \
		case $${dir} in \
			*@*) \
				flavor=$${dir\#*@}; \
				dir=$${dir%@*}; \
				;; \
		esac; \
		case $$dir in \
		/*) ;; \
		*) dir=${PORTSDIR}/$$dir ;; \
		esac; \
		(cd $$dir; ${SETENV} FLAVOR=$${flavor} ${MAKE} $${recursive_cmd}); \
	done

# This script is shared among several dependency list variables.  See file for
# usage.
DEPENDS-LIST= \
	${SETENV} \
			PORTSDIR="${PORTSDIR}" \
			dp_MAKE="${MAKE}" \
			dp_PKGNAME="${PKGNAME}" \
			dp_PKG_INFO="${PKG_INFO}" \
			dp_SCRIPTSDIR="${SCRIPTSDIR}" \
			${SH} ${SCRIPTSDIR}/depends-list.sh \
			${DEPENDS_SHOW_FLAVOR:D-f}

ALL-DEPENDS-LIST=			${DEPENDS-LIST} -r ${_UNIFIED_DEPENDS:Q}
ALL-DEPENDS-FLAVORS-LIST=	${DEPENDS-LIST} -f -r ${_UNIFIED_DEPENDS:Q}
MISSING-DEPENDS-LIST=		${DEPENDS-LIST} -m ${_UNIFIED_DEPENDS:Q}
BUILD-DEPENDS-LIST=			${DEPENDS-LIST} "${PKG_DEPENDS} ${EXTRACT_DEPENDS} ${PATCH_DEPENDS} ${FETCH_DEPENDS} ${BUILD_DEPENDS} ${LIB_DEPENDS}"
RUN-DEPENDS-LIST=			${DEPENDS-LIST} "${LIB_DEPENDS} ${RUN_DEPENDS}"
TEST-DEPENDS-LIST=			${DEPENDS-LIST} ${TEST_DEPENDS:Q}
CLEAN-DEPENDS-LIST=			${DEPENDS-LIST} -wr ${_UNIFIED_DEPENDS:Q} 
CLEAN-DEPENDS-LIMITED-LIST=	${DEPENDS-LIST} -w ${_UNIFIED_DEPENDS:Q}

.if !target(clean-depends)
clean-depends:
	@for dir in $$(${CLEAN-DEPENDS-LIST}); do \
		(cd $$dir; ${MAKE} NOCLEANDEPENDS=yes clean); \
	done
.endif

.if !target(limited-clean-depends)
limited-clean-depends:
	@for dir in $$(${CLEAN-DEPENDS-LIMITED-LIST}); do \
		(cd $$dir; ${MAKE} NOCLEANDEPENDS=yes clean); \
	done
.endif

.if !target(deinstall-depends)
deinstall-depends:
	@recursive_cmd="deinstall"; \
	    recursive_dirs="$$(${ALL-DEPENDS-FLAVORS-LIST})"; \
		${_FLAVOR_RECURSIVE_SH}
.endif

.if !target(fetch-specials)
fetch-specials:
	@${ECHO_MSG} "===> Fetching all distfiles required by ${PKGNAME} for building"
	@recursive_cmd="fetch"; \
	    recursive_dirs="${_DEPEND_SPECIALS}"; \
		${_FLAVOR_RECURSIVE_SH}
.endif

.if !target(fetch-recursive)
fetch-recursive:
	@${ECHO_MSG} "===> Fetching all distfiles for ${PKGNAME} and dependencies"
	@recursive_cmd="fetch"; \
	    recursive_dirs="${.CURDIR} $$(${ALL-DEPENDS-FLAVORS-LIST})"; \
		${_FLAVOR_RECURSIVE_SH}
.endif

.if !target(fetch-recursive-list)
fetch-recursive-list:
	@recursive_cmd="fetch-list"; \
	    recursive_dirs="${.CURDIR} $$(${ALL-DEPENDS-FLAVORS-LIST})"; \
		${_FLAVOR_RECURSIVE_SH}
.endif

# Used by fetch-required and fetch-required list, this script looks
# at each of the dependencies. If 3 items are specified in the tuple,
# such as foo:graphics/foo:extract, the first item (foo)
# is examined. Only if it begins with a / and does not exist on the
# file-system will ``make targ'' proceed.
# For more usual (dual-item) dependency tuples, the ``make targ''
# proceeds, if the exact package, which the directory WOULD'VE installed,
# is not yet installed.
# This is the exact behaviour of the old code, and it may need
# revisiting. For example, the entire first case seems dubious, and in
# the second case we, probably, should be satisfied with _any_ (earlier)
# package, with the same origin as that of the dir.
#
#	-mi
FETCH_LIST?=	for i in $$deps; do \
		prog=$${i%%:*}; dir=$${i\#*:}; \
		case $$dir in \
		/*) ;; \
		*) dir=${PORTSDIR}/$$dir ;; \
		esac; \
		case $$dir in	\
		*:*) if [ $$prog != $${prog\#/} -o ! -e $$prog ]; then	\
				dir=$${dir%%:*};	\
			else	\
				continue;	\
			fi;;	\
		*) if [ -d ${PKG_DBDIR}/$$(cd $$dir; ${MAKE} -V PKGNAME) ]; then \
				continue;	\
			fi;;	\
		esac;	\
		echo cd $$dir; cd $$dir; ${MAKE} $$targ; \
	done

.if !target(fetch-required)
fetch-required: fetch
.if defined(NO_DEPENDS)
	@${ECHO_MSG} "===> NO_DEPENDS is set, not fetching any other distfiles for ${PKGNAME}"
.else
	@${ECHO_MSG} "===> Fetching all required distfiles for ${PKGNAME} and dependencies"
.for deptype in PKG EXTRACT PATCH FETCH BUILD RUN
.if defined(${deptype}_DEPENDS)
	@targ=fetch; deps="${${deptype}_DEPENDS}"; ${FETCH_LIST}
.endif
.endfor
.endif

.endif

.if !target(fetch-required-list)
fetch-required-list: fetch-list
.if !defined(NO_DEPENDS)
.for deptype in PKG EXTRACT PATCH FETCH BUILD RUN
.if defined(${deptype}_DEPENDS)
	@targ=fetch-list; deps="${${deptype}_DEPENDS}"; ${FETCH_LIST}
.endif
.endfor
.endif
.endif

.if !target(checksum-recursive)
checksum-recursive:
	@${ECHO_MSG} "===> Fetching and checking checksums for ${PKGNAME} and dependencies"
	@recursive_cmd="checksum"; \
	    recursive_dirs="${.CURDIR} $$(${ALL-DEPENDS-FLAVORS-LIST})"; \
		${_FLAVOR_RECURSIVE_SH}
.endif

# Dependency lists: build and runtime.  Print out directory names.

build-depends-list:
.if defined(PKG_DEPENDS) || defined(EXTRACT_DEPENDS) || defined(PATCH_DEPENDS) || defined(FETCH_DEPENDS) || defined(BUILD_DEPENDS) || defined(LIB_DEPENDS)
	@${BUILD-DEPENDS-LIST}
.endif

run-depends-list:
.if defined(LIB_DEPENDS) || defined(RUN_DEPENDS)
	@${RUN-DEPENDS-LIST}
.endif

test-depends-list:
.if defined(TEST_DEPENDS)
	@${TEST-DEPENDS-LIST}
.endif

# Package (recursive runtime) dependency list.  Print out both directory names
# and package names.

package-depends-list:
.if defined(CHILD_DEPENDS) || defined(LIB_DEPENDS) || defined(RUN_DEPENDS)
	@${PACKAGE-DEPENDS-LIST}
.endif

_LIB_RUN_DEPENDS=	${LIB_DEPENDS} ${RUN_DEPENDS}
PACKAGE-DEPENDS-LIST?= \
	if [ "${CHILD_DEPENDS}" ]; then \
		installed=$$(${PKG_INFO} -qO ${PKGORIGIN} 2>/dev/null || \
			${TRUE}); \
		if [ "$$installed" ]; then \
			break; \
		fi; \
		if [ -z "$$installed" ]; then \
			installed="${PKGNAME}"; \
		fi; \
		for pkgname in $$installed; do \
			${ECHO_CMD} "$$pkgname ${.CURDIR} ${PKGORIGIN}"; \
		done; \
	fi; \
	checked="${PARENT_CHECKED}"; \
	for dir in ${_LIB_RUN_DEPENDS:C,[^:]*:([^:]*):?.*,\1,}; do \
		unset flavor; \
		case $${dir} in \
		*@*) \
			flavor=$${dir\#*@}; \
			dir=$${dir%@*}; \
			;; \
		esac; \
		case "$$dir" in \
		/*) ;; \
		*) dir=${PORTSDIR}/$$dir ;; \
		esac ; \
		dir=$$(${REALPATH} $$dir); \
		if [ -d $$dir ]; then \
			case $$checked in	\
			$$dir|$$dir\ *|*\ $$dir|*\ $$dir\ *) continue;;	\
			esac;	\
			childout=$$(cd $$dir; ${SETENV} FLAVOR=$${flavor} ${MAKE} CHILD_DEPENDS=yes PARENT_CHECKED="$$checked" package-depends-list); \
			set -- $$childout; \
			childdir=""; \
			while [ $$\# != 0 ]; do \
				childdir="$$childdir $$2"; \
				${ECHO_CMD} "$$1 $$2 $$3"; \
				shift 3; \
			done; \
			checked="$$dir $$childdir $$checked"; \
		else \
			${ECHO_MSG} "${PKGNAME}: \"$$dir\" non-existent -- dependency list incomplete" >&2; \
		fi; \
	done

ACTUAL-PACKAGE-DEPENDS?= \
	depfiles="" ; \
	for lib in ${LIB_DEPENDS:C/\:.*//}; do \
		depfiles="$$depfiles `${SETENV} LIB_DIRS="${LIB_DIRS}" LOCALBASE="${LOCALBASE}" ${SH} ${SCRIPTSDIR}/find-lib.sh $${lib}`" ; \
	done ; \
	${SETENV} PKG_BIN="${PKG_BIN}" ${SH} ${SCRIPTSDIR}/actual-package-depends.sh $${depfiles} ${RUN_DEPENDS:C/(.*)\:.*/"\1"/}

PKG_NOTES_ENV?=
.for note in ${PKG_NOTES}
PKG_NOTES_ENV+=	dp_PKG_NOTE_${note}=${PKG_NOTE_${note}:Q}
.endfor

create-manifest:
	@${SETENV} \
			dp_SCRIPTSDIR='${SCRIPTSDIR}'                         \
			dp_ACTUAL_PACKAGE_DEPENDS='${ACTUAL-PACKAGE-DEPENDS}' \
			dp_CATEGORIES='${CATEGORIES:u:S/$/,/}'                \
			dp_COMMENT=${COMMENT:Q}                               \
			dp_COMPLETE_OPTIONS_LIST='${COMPLETE_OPTIONS_LIST}'   \
			dp_DEPRECATED=${DEPRECATED:Q}                         \
			dp_DESCR='${DESCR}'                                   \
			dp_EXPIRATION_DATE='${EXPIRATION_DATE}'               \
			dp_GROUPS='${GROUPS:u:S/$/,/}'                        \
			dp_LICENSE='${LICENSE:u:S/$/,/}'                      \
			dp_LICENSE_COMB='${LICENSE_COMB}'                     \
			dp_MAINTAINER='${MAINTAINER}'                         \
			dp_METADIR='${METADIR}'                               \
			dp_NO_ARCH='${NO_ARCH}'                               \
			dp_PKGBASE='${PKGBASE}'                               \
			dp_PKGDEINSTALL='${PKGDEINSTALL}'                     \
			dp_PKGINSTALL='${PKGINSTALL}'                         \
			dp_PKGMESSAGES='${_PKGMESSAGES}'                      \
			dp_PKGORIGIN='${PKGORIGIN}'                           \
			dp_PKGPOSTDEINSTALL='${PKGPOSTDEINSTALL}'             \
			dp_PKGPOSTINSTALL='${PKGPOSTINSTALL}'                 \
			dp_PKGPOSTUPGRADE='${PKGPOSTUPGRADE}'                 \
			dp_PKGPREDEINSTALL='${PKGPREDEINSTALL}'               \
			dp_PKGPREINSTALL='${PKGPREINSTALL}'                   \
			dp_PKGPREUPGRADE='${PKGPREUPGRADE}'                   \
			dp_PKGUPGRADE='${PKGUPGRADE}'                         \
			dp_PKGVERSION='${PKGVERSION}'                         \
			dp_PKG_BIN='${PKG_BIN}'                               \
			dp_PKG_IGNORE_DEPENDS='${PKG_IGNORE_DEPENDS}'         \
			dp_PKG_NOTES='${PKG_NOTES}'                           \
			dp_PORT_OPTIONS='${PORT_OPTIONS}'                     \
			dp_PREFIX='${PREFIX}'                                 \
			dp_USERS='${USERS:u:S/$/,/}'                          \
			dp_WWW='${WWW}'                                       \
			${PKG_NOTES_ENV}                                      \
			${SH} ${SCRIPTSDIR}/create-manifest.sh


# Print out package names.

package-depends:
	@${PACKAGE-DEPENDS-LIST} | ${AWK} '{print $$1":"$$3}'

actual-package-depends:
	@${ACTUAL-PACKAGE-DEPENDS}

# Build packages for port and dependencies

package-recursive: package
	@recursive_cmd="package-noinstall"; \
	    recursive_dirs="$$(${ALL-DEPENDS-FLAVORS-LIST})"; \
		${_FLAVOR_RECURSIVE_SH}

# Show missing dependencies
missing:
	@for dir in $$(${MISSING-DEPENDS-LIST}); do \
		echo $${dir#${PORTSDIR}/}; \
	done

# Show missing dependencies by name
missing-packages:
	@_packages=$$(${PKG_INFO} -aq); \
	for dir in $$(${ALL-DEPENDS-LIST}); do \
		_p=$$(cd $$dir; ${MAKE} -VPKGNAME); \
		if ! $$(${ECHO_CMD} $${_packages} | ${GREP} -q $${_p}); then \
			${ECHO_CMD} $${_p}; \
		fi; \
	done

################################################################
# Everything after here are internal targets and really
# shouldn't be touched by anybody but the release engineers.
################################################################

# This target generates an index entry suitable for aggregation into
# a large index.  Format is:
#
# distribution-name|port-path|installation-prefix|comment| \
#  description-file|maintainer|categories|extract-depends| \
#  patch-depends|fetch-depends|build-depends|run-depends|www site
#
# If this ever changes, portmgr should contact the portsnap maintainer
# first to avoid gratuitous breakage.

. if !target(describe)
_EXTRACT_DEPENDS=${EXTRACT_DEPENDS:C/^[^ :]+:([^ :@]+)(@[^ :]+)?(:[^ :]+)?/\1/:O:u:C,(^[^/]),${PORTSDIR}/\1,}
_PATCH_DEPENDS=${PATCH_DEPENDS:C/^[^ :]+:([^ :@]+)(@[^ :]+)?(:[^ :]+)?/\1/:O:u:C,(^[^/]),${PORTSDIR}/\1,}
_FETCH_DEPENDS=${FETCH_DEPENDS:C/^[^ :]+:([^ :@]+)(@[^ :]+)?(:[^ :]+)?/\1/:O:u:C,(^[^/]),${PORTSDIR}/\1,}
_LIB_DEPENDS=${LIB_DEPENDS:C/^[^ :]+:([^ :@]+)(@[^ :]+)?(:[^ :]+)?/\1/:O:u:C,(^[^/]),${PORTSDIR}/\1,}
_BUILD_DEPENDS=${BUILD_DEPENDS:C/^[^ :]+:([^ :@]+)(@[^ :]+)?(:[^ :]+)?/\1/:O:u:C,(^[^/]),${PORTSDIR}/\1,} ${_LIB_DEPENDS}
_RUN_DEPENDS=${RUN_DEPENDS:C/^[^ :]+:([^ :@]+)(@[^ :]+)?(:[^ :]+)?/\1/:O:u:C,(^[^/]),${PORTSDIR}/\1,} ${_LIB_DEPENDS}
. if exists(${DESCR})
_DESCR=${DESCR}
. else
_DESCR=/dev/null
. endif

.  if defined(BUILDING_INDEX) && defined(INDEX_PORTS)
INDEX_OUT=${INDEX_TMPDIR}/${INDEXFILE}.desc.aggr
.  else
INDEX_OUT=/dev/stdout
.  endif

.  if empty(FLAVORS) || defined(_DESCRIBE_WITH_FLAVOR)
describe:
	@(${ECHO_CMD} -n "${PKGNAME}|${.CURDIR}|${PREFIX}|"; \
	${ECHO_CMD} -n ${COMMENT:Q}; \
	${ECHO_CMD} -n "|${_DESCR}|${MAINTAINER}|${CATEGORIES}|${_EXTRACT_DEPENDS}|${_PATCH_DEPENDS}|${_FETCH_DEPENDS}|${_BUILD_DEPENDS:O:u}|${_RUN_DEPENDS:O:u}|"; \
	while read one two discard; do \
		case "$$one" in \
		WWW:)   case "$$two" in \
			https://*|http://*|ftp://*) ${ECHO_CMD} -n "$$two" ;; \
			*) ${ECHO_CMD} -n "http://$$two" ;; \
			esac; \
			break; \
			;; \
		esac; \
	done < ${DESCR}; ${ECHO_CMD}) >>${INDEX_OUT}
.  else # empty(FLAVORS)
describe: ${FLAVORS:S/^/describe-/}
.   for f in ${FLAVORS}
describe-${f}:
	@cd ${.CURDIR} && ${SETENV} FLAVOR=${f} ${MAKE} -B -D_DESCRIBE_WITH_FLAVOR describe
.   endfor
.  endif # empty(FLAVORS)
. endif

www-site:
.if exists(${DESCR})
	@${AWK} '$$1 ~ /^WWW:/ {print $$2}' ${DESCR} | ${HEAD} -1
.else
	@${ECHO_CMD}
.endif

.if !target(readmes)
readmes:	readme
.endif

.if !target(readme)
readme:
	@${RM} ${.CURDIR}/README.html
	@cd ${.CURDIR} && ${MAKE} ${.CURDIR}/README.html
.endif

${.CURDIR}/README.html:
	@${ECHO_MSG} "===>   Creating README.html for ${PKGNAME}"
	@${SED} -e 's|%%PORT%%|'$$(${ECHO_CMD} ${.CURDIR} | \
							  ${SED} -e 's|.*/\([^/]*/[^/]*\)$$|\1|')'|g' \
			-e 's|%%PKG%%|${PKGNAME}|g' \
			-e 's|%%COMMENT%%|'"$$(${ECHO_CMD} ${COMMENT:Q})"'|' \
			-e '/%%COMMENT%%/d' \
			-e 's|%%DESCR%%|'"$$(${ECHO_CMD} ${DESCR} | \
								 ${SED} -e 's|${.CURDIR}/||')"'|' \
			-e 's|%%EMAIL%%|'"$$(${ECHO_CMD} "${MAINTAINER}" | \
								 ${SED} -e 's/([^)]*)//;s/.*<//;s/>.*//')"'|g' \
			-e 's|%%MAINTAINER%%|${MAINTAINER}|g' \
			-e 's|%%WEBSITE%%|'"$$(cd ${.CURDIR} && eval ${MAKE} pretty-print-www-site)"'|' \
			-e 's|%%BUILD_DEPENDS%%|'"$$(cd ${.CURDIR} && eval ${MAKE} pretty-print-build-depends-list)"'|' \
			-e 's|%%RUN_DEPENDS%%|'"$$(cd ${.CURDIR} && eval ${MAKE} pretty-print-run-depends-list)"'|' \
			-e 's|%%TOP%%|'"$$(${ECHO_CMD} ${CATEGORIES} | \
							   ${SED} -e 's| .*||' -e 's|[^/]*|..|g')"'/..|' \
		${TEMPLATES}/README.port >> ${.TARGET}

# The following two targets require an up-to-date INDEX in ${PORTSDIR}

_PRETTY_PRINT_DEPENDS_LIST=\
	if [ ! -r ${INDEXDIR}/${INDEXFILE} ] ; then \
		${ECHO_MSG} "${.TARGET} requires an INDEX file (${INDEXFILE}). Please run make index or make fetchindex."; \
	else \
		target=${.TARGET:C/pretty-print-(.*)-depends-list/\1/} ; \
		if [ "$$target" = "build" ] ; then fldnum=8 ; else fldnum=9 ; fi; \
		${ECHO_MSG} -n 'This port requires package(s) "' ; \
		${ECHO_MSG} -n `${AWK} -F\| "\\$$1 ~ /^${PKGNAME}/ {print \\$$$${fldnum};}" ${INDEXDIR}/${INDEXFILE}` ; \
		${ECHO_MSG} "\" to $$target."; \
	fi;


.if !target(pretty-print-build-depends-list)
pretty-print-build-depends-list:
.if defined(PKG_DEPENDS) || defined(EXTRACT_DEPENDS) || defined(PATCH_DEPENDS) || \
	defined(FETCH_DEPENDS) || defined(BUILD_DEPENDS) || defined(LIB_DEPENDS)
	@${_PRETTY_PRINT_DEPENDS_LIST}
.endif
.endif

.if !target(pretty-print-run-depends-list)
pretty-print-run-depends-list:
.if defined(RUN_DEPENDS) || defined(LIB_DEPENDS)
	@${_PRETTY_PRINT_DEPENDS_LIST}
.endif
.endif

_SUB_LIST_TEMP=	${SUB_LIST:S/$/!g/:S/^/ -e s!%%/:S/=/%%!/}
.if !target(apply-slist)
apply-slist:
.if defined(SUB_FILES)
.for file in ${SUB_FILES}
.if !exists(${FILESDIR}/${file}.in)
	@${ECHO_MSG} "** Missing ${FILESDIR}/${file}.in for ${PKGNAME}."; exit 1
.else
	@${SED} ${_SUB_LIST_TEMP} -e '/^@comment /d' ${FILESDIR}/${file}.in > ${WRKDIR}/${file}
.endif
.endfor
.for i in pkg-message pkg-install pkg-deinstall pkg-req
.if ${SUB_FILES:M${i}*}!=""
${i:S/-//:tu}=	${WRKDIR}/${SUB_FILES:M${i}*}
.endif
.endfor
.endif
.endif

# Generate packing list.  Also tests to make sure all required package
# files exist.

.if !target(generate-plist)
generate-plist: ${WRKDIR}
	@${ECHO_MSG} "===>   Generating temporary packing list"
	@${MKDIR} ${TMPPLIST:H}
	@if [ ! -f ${DESCR} ]; then ${ECHO_MSG} "** Missing pkg-descr for ${PKGNAME}."; exit 1; fi
	@>${TMPPLIST}
	@for file in ${PLIST_FILES}; do \
		${ECHO_CMD} $${file} | ${SED} ${PLIST_SUB:S/$/!g/:S/^/ -e s!%%/:S/=/%%!/} >> ${TMPPLIST}; \
	done
.if !empty(PLIST)
	@if [ -f ${PLIST} ]; then \
		${SED} ${PLIST_SUB:S/$/!g/:S/^/ -e s!%%/:S/=/%%!/} ${PLIST} >> ${TMPPLIST}; \
	fi
.endif

.for dir in ${PLIST_DIRS}
	@${ECHO_CMD} ${dir} | ${SED} ${PLIST_SUB:S/$/!g/:S/^/ -e s!%%/:S/=/%%!/} -e 's,^,@dir ,' >> ${TMPPLIST}
.endfor

.if defined(USE_LINUX_PREFIX)
.if defined(USE_LDCONFIG)
	@${ECHO_CMD} '@preexec [ -n "`/sbin/sysctl -q compat.linux.osrelease`" ] || ( echo "Cannot install package: kernel missing Linux support"; exit 1 )' >> ${TMPPLIST}
	@${ECHO_CMD} "@postexec ${LINUXBASE}/sbin/ldconfig" >> ${TMPPLIST}
	@${ECHO_CMD} "@postunexec ${LINUXBASE}/sbin/ldconfig" >> ${TMPPLIST}
.endif
.else
.if defined(USE_LDCONFIG) || defined(USE_LDCONFIG32)
.if !defined(INSTALL_AS_USER)
	@${ECHO_CMD} "@postexec /usr/sbin/service ldconfig restart > /dev/null" >> ${TMPPLIST}
	@${ECHO_CMD} "@postunexec /usr/sbin/service ldconfig restart > /dev/null" >> ${TMPPLIST}
.else
	@${ECHO_CMD} "@postexec /usr/sbin/service ldconfig restart > /dev/null || ${TRUE}" >> ${TMPPLIST}
	@${ECHO_CMD} "@postunexec /usr/sbin/service ldconfig restart > /dev/null || ${TRUE}" >> ${TMPPLIST}
.endif
.endif
.endif
.endif

${TMPPLIST}:
	@cd ${.CURDIR} && ${MAKE} generate-plist

.for _type in EXAMPLES DOCS
.if !empty(_REALLY_ALL_POSSIBLE_OPTIONS:M${_type})
.if !target(add-plist-${_type:tl})
.if defined(PORT${_type}) && !empty(PORT_OPTIONS:M${_type})
add-plist-${_type:tl}:
.for x in ${PORT${_type}}
	@if ${ECHO_CMD} "${x}"| ${AWK} '$$1 ~ /(\*|\||\[|\]|\?|\{|\}|\$$)/ { exit 1};'; then \
		if [ ! -e ${STAGEDIR}${${_type}DIR}/${x} ]; then \
		${ECHO_CMD} ${${_type}DIR}/${x} >> ${TMPPLIST}; \
	fi;fi
.endfor
	@${FIND} -P ${PORT${_type}:S/^/${STAGEDIR}${${_type}DIR}\//} ! -type d 2>/dev/null | \
		${SED} -ne 's,^${STAGEDIR},,p' >> ${TMPPLIST}
.endif
.endif
.endif
.endfor

.if !target(add-plist-data)
.if defined(PORTDATA)
add-plist-data:
.for x in ${PORTDATA}
	@if ${ECHO_CMD} "${x}"| ${AWK} '$$1 ~ /(\*|\||\[|\]|\?|\{|\}|\$$)/ { exit 1};'; then \
		if [ ! -e ${STAGEDIR}${DATADIR}/${x} ]; then \
		${ECHO_CMD} ${DATADIR}/${x} >> ${TMPPLIST}; \
	fi;fi
.endfor
	@${FIND} -P ${PORTDATA:S/^/${STAGEDIR}${DATADIR}\//} ! -type d 2>/dev/null | \
		${SED} -ne 's,^${STAGEDIR},,p' >> ${TMPPLIST}
.endif
.endif

.if !target(add-plist-info)
.if defined(INFO)
add-plist-info:
.for i in ${INFO}
	@${LS} ${STAGEDIR}${PREFIX}/${INFO_PATH}/$i.info* | ${SED} -e s:${STAGEDIR}:@info\ :g >> ${TMPPLIST}
.endfor
.endif
.endif

# If we're installing into a non-standard PREFIX, we need to remove that directory at
# deinstall-time
.if !target(add-plist-post)
.if (${PREFIX} != ${LOCALBASE} && ${PREFIX} != ${LINUXBASE} && \
    ${PREFIX} != "/usr" && ${PREFIX} != "/" && !defined(NO_PREFIX_RMDIR))
add-plist-post:
	@${ECHO_CMD} "@dir ${PREFIX}" >> ${TMPPLIST}
.endif
.endif

.if !target(install-rc-script)
.if defined(USE_RC_SUBR)
install-rc-script:
	@${ECHO_MSG} "===> Staging rc.d startup script(s)"
	@for i in ${USE_RC_SUBR}; do \
		_prefix=${PREFIX}; \
		[ "${PREFIX}" = "/usr" ] && _prefix="" ; \
		${INSTALL_SCRIPT} ${WRKDIR}/$${i} ${STAGEDIR}$${_prefix}/etc/rc.d/$${i%.sh}; \
		${ECHO_CMD} "$${_prefix}/etc/rc.d/$${i%.sh}" >> ${TMPPLIST}; \
	done
.endif
.endif

.if !target(check-man)
check-man: stage
	@${ECHO_MSG} "====> Checking man pages (check-man)"
	@mdirs= ; \
	for dir in ${MANDIRS:S/^/${STAGEDIR}/} ; do \
		[ -d $$dir ] && mdirs="$$mdirs $$dir" ;\
	done ; \
	err=0 ; \
	for dir in $$mdirs; do \
		for f in $$(find $$dir -name "*.gz"); do \
			${ECHO_CMD} "===> Checking $${f##*/}" ; \
			gunzip -c $$f | mandoc -Tlint -Werror && continue ; \
			err=1 ; \
		done ; \
	done ; \
	exit $$err
.endif

# Compress all manpage not already compressed which are not hardlinks
# Find all manpages which are not compressed and are hadlinks, and only get the list of inodes concerned, for each of them compress the first one found and recreate the hardlinks for the others
# Fixes all dead symlinks left by the previous round
.if !target(compress-man)
compress-man:
	@${ECHO_MSG} "====> Compressing man pages (compress-man)"
	@mdirs= ; \
	for dir in ${MANDIRS:S/^/${STAGEDIR}/} ; do \
		[ -d $$dir ] && mdirs="$$mdirs $$dir" ;\
	done ; \
	for dir in $$mdirs; do \
		${FIND} $$dir -type f \! -name "*.gz" -links 1 -exec ${GZIP_CMD} {} \; ; \
		${FIND} $$dir -type f \! -name "*.gz" \! -links 1 -exec ${STAT} -f '%i' {} \; | \
			${SORT} -u | while read inode ; do \
				unset ref ; \
				for f in $$(${FIND} $$dir -type f -inum $${inode} -print); do \
					if [ -z $$ref ]; then \
						ref=$${f}.gz ; \
						${GZIP_CMD} $${f} ; \
						continue ; \
					fi ; \
					${RM} $${f} ; \
					(cd $${f%/*}; ${LN} -f $${ref##*/} $${f##*/}.gz) ; \
				done ; \
			done ; \
		${FIND} $$dir -type l \! -name "*.gz" | while read link ; do \
				${LN} -sf $$(readlink $$link).gz $$link.gz ;\
				${RM} $$link ; \
		done; \
	done
.endif

.if !target(stage-dir)
stage-dir: ${STAGEDIR}${PREFIX}
.if !defined(NO_MTREE)
	@${MTREE_CMD} ${MTREE_ARGS} ${STAGEDIR}${PREFIX} > /dev/null
.endif
.endif

.if !target(makeplist)
makeplist: stage
	@${SETENV} ${CO_ENV} ${SH} ${SCRIPTSDIR}/check-stagedir.sh makeplist
.endif

.if !target(check-plist)
check-plist: stage
	@${ECHO_MSG} "====> Checking for pkg-plist issues (check-plist)"
	@${SETENV} ${CO_ENV} ${SH} ${SCRIPTSDIR}/check-stagedir.sh checkplist
	@${ECHO_MSG} "===> No pkg-plist issues found (check-plist)"
.endif

.if !target(check-orphans)
check-orphans: check-plist
.endif

.if !target(stage-qa)
stage-qa:
	@${ECHO_MSG} "====> Running Q/A tests (stage-qa)"
	@${SETENV} ${QA_ENV} ${SH} ${SCRIPTSDIR}/qa.sh
.if !defined(DEVELOPER)
	@${ECHO_MSG} "/!\\ To run stage-qa automatically add DEVELOPER=yes to your environment /!\\"
.endif
.endif

pretty-flavors-package-names: .PHONY
.if empty(FLAVORS)
	@${ECHO_CMD} "no flavor: ${PKGNAME}"
.else
.for f in ${FLAVORS}
	@${ECHO_CMD} -n "${f}: "
	@cd ${.CURDIR} && ${SETENV} FLAVOR=${f} ${MAKE} -B -V PKGNAME
.endfor
.endif

flavors-package-names: .PHONY
.if empty(FLAVORS)
	@${ECHO_CMD} "${PKGNAME}"
.else
.for f in ${FLAVORS}
	@cd ${.CURDIR} && ${SETENV} FLAVOR=${f} ${MAKE} -B -V PKGNAME
.endfor
.endif

# Fake installation of package so that user can pkg delete it later.
.if !target(fake-pkg)
STAGE_ARGS=		-i ${STAGEDIR}

.if !defined(NO_PKG_REGISTER)
fake-pkg:
.if defined(INSTALLS_DEPENDS)
	@${ECHO_MSG} "===>   Registering installation for ${PKGNAME} as automatic"
.else
	@${ECHO_MSG} "===>   Registering installation for ${PKGNAME}"
.endif
.if defined(INSTALLS_DEPENDS)
	@${SETENV} ${PKG_ENV} FORCE_POST="${_FORCE_POST_PATTERNS}" ${PKG_REGISTER} -d ${STAGE_ARGS} -m ${METADIR} -f ${TMPPLIST}
.else
	@${SETENV} ${PKG_ENV} FORCE_POST="${_FORCE_POST_PATTERNS}" ${PKG_REGISTER} ${STAGE_ARGS} -m ${METADIR} -f ${TMPPLIST}
.endif
	@${RM} -r ${METADIR}
.endif
.endif

# Depend is generally meaningless for arbitrary ports, but if someone wants
# one they can override this.  This is just to catch people who've gotten into
# the habit of typing `make depend all install' as a matter of course.
# Same goes for tags
.for _t in depend tags
.if !target(${_t})
${_t}:
.endif
.endfor

.if !defined(NOPRECIOUSMAKEVARS)
# These won't change, so we can pass them through the environment
.for var in ${_EXPORTED_VARS}
.if empty(.MAKEFLAGS:M${var}=*) && !empty(${var})
.MAKEFLAGS:	${var}=${${var}:Q}
.endif
.endfor
.endif
PORTS_ENV_VARS+=	${_EXPORTED_VARS}

.if !target(pre-check-config)
pre-check-config:
_CHECK_OPTIONS_NAMES=	OPTIONS_DEFINE
_CHECK_OPTIONS_NAMES+=	${OPTIONS_GROUP:S/^/OPTIONS_GROUP_/}
_CHECK_OPTIONS_NAMES+=	${OPTIONS_MULTI:S/^/OPTIONS_MULTI_/}
_CHECK_OPTIONS_NAMES+=	${OPTIONS_RADIO:S/^/OPTIONS_RADIO_/}
_CHECK_OPTIONS_NAMES+=	${OPTIONS_SINGLE:S/^/OPTIONS_SINGLE_/}
.for var in ${_CHECK_OPTIONS_NAMES}
.  if defined(${var})
.    for o in ${${var}}
.      if ${o:C/[-_[:upper:][:digit:]]//g}
OPTIONS_BAD_NAMES+=	${o}
.      endif
.    endfor
.  endif
.endfor
.if defined(OPTIONS_BAD_NAMES) && !empty(OPTIONS_BAD_NAMES)
DEV_WARNING+=	"These options name have characters outside of [-_A-Z0-9]:"
DEV_WARNING+=	"${OPTIONS_BAD_NAMES:O:u}"
.endif
.for single in ${OPTIONS_SINGLE}
.  for opt in ${OPTIONS_SINGLE_${single}}
.    if empty(ALL_OPTIONS:M${single}) || !empty(PORT_OPTIONS:M${single})
.      if !empty(PORT_OPTIONS:M${opt})
OPTIONS_WRONG_SINGLE_${single}+=	${opt}
.        if defined(OPTFOUND)
OPTIONS_WRONG_SINGLE+=	${single}
.        else
OPTFOUND=	true
.        endif
.      endif
.    else
# if conditional and if the condition is unchecked, remove opt from the list of
# set options
PORT_OPTIONS:=	${PORT_OPTIONS:N${opt}}
OPTNOCHECK=	true
.    endif
.  endfor
.  if !defined(OPTFOUND) && !defined(OPTNOCHECK)
OPTIONS_WRONG_SINGLE+=	${single}
.  endif
.  undef OPTFOUND
.  undef OPTNOCHECK
.endfor
.undef single

.for radio in ${OPTIONS_RADIO}
.  for opt in ${OPTIONS_RADIO_${radio}}
.    if !empty(PORT_OPTIONS:M${opt})
OPTIONS_WRONG_RADIO_${radio}+=	${opt}
.      if defined(OPTFOUND)
OPTIONS_WRONG_RADIO+=	${radio}
.      else
OPTFOUND=	true
.      endif
.    endif
.  endfor
.  undef OPTFOUND
.endfor

.for multi in ${OPTIONS_MULTI}
.  for opt in ${OPTIONS_MULTI_${multi}}
.    if empty(ALL_OPTIONS:M${multi}) || !empty(PORT_OPTIONS:M${multi})
.      if !empty(PORT_OPTIONS:M${opt})
OPTFOUND=	true
.      endif
.    else
# if conditional and if the condition is unchecked, remove opt from the list of
# set options
PORT_OPTIONS:=	${PORT_OPTIONS:N${opt}}
OPTNOCHECK=	true
.    endif
.  endfor
.  if !defined(OPTFOUND) && !defined(OPTNOCHECK)
OPTIONS_WRONG_MULTI+=	${multi}
.  endif
.  undef OPTFOUND
.  undef OPTNOCHECK
.endfor
.undef multi

.for opt in ${PORT_OPTIONS}
.  for conflict in ${${opt}_PREVENTS}
.    if ${PORT_OPTIONS:M${conflict}}
.      if empty(OPTIONS_WRONG_PREVENTS:M${opt})
OPTIONS_WRONG_PREVENTS+=	${opt}
.      endif
OPTIONS_WRONG_PREVENTS_${opt}+=	${conflict}
.    endif
.  endfor
.endfor
.undef conflict
.undef opt
.endif #pre-check-config

.if !target(_check-config)
_check-config: pre-check-config
.for multi in ${OPTIONS_WRONG_MULTI}
	@${ECHO_MSG} "====> You must check at least one option in the ${multi} multi"
.endfor
.for single in ${OPTIONS_WRONG_SINGLE}
	@${ECHO_MSG} "====> You must select one and only one option from the ${single} single"
.if defined(OPTIONS_WRONG_SINGLE_${single})
	@${ECHO_MSG} "=====> Only one of these must be defined: ${OPTIONS_WRONG_SINGLE_${single}}"
.else
	@${ECHO_MSG} "=====> No option was selected (and one must be)"
.endif
.endfor
.for radio in ${OPTIONS_WRONG_RADIO}
	@${ECHO_MSG} "====> You cannot select multiple options from the ${radio} radio"
	@${ECHO_MSG} "=====> Only one of these must be defined: ${OPTIONS_WRONG_RADIO_${radio}}"
.endfor
.if defined(OPTIONS_WRONG_PREVENTS)
	@${ECHO_MSG} "====> Two or more enabled options conflict with each other"
.  for prevents in ${OPTIONS_WRONG_PREVENTS}
	@${ECHO_MSG} "=====> Option ${prevents} conflicts with ${OPTIONS_WRONG_PREVENTS_${prevents}} (select only one)"
.    if defined(${prevents}_PREVENTS_MSG)
	@${ECHO_MSG} "======> ${${prevents}_PREVENTS_MSG}"
.    endif
.  endfor
.endif
.if !empty(OPTIONS_WRONG_MULTI) || !empty(OPTIONS_WRONG_SINGLE) || !empty(OPTIONS_WRONG_RADIO) || !empty(OPTIONS_WRONG_PREVENTS)
_CHECK_CONFIG_ERROR=	true
.endif
.endif # _check-config

.if !target(check-config)
check-config: _check-config
.if !empty(_CHECK_CONFIG_ERROR)
	@${FALSE}
.endif
.endif # check-config

.if !target(sanity-config)
sanity-config: _check-config
.if !empty(_CHECK_CONFIG_ERROR)
	@echo -n "Config is invalid. Re-edit? [Y/n] "; \
	read answer; \
	case $$answer in \
	[Nn]|[Nn][Oo]) \
		exit 0; \
	esac; \
	cd ${.CURDIR} && ${MAKE} config
.endif
.endif # sanity-config

.if !target(pre-config)
pre-config:
D4P_ENV=	PKGNAME="${PKGNAME}" \
		PORT_OPTIONS="${PORT_OPTIONS}" \
		ALL_OPTIONS="${ALL_OPTIONS}" \
		OPTIONS_MULTI="${OPTIONS_MULTI}" \
		OPTIONS_SINGLE="${OPTIONS_SINGLE}" \
		OPTIONS_RADIO="${OPTIONS_RADIO}" \
		OPTIONS_GROUP="${OPTIONS_GROUP}" \
		NEW_OPTIONS="${NEW_OPTIONS}" \
		DIALOG4PORTS="${DIALOG4PORTS}" \
		PREFIX="${PREFIX}" \
		LOCALBASE="${LOCALBASE}" \
		PORTSDIR="${PORTSDIR}" \
		MAKE="${MAKE}" \
		D4PHEIGHT="${D4PHEIGHT}" \
		D4PWIDTH="${D4PWIDTH}" \
		D4PFULLSCREEN="${D4PFULLSCREEN}"
.if exists(${PKGHELP})
D4P_ENV+=	PKGHELP="${PKGHELP}"
.endif
.for opt in ${ALL_OPTIONS}
D4P_ENV+=	 ${opt}_DESC=""${${opt}_DESC:Q}""
.endfor
.for otype in MULTI GROUP SINGLE RADIO
.  for m in ${OPTIONS_${otype}}
D4P_ENV+=	OPTIONS_${otype}_${m}="${OPTIONS_${otype}_${m}}" \
		${m}_DESC=""${${m}_DESC:Q}""
.    for opt in ${OPTIONS_${otype}_${m}}
D4P_ENV+=	 ${opt}_DESC=""${${opt}_DESC:Q}""
.    endfor
.  endfor
.endfor
.undef m
.undef otype
.undef opt
.endif # pre-config

.if !target(do-config)
do-config:
.if empty(ALL_OPTIONS) && empty(OPTIONS_SINGLE) && empty(OPTIONS_MULTI) && empty(OPTIONS_RADIO) && empty(OPTIONS_GROUP)
	@${ECHO_MSG} "===> No options to configure"
.else
	@optionsdir=${OPTIONS_FILE:H}; \
	if [ ! -w "${PORT_DBDIR}" -a "`stat -f %u ${PORT_DBDIR:H}`" = 0 ]; \
	then \
		${ECHO_MSG} "===>  Switching to root credentials to create $${optionsdir}"; \
		(${SU_CMD} "${SH} -c \"${MKDIR} $${optionsdir} 2> /dev/null\"") || \
			(${ECHO_MSG} "===> Cannot create $${optionsdir}, check permissions"; exit 1); \
		${ECHO_MSG} "===>  Returning to user credentials" ; \
	else \
	${MKDIR} $${optionsdir} 2> /dev/null || \
	(${ECHO_MSG} "===> Cannot create $${optionsdir}, check permissions"; exit 1) ; \
	fi
	@TMPOPTIONSFILE=$$(mktemp -t portoptions); \
	trap "${RM} $${TMPOPTIONSFILE}; exit 1" 1 2 3 5 10 13 15; \
	${SETENV} ${D4P_ENV} ${SH} ${SCRIPTSDIR}/dialog4ports.sh $${TMPOPTIONSFILE} || { \
		${RM} $${TMPOPTIONSFILE}; \
		${ECHO_MSG} "===> Options unchanged"; \
		exit 0; \
	}; \
	${ECHO_CMD}; \
	if [ ! -e $${TMPOPTIONSFILE} ]; then \
		${ECHO_MSG} "===> No user-specified options to save for ${PKGNAME}"; \
		exit 0; \
	fi; \
	SELOPTIONS=$$(${CAT} $${TMPOPTIONSFILE}); \
	${RM} $${TMPOPTIONSFILE}; \
	TMPOPTIONSFILE=$$(mktemp -t portoptions); \
	trap "${RM} $${TMPOPTIONSFILE}; exit 1" 1 2 3 5 10 13 15; \
	${ECHO_CMD} "# This file is auto-generated by 'make config'." > $${TMPOPTIONSFILE}; \
	${ECHO_CMD} "# Options for ${PKGNAME}" >> $${TMPOPTIONSFILE}; \
	${ECHO_CMD} "_OPTIONS_READ=${PKGNAME}" >> $${TMPOPTIONSFILE}; \
	${ECHO_CMD} "_FILE_COMPLETE_OPTIONS_LIST=${COMPLETE_OPTIONS_LIST}" >> $${TMPOPTIONSFILE}; \
	for i in ${COMPLETE_OPTIONS_LIST}; do \
		if ${ECHO_CMD} $${SELOPTIONS} | ${GREP} -qw $${i}; then \
			${ECHO_CMD} "OPTIONS_FILE_SET+=$${i}" >> $${TMPOPTIONSFILE}; \
		else \
			${ECHO_CMD} "OPTIONS_FILE_UNSET+=$${i}" >> $${TMPOPTIONSFILE}; \
		fi; \
	done; \
	if [ ! -w "${OPTIONS_FILE:H}" -a "`stat -f %u ${OPTIONS_FILE:H}`" != ${UID} ]; \
	then \
		${ECHO_MSG} "===>  Switching to root credentials to write ${OPTIONS_FILE}"; \
		${SU_CMD} "${CAT} $${TMPOPTIONSFILE} > ${OPTIONS_FILE}"; \
		${ECHO_MSG} "===>  Returning to user credentials"; \
	else \
		${CAT} $${TMPOPTIONSFILE} > ${OPTIONS_FILE}; \
	fi; \
	${RM} $${TMPOPTIONSFILE}
	@cd ${.CURDIR} && ${MAKE} sanity-config
.endif
.endif # do-config

.if !target(config)
.if !defined(NO_DIALOG)
config: pre-config do-config
.else
config:
	@${ECHO_MSG} "===> Skipping 'config' as NO_DIALOG is defined"
.endif
.endif # config

.if !target(config-recursive)
config-recursive:
	@${ECHO_MSG} "===> Setting user-specified options for ${PKGNAME} and dependencies";
	@recursive_cmd="config-conditional"; \
	    recursive_dirs="${.CURDIR} $$(${ALL-DEPENDS-FLAVORS-LIST})"; \
		${_FLAVOR_RECURSIVE_SH}
.endif # config-recursive

.if !target(config-conditional)
config-conditional:
.if !empty(NEW_OPTIONS)
	@cd ${.CURDIR} && ${MAKE} config;
.endif
.endif # config-conditional

.if !target(showconfig) && (make(*config*) || (!empty(.MAKEFLAGS:M-V) && !empty(.MAKEFLAGS:M*_DESC)))
.include "${PORTSDIR}/Mk/bsd.options.desc.mk"
MULTI_EOL=	: you have to choose at least one of them
SINGLE_EOL=	: you have to select exactly one of them
RADIO_EOL=	: you can only select none or one of them
showconfig: check-config
.if !empty(COMPLETE_OPTIONS_LIST)
	@${ECHO_MSG} "===> The following configuration options are available for ${PKGNAME}":
.for opt in ${ALL_OPTIONS}
	@[ -z "${PORT_OPTIONS:M${opt}}" ] || match="on" ; ${ECHO_MSG} -n "     ${opt}=$${match:-off}"
.  if !empty(${opt}_DESC)
	@${ECHO_MSG} -n ": "${${opt}_DESC:Q}
.  endif
	@${ECHO_MSG} ""
.endfor

#multi and conditional multis
.for otype in MULTI GROUP SINGLE RADIO
.  for m in ${OPTIONS_${otype}}
.    if empty(${m}_DESC)
		@${ECHO_MSG} "====> Options available for the ${otype:tl} ${m}${${otype}_EOL}"
.    else
		@${ECHO_MSG} "====> ${${m}_DESC}${${otype}_EOL}"
.    endif
.    for opt in ${OPTIONS_${otype}_${m}}
	@[ -z "${PORT_OPTIONS:M${opt}}" ] || match="on" ; ${ECHO_MSG} -n "     ${opt}=$${match:-off}"
.      if !empty(${opt}_DESC)
	@${ECHO_MSG} -n ": "${${opt}_DESC:Q}
.      endif
	@${ECHO_MSG} ""
.    endfor
.  endfor
.endfor

.undef otype
.undef m
.undef opt
	@${ECHO_MSG} "===> Use 'make config' to modify these settings"
.endif
.endif # showconfig

.if !target(showconfig-recursive)
showconfig-recursive:
	@${ECHO_MSG} "===> The following configuration options are available for ${PKGNAME} and dependencies";
	@recursive_cmd="showconfig"; \
	    recursive_dirs="${.CURDIR} $$(${ALL-DEPENDS-FLAVORS-LIST})"; \
		${_FLAVOR_RECURSIVE_SH}
.endif # showconfig-recursive

.if !target(rmconfig)
rmconfig:
.if exists(${OPTIONS_FILE})
	-@${ECHO_MSG} "===> Removing user-configured options for ${PKGNAME}"; \
	optionsdir=${OPTIONS_FILE:H}; \
	if [ ${UID} != 0 -a "x${INSTALL_AS_USER}" = "x" -a ! -w "${OPTIONS_FILE}" ]; then \
		${ECHO_MSG} "===> Switching to root credentials to remove ${OPTIONS_FILE} and $${optionsdir}"; \
		${SU_CMD} "${RM} ${OPTIONS_FILE} ; \
			${RMDIR} $${optionsdir}"; \
		${ECHO_MSG} "===> Returning to user credentials"; \
	else \
		${RM} ${OPTIONS_FILE}; \
		${RMDIR} $${optionsdir} 2>/dev/null || return 0; \
	fi
.else
	@${ECHO_MSG} "===> No user-specified options configured for ${PKGNAME}"
.endif
.endif # rmconfig

.if !target(rmconfig-recursive)
rmconfig-recursive:
	@${ECHO_MSG} "===> Removing user-specified options for ${PKGNAME} and dependencies";
	@recursive_cmd="rmconfig"; \
	    recursive_dirs="${.CURDIR} $$(${ALL-DEPENDS-FLAVORS-LIST})"; \
		${_FLAVOR_RECURSIVE_SH}
.endif # rmconfig-recursive

.if !target(pretty-print-config)
MULTI_START=	[
MULTI_END=	]
GROUP_START=	[
GROUP_END=	]
SINGLE_START=	(
SINGLE_END=	)
RADIO_START=	(
RADIO_END=	)
pretty-print-config:
.for opt in ${ALL_OPTIONS}
	@[ -z "${PORT_OPTIONS:M${opt}}" ] || match="+" ; ${ECHO_MSG} -n "$${match:--}${opt} "
.endfor
.for otype in MULTI GROUP SINGLE RADIO
.  for m in ${OPTIONS_${otype}}
	@${ECHO_MSG} -n "${m}${${otype}_START} "
.    for opt in ${OPTIONS_${otype}_${m}}
		@[ -z "${PORT_OPTIONS:M${opt}}" ] || match="+" ; ${ECHO_MSG} -n "$${match:--}${opt} "
.    endfor
	@${ECHO_MSG} -n "${${otype}_END} "
.  endfor
.endfor
.undef otype
.undef m
.undef opt
	@${ECHO_MSG} ""
.endif # pretty-print-config

desktop-categories:
	@${SETENV} \
			dp_CATEGORIES="${CATEGORIES}" \
			dp_ECHO_CMD=${ECHO_CMD} \
			dp_SCRIPTSDIR="${SCRIPTSDIR}" \
			dp_SORT="${SORT}" \
			dp_TR="${TR}" \
			${SH} ${SCRIPTSDIR}/desktop-categories.sh

.if defined(DESKTOP_ENTRIES)
check-desktop-entries:
	@${SETENV} \
			dp_CURDIR="${.CURDIR}" \
			dp_ECHO_CMD=${ECHO_CMD} \
			dp_ECHO_MSG=${ECHO_MSG} \
			dp_EXPR="${EXPR}" \
			dp_GREP="${GREP}" \
			dp_MAKE="${MAKE}" \
			dp_PKGNAME="${PKGNAME}" \
			dp_SCRIPTSDIR="${SCRIPTSDIR}" \
			dp_SED="${SED}" \
			dp_VALID_DESKTOP_CATEGORIES="${VALID_DESKTOP_CATEGORIES}" \
			dp_TR="${TR}" \
			${SH} ${SCRIPTSDIR}/check-desktop-entries.sh ${DESKTOP_ENTRIES}
.endif

.if !target(install-desktop-entries)
.if defined(DESKTOP_ENTRIES)
install-desktop-entries:
	@${SETENV} \
			dp_CURDIR="${.CURDIR}" \
			dp_ECHO_CMD=${ECHO_CMD} \
			dp_SCRIPTSDIR="${SCRIPTSDIR}" \
			dp_STAGEDIR="${STAGEDIR}" \
			dp_DESKTOPDIR="${DESKTOPDIR}" \
			dp_TMPPLIST="${TMPPLIST}" \
			dp_MAKE="${MAKE}" \
			dp_SED="${SED}" \
			${SH} ${SCRIPTSDIR}/install-desktop-entries.sh ${DESKTOP_ENTRIES}
.endif
.endif

.if !empty(BINARY_ALIAS)
.if !target(create-binary-alias)
create-binary-alias: ${BINARY_LINKDIR}
.for target src in ${BINARY_ALIAS:C/=/ /}
	@${RLN} `which ${src}` ${BINARY_LINKDIR}/${target}
.endfor
.endif
.endif

.if defined(WARNING)
WARNING_WAIT?=	10
show-warnings:
	@${ECHO_MSG} "/!\\ WARNING /!\\"
	@${ECHO_MSG}
.for m in ${WARNING}
	@${ECHO_MSG} "${m}" | ${FMT_80}
	@${ECHO_MSG}
.endfor
	@sleep ${WARNING_WAIT}
.endif

.if defined(ERROR)
show-errors:
	@${ECHO_MSG} "/!\\ ERRORS /!\\"
	@${ECHO_MSG}
.for m in ${ERROR}
	@${ECHO_MSG} "${m}" | ${FMT_80}
	@${ECHO_MSG}
.endfor
	@${FALSE}
.endif

.if defined(DEVELOPER)
.if defined(DEV_WARNING)
DEV_WARNING_WAIT?=	10
show-dev-warnings:
	@${ECHO_MSG} "/!\\ ${PKGNAME}: Makefile warnings, please consider fixing /!\\"
	@${ECHO_MSG}
.for m in ${DEV_WARNING}
	@${ECHO_MSG} ${m} | ${FMT_80}
	@${ECHO_MSG}
.endfor
.if defined(DEV_WARNING_FATAL)
	@${FALSE}
.else
	@sleep ${DEV_WARNING_WAIT}
.endif
.endif

.if defined(DEV_ERROR)
show-dev-errors:
	@${ECHO_MSG} "/!\\ ${PKGNAME}: Makefile errors /!\\"
	@${ECHO_MSG}
.for m in ${DEV_ERROR}
	@${ECHO_MSG} "${m}" | ${FMT_80}
	@${ECHO_MSG}
.endfor
	@${FALSE}
.endif
.endif #DEVELOPER

${_PORTS_DIRECTORIES}:
	@${MKDIR} ${.TARGET}

# Please note that the order of the following targets is important, and
# should not be modified.

_TARGETS_STAGES=	SANITY PKG FETCH EXTRACT PATCH CONFIGURE BUILD INSTALL TEST PACKAGE STAGE

# Define the SEQ of actions to take when each target is ran, and which targets
# it depends on before running its SEQ.
#
# Main target has a priority of 500, pre-target 300, post-target 700,
# target-depends 150.  Other targets are spaced in between those
#
# If you change the pre-foo and post-foo values here, go and keep them in sync
# in _OPTIONS_TARGETS in bsd.options.mk

_SANITY_SEQ=	050:post-chroot 100:pre-everything \
				125:show-unsupported-system-error 150:check-makefile \
				190:show-errors 200:show-warnings \
				210:show-dev-errors 220:show-dev-warnings \
				250:check-categories 300:check-makevars \
				350:check-desktop-entries 400:check-depends \
				450:identify-install-conflicts 500:check-deprecated \
				550:check-vulnerable 600:check-license 650:check-config \
				700:buildanyway-message 750:options-message ${_USES_sanity}

_PKG_DEP=		check-sanity
_PKG_SEQ=		500:pkg-depends
_FETCH_DEP=		pkg
_FETCH_SEQ=		150:fetch-depends 300:pre-fetch 450:pre-fetch-script \
				500:do-fetch 550:fetch-specials 700:post-fetch \
				850:post-fetch-script \
				${_OPTIONS_fetch} ${_USES_fetch}
_EXTRACT_DEP=	fetch
_EXTRACT_SEQ=	010:check-build-conflicts 050:extract-message 100:checksum \
				150:extract-depends 190:clean-wrkdir 200:${EXTRACT_WRKDIR} \
				300:pre-extract 450:pre-extract-script 500:do-extract \
				700:post-extract 850:post-extract-script \
				999:extract-fixup-modes \
				${_OPTIONS_extract} ${_USES_extract} ${_SITES_extract}
_PATCH_DEP=		extract
_PATCH_SEQ=		050:ask-license 100:patch-message 150:patch-depends \
				300:pre-patch 450:pre-patch-script 500:do-patch \
				700:post-patch 850:post-patch-script \
				${_OPTIONS_patch} ${_USES_patch}
_CONFIGURE_DEP=	patch
_CONFIGURE_SEQ=	150:build-depends 151:lib-depends 160:create-binary-alias \
				200:configure-message \
				300:pre-configure 450:pre-configure-script \
				490:run-autotools-fixup 500:do-configure 700:post-configure \
				850:post-configure-script \
				${_OPTIONS_configure} ${_USES_configure}
_BUILD_DEP=		configure
_BUILD_SEQ=		100:build-message 300:pre-build 450:pre-build-script \
				500:do-build 700:post-build 850:post-build-script \
				${_OPTIONS_build} ${_USES_build}
_STAGE_DEP=		build
# STAGE is special in its numbering as it has install and stage, so install is
# the main, and stage goes after.
_STAGE_SEQ=		050:stage-message 100:stage-dir 150:run-depends \
				200:apply-slist 300:pre-install \
				400:generate-plist 450:pre-su-install 475:create-users-groups \
				500:do-install 550:kmod-post-install 600:fixup-lib-pkgconfig 700:post-install \
				750:post-install-script 800:post-stage 850:compress-man \
				860:install-rc-script 870:install-ldconfig-file \
				880:install-license 890:install-desktop-entries \
				900:add-plist-info 910:add-plist-docs 920:add-plist-examples \
				930:add-plist-data 940:add-plist-post ${POST_PLIST:C/^/990:/} \
				${_OPTIONS_install} ${_USES_install} \
				${_OPTIONS_stage} ${_USES_stage}
.if defined(DEVELOPER)
_STAGE_SEQ+=	995:stage-qa
.else
stage-qa: stage
.endif
_TEST_DEP=		stage
_TEST_SEQ=		100:test-message 150:test-depends 300:pre-test 500:do-test \
				800:post-test \
				${_OPTIONS_test} ${_USES_test}
_INSTALL_DEP=	stage
_INSTALL_SEQ=	100:install-message \
				200:check-already-installed \
				300:create-manifest
_INSTALL_SUSEQ=	400:fake-pkg 500:security-check

_PACKAGE_DEP=	stage
_PACKAGE_SEQ=	100:package-message 300:pre-package 450:pre-package-script \
				500:do-package 850:post-package-script \
				${_OPTIONS_package} ${_USES_package}

# Enforce order for -jN builds
.for _t in ${_TARGETS_STAGES}
# Check if the port need to change the default order of some targets...
.  if defined(TARGET_ORDER_OVERRIDE)
_tmp_seq:=
.    for _entry in ${_${_t}_SEQ}
# for _target because :M${_target} does not work with fmake
.      for _target in ${_entry:C/^[0-9]+://}
.        if ${TARGET_ORDER_OVERRIDE:M*\:${_target}}
_tmp_seq:=	${_tmp_seq} ${TARGET_ORDER_OVERRIDE:M*\:${_target}}
.        else
_tmp_seq:=	${_tmp_seq} ${_entry}
.        endif
.      endfor
.    endfor
_${_t}_SEQ:=	${_tmp_seq}
.  endif
.  for s in ${_${_t}_SEQ:O:C/^[0-9]+://}
.    if target(${s})
.      if ! ${NOTPHONY:M${s}}
_PHONY_TARGETS+= ${s}
.      endif
_${_t}_REAL_SEQ+=	${s}
.    endif
.  endfor
.  for s in ${_${_t}_SUSEQ:O:C/^[0-9]+://}
.    if target(${s})
.      if ! ${NOTPHONY:M${s}}
_PHONY_TARGETS+= ${s}
.       endif
_${_t}_REAL_SUSEQ+=	${s}
.    endif
.  endfor
.ORDER: ${_${_t}_DEP} ${_${_t}_REAL_SEQ}
.endfor

# Define all of the main targets which depend on a sequence of other targets.
# See above *_SEQ and *_DEP. The _DEP will run before this defined target is
# ran. The _SEQ will run as this target once _DEP is satisfied.

.for target in extract patch configure build stage install package

# Check if config dialog needs to show and execute it if needed. If is it not
# needed (_OPTIONS_OK), then just depend on the cookie which is defined later
# to depend on the *_DEP and execute the *_SEQ.
# If options are required, execute config-conditional and then re-execute the
# target noting that config is no longer needed.
.if !target(${target}) && defined(_OPTIONS_OK)
_PHONY_TARGETS+= ${target}
${target}: ${${target:tu}_COOKIE}
.elif !target(${target})
${target}: config-conditional
	@cd ${.CURDIR} && ${MAKE} CONFIG_DONE_${PKGBASE:tu}=1 ${${target:tu}_COOKIE}
.elif target(${target}) && defined(IGNORE)
.endif

.if !exists(${${target:tu}_COOKIE})

# Define the real target behavior. Depend on the target's *_DEP. Execute
# the target's *_SEQ. Also handle su and USE_SUBMAKE needs.
.if ${UID} != 0 && defined(_${target:tu}_REAL_SUSEQ) && !defined(INSTALL_AS_USER)
.  if defined(USE_SUBMAKE)
${${target:tu}_COOKIE}: ${_${target:tu}_DEP}
	@cd ${.CURDIR} && ${MAKE} ${_${target:tu}_REAL_SEQ}
.  else  # !USE_SUBMAKE
${${target:tu}_COOKIE}: ${_${target:tu}_DEP} ${_${target:tu}_REAL_SEQ}
.  endif # USE_SUBMAKE
	@${ECHO_MSG} "===>  Switching to root credentials for '${target}' target"
	@cd ${.CURDIR} && \
		${SU_CMD} "${MAKE} ${_${target:tu}_REAL_SUSEQ}"
	@${ECHO_MSG} "===>  Returning to user credentials"
	@${TOUCH} ${TOUCH_FLAGS} ${.TARGET}
.else # No SU needed
.  if defined(USE_SUBMAKE)
${${target:tu}_COOKIE}: ${_${target:tu}_DEP}
	@cd ${.CURDIR} && \
		${MAKE} ${_${target:tu}_REAL_SEQ} ${_${target:tu}_REAL_SUSEQ}
	@${TOUCH} ${TOUCH_FLAGS} ${.TARGET}
.  else # !USE_SUBMAKE
${${target:tu}_COOKIE}: ${_${target:tu}_DEP} ${_${target:tu}_REAL_SEQ} ${_${target:tu}_REAL_SUSEQ}
	@${TOUCH} ${TOUCH_FLAGS} ${.TARGET}
.  endif # USE_SUBMAKE
.endif # SU needed

.else # exists(cookie)
${${target:tu}_COOKIE}::
	@if [ ! -e ${.TARGET} ]; then \
		cd ${.CURDIR} && ${MAKE} ${.TARGET}; \
	fi
.endif # !exists(cookie)

.endfor # foreach(targets)

.PHONY: ${_PHONY_TARGETS} check-sanity fetch pkg

.if !target(check-sanity)
check-sanity: ${_SANITY_REAL_SEQ}
.endif

.if !target(fetch)
fetch: ${_FETCH_DEP} ${_FETCH_REAL_SEQ}
.endif

.if !target(pkg)
pkg: ${_PKG_DEP} ${_PKG_REAL_SEQ}
.endif

.if !target(test)
test: ${_TEST_DEP}
.if !defined(NO_TEST)
test: ${_TEST_REAL_SEQ}
.endif
.endif

.endif
# End of post-makefile section.

.endif
# End of the DESTDIR if statement
