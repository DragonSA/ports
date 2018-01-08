# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dotnet-runtime
DISTVERSION=	2.0.4
DISTVERSIONSUFFIX=	-linux-x64
CATEGORIES=	lang
MASTER_SITES?=	https://download.microsoft.com/download/2/B/2/2B2854E7-7EAE-4FE9-85D2-19ACCD716F18/
PKGNAMEPREFIX=	linux-

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Cross-platform .NET implementation

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

ONLY_FOR_ARCHS=	amd64

USES=		linux:c7
USE_LINUX=	curl libicu libunwind lttng-ust openssl

NO_BUILD=	yes
NO_WRKSUBDIR=	yes

do-install:
	cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/dotnet
.for bin in dotnet shared/Microsoft.NETCore.App/2.0.4/createdump
	${RM} ${STAGEDIR}${PREFIX}/dotnet/${bin}
	${INSTALL_PROGRAM} ${WRKSRC}/${bin} ${STAGEDIR}${PREFIX}/dotnet/${bin}
.endfor
	${LN} -s ../dotnet/dotnet ${STAGEDIR}${PREFIX}/bin/dotnet

.include <bsd.port.mk>
