# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD: head/devel/py-typed-ast/Makefile 496454 2019-03-21 13:34:10Z amdmi3 $

PORTNAME=	typed-ast
PORTVERSION=	1.3.1
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
	@${STRIP_CMD} ${STAGEDIR}${PYTHONPREFIX_SITELIBDIR}/typed_ast/*.so

.include <bsd.port.mk>
