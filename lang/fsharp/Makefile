# Created by: Phillip Neumann <pneumann@gmail.com>
# $FreeBSD: head/lang/fsharp/Makefile 460430 2018-01-30 19:00:27Z dbn $

PORTNAME=	fsharp
PORTVERSION=	4.1.34
CATEGORIES=	lang
EXTRACT_ONLY=	${DISTNAME}${EXTRACT_SUFX}

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Functional and object-oriented language for the .NET platform

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/License.txt

BUILD_DEPENDS=	msbuild:devel/msbuild
TEST_DEPENDS=	libgdiplus>=0:x11-toolkits/libgdiplus

USE_GITHUB=	yes

USES=		autoreconf gmake mono:nuget pkgconfig
GNU_CONFIGURE=	yes
MAKE_JOBS_UNSAFE=	Build not parallelizable
NO_ARCH=	yes

do-test:
	${MKDIR} ${WRKDIR}/bin
	echo "#!/bin/sh" > ${WRKDIR}/bin/fsharpc
	echo 'exec ${LOCALBASE}/bin/mono ${WRKSRC}/Release/net40/bin/fsc.exe "$$@"' >> ${WRKDIR}/bin/fsharpc
	${CHMOD} 0755 ${WRKDIR}/bin/fsharpc
	(cd ${WRKSRC}/tests/fsharp/core; \
		${ENV} \
			PATH=${WRKDIR}/bin:${PATH} \
			MONO_PATH=${WRKSRC}/Release/net40/bin \
			./run-all.sh)

.include <bsd.port.mk>
