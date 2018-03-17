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

.if ${PORTNAME} != dotnet-cli
RUN_DEPENDS=	dotnet:lang/linux-dotnet-cli
.endif

ONLY_FOR_ARCHS=	amd64

USES=		linux:c7
USE_LINUX?=	curl icu libunwind lttng-ust openssl

DATADIR=	${PREFIX}/share/dotnet
NO_BUILD=	yes
NO_WRKSUBDIR=	yes

SLAVEDIR=	${.CURDIR}
DISTINFO_FILE?=	${SLAVEDIR}/distinfo
PLIST=		${SLAVEDIR}/pkg-plist
PLIST_SUB=	VERSION=${DISTVERSION}

BINFILES?=	shared/Microsoft.NETCore.App/${DISTVERSION}/createdump

.if !target(do-install)
do-install:
	cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${DATADIR}
	${RM} ${STAGEDIR}${DATADIR}/dotnet
.for bin in ${BINFILES}
	${RM} ${STAGEDIR}${DATADIR}/${bin}
	${INSTALL_PROGRAM} ${WRKSRC}/${bin} ${STAGEDIR}${DATADIR}/${bin}
.endfor
.endif

.include <bsd.port.mk>
