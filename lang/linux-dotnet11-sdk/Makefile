# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dotnet10-sdk
DISTVERSION=	1.1.9
DISTNAME=	dotnet-dev-centos-x64.${DISTVERSION}
MASTER_SITES=	https://download.microsoft.com/download/4/0/2/4022CFC7-5061-4762-B9BA-48B35632572D/

RUN_DEPENDS=	linux-dotnet10-runtime>=0:lang/linux-dotnet10-runtime \
		linux-dotnet11-runtime>=0:lang/linux-dotnet11-runtime

EXTRACT_EXTRA_ARGS=

MASTERDIR=	${.CURDIR}/../linux-dotnet-sdk

.include "${MASTERDIR}/Makefile"
