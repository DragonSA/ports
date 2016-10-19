# Created by: fluffy
# $FreeBSD: head/mail/opensmtpd-extras-queue-python/Makefile 417368 2016-06-23 12:00:36Z fluffy $

PKGNAMESUFFIX=		-queue-python
PORTREVISION=		0

COMMENT=		Python queue support for OpenSMTPD

PLIST_FILES=		libexec/opensmtpd/queue-python

CONFIGURE_ARGS+=	--with-queue-python --with-python-type=${PYTHON_VERSION}

USES=			python:2 pkgconfig

MASTERDIR=		${.CURDIR}/../opensmtpd-extras
SLAVE_PORT=		yes

.include "${MASTERDIR}/Makefile"
