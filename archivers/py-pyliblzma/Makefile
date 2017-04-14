# Created by: David Naylor <naylor.b.david@gmail.com>
# $FreeBSD: head/archivers/py-pyliblzma/Makefile 438510 2017-04-14 12:58:20Z dbn $

PORTNAME=	pyliblzma
PORTVERSION=	0.5.3
PORTREVISION=	6
CATEGORIES=	archivers python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	dbn@FreeBSD.org
COMMENT=	Python binding for the LZMA compression library

LICENSE=	LGPL3
LICENSE_FILE=	${WRKSRC}/COPYING

USES=		pkgconfig python:2.7- tar:bzip2
USE_PYTHON=	autoplist distutils

post-install:
	${STRIP_CMD} ${STAGEDIR}${PYTHONPREFIX_SITELIBDIR}/lzma.so

do-test:
	@cd ${WRKSRC} && ${PYTHON_CMD} ${PYDISTUTILS_SETUP} test

.include <bsd.port.mk>
