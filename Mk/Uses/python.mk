# $FreeBSD: head/Mk/Uses/python.mk 467712 2018-04-18 13:58:15Z jbeich $
#
# Provide support for Python related ports. This includes detecting Python
# interpreters, ports providing package and modules for python as well as
# consumer ports requiring Python at build or run time.
#
# Feature:	python
# Usage:	USES=python or USES=python:args
# Valid ARGS:	<version>, patch, build, run, test
#
# version 	If your port requires only some set of Python versions, you
# 		can set this to [min]-[max] or min+ or -max or as an
#		explicit version (eg. 3.3-3.4 for [min]-[max], 2.7+ or -3.3
#		for min+ and -max, 2.7 for an explicit version). Example:
#
#			USES=python:2.7		# Only use Python 2.7
#			USES=python:3.3+	# Use Python 3.3 or newer
#			USES=python:3.3-3.4	# Use Python 3.3 or 3.4
#			USES=python:-3.3	# Use any Python up to 3.3
#			USES=python		# Use the set default Python
#						# version
#
# patch		Indicates that Python is needed at patch time and adds
#		it to PATCH_DEPENDS.
# build		Indicates that Python is needed at build time and adds
#		it to BUILD_DEPENDS.
# run		Indicates that Python is needed at run time and adds
#		it to RUN_DEPENDS.
# test		Indicates that Python is needed at test time and adds
# 		it to TEST_DEPENDS.
# env		Indicates that the port does not require a dependency on Python
#		itself but needs the environment set up. This is mainly used
#		when depending on flavored python ports, or when a correct
#		PYTHON_CMD is required.  It has the same effect than setting
#		PYTHON_NO_DEPENDS.
#
# If build, run and test are omitted, Python will be added as BUILD_DEPENDS,
# RUN_DEPENDS and TEST_DEPENDS.
# patch is independant, it does not prevent the default build/run/test
# dependency.
# env or PYTHON_NO_DEPENDS can be set to not add any dependencies.
#
# Variables, which can be set by a user:
#
# PYTHON_VERSION	- The chosen Python interpreter including the version,
#			  e.g. python2.7, python3.3, etc. This allows the user
#			  to override the currently chosen default version and
#			  to install the port for a specific Python version.
#			  It must not be set by a port.
#
# Variables, which can be set by the port:
#
# USE_PYTHON		- A list of additional features and functionality to
#			  enable. Supported features are:
#
#	concurrent 	- Indicates that the port can be installed for
#			  different python versions at the same time. The port
#			  is supposed to use a unique prefix for certain
#			  directories using USES=uniquefiles:dirs (see the
#			  uniquefiles.mk Uses for details about the
#			  directories), if set to yes. Binaries receive an
#			  additional suffix, based on ${PYTHON_VER}.
#
#			  The values for the uniquefiles USES are set as
#			  follows:
#
#				UNIQUE_PREFIX=  ${PYTHON_PKGNAMEPREFIX}
#				UNIQUE_SUFFIX=  -${PYTHON_VER}
#
#			  If the port is installed for the current default
#			  python version, scripts and binaries in
#
#				${PREFIX}/bin
#				${PREFIX}/sbin
#				${PREFIX}/libexec
#
#			  are linked from the prefixed version to the
#			  prefix-less original name, e.g.
#			  bin/foo-2.7 --> bin/foo.
#
#	cython		- Depend on lang/cython at build-time.
#
#	cython_run	- Depend on lang/cython at run-time.
#
#	flavors		- Force creation of flavors for Python 2 and 3 default
#			  versions, where applicable.
#
#	noflavors	- Disable automatic creation of flavors if they would
#			  otherwise be created and they are not wanted.
#
#	allflavors 	- Generate flavors for all possible versions and not
#			  simply the default ones.  Only to be used for py-*
#			  ports that are part of the Python distribution, but
#			  kept as separate ports.
#
#	optsuffix	- Set PKGNAMESUFFIX to PYTHON_PKGNAMESUFFIX if not the
#			  default python version.
#
#	distutils	- Use distutils as do-configure, do-build and
#			  do-install targets. implies flavors.
#
#	autoplist	- Automatically generates the packaging list for a
#			  port that uses distutils when defined.
#			  requires: distutils
#
#	py3kplist	- Automatically generates Python 3.x compatible
#			  __pycache__ entries from a Python 2.x packaging list
#			  when defined. Use this for ports that do *not* use
#			  standard Python packaging mechanisms such as
#			  distutils, and support *both* Python 2.x and 3.x.
#			  Not needed, if USE_PYTHON=autoplist is set.
#
#	pythonprefix	- Says that the port installs in ${PYTHONBASE} instead
#			  of ${PREFIX}.
#
#	noegginfo	- Skip an egg-info entry from plist, if defined.
#
# PYTHON_CMD		- Python's command line file name, including the
#			  version number (used for dependencies).
#			  default: ${PYTHONBASE}/bin/${PYTHON_VERSION}
#
# PYSETUP		- Name of the setup script used by the distutils
#			  package.
#			  default: setup.py
#
# PYDISTUTILS_PKGNAME
#			- Internal name in the distutils for egg-info.
#			  default: ${PORTNAME}
#
# PYDISTUTILS_PKGVERSION
#			- Internal version in the distutils for egg-info.
#			  default: ${PORTVERSION}
#
# PYDISTUTILS_CONFIGURE_TARGET
#			- Pass this command to distutils on configure stage.
#			  default: config
#
# PYDISTUTILS_BUILD_TARGET
#			- Pass this command to distutils on build stage.
#			  default: build
#
# PYDISTUTILS_INSTALL_TARGET
#			- Pass this command to distutils on install stage.
#			  default: install
#
# PYDISTUTILS_CONFIGUREARGS
#			- Arguments to config with distutils.
#			  default: <empty>
#
# PYDISTUTILS_BUILDARGS
#			- Arguments to build with distutils.
#			  default: <empty>
#
# PYDISTUTILS_INSTALLARGS
#			- Arguments to install with distutils.
#			  default: -c -O1 --prefix=${PREFIX} --single-version-externally-managed --root=${STAGEDIR}
#
# PYDISTUTILS_EGGINFO
#			- Canonical name for egg-info.
#			  default: ${PYDISTUTILS_PKGNAME:C/[^A-Za-z0-9.]+/_/g}-${PYDISTUTILS_PKGVERSION:C/[^A-Za-z0-9.]+/_/g}-py${PYTHON_VER}.egg-info
#
# The following variables can be read by ports and must not be modified:
#
# PYTHONBASE		- The installation prefix of the chosen Python
#			  interpreter, e.g. /usr/local
#
# PYTHON_PORTVERSION
#			- Version number suitable for ${PORTVERSION}.
#
# PYTHON_PORTSDIR	- The port directory of the chosen Python interpreter
#
# PYTHON_REL		- The release number of the chosen Python interpreter
#			  without dots, e.g. 2706, 3401, ...
#
# PYTHON_SUFFIX		- The major-minor release number of the chosen Python
#			  interpreter without dots, e.g. 27, 34, ...
#			  Used for prefixes and suffixes.
#
# PYTHON_MAJOR_VER	- The major release version of the chosen Python
#			  interpreter, e.g. 2, 3, ...
#
# PYTHON_VER		- The major-minor release version of the chosen Python
#			  interpreter, e.g. 2.7, 3.4, ...
#
# PYTHON_ABIVER		- Additional ABI flags set by the chosen Python
#			  interpreter, e.g. md
#
# PYTHON_INCLUDEDIR	- Location of the Python include files.
#			  default: ${PYTHONBASE}/include/${PYTHON_VERSION}
#
# PYTHON_LIBDIR		- Base of the python library tree
#			  default: ${PYTHONBASE}/lib/${PYTHON_VERSION}
#
# PYTHON_SITELIBDIR	- Location of the site-packages tree. Don't change,
#			  unless you know what you do.
#			  default: ${PYTHON_LIBDIR}/site-packages
#
# There are PREFIX-clean variants of the PYTHON_*DIR variables above.
# They are meant to be used by ports instead of the above variables, so the
# ports respect ${PREFIX} (unless USE_PYTHON=pythonprefix is specified).
#
# PYTHONPREFIX_INCLUDEDIR	default: ${PREFIX}/include/${PYTHON_VERSION}
# PYTHONPREFIX_LIBDIR		default: ${PREFIX}/lib/${PYTHON_VERSION}
# PYTHONPREFIX_SITELIBDIR	default: ${PYTHONPREFIX_LIBDIR}/site-packages
#
# PYTHON_PLATFORM	- Python's idea of the OS release.
#			  This is faked with ${OPSYS} and ${OSREL} until we
#			  find out how to delay defining a variable until
#			  after a certain target has been built.
#
# PYTHON_PKGNAMEPREFIX
#			- Use this as a ${PKGNAMEPREFIX} to distinguish
#			  packages for different Python versions.
#			  default: py${PYTHON_SUFFIX}-
#
# Using USES=python.mk also will add some useful entries to PLIST_SUB:
#
#	PYTHON_INCLUDEDIR=${PYTHONPREFIX_INCLUDEDIR:S;${PREFIX}/;;}
#	PYTHON_LIBDIR=${PYTHONPREFIX_LIBDIR:S;${PREFIX}/;;}
#	PYTHON_PLATFORM=${PYTHON_PLATFORM}
#	PYTHON_PYOEXTENSION=${PYTHON_PYOEXTENSION}
#	PYTHON_SITELIBDIR=${PYTHONPREFIX_SITELIBDIR:S;${PREFIX}/;;}
#	PYTHON_SUFFIX=${PYTHON_SUFFIX}
#	PYTHON_VER=${PYTHON_VER}
#	PYTHON_VERSION=${PYTHON_VERSION}
#
# and PYTHON2 and PYTHON3 will be set according to the Python version:
#
#	PYTHON2="" PYTHON3="@comment " for Python 2.x
#	PYTHON2="@comment " PYTHON3="" for Python 3.x
#
# PYTHON_PKGNAMESUFFIX
#			- Deprecated, use PYTHON_PKGNAMEPREFIX instead
#			  default: -py${PYTHON_SUFFIX}
#
# PYDISTUTILS_INSTALLNOSINGLE
#			- Deprecated without replacement
#
# MAINTAINER: python@FreeBSD.org

