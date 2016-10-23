# Created by: Alexander Botero-Lowry <alex@foxybanana.com>
# $FreeBSD: head/devel/py-ocempgui/Makefile 412346 2016-04-01 14:00:51Z mat $

PORTNAME=	ocempgui
PORTVERSION=	0.2.9
PORTREVISION=	9
CATEGORIES=	devel python
MASTER_SITES=	SF/ocemp/${PORTNAME}/${PORTVERSION}
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	OcempGUI-${PORTVERSION}

MAINTAINER=	mva@FreeBSD.org
COMMENT=	GUI toolkit in python

LICENSE=	BSD2CLAUSE

BUILD_DEPENDS=	${PYTHON_INCLUDEDIR}/pygame/pygame.h:devel/py-game
RUN_DEPENDS=	${PYTHON_INCLUDEDIR}/pygame/pygame.h:devel/py-game

USES=		python:2
USE_GNOME=	atk
USE_PYTHON=	autoplist distutils
NO_ARCH=	yes

post-patch:
	@${REINPLACE_CMD} -e 's|@DATAPATH@|${DATADIR}|' ${WRKSRC}/ocempgui/widgets/Constants.py

.include <bsd.port.mk>
