# Created by: TAKATSU Tomonari <tota@FreeBSD.org>
# $FreeBSD: head/astro/R-cran-maptools/Makefile 487272 2018-12-12 01:35:33Z gerald $

PORTNAME=	maptools
DISTVERSION=	0.9-4
PORTREVISION=	1
CATEGORIES=	astro
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	Tools for reading and handling spatial objects

LICENSE=	GPLv2+

CRAN_DEPENDS=	R-cran-sp>=1.0.11:math/R-cran-sp
BUILD_DEPENDS=	${CRAN_DEPENDS}
RUN_DEPENDS=	${CRAN_DEPENDS}

USES=	cran:auto-plist,compiles

.include <bsd.port.mk>
