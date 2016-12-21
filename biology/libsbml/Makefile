# Created by: Wen Heping <wenheping@gmail.com>
# $FreeBSD: head/biology/libsbml/Makefile 425174 2016-11-02 22:45:14Z mat $

PORTNAME=	libsbml
PORTVERSION=	5.13.0
CATEGORIES=	biology devel
MASTER_SITES=	SF/sbml/${PORTNAME}/${PORTVERSION}/stable
DISTNAME=	libSBML-${PORTVERSION}-core-src

MAINTAINER=	ports@FreeBSD.org
COMMENT=	API Library for Working with SBML File

LICENSE=	LGPL21
LICENSE_FILE=	${WRKSRC}/COPYING.txt

WRKSRC=		${WRKDIR}/${PORTNAME}-${PORTVERSION}

USES=		cmake:outsource iconv:build
USE_GNOME=	libxml2
USE_LDCONFIG=	yes

CFLAGS+=	-I${ICONV_PREFIX}/include
LDFLAGS+=	-L${ICONV_PREFIX}/lib

OPTIONS_DEFINE=	EXAMPLES PYTHON RUBY
OPTIONS_SUB=	yes
PLIST_SUB+=	PORTVERSION=${PORTVERSION}

PYTHON_BUILD_DEPENDS=	swig2.0:devel/swig20
PYTHON_USES=		python
PYTHON_CMAKE_ON=	-DWITH_PYTHON:BOOL=ON \
			-DPYTHON_INCLUDE_DIR:STRING="${PYTHON_INCLUDEDIR}" \
			-DPYTHON_LIBRARY:STRING="${PYTHON_LIB}" \
			-DPYTHON_EXECUTABLE:STRING="${PYTHON_CMD}"

RUBY_BUILD_DEPENDS=	swig2.0:devel/swig20
RUBY_USE=		ruby=yes
RUBY_CMAKE_ON=		-DWITH_RUBY:BOOL=ON

post-patch:
	@${REINPLACE_CMD} -e \
		's|/usr/local/include|${LOCALBASE}/include| ; \
		s|/usr/local/lib|${LOCALBASE}/lib| ; \
		s|$${CMAKE_INSTALL_LIBDIR}/pkgconfig|libdata/pkgconfig| ; \
		/$${DOCUMENTATION_FILES}/s|^|#|' ${WRKSRC}/CMakeLists.txt

post-install-EXAMPLES-on:
	${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	cd ${WRKSRC}/examples && ${COPYTREE_SHARE} . \
		${STAGEDIR}${EXAMPLESDIR} '! -name *Makefile*'

.include <bsd.port.mk>
