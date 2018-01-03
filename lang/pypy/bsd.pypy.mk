# $FreeBSD: head/lang/pypy/bsd.pypy.mk 457998 2018-01-03 18:42:15Z dbn $

DISTVERSION=	5.10.0

.if !defined(LICENSE)
LICENSE=	MIT PSFL
LICENSE_COMB=	multi
.endif

USES+=		compiler:c11

PYTHON_IMPL?=	${PORTNAME}
PYPY_DIR=	${PYTHON_IMPL}-${DISTVERSION:C|([0-9])\.([0-9]+).*|\1.\2|}
PLIST_SUB+=	PYPY_DIR=${PYPY_DIR} PYPY_CFFI_VER=${PYPY_CFFI_VER}

.if ${PYTHON_IMPL} == pypy
PYPY_CFFI_VER=	${PYTHON_IMPL}-41
.else # ${PYTHON_IMPL} == pypy3
PYPY_CFFI_VER=	${PYTHON_IMPL}-${DISTVERSION:S|.||:C|\..*||}-${OPSYS:tl}${OSREL:C|\..*||}
.endif
