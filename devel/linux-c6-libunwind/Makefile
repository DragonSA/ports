# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD: head/devel/linux-c6-libunwind/Makefile 460526 2018-01-31 20:10:29Z tijl $

PORTNAME=	libunwind
PORTVERSION=	1.1
CATEGORIES=	devel linux
MASTER_SITES=	EPEL/l

MAINTAINER=	emulation@FreeBSD.org
COMMENT=	Generic stack unwinding library (Linux CentOS ${LINUX_DIST_VER})

DESCR=		${.CURDIR}/../${PORTNAME}/pkg-descr
RPMVERSION=	3.el6
USES=		linux:c6
USE_LDCONFIG=	yes
USE_LINUX_RPM=	yes

OPTIONS_DEFINE=	DOCS

.include <bsd.port.mk>
