# Created by: Russell L. Carter <rcarter@pinyon.org>
# $FreeBSD: head/databases/metakit/Makefile 426088 2016-11-14 06:49:45Z linimon $

PORTNAME=	metakit
PORTVERSION=	2.4.9.7
PORTREVISION=	2
CATEGORIES=	databases
MASTER_SITES=	http://www.equi4.com/pub/mk/

MAINTAINER=	ports@FreeBSD.org
COMMENT=	C++ embedded database engine with Python and Tcl support

LICENSE=	MIT

GNU_CONFIGURE=	yes
CONFIGURE_SCRIPT=	../unix/configure
USE_LDCONFIG=	yes

WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION}/builds

BROKEN_aarch64=		Fails to build: error: typedef redefinition with different types
BROKEN_mips64=		Fails to build: error: conflicting declaration typedef long int t4_i32

OPTIONS_DEFINE=	PYTHON TCL DOCS
OPTIONS_DEFAULT=	PYTHON
OPTIONS_SUB=	yes

PYTHON_CATEGORIES=	python
PYTHON_CONFIGURE_WITH=	python=${PYTHON_INCLUDEDIR},${PYTHON_SITELIBDIR}
PYTHON_USES=		python

TCL_CATEGORIES=		tcl
TCL_CONFIGURE_ENV=	TCL_LIBDIR=${TCL_LIBDIR}
TCL_CONFIGURE_WITH=	tcl=${TCL_INCLUDEDIR}
TCL_PLIST_SUB=		TCL_V="${TCL_VER}"
TCL_USES=		tcl:85

pre-patch:
	${REINPLACE_CMD} -e "s=doc/==" ${WRKSRC}/../Metakit.html
	${REINPLACE_CMD} -e "s|= tclsh|=${TCLSH}|" \
		${WRKSRC}/../unix/Makefile.in

post-build-PYTHON-on:
	${PYTHON_CMD} ${PYTHON_LIBDIR}/compileall.py \
		${WRKSRC}/../python
	${PYTHON_CMD} -O ${PYTHON_LIBDIR}/compileall.py \
		${WRKSRC}/../python

pre-install:
	@${MKDIR} ${STAGEDIR}${PYTHON_SITELIBDIR}

post-install:
	${INSTALL_PROGRAM} ${WRKSRC}/libmk4.so \
		${STAGEDIR}${PREFIX}/lib/libmk4.so.0
	${LN} -sf libmk4.so.0 ${STAGEDIR}${PREFIX}/lib/libmk4.so
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${TAR} -C ${WRKSRC}/../doc --exclude "*CVS" -cf - . | \
		${TAR} -C ${STAGEDIR}${DOCSDIR} --unlink -xf -
	${INSTALL_DATA} ${WRKSRC}/../Metakit.html ${WRKSRC}/../CHANGES \
		${WRKSRC}/../README ${STAGEDIR}${DOCSDIR}

do-test:
	@(cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} \
		${MAKE_CMD} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} test)

do-test-TCL-on:
	@(cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} \
		${MAKE_CMD} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} test-tcl)

.include <bsd.port.mk>
