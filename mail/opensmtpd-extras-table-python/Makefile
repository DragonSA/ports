# Created by: gahr
# $FreeBSD: head/mail/opensmtpd-extras-table-python/Makefile 417124 2016-06-19 15:51:49Z fluffy $

PKGNAMESUFFIX=	-table-python
PORTREVISION=	0

COMMENT=	Python table support for OpenSMTPD

PLIST_FILES=	libexec/opensmtpd/table-python

CONFIGURE_ARGS+=	--with-table-python --with-python=${LOCALBASE} \
			--with-python-type=`basename ${PYTHON_CMD}`

USES=		python:2 pkgconfig

MASTERDIR=	${.CURDIR}/../opensmtpd-extras
SLAVE_PORT=	yes

.include "${MASTERDIR}/Makefile"
