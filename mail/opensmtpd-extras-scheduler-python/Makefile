# Created by: fluffy
# $FreeBSD: head/mail/opensmtpd-extras-scheduler-python/Makefile 417368 2016-06-23 12:00:36Z fluffy $

PKGNAMESUFFIX=		-scheduler-python
PORTREVISION=		0

COMMENT=		Python scheduler support for OpenSMTPD

PLIST_FILES=		libexec/opensmtpd/scheduler-python

CONFIGURE_ARGS+=	--with-scheduler-python --with-python=${LOCALBASE} \
			--with-python-type=`basename ${PYTHON_CMD}`

USES=			python:2 pkgconfig

MASTERDIR=		${.CURDIR}/../opensmtpd-extras
SLAVE_PORT=		yes

.include "${MASTERDIR}/Makefile"
