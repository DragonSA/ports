# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD: head/devel/py-typed-ast/Makefile 434190 2017-02-15 19:14:52Z dbn $

PORTNAME=	typed-ast
PORTVERSION=	1.0.0
CATEGORIES=	devel python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	dbn@FreeBSD.org
COMMENT=	Fast version of Python's ast module with support for PEP484 typed comments

LICENSE=	APACHE20 PSFL
LICENSE_COMB=	multi
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		python:3.3+
USE_PYTHON=	autoplist distutils concurrent

post-install:
		${STRIP_CMD} ${STAGEDIR}${PYTHON_SITELIBDIR}/_ast27.so
		${STRIP_CMD} ${STAGEDIR}${PYTHON_SITELIBDIR}/_ast3.so

.include <bsd.port.mk>
