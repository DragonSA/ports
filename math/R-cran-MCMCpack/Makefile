# Created by: TAKATSU Tomonari <tota@FreeBSD.org>
# $FreeBSD: head/math/R-cran-MCMCpack/Makefile 487272 2018-12-12 01:35:33Z gerald $

PORTNAME=	MCMCpack
DISTVERSION=	1.4-4
PORTREVISION=	1
CATEGORIES=	math
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	Markov chain Monte Carlo Package

LICENSE=	GPLv3

CRAN_DEPENDS=	R-cran-coda>=0.11.3:math/R-cran-coda \
		R-cran-mcmc>0:math/R-cran-mcmc \
		R-cran-quantreg>0:math/R-cran-quantreg
BUILD_DEPENDS=	${CRAN_DEPENDS}
RUN_DEPENDS=	${CRAN_DEPENDS}

USES=		cran:auto-plist,compiles

.include <bsd.port.mk>
