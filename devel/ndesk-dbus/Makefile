# Created by: FreeBSD GNOME Team <gnome@FreeBSD.org>
# $FreeBSD: head/devel/ndesk-dbus/Makefile 460430 2018-01-30 19:00:27Z dbn $
#   $MCom: ports/devel/ndesk-dbus/Makefile,v 1.2 2008/01/14 22:35:41 mezz Exp $

PORTNAME=	ndesk-dbus
PORTVERSION=	0.6.1a
PORTREVISION=	1
CATEGORIES=	devel
MASTER_SITES=	http://www.ndesk.org/archive/ndesk-dbus/

MAINTAINER=	gnome@FreeBSD.org
COMMENT=	C\# implementation of D-Bus

USES=		gmake mono pathfix pkgconfig
GNU_CONFIGURE=	yes
CONFIGURE_ENV=	ac_cv_path_CSC=${LOCALBASE}/bin/mcs

OPTIONS_DEFINE=	DOCS

DOCS=		AUTHORS COPYING README

post-install:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
.for i in ${DOCS}
	@${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${DOCSDIR}
.endfor

.include <bsd.port.mk>
