# Created by: roam@FreeBSD.org
# $FreeBSD: head/sysutils/timelimit/Makefile 467417 2018-04-15 20:02:46Z sunpoet $

PORTNAME=	timelimit
PORTVERSION=	1.9.0
CATEGORIES=	sysutils
MASTER_SITES=	https://devel.ringlet.net/files/sys/timelimit/ \
		LOCAL/sunpoet

MAINTAINER=	sunpoet@FreeBSD.org
COMMENT=	Limit the absolute execution time of a process

LICENSE=	BSD2CLAUSE

# bin/timelimit man/man1/timelimit.1.gz
CONFLICTS_INSTALL=	netpipes

USES=		tar:xz

PLIST_FILES=	bin/timelimit man/man1/timelimit.1.gz

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/timelimit ${STAGEDIR}${PREFIX}/bin/
	${INSTALL_DATA} ${WRKSRC}/timelimit.1 ${STAGEDIR}${MAN1PREFIX}/man/man1/

.include <bsd.port.mk>
