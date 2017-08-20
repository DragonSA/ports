# Created by: Tom McLaughlin <tmclaugh@FreeBSD.org>
# $FreeBSD: head/x11-toolkits/gnome-sharp20/Makefile 427247 2016-11-27 17:00:08Z dbn $

PORTNAME=	gnome-sharp
PORTVERSION=	2.24.4
CATEGORIES=	x11-toolkits

MAINTAINER=	mono@FreeBSD.org
COMMENT=	GNOME interfaces for the .NET runtime

LICENSE=	LGPL21
LICENSE_FILE=	${WRKSRC}/COPYING

LIB_DEPENDS=	libpopt.so:devel/popt \
		libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2

GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes
USES=		autoreconf gettext-runtime gmake libtool mono pathfix perl5 pkgconfig shebangfix tar:bzip2
USE_GITHUB=	yes
USE_GNOME=	cairo gnomevfs2 gtksharp20 librsvg2 vte libgnomeprintui libgnomeui
USE_PERL5=	run
USE_XORG=	ice sm
INSTALL_TARGET=	install-strip
SHEBANG_GLOB=	*.pl

GH_ACCOUNT=	mono

pre-configure:
	(cd ${WRKSRC}; ./bootstrap-2.24)

.include <bsd.port.mk>
