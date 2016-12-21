# Created by: Sahil Tandon <sahil@FreeBSD.org>
# $FreeBSD: head/graphics/py-graphy/Makefile 424411 2016-10-21 12:51:40Z mat $

PORTNAME=	graphy
PORTVERSION=	1.0
CATEGORIES=	graphics python
MASTER_SITES=	GOOGLE_CODE
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	${PORTNAME}_${PORTVERSION}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Simple chart library for Python

LICENSE=	APACHE20
LICENSE_FILE=	${WRKSRC}/LICENSE

BROKEN=		Unfetchable (google code has gone away)
DEPRECATED=	Abandoned software: no update since 2010 and no upstream
EXPIRATION_DATE=2016-12-31

USES=		python:run tar:bzip2

PORTDOCS=	README
PORTEXAMPLES=	*

NO_BUILD=	yes

OPTIONS_DEFINE=	DOCS EXAMPLES

post-patch:
	@${REINPLACE_CMD} -e 's|python2.4|${PYTHON_CMD}|' \
		${WRKSRC}/examples/*.py \
		${WRKSRC}/${PORTNAME}/*.py
	@${FIND} ${WRKSRC} -name '.svn' -or -name '*.bak' | \
		${XARGS} ${RM} -r

do-install:
	@${MKDIR} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}
	@(cd ${WRKSRC}/${PORTNAME}/ && \
	     ${COPYTREE_SHARE} . ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME})
post-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/${PORTDOCS} ${STAGEDIR}${DOCSDIR}
post-install-EXAMPLES-on:
	@${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	@(cd ${WRKSRC}/examples/ && ${COPYTREE_SHARE} . ${STAGEDIR}${EXAMPLESDIR})

.include <bsd.port.mk>
