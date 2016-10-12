# Created by: TAKATSU Tomonari <tota@FreeBSD.org>
# $FreeBSD: head/graphics/R-cran-rgdal/Makefile 415163 2016-05-13 23:59:01Z tota $

PORTNAME=	rgdal
DISTVERSION=	1.1-10
CATEGORIES=	graphics
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	Bindings for the Geospatial Data Abstraction Library

LICENSE=	GPLv2+

LIB_DEPENDS=	libgdal.so:graphics/gdal \
		libproj.so:graphics/proj
RUN_DEPENDS=	R-cran-sp>=1.1.0:math/R-cran-sp

USES=	cran:auto-plist

.include <bsd.port.mk>
