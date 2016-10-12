# Created by: TAKATSU Tomonari <tota@FreeBSD.org>
# $FreeBSD: head/databases/R-cran-RMySQL/Makefile 414840 2016-05-09 12:20:28Z tota $

PORTNAME=	RMySQL
DISTVERSION=	0.10.9
CATEGORIES=	databases
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	R interface to the MySQL database

LICENSE=	GPLv2

RUN_DEPENDS=	R-cran-DBI>=0.4:databases/R-cran-DBI

USES=	cran:auto-plist mysql

post-patch:
	@${REINPLACE_CMD} -e '/bin\//s|bash|sh|' ${WRKSRC}/configure

.include <bsd.port.mk>