.if !defined(_INCLUDE_USES_PYTHON_MK)
_INCLUDE_USES_PYTHON_MK=	yes

# What Python version and what Python interpreters are currently supported?
# When adding a version, please keep the comment in
# Mk/bsd.default-versions.mk in sync.
_PYTHON_VERSIONS=		2.7 3.6 3.5 3.4	# preferred first
_PYTHON_PORTBRANCH=		2.7		# ${_PYTHON_VERSIONS:[1]}
_PYTHON_BASECMD=		${LOCALBASE}/bin/python
_PYTHON_RELPORTDIR=		lang/python

# Make each individual feature available as _PYTHON_FEATURE_<FEATURENAME>
.for var in ${USE_PYTHON}
_PYTHON_FEATURE_${var:C/=.*$//:tu}=	${var:C/.*=//:S/,/ /g}
.endfor

# distutils automatically generates flavors depending on the supported
# versions.
.if defined(_PYTHON_FEATURE_DISTUTILS)
_PYTHON_FEATURE_FLAVORS=	yes
.endif

.if defined(_PYTHON_FEATURE_NOFLAVORS)
.undef _PYTHON_FEATURE_FLAVORS
.endif

# Make sure that no dependency or some other environment variable
# pollutes the build/run dependency detection
.undef _PYTHON_BUILD_DEP
.undef _PYTHON_RUN_DEP
.undef _PYTHON_TEST_DEP
_PYTHON_ARGS=		${python_ARGS:S/,/ /g}
.if ${_PYTHON_ARGS:Mpatch}
_PYTHON_PATCH_DEP=	yes
_PYTHON_ARGS:=		${_PYTHON_ARGS:Npatch}
.endif
.if ${_PYTHON_ARGS:Mbuild}
_PYTHON_BUILD_DEP=	yes
_PYTHON_ARGS:=		${_PYTHON_ARGS:Nbuild}
.endif
.if ${_PYTHON_ARGS:Mrun}
_PYTHON_RUN_DEP=	yes
_PYTHON_ARGS:=		${_PYTHON_ARGS:Nrun}
.endif
.if ${_PYTHON_ARGS:Mtest}
_PYTHON_TEST_DEP=	yes
_PYTHON_ARGS:=		${_PYTHON_ARGS:Ntest}
.endif
.if ${_PYTHON_ARGS:Menv}
PYTHON_NO_DEPENDS=	yes
_PYTHON_ARGS:=		${_PYTHON_ARGS:Nenv}
.endif

# The port does not specify a build, run or test dependency, assume all are
# required.
.if !defined(_PYTHON_BUILD_DEP) && !defined(_PYTHON_RUN_DEP) && \
    !defined(_PYTHON_TEST_DEP) && !defined(PYTHON_NO_DEPENDS)
_PYTHON_BUILD_DEP=	yes
_PYTHON_RUN_DEP=	yes
_PYTHON_TEST_DEP=	yes
.endif

.if ${PYTHON2_DEFAULT} != ${PYTHON_DEFAULT} && ${PYTHON3_DEFAULT} != ${PYTHON_DEFAULT}
WARNING+=	"PYTHON_DEFAULT must be a version present in PYTHON2_DEFAULT or PYTHON3_DEFAULT, if you want more Python flavors, set BUILD_ALL_PYTHON_FLAVORS in your make.conf"
.endif

.if ${_PYTHON_ARGS} == "2"
DEV_ERROR+=		"USES=python:2 is no longer supported, use USES=python:2.7"
.elif ${_PYTHON_ARGS} == "3"
DEV_ERROR+=		"USES=python:3 is no longer supported, use USES=python:3.4+ or an appropriate version range"
.endif  # ${_PYTHON_ARGS} == "2"

.if defined(PYTHON_VERSION)
# A port/user requests a specific python version for its dependencies via
# DEPENDS_ARGS, since it requires the specific python version itself.
# Several things can happen now:
#	a) the dependency supports the requested version -> everything's fine
#	b) the dependency does not support the requested version
#		1) the dependency works in a way that the different python
#		   versions do not matter -> everything's fine
#		2) the dependency is likely to break due to the conflict
#		   nothing's fine
#
# b.2) needs to be resolved. Due to the complexity of how different pieces of
# software are built, we can't solve this automatically. Instead, let's assume
# that maintainers know what they are doing and assume PYTHON_VERSION to be a
# hint. Just warn maintainers, if the versions do not match
# (_PYTHON_VERSION_NONSUPPORTED).
_PYTHON_VERSION:=	${PYTHON_VERSION:S/^python//}
.else
_PYTHON_VERSION:=	${PYTHON_DEFAULT}
.endif # defined(PYTHON_VERSION)

# Validate Python version whether it meets the version restriction.
_PYTHON_VERSION_CHECK:=		${_PYTHON_ARGS:C/^([1-9]\.[0-9])$/\1-\1/}
_PYTHON_VERSION_MINIMUM_TMP:=	${_PYTHON_VERSION_CHECK:C/([1-9]\.[0-9])[-+].*/\1/}
_PYTHON_VERSION_MINIMUM:=	${_PYTHON_VERSION_MINIMUM_TMP:M[1-9].[0-9]}
_PYTHON_VERSION_MAXIMUM_TMP:=	${_PYTHON_VERSION_CHECK:C/.*-([1-9]\.[0-9])/\1/}
_PYTHON_VERSION_MAXIMUM:=	${_PYTHON_VERSION_MAXIMUM_TMP:M[1-9].[0-9]}

.undef _PYTHON_VERSION_NONSUPPORTED
.if !empty(_PYTHON_VERSION_MINIMUM) && (${_PYTHON_VERSION} < ${_PYTHON_VERSION_MINIMUM})
_PYTHON_VERSION_NONSUPPORTED=	${_PYTHON_VERSION_MINIMUM} at least
.elif !empty(_PYTHON_VERSION_MAXIMUM) && (${_PYTHON_VERSION} > ${_PYTHON_VERSION_MAXIMUM})
_PYTHON_VERSION_NONSUPPORTED=	${_PYTHON_VERSION_MAXIMUM} at most
.endif

# If we have an unsupported version of Python, try another.
.if defined(_PYTHON_VERSION_NONSUPPORTED)
.if defined(PYTHON_VERSION) || defined(PYTHON_CMD)
_PV:=		${_PYTHON_VERSION}	# preserve the specified python version
IGNORE=		needs Python ${_PYTHON_VERSION_NONSUPPORTED}, but ${_PV} was specified
.endif # defined(PYTHON_VERSION) || defined(PYTHON_CMD)
.undef _PYTHON_VERSION
.for ver in ${PYTHON2_DEFAULT} ${PYTHON3_DEFAULT} ${_PYTHON_VERSIONS}
__VER=		${ver}
.if !defined(_PYTHON_VERSION) && \
	!(!empty(_PYTHON_VERSION_MINIMUM) && ( \
		${__VER} < ${_PYTHON_VERSION_MINIMUM})) && \
	!(!empty(_PYTHON_VERSION_MAXIMUM) && ( \
		${__VER} > ${_PYTHON_VERSION_MAXIMUM}))
_PYTHON_VERSION=	${ver}
.endif
.endfor
.if !defined(_PYTHON_VERSION)
IGNORE=		needs an unsupported version of Python
.endif
.endif	# defined(_PYTHON_VERSION_NONSUPPORTED)

# Automatically generates FLAVORS if empty
.if empty(FLAVORS) && defined(_PYTHON_FEATURE_FLAVORS)
.  undef _VALID_PYTHON_VERSIONS
.  for ver in ${PYTHON_DEFAULT} ${PYTHON2_DEFAULT} ${PYTHON3_DEFAULT} ${_PYTHON_VERSIONS}
__VER=		${ver}
.    if !(!empty(_PYTHON_VERSION_MINIMUM) && ( \
		${__VER} < ${_PYTHON_VERSION_MINIMUM})) && \
	!(!empty(_PYTHON_VERSION_MAXIMUM) && ( \
		${__VER} > ${_PYTHON_VERSION_MAXIMUM}))
.      if empty(_VALID_PYTHON_VERSIONS:M${ver})
_VALID_PYTHON_VERSIONS+=	${ver}
.      endif
.    endif
.  endfor
# Get all possible flavors depending on version requirements
.  if defined(_VALID_PYTHON_VERSIONS)
_ALL_PYTHON_FLAVORS=	${_VALID_PYTHON_VERSIONS:S/.//:S/^/py/}
.  else
_ALL_PYTHON_FLAVORS=	${_PYTHON_VERSIONS:S/.//:S/^/py/}
.  endif
# Decide how many flavors we want.  By default, only generate the default
# versions.
.  if defined(BUILD_ALL_PYTHON_FLAVORS) || defined(_PYTHON_FEATURE_ALLFLAVORS)
FLAVORS=	${_ALL_PYTHON_FLAVORS}
.  else
.    for _v in ${PYTHON_DEFAULT} ${PYTHON2_DEFAULT} ${PYTHON3_DEFAULT}
_f=	py${_v:S/.//}
.      if ${_ALL_PYTHON_FLAVORS:M${_f}} && !${FLAVORS:M${_f}}
.if !empty(FLAVORS)
FLAVORS:=	${FLAVORS} ${_f}
.else
FLAVORS:=	${_f}
.endif
.      endif
.    endfor
.  endif
.  if !empty(FLAVORS) && empty(FLAVOR)
FLAVOR=	${FLAVORS:[1]}
.  endif
.endif

.if ${FLAVOR:Mpy[23][0-9]}
_PYTHON_VERSION=	${FLAVOR:S/py//:C/(.)/\1./}
.endif

.if !empty(FLAVOR) && ${_PYTHON_VERSION} != ${PYTHON_DEFAULT}
.if defined(_PYTHON_FEATURE_OPTSUFFIX)
DEV_WARNING+=	"USE_PYTHON=optsuffix is deprecated, consider migrating to using unconditional PKGNAMESUFFIX or PKGNAMEPREFIX"
PKGNAMESUFFIX=	${PYTHON_PKGNAMESUFFIX}
.endif
.endif

# To avoid having dependencies with @ and empty flavor:
# _PYTHON_VERSION is either set by (first that matches):
# - If using Python flavors, from the current Python flavor
# - If using a version restriction (USES=python:3.4+), from the first
#   acceptable default Python version.
# - From PYTHON_DEFAULT
PY_FLAVOR=	py${_PYTHON_VERSION:S/.//}

# Pass PYTHON_VERSION down the dependency chain. This ensures that
# port A -> B -> C all will use the same python version and do not
# try to find a different one, if the passed version fits into
# the supported version range.
PYTHON_VERSION?=	python${_PYTHON_VERSION}
.if !defined(PYTHON_NO_DEPENDS) && \
    ${PYTHON_VERSION} != python${PYTHON_DEFAULT}
DEPENDS_ARGS+=		PYTHON_VERSION=${PYTHON_VERSION}
.endif

# NOTE:
#
#  PYTHON_VERSION will hold whatever is passed down the dependency chain.
#  If a user runs `make PYTHON_VERSION=python3.3, PYTHON_VERSION will be
#  set to 'python3.3'. A port however may require a different version,
#  which is stored (above) in _PYTHON_VERSION.
#  Every python bit below hence should use python${_PYTHON_VERSION}, since
#  this is the value, the _port_ requires
#

# Got the correct python version, set some publicly accessible variables
PYTHON_VER=		${_PYTHON_VERSION}
PYTHON_SUFFIX=		${_PYTHON_VERSION:S/.//g}
PYTHON_MAJOR_VER=	${PYTHON_VER:R}
PYTHON_REL=		# empty
PYTHON_ABIVER=		# empty
PYTHON_PORTSDIR=	${_PYTHON_RELPORTDIR}${PYTHON_SUFFIX}
# Protect partial checkouts from Mk/Scripts/functions.sh:export_ports_env().
.if !defined(_PORTS_ENV_CHECK) || exists(${PORTSDIR}/${PYTHON_PORTSDIR})
.include "${PORTSDIR}/${PYTHON_PORTSDIR}/Makefile.version"
.endif
# Create a 4 integer version string, prefixing 0 to the last token if
# it's a single character. Only use the the first 3 tokens of
# PORTVERSION to support pre-release versions (rc3, alpha4, etc) of
# any Python port (lang/pythonXY)
PYTHON_REL=	${PYTHON_PORTVERSION:C/^([0-9]+\.[0-9]+\.[0-9]+).*/\1/:C/\.([0-9]+)$/.0\1/:C/\.0?([0-9][0-9])$/.\1/:S/.//g}

# Might be overridden by calling ports
PYTHON_CMD?=		${_PYTHON_BASECMD}${_PYTHON_VERSION}
.if ${PYTHON_VER} != 2.7
.if exists(${PYTHON_CMD}-config)
PYTHON_ABIVER!=		${PYTHON_CMD}-config --abiflags
.else
# Default ABI flags for lang/python3x ports
PYTHON_ABIVER=		m
.endif
.endif

.if !defined(PYTHONBASE)
PYTHONBASE!=	(${PYTHON_CMD} -c 'import sys; print(sys.prefix)' \
			2> /dev/null || ${ECHO_CMD} ${LOCALBASE}) | ${TAIL} -1
.endif
_EXPORTED_VARS+=	PYTHONBASE

PYTHON_INCLUDEDIR=	${PYTHONBASE}/include/python${_PYTHON_VERSION}${PYTHON_ABIVER}
PYTHON_LIBDIR=		${PYTHONBASE}/lib/python${_PYTHON_VERSION}
PYTHON_PLATFORM=	${OPSYS:tl}${OSREL:C/\.[0-9.]*//}
PYTHON_SITELIBDIR=	${PYTHON_LIBDIR}/site-packages
PYTHON_PKGNAMEPREFIX=	py${PYTHON_SUFFIX}-
PYTHON_PKGNAMESUFFIX=	-py${PYTHON_SUFFIX}

PYTHONPREFIX_INCLUDEDIR=	${PYTHON_INCLUDEDIR:S;${PYTHONBASE};${PREFIX};}
PYTHONPREFIX_LIBDIR=		${PYTHON_LIBDIR:S;${PYTHONBASE};${PREFIX};}
PYTHONPREFIX_SITELIBDIR=	${PYTHON_SITELIBDIR:S;${PYTHONBASE};${PREFIX};}

# Used for recording the installed files.
_PYTHONPKGLIST=	${WRKDIR}/.PLIST.pymodtmp

# PEP 0488 (https://www.python.org/dev/peps/pep-0488/)
.if ${PYTHON_REL} < 3500
PYTHON_PYOEXTENSION=	pyo
.else
PYTHON_PYOEXTENSION=	opt-1.pyc
.endif

# Ports bound to a certain python version SHOULD
# - use the PYTHON_PKGNAMEPREFIX
# - use directories using the PYTHON_PKGNAMEPREFIX
# - install binaries using the required PYTHON_VER, with
#   the default python version creating a symlink to the original binary
#   name (for staging-aware ports).
#
# What makes a port 'bound' to a certain python version?
# - it installs data into PYTHON_SITELIBDIR, PYTHON_INCLUDEDIR, ...
# - it links against libpython*.so
# - it uses USE_PYTHON=distutils
#

.if defined(_PYTHON_FEATURE_CYTHON)
BUILD_DEPENDS+=	cython-${PYTHON_VER}:lang/cython@${PY_FLAVOR}
.endif

.if defined(_PYTHON_FEATURE_CYTHON_RUN)
RUN_DEPENDS+=	cython-${PYTHON_VER}:lang/cython@${PY_FLAVOR}
.endif

.if defined(_PYTHON_FEATURE_CONCURRENT)
.if !defined(_PYTHON_FEATURE_FLAVORS) && (${_PYTHON_VERSION_MINIMUM:M3*} || ${_PYTHON_VERSION_MAXIMUM:M2*})
DEV_WARNING+=	"USE_PYTHON=concurrent when only one of Python 2 or 3 is supported AND not using flavors does not make any sense"
.endif
_USES_POST+=		uniquefiles:dirs
.if defined(_PYTHON_FEATURE_FLAVORS) && ${FLAVOR} == ${FLAVORS:[1]}
UNIQUE_DEFAULT_LINKS=	yes
.elif !defined(_PYTHON_FEATURE_FLAVORS) && ${PYTHON_VERSION} == python${PYTHON_DEFAULT}
UNIQUE_DEFAULT_LINKS=	yes
.else
UNIQUE_DEFAULT_LINKS=	no
.endif
UNIQUE_PREFIX=		${PYTHON_PKGNAMEPREFIX}
UNIQUE_SUFFIX=		-${PYTHON_VER}
UNIQUE_SUFFIX_TYPES+=	SUFFIX_MAN
UNIQUE_SUFFIX_MAN_WITH_EXT=	.[1-9ln]
UNIQUE_SUFFIX_MAN_EXTRA_EXT=	.gz

.if defined(_PYTHON_FEATURE_AUTOPLIST)
_UNIQUE_FIND_SUFFIX_FILES=	${SED} -e 's|^${PREFIX}/||' ${_PYTHONPKGLIST} ${TMPPLIST}
.else
_UNIQUE_FIND_SUFFIX_FILES=	${SED} -e 's|^${PREFIX}/||' ${TMPPLIST} 2>/dev/null
.endif
UNIQUE_FIND_SUFFIX_FILES+=	${_UNIQUE_FIND_SUFFIX_FILES} | \
				${EGREP} -he '^bin/.*$$|^sbin/.*$$|^libexec/.*$$'
UNIQUE_FIND_SUFFIX_MAN_FILES+=	${_UNIQUE_FIND_SUFFIX_FILES} | \
				${EGREP} -he '^man/man[1-9ln]/.*$$'
.endif # defined(_PYTHON_FEATURE_CONCURRENT)

_CURRENTPORT:=	${PKGNAMEPREFIX}${PORTNAME}${PKGNAMESUFFIX}
.if defined(_PYTHON_FEATURE_DISTUTILS) && \
	${_CURRENTPORT} != ${PYTHON_PKGNAMEPREFIX}setuptools
BUILD_DEPENDS+=		${PYTHON_PKGNAMEPREFIX}setuptools>0:devel/py-setuptools@${PY_FLAVOR}
RUN_DEPENDS+=		${PYTHON_PKGNAMEPREFIX}setuptools>0:devel/py-setuptools@${PY_FLAVOR}
.endif

# distutils support
PYSETUP?=		setup.py
PYDISTUTILS_SETUP?=	-c \
	"import sys; import setuptools; \
	__file__='${PYSETUP}'; sys.argv[0]='${PYSETUP}'; \
	exec(compile(open(__file__, 'rb').read().replace(b'\\r\\n', b'\\n'), __file__, 'exec'))"
PYDISTUTILS_CONFIGUREARGS?=	# empty
PYDISTUTILS_BUILDARGS?=		# empty
PYDISTUTILS_INSTALLARGS?=	-c -O1 --prefix=${PREFIX}
.if defined(_PYTHON_FEATURE_DISTUTILS)
. if !defined(PYDISTUTILS_INSTALLNOSINGLE)
PYDISTUTILS_INSTALLARGS+=	--single-version-externally-managed
. endif
PYDISTUTILS_INSTALLARGS+=	--root=${STAGEDIR}
.endif
PYDISTUTILS_INSTALLARGS:=	--record ${_PYTHONPKGLIST} \
		${PYDISTUTILS_INSTALLARGS}

PYDISTUTILS_PKGNAME?=	${PORTNAME}
PYDISTUTILS_PKGVERSION?=${PORTVERSION}
PYDISTUTILS_EGGINFO?=	${PYDISTUTILS_PKGNAME:C/[^A-Za-z0-9.]+/_/g}-${PYDISTUTILS_PKGVERSION:C/[^A-Za-z0-9.]+/_/g}-py${PYTHON_VER}.egg-info
PYDISTUTILS_EGGINFODIR?=${STAGEDIR}${PYTHONPREFIX_SITELIBDIR}

.if !defined(_PYTHON_FEATURE_NOEGGINFO) && \
	!defined(_PYTHON_FEATURE_AUTOPLIST) && \
	defined(_PYTHON_FEATURE_DISTUTILS) && \
	defined(PYTHON_REL)
_USES_stage+=	933:add-plist-egginfo
add-plist-egginfo:
. for egginfo in ${PYDISTUTILS_EGGINFO}
	if [ -d "${PYDISTUTILS_EGGINFODIR}/${egginfo}" ]; then \
		${LS} ${PYDISTUTILS_EGGINFODIR}/${egginfo} | while read f; do \
			${ECHO_CMD} ${PYDISTUTILS_EGGINFODIR:S;^${STAGEDIR}${PREFIX}/;;}/${egginfo}/$${f} >> ${TMPPLIST}; \
		done; \
	fi;
. endfor
.endif

.if defined(_PYTHON_FEATURE_AUTOPLIST) && defined(_PYTHON_FEATURE_DISTUTILS)
_RELSITELIBDIR=	${PYTHONPREFIX_SITELIBDIR:S;${PREFIX}/;;}
_RELLIBDIR=		${PYTHONPREFIX_LIBDIR:S;${PREFIX}/;;}

_USES_stage+=	934:add-plist-pymod
add-plist-pymod:
	@${SED} -e 's|^${STAGEDIR}${PREFIX}/||' \
		-e 's|^${PREFIX}/||' \
		-e 's|^\(man/.*man[0-9]\)/\(.*\.[0-9]\)$$|\1/\2.gz|' \
		-e 's|[[:alnum:]|[:space:]]*/\.\./*||g; s|/\./|/|g' \
		${_PYTHONPKGLIST} | ${SORT} >> ${TMPPLIST}

.else
.if ${PYTHON_REL} >= 3200 && defined(_PYTHON_FEATURE_PY3KPLIST)
# When Python version is 3.2+ we rewrite all the filenames
# of TMPPLIST that end with .py[co], so that they conform
# to PEP 3147 (see http://www.python.org/dev/peps/pep-3147/)
PYMAGICTAG=		${PYTHON_CMD} -c 'import imp; print(imp.get_tag())'
_USES_stage+=	935:add-plist-python
add-plist-python:
	@${AWK} '\
		/\.py[co]$$/ && !($$0 ~ "/" pc "/") {id = match($$0, /\/[^\/]+\.py[co]$$/); if (id != 0) {d = substr($$0, 1, RSTART - 1); dirs[d] = 1}; sub(/\.pyc$$/,  "." mt "&"); sub(/\.pyo$$/, "." mt "." pyo); sub(/[^\/]+\.py[co]$$/, pc "/&"); print; next} \
		/^@dirrm / {d = substr($$0, 8); if (d in dirs) {print $$0 "/" pc}; print $$0; next} \
		/^@dirrmtry / {d = substr($$0, 11); if (d in dirs) {print $$0 "/" pc}; print $$0; next} \
		{print} \
		' \
		pc="__pycache__" mt="$$(${PYMAGICTAG})" pyo="${PYTHON_PYOEXTENSION}" \
		${TMPPLIST} > ${TMPPLIST}.pyc_tmp
	@${MV} ${TMPPLIST}.pyc_tmp ${TMPPLIST}
.endif # ${PYTHON_REL} >= 3200 && defined(_PYTHON_FEATURE_PY3KPLIST)
.endif # defined(_PYTHON_FEATURE_AUTOPLIST) && defined(_PYTHON_FEATURE_DISTUTILS)

# Fix for programs that build python from a GNU auto* environment
CONFIGURE_ENV+=	PYTHON="${PYTHON_CMD}"

# By default CMake picks up the highest available version of Python package.
# Enforce the version required by the port or the default.
CMAKE_ARGS+=	-DPython_ADDITIONAL_VERSIONS=${PYTHON_VER}

# Python 3rd-party modules
PYGAME=		${PYTHON_PKGNAMEPREFIX}game>0:devel/py-game@${PY_FLAVOR}
PYNUMPY=	${PYTHON_PKGNAMEPREFIX}numpy>0:math/py-numpy@${PY_FLAVOR}

# Common Python modules that can be needed but only for some versions of Python.
.if ${PYTHON_REL} < 3400
PY_ENUM34=	${PYTHON_PKGNAMEPREFIX}enum34>0:devel/py-enum34@${PY_FLAVOR}
PY_ENUM_COMPAT=	${PYTHON_PKGNAMEPREFIX}enum-compat>0:devel/py-enum-compat@${PY_FLAVOR}
PY_PATHLIB=	${PYTHON_PKGNAMEPREFIX}pathlib>0:devel/py-pathlib@${PY_FLAVOR}
.else
PY_ENUM34=
PY_ENUM_COMPAT=
PY_PATHLIB=	
.endif

.if ${PYTHON_REL} < 3300
PY_IPADDRESS=	${PYTHON_PKGNAMEPREFIX}ipaddress>0:net/py-ipaddress@${PY_FLAVOR}
.else
PY_IPADDRESS=
.endif

.if ${PYTHON_REL} < 3200
PY_FUTURES=	${PYTHON_PKGNAMEPREFIX}futures>0:devel/py-futures@${PY_FLAVOR}
.else
PY_FUTURES=
.endif

CMAKE_ARGS+=	-DBOOST_PYTHON_SUFFIX:STRING=${PYTHON_SUFFIX}
PY_BOOST_LIB=	boost_python${PYTHON_SUFFIX}
PY_BOOST=	lib${PY_BOOST_LIB}.so:devel/boost-python-libs@${PY_FLAVOR}

# dependencies
.for _stage in PATCH BUILD RUN TEST
.  if defined(_PYTHON_${_stage}_DEP)
${_stage}_DEPENDS+=	${PYTHON_CMD}:${PYTHON_PORTSDIR}
.  endif
.endfor

# set $PREFIX as Python's one
.if defined(_PYTHON_FEATURE_PYTHONPREFIX)
PREFIX=		${PYTHONBASE}
.endif

# Substitutions for pkg-plist
# Use a short form of the PYTHONPREFIX_*DIR variables; we don't need the
# base directory in the plist file.
PLIST_SUB+=	PYTHON_INCLUDEDIR=${PYTHONPREFIX_INCLUDEDIR:S;${PREFIX}/;;} \
		PYTHON_LIBDIR=${PYTHONPREFIX_LIBDIR:S;${PREFIX}/;;} \
		PYTHON_PLATFORM=${PYTHON_PLATFORM} \
		PYTHON_PYOEXTENSION=${PYTHON_PYOEXTENSION} \
		PYTHON_SITELIBDIR=${PYTHONPREFIX_SITELIBDIR:S;${PREFIX}/;;} \
		PYTHON_SUFFIX=${PYTHON_SUFFIX} \
		PYTHON_VER=${PYTHON_VER} \
		PYTHON_VERSION=${PYTHON_VERSION}
.if ${PYTHON_REL} < 3000
PLIST_SUB+=	PYTHON2="" PYTHON3="@comment "
.else
PLIST_SUB+=	PYTHON2="@comment " PYTHON3=""
.endif

_USES_POST+=	python
.endif # _INCLUDE_USES_PYTHON_MK

.if defined(_POSTMKINCLUDED) && !defined(_INCLUDE_USES_PYTHON_POST_MK)
_INCLUDE_USES_PYTHON_POST_MK=	yes

# py-distutils support
PYDISTUTILS_CONFIGURE_TARGET?=	config
PYDISTUTILS_BUILD_TARGET?=	build
PYDISTUTILS_INSTALL_TARGET?=	install

.if defined(_PYTHON_FEATURE_DISTUTILS)
LDSHARED?=	${CC} -shared
MAKE_ENV+=	LDSHARED="${LDSHARED}" PYTHONDONTWRITEBYTECODE= PYTHONOPTIMIZE=

.if !target(do-configure) && !defined(HAS_CONFIGURE) && !defined(GNU_CONFIGURE)
do-configure:
	@(cd ${BUILD_WRKSRC}; ${SETENV} ${MAKE_ENV} ${PYTHON_CMD} ${PYDISTUTILS_SETUP} ${PYDISTUTILS_CONFIGURE_TARGET} ${PYDISTUTILS_CONFIGUREARGS})
.endif

.if !target(do-build)
do-build:
	@(cd ${BUILD_WRKSRC}; ${SETENV} ${MAKE_ENV} ${PYTHON_CMD} ${PYDISTUTILS_SETUP} ${PYDISTUTILS_BUILD_TARGET} ${PYDISTUTILS_BUILDARGS})
.endif

.if !target(do-install)
do-install:
	@(cd ${INSTALL_WRKSRC}; ${SETENV} ${MAKE_ENV} ${PYTHON_CMD} ${PYDISTUTILS_SETUP} ${PYDISTUTILS_INSTALL_TARGET} ${PYDISTUTILS_INSTALLARGS})
.endif
.endif # defined(_PYTHON_FEATURE_DISTUTILS)
.endif # defined(_POSTMKINCLUDED) && !defined(_INCLUDE_USES_PYTHON_POST_MK)
