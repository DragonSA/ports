# Created by: Romain Tartiere <romain@blogreen.org>
# $FreeBSD: head/lang/mono-basic/Makefile 472555 2018-06-16 15:56:41Z feld $

PORTNAME=	mono-basic
PORTVERSION=	4.7
CATEGORIES=	lang
MASTER_SITES=	http://download.mono-project.com/sources/${PORTNAME}/ \
		http://ftp.novell.com/pub/mono/sources/${PORTNAME}/

MAINTAINER=	mono@FreeBSD.org
COMMENT=	VisualBasic.NET support for Mono

HAS_CONFIGURE=	yes
CONFIGURE_ARGS=	--prefix=${PREFIX}
USES=		gmake mono tar:bzip2

do-test:
	@(cd ${WRKSRC} && \
		${SETENV} ${MAKE_ENV} MONO_PATH=${WRKSRC}/class/lib/net_4_5 ${MAKE_CMD} \
			${MAKE_FLAGS} Makefile ${MAKE_ARGS} test)

.include <bsd.port.mk>
