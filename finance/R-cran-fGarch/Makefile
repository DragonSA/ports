# Created by: David Naylor <naylor.b.david@gmail.com>
# $FreeBSD: head/finance/R-cran-fGarch/Makefile 497434 2019-03-31 17:28:18Z dbn $

PORTNAME=	fGarch
DISTVERSION=	3042.83.1
CATEGORIES=	finance
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	dbn@FreeBSD.org
COMMENT=	Rmetrics - Autoregressive Conditional Heteroskedastic Modelling

LICENSE=	GPLv2+

RUN_DEPENDS=	R-cran-fBasics>0:finance/R-cran-fBasics \
		R-cran-timeDate>0:finance/R-cran-timeDate \
		R-cran-timeSeries>0:finance/R-cran-timeSeries \
		R-cran-fastICA>0:science/R-cran-fastICA
TEST_DEPENDS=	R-cran-RUnit>0:devel/R-cran-RUnit

USES=		cran:auto-plist,compiles

.include <bsd.port.mk>
