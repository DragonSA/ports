# Created by: David Naylor <dbn@FreeBSD.org>
# $FreeBSD$

DISTNAME=	dotnet-centos-x64.${DISTVERSION}
DISTVERSION=	1.1.7
MASTER_SITES=	https://download.microsoft.com/download/1/4/1/1416E22E-A1C5-48E3-81EF-AFE86CDA9C78/

BINFILES=	dotnet shared/Microsoft.NETCore.App/${DISTVERSION}/corehost shared/Microsoft.NETCore.App/${DISTVERSION}/dotnet

MASTERDIR=	${.CURDIR}/../linux-dotnet-runtime

.include "${MASTERDIR}/Makefile"
