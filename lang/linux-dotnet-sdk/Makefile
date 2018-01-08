# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dotnet-sdk
DISTVERSION=	2.1.3
DISTVERSIONSUFFIX=	-linux-x64
CATEGORIES=	lang
MASTER_SITES=	https://download.microsoft.com/download/2/9/3/293BC432-348C-4D1C-B628-5AC8AB7FA162/
PKGNAMEPREFIX=	linux-

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Cross-platform .NET implementation

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

RUN_DEPENDS=	linux-dotnet-runtime>=2.0.4:lang/linux-dotnet-runtime

ONLY_FOR_ARCHS=	amd64

EXTRACT_AFTER_ARGS=        --no-same-owner --no-same-permissions \
		--include LICENSE.txt --include additionalDeps --include sdk --include store
NO_BUILD=	yes
NO_WRKSUBDIR=	yes

USES=		linux:c7

do-install:
	cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/dotnet
	${RM} ${STAGEDIR}${PREFIX}/dotnet/LICENSE.txt

.include <bsd.port.mk>
