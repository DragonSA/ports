# $FreeBSD: head/lang/pypy/bsd.pypy.mk 419600 2016-08-04 08:43:36Z dbn $

.if !defined(LICENSE)
LICENSE=	MIT PSFL
LICENSE_COMB=	multi
.endif

USES+=		compiler:c11

PYPY_DIR=	pypy-${PORTVERSION:C|([0-9])\.([0-9]).*|\1.\2|}
PYPY_CFFI_VER?=	pypy-41
PLIST_SUB+=	PYPY_DIR=${PYPY_DIR} PYPY_CFFI_VER=${PYPY_CFFI_VER}
