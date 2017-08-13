# Created by: David Naylor <dbn@dragon.local>
# $FreeBSD$

PORTNAME=	msbuild
DISTVERSION=	15.3.407.29267
CATEGORIES=	devel
DISTVERSIONPREFIX=	v
DISTFILES=	mono_msbuild_d25dd923839404bd64cc63f420e75acf96fc75c4.zip:bootstrap
MASTER_SITES=	https://github.com/Microsoft/msbuild/releases/download/mono-hosted-msbuild-v0.03/:bootstrap

MAINTAINER=	mono@FreeBSD.org
COMMENT=	

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	bash:shells/bash

NUGET_DEPENDS=	Newtonsoft.Json=9.0.1 \
		Microsoft.Build=14.3.0 \
		Microsoft.Build.Framework=14.3.0 \
		Microsoft.Build.Utilities.Core=14.3.0 \
		Microsoft.Net.Compilers=2.0.0-rc3 \
		xunit.assert=2.1.0

USES=		mono:nuget
USE_GITHUB=	yes
GH_ACCOUNT=	mono
GH_PROJECT=	linux-packaging-msbuild
GH_TAGNAME=		431c7ec

MAKE_ENV=	NUGET_PACKAGEDIR=${NUGET_PACKAGEDIR} \
		CscToolExe=csc CscToolPath=${FILESDIR}

post-extract:
	${MKDIR} ${NUGET_PACKAGEDIR} ${WRKSRC}/Tools/dotnetcli ${WRKSRC}/Tools/net45
	#${LN} -s ${NUGET_PACKAGEDIR} ${WRKDIR}/.nuget/packages
	${LN} -s ${HOME}/.nuget ${WRKDIR}/.nuget
	${MV} ${WRKDIR}/msbuild ${NUGET_PACKAGEDIR}
	${CP} ${WRKSRC}/packages/msbuild/Microsoft.DotNet.Build.Tasks.dll \
		${WRKSRC}/packages/Newtonsoft.Json/lib/net45/Newtonsoft.Json.dll ${WRKSRC}/Tools/net45
	${CP} ${FILESDIR}/dotnet ${WRKSRC}/Tools/dotnetcli/dotnet
	${CP} ${FILESDIR}/csc.exe ${WRKSRC}/packages/msbuild/
	(cd ${HOME}/archive/work/Deloitte/dnaylor/dotnet/msbuild; ${FIND} . -name project.lock.json | xargs ${TAR} -cf - ) | \
		${TAR} -xvf - -C ${WRKSRC}
	${FIND} ${WRKSRC} -name project.lock.json | ${XARGS} sed -i '' 's|C:\\\\Users\\\\dnaylor\\\\.nuget\\\\packages|${NUGET_PACKAGEDIR}|g'

do-build:
	${RM} /tmp/run.sh
	(cd ${WRKSRC}; \
		${SETENV} ${MAKE_ENV} ./cibuild.sh --scope Compile --target Mono --host Mono --config Release)

do-install:
	(cd ${WRKSRC}; bash cibuild.sh --scope=Test --target=Mono --host=Mono --config=Release)

.include <bsd.port.mk>
