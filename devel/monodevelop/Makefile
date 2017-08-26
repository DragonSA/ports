# Created by: Tom McLaughlin <tmclaugh@sdf.lonestar.org>
# $FreeBSD: head/devel/monodevelop/Makefile 465694 2018-03-27 11:55:18Z antoine $

PORTNAME=	monodevelop
PORTVERSION=	7.1.0.1297
DISTVERSIONPREFIX=	${PORTNAME}-
CATEGORIES=	devel

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
# main/src/core/MonoDevelop.Core/packages.config
NUGET_DEPENDS=	ExtCore=0.8.46 \
		FSharp.Compiler.CodeDom=0.9.2 \
		FSharp.Compiler.Service=11.0.10 \
		FSharp.Core=4.1.0.2 \
		Fantomas=2.6.1 \
		Microsoft.AspNet.Mvc=5.2.3 \
		Microsoft.AspNet.Razor=3.2.3 \
		Microsoft.AspNet.WebPages=3.2.3 \
		Microsoft.DotNet.Common.ProjectTemplates.1.x=${TEMPLATE1_VERSION} \
		Microsoft.DotNet.Common.ProjectTemplates.2.0=${TEMPLATE2_VERSION} \
		Microsoft.DotNet.Test.ProjectTemplates.1.x=${TEMPLATE1_VERSION} \
		Microsoft.DotNet.Test.ProjectTemplates.2.0=${TEMPLATE2_VERSION} \
		Microsoft.DotNet.Web.ProjectTemplates.1.x=${TEMPLATE1_VERSION} \
		Microsoft.DotNet.Web.ProjectTemplates.2.0=${TEMPLATE2_VERSION} \
		NUnit=2.6.4 \
		NUnit.Engine=3.0.1 \
		NUnit.Runners=2.6.4 \
		Newtonsoft.Json=9.0.1

GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--enable-release --disable-update-mimedb --disable-update-desktopdb \
		--enable-maintainer-mode --enable-gnomeplatform --enable-git
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

USES=		autoreconf desktop-file-utils gettext gmake mono:nuget pathfix pkgconfig shared-mime-info ssl
USE_GNOME=	gtksharp20 gnomesharp20
INSTALLS_ICONS=	yes

INSTALL_TARGET=	install-strip
MAKE_ENV=	DOTNET_MSBUILD_SDK_RESOLVER_SDKS_DIR=
MAKE_JOBS_UNSAFE=	Build parallelization not implemented
WRKSRC_SUBDIR=		main
PORTSCOUT=	limit:^\d+\.\d+\.[1-9]\d*

TEMPLATE1_VERSION=	1.0.0-beta2-20170629-269
TEMPLATE2_VERSION=	1.0.0-beta2-20170727-301

post-extract:
	${LN} -Fs ${NUGET_PACKAGEDIR} ${WRKSRC}/external/fsharpbinding/packages

post-patch:
	${REINPLACE_CMD} 's/0.1.157-dev/0.1.248/g' \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/MonoDevelop.Packaging/DotNetProjectExtensions.cs \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/PostBuild.proj \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/Templates/CrossPlatformLibrary.xpt.xml \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/Templates/PackagingProject.xpt.xml \
		${WRKSRC}/src/addins/MonoDevelop.Packaging/packages.config
	${LN} -Fs ${WRKSRC}/packages/System.Collections.Immutable.1.3.1 \
		${WRKSRC}/packages/System.Collections.Immutable.1.1.37
	${ECHO} "Release ID: ${PORTVERSION}" > ${WRKSRC}/buildinfo

.include <bsd.port.mk>
