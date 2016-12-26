# Created by: Adrian Chadd
# $FreeBSD: head/sysutils/intel-pcm/Makefile 423941 2016-10-14 00:03:37Z imp $

PORTNAME=	intel-pcm
PORTVERSION=	2.11
CATEGORIES=	sysutils
MASTER_SITES=	LOCAL/imp
DISTNAME=	IntelPerformanceCounterMonitor-V${PORTVERSION}

MAINTAINER=	imp@FreeBSD.org
COMMENT=	Intel PCM toolkit

LICENSE=	BSD3CLAUSE

USES=		compiler:c++11-lib gmake tar:xz

ONLY_FOR_ARCHS=	i386 amd64

WRKSRC=		${WRKDIR}/IntelPerformanceCounterMonitor-V${PORTVERSION}
MAKE_ARGS=	CXX="${CXX}" LIB=-lpthread

BROKEN_FreeBSD_9=	Does not build

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/*.x ${STAGEDIR}${PREFIX}/sbin

.include <bsd.port.mk>
