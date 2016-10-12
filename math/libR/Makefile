# Created by: bf <bf@FreeBSD.org>
# $FreeBSD: head/math/libR/Makefile 418290 2016-07-09 19:32:32Z riggs $

PORTNAME=	libR

COMMENT=	The static libR library from R

DESCR=	${.CURDIR}/pkg-descr
LIBR_SLAVEPORT=	yes
MASTERDIR=	${.CURDIR}/../R
PLIST=	${.CURDIR}/pkg-plist
PLIST_FILES=	lib/R/lib/libR.a

BROKEN=		Transient breakage while restructuring the master port

.include "${MASTERDIR}/Makefile"
