# Created by: Juli Mallett
# $FreeBSD: head/x11-toolkits/gtk-sharp20/Makefile 460430 2018-01-30 19:00:27Z dbn $

PORTNAME=	gtk-sharp
PORTVERSION=	2.12.45
PORTREVISION=	1
CATEGORIES=	x11-toolkits
MASTER_SITES=	http://download.mono-project.com/sources/gtk-sharp212/
PKGNAMESUFFIX=	20

MAINTAINER=	mono@FreeBSD.org
COMMENT=	GTK+ and GNOME interfaces for the .NET runtime

LICENSE=	LGPL21
LICENSE_FILE=	${WRKSRC}/COPYING

LIB_DEPENDS=	libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2
RUN_DEPENDS=	p5-XML-LibXML>=0:textproc/p5-XML-LibXML

USES=		gmake libtool mono pathfix perl5 pkgconfig shebangfix
USE_LDCONFIG=	yes
USE_GNOME=	cairo gdkpixbuf2 gtk20 libglade2
USE_PERL5=	run
SHEBANG_FILES=	parser/*.pl

GNU_CONFIGURE=	yes
MAKE_ENV=	INSTALL_STRIP_FLAG=${STRIP}

post-patch:
	@${REINPLACE_CMD} -e 's|glib/.*\.h>|glib.h>|g' \
		${WRKSRC}/glib/glue/*.c

.include <bsd.port.mk>
