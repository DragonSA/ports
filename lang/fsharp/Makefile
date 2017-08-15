# Created by: Phillip Neumann <pneumann@gmail.com>
# $FreeBSD: head/lang/fsharp/Makefile 460430 2018-01-30 19:00:27Z dbn $

PORTNAME=	fsharp
PORTVERSION=	4.1.25
CATEGORIES=	lang
EXTRACT_ONLY=	${DISTNAME}${EXTRACT_SUFX}

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Functional and object-oriented language for the .NET platform

LICENSE=	APACHE20
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	msbuild:devel/msbuild
TEST_DEPENDS=	libgdiplus>=0:x11-toolkits/libgdiplus

NUGET_DEPENDS=	FSharp.Compiler.Tools=4.1.23 \
		FSharp.Core=3.0.2 \
		FSharp.Core=3.1.2.5 \
		FSharp.Core=4.0.0.1 \
		FSharp.Core=4.1.17 \
		FSharp.Data=2.2.5 \
		FsCheck=2.6.2 \
		FsLexYacc=7.0.4 \
		Microsoft.DiaSymReader=1.1.0 \
		Microsoft.DiaSymReader.PortablePdb=1.1.0 \
		NUnit=3.5.0 \
		System.Collections.Immutable=1.2.0 \
		System.Reflection.Metadata=1.4.2 \
		System.ValueTuple=4.3.1

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
