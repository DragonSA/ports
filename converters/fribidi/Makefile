# Created by: ijliao
# $FreeBSD: head/converters/fribidi/Makefile 412342 2016-04-01 13:18:17Z mat $

PORTNAME=	fribidi
PORTVERSION=	0.19.7
CATEGORIES=	converters
MASTER_SITES=	http://fribidi.org/download/

MAINTAINER=	gnome@FreeBSD.org
COMMENT=	Free Implementation of the Unicode Bidirectional Algorithm

LICENSE=	LGPL21
LICENSE_FILE=	${WRKSRC}/COPYING

USES=		gmake libtool pathfix tar:bz2
USE_LDCONFIG=	yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-static --without-glib
INSTALL_TARGET=	install-strip

.if !defined(WITH_DEBUG)
CONFIGURE_ARGS+=--disable-debug
.endif

post-patch:
	@${SED} -e 's|%%LOCALBASE%%|${LOCALBASE}|g' < \
		${FILESDIR}/fribidi-config > ${WRKDIR}/fribidi-config

post-install:
	${INSTALL_SCRIPT} ${WRKDIR}/fribidi-config ${STAGEDIR}${PREFIX}/bin

.include <bsd.port.mk>
