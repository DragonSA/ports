# Created by: Nicola Vitale <nivit@email.it>
# $FreeBSD: head/textproc/py-genshi/Makefile 472884 2018-06-20 17:05:41Z mat $

PORTNAME=	Genshi
PORTVERSION=	0.7
PORTREVISION=	2
#PORTEPOCH=	0
CATEGORIES=	textproc www python
MASTER_SITES=	http://ftp.edgewall.com/pub/${PORTNAME:tl}/
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	nivit@FreeBSD.org
COMMENT=	Python toolkit for stream-based generation of output for the web

LICENSE=	BSD3CLAUSE

OPTIONS_DEFINE=	BABEL
BABEL_DESC=	I18n support through the Babel plugin

USES=		python
USE_PYTHON=	distutils autoplist

BABEL_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}Babel>=0.9.6:devel/py-babel@${PY_FLAVOR}

.include <bsd.port.mk>
