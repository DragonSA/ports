# Created by: Tom McLaughlin <tmclaugh@FreeBSD.org>
# $FreeBSD: head/x11-toolkits/gnome-sharp20/Makefile 369823 2014-10-02 13:23:11Z kwm $

PORTNAME=	gnome-sharp
PORTVERSION=	2.24.2
PORTREVISION=	4
CATEGORIES=	x11-toolkits
MASTER_SITES=	GNOME

MAINTAINER=	mono@FreeBSD.org
COMMENT=	GNOME interfaces for the .NET runtime

GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes
USES=		gmake libtool mono pathfix perl5 pkgconfig tar:bzip2
USE_PERL5=	run
USE_GNOME=	gnomevfs2 gtksharp20 librsvg2 vte libgnomeprintui libgnomeui
MAKE_JOBS_UNSAFE=	yes
INSTALL_TARGET=	install-strip

post-patch:
	@${FIND} ${WRKSRC} -name '*.pl' | ${XARGS} ${REINPLACE_CMD} -e \
		's|^#!/usr/bin/perl|#!${PERL}|'

.include <bsd.port.mk>