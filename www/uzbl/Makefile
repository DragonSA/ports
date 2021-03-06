# Created by: Klaus Aehlig <aehlig@linta.de>
# $FreeBSD: head/www/uzbl/Makefile 493883 2019-02-25 16:58:48Z kwm $

PORTNAME=	uzbl
PORTVERSION=	0.9.1
DISTVERSIONPREFIX=v
PORTREVISION=	4
CATEGORIES=	www

MAINTAINER=	aehlig@linta.de
COMMENT=	Web interface tools which adhere to the unix philosophy

LICENSE=	GPLv3
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${PYTHON_PKGNAMEPREFIX}setuptools>0:devel/py-setuptools@${PY_FLAVOR}
LIB_DEPENDS=	libwebkitgtk-1.0.so:www/webkit-gtk2 \
		libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2  \
		libsoup-2.4.so:devel/libsoup
RUN_DEPENDS=	socat:net/socat \
		dmenu:x11/dmenu \
		${PYTHON_PKGNAMEPREFIX}configparser>0:devel/py-configparser@${PY_FLAVOR}

DEPRECATED=	Uses webkit-gtk2 which has security issues
EXPIRATION_DATE=2019-03-24

USES=		gmake pkgconfig python:2.7 desktop-file-utils gettext-runtime shebangfix
USE_XORG=	x11
USE_GNOME=	gtk20 pygtk2 cairo
USE_LDCONFIG=	yes
INSTALLS_ICONS=	yes

USE_GITHUB=	yes
GH_ACCOUNT=	uzbl

SHEBANG_FILES=	bin/uzbl-tabbed \
		examples/data/scripts/*.py \
		examples/data/scripts/uzblcat

MAKE_ENV=	PYTHON=${PYTHON_VERSION} \
		MANDIR=${STAGEDIR}${MANPREFIX}/man

PORTDOCS=	AUTHORS DEBUGGING.md FAQ.md HACKING.md vim
PORTDATA=	examples

OPTIONS_DEFINE=	DOCS

post-patch:
	@${REINPLACE_CMD} -e "s|/usr/local|${PREFIX}|" \
		${WRKSRC}/examples/config/config \
		${WRKSRC}/bin/uzbl-browser.in
	@${REINPLACE_CMD} -e "s|share/uzbl|${DATADIR_REL}|" \
		${WRKSRC}/examples/config/config \
		${WRKSRC}/bin/uzbl-browser.in
	@${REINPLACE_CMD} -e "s|/usr/share/uzbl|${DATADIR}|" \
		${WRKSRC}/bin/uzbl-tabbed

post-build:
	@${FIND} ${WRKSRC} \( -name "*.orig" -or -name "*.bak" \) -exec ${RM} {} \;

post-install:
	@${MKDIR} ${STAGEDIR}${DATADIR}/examples/data/dforms ${STAGEDIR}${DATADIR}/examples/config
.for f in data/bookmarks \
	data/dforms/bbs.archlinux.org \
	config/style.css data/uzbl.png
		${INSTALL_DATA} ${WRKSRC}/examples/${f} ${STAGEDIR}${DATADIR}/examples/${f}
.endfor
	${INSTALL_DATA} ${WRKSRC}/examples/config/config ${STAGEDIR}${DATADIR}/examples/config/config
	(cd ${WRKSRC}/examples/data && \
		${COPYTREE_BIN} scripts ${STAGEDIR}${DATADIR}/examples/data/)
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/bin/uzbl-core

post-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
.for f in AUTHORS DEBUGGING.md FAQ.md HACKING.md
	${INSTALL_DATA} ${WRKSRC}/${f} ${STAGEDIR}${DOCSDIR}/${f}
.endfor
	(cd ${WRKSRC}/extras && ${COPYTREE_SHARE} vim ${STAGEDIR}${DOCSDIR})

.include <bsd.port.mk>
