# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME?=	dotnet-runtime
DISTVERSION?=	2.0.6
DISTVERSIONSUFFIX=	-linux-x64
CATEGORIES=	lang
MASTER_SITES?=	https://download.microsoft.com/download/8/D/A/8DA04DA7-565B-4372-BBCE-D44C7809A467/
PKGNAMEPREFIX=	linux-

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Cross-platform .NET implementation

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

ONLY_FOR_ARCHS=	amd64

USES=		linux:c7
USE_LINUX=	curl icu libunwind lttng-ust openssl

DATADIR=	${PREFIX}/share/dotnet
NO_BUILD=	yes
NO_WRKSUBDIR=	yes

SLAVEDIR?=	${.CURDIR}
DISTINFO_FILE=	${SLAVEDIR}/distinfo
PLIST=		${SLAVEDIR}/pkg-plist
PLIST_SUB=	VERSION=${DISTVERSION}

BINFILES?=	dotnet shared/Microsoft.NETCore.App/${DISTVERSION}/createdump

do-install:
	cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${DATADIR}
.for bin in ${BINFILES}
	${RM} ${STAGEDIR}${DATADIR}/${bin}
	${INSTALL_PROGRAM} ${WRKSRC}/${bin} ${STAGEDIR}${DATADIR}/${bin}
.endfor
	${LN} -s ../share/dotnet/dotnet ${STAGEDIR}${PREFIX}/bin/dotnet

.include <bsd.port.mk>
