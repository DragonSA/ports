# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dotnet-sdk
DISTVERSION=	2.1.3
DISTVERSIONSUFFIX=	-linux-x64
CATEGORIES=	lang
MASTER_SITES=	https://download.microsoft.com/download/2/9/3/293BC432-348C-4D1C-B628-5AC8AB7FA162/
PKGNAMEPREFIX=	linux-

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Cross-platform .NET implementation (Software Development Kit)

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE.txt

BUILD_DEPENDS=${LOCALBASE}/bin/lzma:archivers/lzma \
		zip:archivers/zip
RUN_DEPENDS=	linux-dotnet-runtime>=2.0.4:lang/linux-dotnet-runtime

ONLY_FOR_ARCHS=	amd64

DESCR=		${.CURDIR}/../linux-dotnet-runtime/pkg-descr
EXTRACT_AFTER_ARGS=        --no-same-owner --no-same-permissions \
		--include LICENSE.txt --include additionalDeps --include sdk --include store
NO_WRKSUBDIR=	yes

USES=		linux:c7

do-build:
	${SETENV} \
		dp_LN=${LN} \
		dp_LZMA=${LOCALBASE}/bin/lzma \
		dp_MKDIR="${MKDIR}" \
		dp_MV=${MV} \
		dp_RM="${RM}" \
		dp_RMDIR=${RMDIR} \
		dp_SCRIPTSDIR=${SCRIPTSDIR} \
		dp_TR=${TR} \
		dp_UNZIP=${UNZIP_NATIVE_CMD} \
		${SH} ${FILESDIR}/extract.sh \
			${WRKSRC}/sdk/${DISTVERSION}/nuGetPackagesArchive.lzma \
			${WRKSRC}/sdk/NuGetFallbackFolder
	${RM} ${WRKSRC}/sdk/${DISTVERSION}/nuGetPackagesArchive.lzma
	${TOUCH} ${WRKSRC}/sdk/NuGetFallbackFolder/${DISTVERSION}.dotnetSentinel

do-install:
	cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/dotnet
	${RM} ${STAGEDIR}${PREFIX}/dotnet/LICENSE.txt

.include <bsd.port.mk>
