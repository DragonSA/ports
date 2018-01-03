# $FreeBSD: head/lang/pypy/bsd.pypy.cffi.mk 457998 2018-01-03 18:42:15Z dbn $

PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTFILES=

BUILD_DEPENDS+=	${PYTHON_IMPL}:lang/${PYTHON_IMPL}
RUN_DEPENDS+=	${PYTHON_IMPL}:lang/${PYTHON_IMPL}

PLIST_FILES=	${PYPY_DIR}/lib_pypy/${CFFI_MODULE}_cffi.${PYPY_CFFI_VER}.so

CFFI_MODULE?=	_${PORTNAME}

FLAVORS=	pypy pypy3
FLAVOR?=	${FLAVORS:[1]}

PYTHON_IMPL=	${FLAVOR}
PYTHON_PORTVERSION=	${DISTVERSION}
PYTHON_PKGNAMEPREFIX=	${PYTHON_IMPL}-
PYTHON_CMD=	${LOCALBASE}/bin/${PYTHON_IMPL}

.include "${.CURDIR}/../../lang/pypy/bsd.pypy.mk"

do-build:
	${CP} ${LOCALBASE}/${PYPY_DIR}/lib_pypy/${CFFI_MODULE}_build.py ${WRKDIR}/${PORTNAME}.py
	(cd ${WRKDIR}; \
		${PYTHON_CMD} -c "from ${PORTNAME} import ${CFFI_NAME} as ffi; ffi.compile('${WRKDIR}');")

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/${PYPY_DIR}/lib_pypy/`dirname ${CFFI_MODULE}`/
	${INSTALL_LIB} ${WRKDIR}/${CFFI_MODULE}_cffi.${PYPY_CFFI_VER}.so ${STAGEDIR}${PREFIX}/${PYPY_DIR}/lib_pypy/`dirname ${CFFI_MODULE}`/
