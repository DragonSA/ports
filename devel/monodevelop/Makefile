# Created by: Tom McLaughlin <tmclaugh@sdf.lonestar.org>
# $FreeBSD: head/devel/monodevelop/Makefile 465694 2018-03-27 11:55:18Z antoine $

PORTNAME=	monodevelop
PORTVERSION=	7.1.0.1297
DISTVERSIONPREFIX=	${PORTNAME}-
CATEGORIES=	devel
MASTER_SITES=	https://dl.xamarin.com/uploads/at5p4wjtk44/:xamarin
DISTFILES=	${AZURE_CLI:C/[^-]*-//}:xamarin
EXTRACT_ONLY=	${_DISTFILES:N*.nupkg:N*.zip}

MAINTAINER=	mono@FreeBSD.org
COMMENT=	IDE for the .NET platform

LICENSE=	LGPL21
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	msbuild:devel/msbuild \
		fsharpc:lang/fsharp \
		cmake:devel/cmake
LIB_DEPENDS=	libcurl.so:ftp/curl \
		libssh2.so:security/libssh2
RUN_DEPENDS=	${LOCALBASE}/lib/libgdiplus.a:x11-toolkits/libgdiplus \
		exctags:devel/ctags \
		git:devel/git \
		svn:devel/subversion \
		fsharpc:lang/fsharp

# main/external/fsharpbinding/paket.dependencies
NUGET_FEEDS=	ROSLYN APPVEYOR VSTEST TEMPLATING AZURE_APPSERVICE NUGET3 NUGET
ROSLYN_URL=	https://dotnet.myget.org/F/roslyn/api/v3/index.json
APPVEYOR_URL=	https://ci.appveyor.com/nuget/nugetizer3000
VSTEST_URL=	https://dotnet.myget.org/F/vstest/
TEMPLATING_URL=	https://dotnet.myget.org/F/templating/
AZURE_APPSERVICE_URL=https://www.myget.org/F/azure-appservice/api/v3/index.json
NUGET3_URL=	https://api.nuget.org/v3/index.json
PAKET_DEPENDS=	ExtCore=0.8.46 \
		FSharp.Compiler.CodeDom=0.9.2 \
		FSharp.Compiler.Service=11.0.10 \
		FSharp.Core=4.1.0.2 \
		Fantomas=2.6.1 \
		Mono.Cecil=0.10.0-beta5 \
		Newtonsoft.Json=9.0.1 \
		StrongNamer=0.0.3 \
		System.Collections.Immutable=1.3.1 \
		System.Reflection.Metadata=1.4.2 \
		System.ValueTuple=4.3.0
PAKET_PACKAGEDIR=	${WRKSRC}/external/fsharpbinding/packages

USES=		autoreconf desktop-file-utils gettext gmake mono:nuget pathfix pkgconfig shared-mime-info ssl
USE_GNOME=	gtksharp20 gnomesharp20
INSTALLS_ICONS=	yes

GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-release --disable-update-mimedb --disable-update-desktopdb \
		--enable-maintainer-mode --enable-gnomeplatform --enable-git
INSTALL=	/usr/bin/install
USE_GITHUB=	yes
GH_ACCOUNT=	mono
GH_TUPLE=	icsharpcode:RefactoringEssentials:e67e215:1/external/RefactoringEssentials \
		mono:debugger-libs:9960de0:3/external/debugger-libs \
		mono:guiunit:052ee0f:4/external/guiunit \
		mono:libgit-binary:d8b2aca:6/external/libgit-binary \
		mono:libgit2:e8b8948:7/external/libgit2 \
		mono:libgit2sharp:319fa36:8/external/libgit2sharp \
		mono:mono-addins:993c9c5:9/external/mono-addins \
		icsharpcode:NRefactory:e453674:10/external/nrefactory \
		mono:nuget-binary:25573a8:11/external/nuget-binary \
		mono:xwt:8d64080:12/external/xwt

INSTALL_TARGET=	install-strip
MAKE_ENV=	DOTNET_MSBUILD_SDK_RESOLVER_SDKS_DIR= \
		XDG_CACHE_HOME=${WRKDIR}
MAKE_JOBS_UNSAFE=	Build parallelization not implemented
WRKSRC_SUBDIR=		main
PORTSCOUT=	limit:^\d+\.\d+\.[1-9]\d*

# ${WKRSRC}/src/addins/MonoDevelop.AzureFunctions/MonoDevelop.AzureFunctions.csproj
AZURE_CLI=	81a64e48-azure-functions-cli-66a932fb.zip

post-extract:
	${MKDIR} ${WRKDIR}/MDBuild
	${CP} ${DISTDIR}/${AZURE_CLI:C/[^-]*-//} ${WRKDIR}/MDBuild/${AZURE_CLI:S/.zip//}
	${TOUCH} ${WRKDIR}/MDBuild/${AZURE_CLI:S/.zip//}.verified

post-patch:
	${REINPLACE_CMD} 's/0.1.157-dev/0.1.248/g' \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/MonoDevelop.Packaging/DotNetProjectExtensions.cs \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/PostBuild.proj \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/Templates/CrossPlatformLibrary.xpt.xml \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/Templates/PackagingProject.xpt.xml \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/packages.config
	${ECHO} "Release ID: ${PORTVERSION}" > ${WRKSRC}/buildinfo

.include <bsd.port.mk>
