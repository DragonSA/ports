# Created by: David Naylor <dbn@dragon.local>
# $FreeBSD$

PORTNAME=	msbuild
DISTVERSIONPREFIX=	v
DISTVERSION=	15.3.0.0
CATEGORIES=	devel
MASTER_SITES=	https://github.com/Microsoft/msbuild/releases/download/mono-hosted-msbuild-v0.03/:bootstrap
DISTFILES=	mono_msbuild_d25dd923839404bd64cc63f420e75acf96fc75c4.zip:bootstrap

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Build platform for .NET and Visual Studio

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	bash:shells/bash \
		python:lang/python

NUGET_FEEDS=	DOTNET_BUILDTOOLS NUGET
DOTNET_BUILDTOOLS_DEPENDS=	Microsoft.xunit.netcore.extensions=1.0.0-prerelease-00629-09
DOTNET_BUILDTOOLS_URL=	https://dotnet.myget.org/F/dotnet-buildtools/api/v2/
NUGET_DEPENDS=	Newtonsoft.Json=9.0.1 \
		Microsoft.Build=14.3.0 \
		Microsoft.Build.Framework=14.3.0 \
		Microsoft.Build.Utilities.Core=14.3.0 \
		Microsoft.Net.Compilers=2.0.0-rc3 \
		xunit.abstractions=2.0.0 \
		xunit.assert=2.1.0 \
		xunit.extensibility.core=2.1.0 \
		xunit.extensibility.execution=2.1.0 \
		xunit.runner.console=2.1.0 \

USES=		mono:nuget
USE_GITHUB=	yes
GH_ACCOUNT=	mono
GH_PROJECT=	linux-packaging-msbuild
GH_TAGNAME=	431c7ec

MAKE_ENV=	NUGET_PACKAGEDIR=${NUGET_PACKAGEDIR}

post-extract:
	${MKDIR} ${WRKDIR}/.nuget ${WRKSRC}/Tools/dotnetcli ${WRKSRC}/Tools/net45
	${LN} -s ${NUGET_PACKAGEDIR} ${WRKDIR}/.nuget/packages
	${MV} ${WRKDIR}/msbuild ${NUGET_PACKAGEDIR}
	${CP} ${WRKSRC}/packages/msbuild/Microsoft.DotNet.Build.Tasks.dll \
		${WRKSRC}/packages/Newtonsoft.Json.9.0.1/lib/net45/Newtonsoft.Json.dll ${WRKSRC}/Tools/net45
	${CP} ${FILESDIR}/dotnet ${WRKSRC}/Tools/dotnetcli/dotnet
	${CP} ${FILESDIR}/csc.exe ${NUGET_PACKAGEDIR}/msbuild/

post-patch:
	${FIND} ${WRKSRC} -name AssemblyInfo.cs | ${XARGS} ${REINPLACE_CMD} -E 's/(InternalsVisibleTo\(".*Unit[Tt]ests?), PublicKey=.*")/\1")/g'

do-build:
	(cd ${WRKSRC}; \
		${SETENV} ${MAKE_ENV} ./cibuild.sh --scope Compile --target Mono --host Mono --config Release)

do-install:
	(cd ${WRKSRC}; \
		${SETENV} DESTDIR=${STAGEDIR} ./install-mono-prefix.sh ${PREFIX})

pre-test:
	${MKDIR} ${WRKSRC}/bin/Release-MONO/AnyCPU/Unix/Unix_Deployment_Test
	${CP} \
		${NUGET_PACKAGEDIR}/Microsoft.xunit.netcore.extensions/*/lib/*/Xunit.NetCore.Extensions.dll \
		${NUGET_PACKAGEDIR}/xunit.abstractions/*/lib/*net45*/xunit.abstractions.dll \
		${NUGET_PACKAGEDIR}/xunit.assert/*/lib/*net45*/xunit.assert.dll \
		${NUGET_PACKAGEDIR}/xunit.extensibility.core/*/lib/*net45*/xunit.core.dll \
		${NUGET_PACKAGEDIR}/xunit.extensibility.execution/*/lib/*net45*/xunit.execution.desktop.dll \
			${WRKSRC}/bin/Release-MONO/AnyCPU/Unix/Unix_Deployment_Test/

do-test:
	(cd ${WRKSRC}; \
		${SETENV} ${MAKE_ENV} ./cibuild.sh --scope Test --target Mono --host Mono --config Release)

.include <bsd.port.mk>
