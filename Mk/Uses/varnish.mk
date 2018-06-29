# $FreeBSD: head/Mk/Uses/varnish.mk 473447 2018-06-27 15:48:17Z feld $
#
# Provide support for Varnish
#
# Feature:      varnish
# Usage:        USES=varnish
# Valid ARGS:   4, 5, 6, run
#
# MAINTAINER: ports@FreeBSD.org

.if !defined(_INCLUDE_USES_VARNISH_MK)
_INCLUDE_USES_VARNISH_MK=    yes

VARNISH_VERSION=	${VARNISH_DEFAULT}

. if ${varnish_ARGS:M4}
VARNISH_VERSION=	4
. elif ${varnish_ARGS:M5}
VARNISH_VERSION=	5
. elif ${varnish_ARGS:M6}
VARNISH_VERSION=	6
. elif defined(VARNISH_DEFAULT)
. endif

RUN_DEPENDS+=	varnish${VARNISH_VERSION}>=${VARNISH_VERSION}:www/varnish${VARNISH_VERSION}
BUILD_DEPENDS+=	varnish${VARNISH_VERSION}>=${VARNISH_VERSION}:www/varnish${VARNISH_VERSION}

CFLAGS+= 	-I${LOCALBASE}/include -I${LOCALBASE}/include/varnish
CPPFLAGS+= 	-I${LOCALBASE}/include -I${LOCALBASE}/include/varnish
LIBS+=		-L${LOCALBASE}/lib

.endif
