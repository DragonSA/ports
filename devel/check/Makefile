# Created by: mikeh@FreeBSD.org
# $FreeBSD: head/devel/check/Makefile 484628 2018-11-10 18:12:57Z bapt $

PORTNAME=	check
PORTVERSION=	0.12.0
PORTREVISION=	1
CATEGORIES=	devel

MAINTAINER=	sunpoet@FreeBSD.org
COMMENT=	Unit test framework for C

LICENSE=	LGPL21

OPTIONS_DEFINE=	DOCS EXAMPLES

CONFIGURE_ENV=	ac_cv_path_AWK_PATH=${AWK}
GNU_CONFIGURE=	yes
INSTALL_TARGET=	install-strip
USE_LDCONFIG=	yes
USES=		autoreconf libtool makeinfo pathfix pkgconfig

INFO=		check
PORTDOCS=	*
PORTEXAMPLES=	*

GH_ACCOUNT=	lib${PORTNAME}
USE_GITHUB=	yes

post-patch:
	@${REINPLACE_CMD} \
		-e 's|COPYING.LESSER||' \
		-e '/^docdir = / s|$$(PACKAGE)|${PORTNAME}|' \
			${WRKSRC}/Makefile.am
	@${REINPLACE_CMD} \
		-e '/^exampledir = / s|(docdir)/example|(datadir)/examples/${PORTNAME}|' \
		-e '/^example[a-z]*dir = / s|(docdir)/example/|(exampledir)/|' \
			${WRKSRC}/doc/Makefile.am

.include <bsd.port.mk>
