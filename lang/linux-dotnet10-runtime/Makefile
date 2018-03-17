# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

PORTNAME=	dotnet10-runtime
DISTNAME=	dotnet-centos-x64.${DISTVERSION}
DISTVERSION=	1.0.10
MASTER_SITES=	https://download.microsoft.com/download/2/E/1/2E1D70C2-F74D-4024-B14D-3F30330450A8/

MASTERDIR=	${.CURDIR}/../linux-dotnet-runtime
SLAVEDIR=	${.CURDIR}

BINFILES=	dotnet shared/Microsoft.NETCore.App/${DISTVERSION}/corehost shared/Microsoft.NETCore.App/${DISTVERSION}/dotnet

.include "${MASTERDIR}/Makefile"
