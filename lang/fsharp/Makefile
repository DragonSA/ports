# Created by: Phillip Neumann <pneumann@gmail.com>
# $FreeBSD: head/lang/fsharp/Makefile 420321 2016-08-17 07:43:05Z romain $

PORTNAME=	fsharp
PORTVERSION=	4.0.1.10
CATEGORIES=	lang

MAINTAINER=	mono@FreeBSD.org
COMMENT=	Functional and object-oriented language for the .NET platform

LICENSE=	APACHE20

BUILD_DEPENDS=	mono>=3.0:lang/mono
RUN_DEPENDS=	mono>=3.0:lang/mono

NO_PACKAGE=	The build process downloads external dependencies we cannot provide through ports

USE_GITHUB=	yes

USES=		autoreconf gmake mono pkgconfig
GNU_CONFIGURE=	yes

.include <bsd.port.mk>
