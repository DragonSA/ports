# Created by: Kris Moore <kmoore@FreeBSD.org>
# $FreeBSD: head/emulators/wine-staging/Makefile 407682 2016-02-01 06:04:06Z dbn $

PKGNAMESUFFIX=	-staging

COMMENT=	Wine built with the Staging patchset

CONFLICTS_INSTALL=	wine-[0-9]* wine-devel-[0-9]* i386-wine-[0-9]* \
			i386-wine-staging-[0-9]* i386-wine-devel-[0-9]*

OPTIONS_SLAVE=	STAGING
OPTIONS_SET=	LIBXSLT MPG123 HAL V4L X11

MASTERDIR=	${.CURDIR}/../wine-devel
PLIST=		${MASTERDIR}/pkg-plist

.include "${MASTERDIR}/Makefile"
