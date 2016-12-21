# Created by: Douglas K. Rand <rand@meridian-enviro.com>
# $FreeBSD: head/graphics/mapserver/Makefile 428468 2016-12-13 07:05:57Z wen $

PORTNAME=		mapserver
PORTVERSION=		7.0.3
CATEGORIES=		graphics www geography
MASTER_SITES=		http://download.osgeo.org/mapserver/

MAINTAINER=		wen@FreeBSD.org
COMMENT=		System for developing web-based GIS applications

LICENSE=		MIT

LIB_DEPENDS=		libgd.so:graphics/gd \
			libproj.so:graphics/proj \
			libpng.so:graphics/png \
			libgif.so:graphics/giflib \
			libharfbuzz.so:print/harfbuzz

USES=			cpe cmake:outsource jpeg
CPE_VENDOR=		umn
USE_GNOME=		libxml2
LDFLAGS+=		-L${LOCALBASE} -pthread
CMAKE_ARGS+=		-DCMAKE_PREFIX_PATH=${LOCALBASE} \
			-DCMAKE_INSTALL_PREFIX=${PREFIX} \
			-DWITH_GD=1
MAKE_JOBS_UNSAFE=	yes

OPTIONS_DEFINE=		FRIBIDI CURL GDAL GEOS KML POSTGIS PHP PERL PYTHON \
			WMS WFS WCS FASTCGI DEBUG CAIRO CAIRO_SVG \
			CLIENT_WMS CLIENT_WFS
OPTIONS_DEFAULT=	FRIBIDI GDAL GEOS CLIENT_WMS CLIENT_WFS KML CAIRO_SVG
OPTIONS_SUB=		yes
CAIRO_SVG_DESC=		Cairo SVG parser support
GDAL_DESC=		GDAL library support
FRIBIDI_DESC=		Fribidi library support
KML_DESC=		KML support
WMS_DESC=		WMS Server support
WFS_DESC=		WFS Server support
WCS_DESC=		WCS Server support

PYTHON_USES=			python:-2.7
PYTHON_BUILD_DEPENDS=		swig2.0:devel/swig20
PYTHON_CMAKE_BOOL=		WITH_PYTHON
PYTHON_VARS=			MAP_EGG=MapScript-${PORTVERSION}-py${PYTHON_VER}
PYTHON_PLIST_SUB=		MAP_EGG=${MAP_EGG}

CAIRO_LIB_DEPENDS=		libcairo.so:graphics/cairo \
				libexpat.so:textproc/expat2
CAIRO_CMAKE_BOOL=		WITH_CAIRO

FRIBIDI_LIB_DEPENDS=		libfribidi.so:converters/fribidi
FRIBIDI_CMAKE_BOOL=		WITH_FRIBIDI

CAIRO_SVG_LIB_DEPENDS=		libsvg-cairo.so:graphics/libsvg-cairo
CAIRO_SVG_CMAKE_ARGS=		WITH_SVGCAIRO
CAIRO_SVG_USES=			pkgconfig
CAIRO_SVG_IMPLIES=		CAIRO

KML_LIB_DEPENDS=		libxml2.so:textproc/libxml2
KML_CMAKE_BOOL=			WITH_KML

WMS_CMAKE_BOOL=			WITH_WMS

WFS_CMAKE_BOOL=			WITH_WFS

WCS_CMAKE_BOOL=			WITH_WCS

GDAL_USES=			iconv
GDAL_LIB_DEPENDS=		libgdal.so:graphics/gdal
GDAL_CMAKE_BOOL=		WITH_GDAL

GEOS_LIB_DEPENDS=		libgeos.so:graphics/geos
GEOS_CMAKE_BOOL=		WITH_GEOS

POSTGIS_USES=			pgsql
POSTGIS_CMAKE_ARGS=		WITH_POSTGIS

PHP_USES=			php:build
PHP_VARS=			IGNORE_WITH_PHP=70
PHP_CMAKE_BOOL=			WITH_PHP

PERL_USES=			perl5
PERL_BUILD_DEPENDS=		${LOCALBASE}/bin/swig2.0:devel/swig20
PERL_CMAKE_BOOL=		WITH_PERL

CURL_LIB_DEPENDS=		libcurl.so:ftp/curl
CURL_CMAKE_BOOL=		WITH_CURL

FASTCGI_BUILD_DEPENDS=		${LOCALBASE}/bin/cgi-fcgi:www/fcgi
FASTCGI_CMAKE_BOOL=		WITH_FCGI

DEBUG_CMAKE_ON=			-DCMAKE_BUILD_TYPE=Debug
DEBUG_CMAKE_OFF=		-DCMAKE_BUILD_TYPE=Release

CLIENT_WMS_CMAKE_BOOL=		WITH_CLIENT_WMS
CLIENT_WMS_IMPLIES=		CURL GDAL

CLIENT_WFS_CMAKE_BOOL=		WITH_CLIENT_WFS
CLIENT_WFS_IMPLIES=		CURL GDAL

PROG_FILES=		legend scalebar shp2img shptree shptreetst shptreevis \
			sortshp msencrypt tile4ms mapserv

do-install:
.for f in ${PROG_FILES}
	${STRIP_CMD} ${BUILD_WRKSRC}/${f}
	${INSTALL_SCRIPT} ${BUILD_WRKSRC}/${f} ${STAGEDIR}${PREFIX}/bin
.endfor
	${INSTALL_PROGRAM} ${BUILD_WRKSRC}/libmapserver.so.${PORTVERSION} ${STAGEDIR}${PREFIX}/lib

	@${LN} -s ${PREFIX}/lib/libmapserver.so.7.0.2 ${STAGEDIR}${PREFIX}/lib/libmapserver.so.2
	@${LN} -s ${PREFIX}/lib/libmapserver.so.2 ${STAGEDIR}${PREFIX}/lib/libmapserver.so

do-install-PHP-on:
	@${MKDIR} ${STAGEDIR}${PREFIX}/lib/php/${PHP_EXT_DIR}
	${INSTALL_PROGRAM} ${BUILD_WRKSRC}/mapscript/php/php_mapscript.so \
		${STAGEDIR}${PREFIX}/lib/php/${PHP_EXT_DIR}/
	@${MKDIR} ${STAGEDIR}${PREFIX}/etc/php
	@${ECHO_CMD} "extension=php_mapscript.so" > ${STAGEDIR}${PREFIX}/etc/php/ext-20-php_mapscript.ini


do-install-PYTHON-on:
	@${MKDIR} ${STAGEDIR}${PYTHON_SITELIBDIR}/
	(cd ${BUILD_WRKSRC}/mapscript/python && ${CP} mapscript.py _mapscript.so ${STAGEDIR}${PYTHON_SITELIBDIR}/)


.include <bsd.port.mk>
