# $FreeBSD: head/graphics/partio/Makefile 412346 2016-04-01 14:00:51Z mat $

PORTNAME=	partio
PORTVERSION=	1.1.0.20150221
CATEGORIES=	graphics math

MAINTAINER=	mva@FreeBSD.org
COMMENT=	C++ library for manipulating animation particle formats

LICENSE=	BSD3CLAUSE

USES=		cmake:outsource
USE_XORG=	xmu
USE_GL=		gl glut

USE_GITHUB=	yes
GH_ACCOUNT=	wdas
GH_TAGNAME=	1fd6747

OPTIONS_DEFINE=		DOCS PYTHON
OPTIONS_DEFAULT=	PYTHON

DOCS_BUILD_DEPENDS=	doxygen:devel/doxygen
PYTHON_USES=		python
PYTHON_BUILD_DEPENDS=	swig:devel/swig13

PORTDOCS=	*

.include <bsd.port.options.mk>

post-patch:
	@${REINPLACE_CMD} -e 's|python -c|${PYTHON_CMD} -c|; \
		s|lib64/python$${PYTHON_VERSION}/site-packages|${PYTHONPREFIX_SITELIBDIR:S/${PREFIX}\///}|' \
		${WRKSRC}/src/py/CMakeLists.txt
	@${REINPLACE_CMD} -e '/install(TARGETS/d' \
		${WRKSRC}/src/tests/CMakeLists.txt

post-patch-PYTHON-off:
	@${REINPLACE_CMD} -e '/ADD_SUBDIRECTORY.*src\/py.*/d' \
		${WRKSRC}/CMakeLists.txt

post-patch-DOCS-off:
	@${REINPLACE_CMD} -e '/ADD_SUBDIRECTORY.*src\/doc.*/d' \
		${WRKSRC}/CMakeLists.txt

post-build-DOCS-on:
	@(cd ${BUILD_WRKSRC}; make doc)

.include <bsd.port.mk>
