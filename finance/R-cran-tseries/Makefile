# Created by: David Naylor <naylor.b.david@gmail.com>
# $FreeBSD: head/finance/R-cran-tseries/Makefile 426364 2016-11-19 12:57:24Z dbn $

PORTNAME=	tseries
DISTVERSION=	0.10-35
PORTREVISION=	1
CATEGORIES=	finance
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	dbn@FreeBSD.org
COMMENT=	Time series analysis and computational finance

LICENSE=	GPLv2 GPLv3
LICENSE_COMB=	dual

BUILD_DEPENDS=	R-cran-quadprog>0:math/R-cran-quadprog \
		R-cran-zoo>0:math/R-cran-zoo
RUN_DEPENDS=	R-cran-quadprog>0:math/R-cran-quadprog \
		R-cran-zoo>0:math/R-cran-zoo

USES=		cran:auto-plist,compiles

.include <bsd.port.mk>
