# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dotnet-cli
DISTNAME=	dotnet-runtime-${DISTVERSION}-linux-x64

PLIST_FILES=	bin/dotnet ${DATADIR}/dotnet
USE_LINUX=

DISTINFO_FILE=	${MASTERDIR}/distinfo
PKGMESSAGE=	${.CURDIR}/pkg-message

MASTERDIR=	${.CURDIR}/../linux-dotnet-runtime

do-install:
	${MKDIR} ${STAGEDIR}${DATADIR}
	${INSTALL_PROGRAM} ${WRKSRC}/dotnet ${STAGEDIR}${DATADIR}/dotnet
	${LN} -s ../share/dotnet/dotnet ${STAGEDIR}${PREFIX}/bin/dotnet

.include "${MASTERDIR}/Makefile"
