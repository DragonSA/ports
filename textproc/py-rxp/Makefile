# Created by: Hye-Shik Chang <perky@fallin.lv>
# $FreeBSD: head/textproc/py-rxp/Makefile 455210 2017-11-30 15:50:30Z mat $

PORTNAME=	rxp
PORTVERSION=	0.9
PORTREVISION=	3
CATEGORIES=	textproc python
MASTER_SITES=	http://www.reportlab.com/ftp/
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	pyRXP-${PORTVERSION:S/./-/}

MAINTAINER=	ports@FreeBSD.org
COMMENT=	Fast validating XML parser for Python

OPTIONS_DEFINE=	DOCS EXAMPLES

NO_WRKSUBDIR=	yes
USES=		python:2.7 tar:tgz
USE_PYTHON=	distutils autoplist

DOCSDIR=	${PREFIX}/share/doc/py-rxp
EXAMPLESDIR=	${PREFIX}/share/examples/py-rxp
PORTDOCS=	*
PORTEXAMPLES=	*

post-install:
	${STRIP_CMD} ${STAGEDIR}${PYTHONPREFIX_SITELIBDIR}/pyRXP.so

post-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/docs/* ${STAGEDIR}${DOCSDIR}

post-install-EXAMPLES-on:
	@${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	${INSTALL_DATA} ${WRKSRC}/examples/* ${STAGEDIR}${EXAMPLESDIR}

.include <bsd.port.mk>
