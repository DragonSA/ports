# Created by: TAKATSU Tomonari <tota@FreeBSD.org>
# $FreeBSD: head/devel/R-cran-gdata/Makefile 412346 2016-04-01 14:00:51Z mat $

PORTNAME=	gdata
PORTVERSION=	2.17.0
CATEGORIES=	devel
DISTNAME=	${PORTNAME}_${PORTVERSION}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	Various R programming tools for data manipulation

LICENSE=	GPLv2

RUN_DEPENDS=	R-cran-gtools>0:devel/R-cran-gtools

USES=		cran:auto-plist perl5 shebangfix
USE_PERL5=	run

SHEBANG_FILES=	inst/perl/*.pl

.include <bsd.port.mk>
