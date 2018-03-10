# Created by: TAKATSU Tomonari <tota@FreeBSD.org>
# $FreeBSD: head/math/R-cran-memisc/Makefile 463939 2018-03-09 07:58:05Z tota $

PORTNAME=	memisc
DISTVERSION=	0.99.14.9
CATEGORIES=	math
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	Provides an infrastructure for the management of survey data

LICENSE=	GPLv2

CRAN_DEPENDS=	R-cran-repr>0:devel/R-cran-repr
BUILD_DEPENDS=	${CRAN_DEPENDS}
RUN_DEPENDS=	${CRAN_DEPENDS}

USES=	cran:auto-plist,compiles

.include <bsd.port.mk>
