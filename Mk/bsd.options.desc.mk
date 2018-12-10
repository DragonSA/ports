# $FreeBSD: head/Mk/bsd.options.desc.mk 485166 2018-11-17 17:33:28Z sunpoet $
#
# READ BEFORE EDITING:
# - Please keep descriptions sorted alphabetically by variable name.
#
# - Please respect these limits or the dialog options wrap or get cutoff
#  - OPTION_DESC?= must be 19 characters or less
#  - OPTION description text must be 43 characters or less
#
# - This file is maintained by ports@FreeBSD.org so that entries can be added
#   to it easily.  Any sweeping changes should be approved by portmgr@.

Options_Desc_MAINTAINER=	ports@FreeBSD.org

# OPTION_DESC:		 Description:
#  Length         |	|                   Length                |
#
A52_DESC?=		AC-3 support via liba52
AAC_DESC?=		AAC/MP4 format support
AACPLUS_DESC?=		AAC support via libaacplus
AALIB_DESC?=		AAlib graphics library support
ACOUSTID_DESC?=		AcoustID audio fingerprinting support
ALAC_DESC?=		Apple Lossless audio format support
ALSA_DESC?=		ALSA audio architecture support
AMR_DESC?=		AMR 3GPP speech codec support (opencore)
AMR_NB_DESC?=		AMR Narrow Band audio support (opencore)
AMR_WB_DESC?=		AMR Wide Band audio support (opencore)
AO_DESC?=		libao audio library support
APACHE_DESC?=		Apache server support
APE_DESC?=		Monkey's Audio lossless format support
ARCHIVE_DESC?=		bzip2/zip/iso9660 archive support
ARMADILLO_DESC?=	TPS transform computation via Armadillo
ASIO_DESC?=		Asynchronous I/O support
ASM_DESC?=		Use optimized assembly code
ASPELL_DESC?=		Spell checking support via GNU Aspell
ASSERT_DESC?=		Enable debug assertions
ATLAS_DESC?=		ATLAS blas implementation
AUDIOFILE_DESC?=	SGI audio file format support
AVAHI_DESC?=		Zeroconf support via Avahi
BASH_DESC?=		Install programmable completions for Bash
BDB_DESC?=		Berkeley DB support
BDB1_DESC?=		Berkeley DB 1.85 support
BITTORRENT_DESC?=	BitTorrent file sharing support
BOOST_DESC?=		Boost C++ libraries support
BROTLI_DESC?=		Brotli compression support
BZIP2_DESC?=		bzip2 compression support
CACA_DESC?=		libcaca graphics library support
CAIRO_DESC?=		Cairo graphics library support
CARES_DESC?=		Asynchronous DNS resolution via c-ares
CDDA_DESC?=		Digital Audio CD support
CDDA2WAV_DESC?=		CD ripping support (via cdda2wav)
CDDB_DESC?=		CDDB (compact disc database) support
CDIO_DESC?=		CDIO support via libcdio
CDPARANOIA_DESC?=	CD ripping support (via cdparanoia)
CELT_DESC?=		CELT audio codec support
CFITSIO_DESC?=		FITS support via CFITSIO
COLORD_DESC?=		Color management via colord
COMPOSITE_DESC?=	X11 Composite extension support
COOKIE_DESC?=		Web cookie support
CUE_DESC?=		Embedded CUE sheets support
CUPS_DESC?=		CUPS printing system support
CURL_DESC?=		Data transfer support via cURL
CXX_DESC?=		C++ language support
CYASSL_DESC?=		SSL/TLS support via CyaSSL
DAGRAB_DESC?=		CD ripping support (via dagrab)
DATA_DESC?=		Install data files
DBM_DESC?=		dbm database library support
DBUS_DESC?=		D-Bus IPC system support
DCA_DESC?=		DTS support via libdca
DCRAW_DESC?=		Raw image processing support via dcraw
DEBUG_DESC?=		Build with debugging support
DEVD_DESC?=		Install devd(8) files
DIRAC_DESC?=		Dirac codec support via libdirac
DJVU_DESC?=		DjVu document support
DOCS_DESC?=		Build and/or install documentation
DOXYGEN_DESC?=		Build documentation with Doxygen
DTRACE_DESC?=		Build with DTrace probes
DV_DESC?=		Quasar DV video codec support (libdv)
DVDCSS_DESC?=		Encrypted DVD support via libdvdcss
ECW_DESC?=		ECW image format support
ESOUND_DESC?=		EsounD sound server support
EXAMPLES_DESC?=		Build and/or install examples
EXIV2_DESC?=		EXIF and IPTC metadata support via exiv2
EXPAT_DESC?=		XML parser support via Expat
FAAC_DESC?=		FAAC AAC encoder support
FAAD_DESC?=		FAAD AAC decoder support
FAM_DESC?=		File Alteration Monitor support
FASTCGI_DESC?=		FastCGI protocol support
FFMPEG_DESC?=		FFmpeg support (WMA, AIFF, AC3, APE...)
FFTW_DESC?=		Discrete Fourier Transform support
FINGER_DESC?=		finger(1) user information support
FIREBIRD_DESC?=		Firebird (Interbase) database support
FISH_DESC?=		Install programmable completions for Fish
FLAC_DESC?=		FLAC lossless audio codec support
FLICKR_DESC?=		Flickr support via flickcurl
FLUIDSYNTH_DESC?=	MIDI playback support via FluidSynth
FONTCONFIG_DESC?=	X11 font configuration support
FORTRAN_DESC?=		Fortran language support
FPECTL_DESC?=		Floating point exception handling
FPX_DESC?=		FlashPix image format support
FREETDS_DESC?=		FreeTDS library support
FREETYPE_DESC?=		TrueType font rendering support
FREEXL_DESC?=		Excel file (.xls) support via FreeXL
FREI0R_DESC?=		Frei0r video plugins support
FRIBIDI_DESC?=		Bidirectional text support via GNU FriBidi
FTP_DESC?=		FTP protocol support
FTPS_DESC?=		FTP with SSL/TLS support
FUSE_DESC?=		FUSE (Filesystem in Userspace) support
GCC_DESC?=		Build with modern GCC (from ports)
GCONF_DESC?=		GConf configuration backend support
GCRYPT_DESC?=		Use GNU crypt library instead of OpenSSL
GD_DESC?=		GD graphics library support
GDBM_DESC?=		GNU dbm library support
GDM_DESC?=		Install GDM login manager
GEOIP_DESC?=		GeoIP IP location support
GEOS_DESC?=		GEOS Geometry Engine support
GEOTIFF_DESC?=		GeoTIFF file format support
GGI_DESC?=		General Graphics Interface support
GHOSTSCRIPT_DESC?=	Ghostscript support
GIF_DESC?=		GIF image format support
GIO_DESC?=		Use GIO for file I/O
GLADE_DESC?=		Glade interface builder support
GLUT_DESC?=		OpenGL Utility Toolkit support
GLX_DESC?=		X11 OpenGL rendering support
GMP_DESC?=		GMP (multiple precision arithmetic) support
GNOME_DESC?=		GNOME desktop environment support
GNOMEKEYRING_DESC?=	GNOME Keyring password manager support
GNOMEVFS2_DESC?=	GnomeVFS2 (virtual file system) support
GNUPG_DESC?=		GNU Privacy Guard support
GNUPLOT_DESC?=		Plotting support via gnuplot
GNUTLS_DESC?=		SSL/TLS support via GnuTLS
GOPHER_DESC?=		Gopher protocol support
GPERFTOOLS_DESC?=	Google gperftools support
GPHOTO_DESC?=		Digital cameras support via libgphoto2
GRAPHMAGICK_DESC?=	GraphicsMagick image processing support
GRAPHVIZ_DESC?=		Graphviz graph drawing support
GRASS_DESC?=		Geographic Information System (GIS) support
GRIB_API_DESC?=		ECMWF GRIB API support
GSM_DESC?=		GSM codec support
GSSAPI_BASE_DESC?=	GSSAPI support via base system (needs Kerberos)
GSSAPI_DESC?=		GSSAPI Security API support
GSSAPI_HEIMDAL_DESC?=	GSSAPI support via security/heimdal
GSSAPI_MIT_DESC?=	GSSAPI support via security/krb5
GSSAPI_NONE_DESC?=	Disable GSSAPI support
GSTREAMER_DESC?=	Multimedia support via GStreamer
GTA_DESC?=		Generic Tagged Array (GTA) support
GTK1_DESC?=		GTK+ 1 GUI toolkit support
GTK2_DESC?=		GTK+ 2 GUI toolkit support
GTK3_DESC?=		GTK+ 3 GUI toolkit support
GUI_DESC?=		GUI (Graphical User Interface) support
GUILE_DESC?=		Guile extension language support
GVFS_DESC?=		Virtual filesystems support via GVFS
H323_DESC?=		H.323 codec support
HAL_DESC?=		HAL (Hardware Abstraction Layer) support
HDF5_DESC?=		HDF-5 data format support
HPACK_DESC?=		Header Compression for HTTP/2.0 support
HTTP2_DESC?=		HTTP protocol version 2.0 support
HTTPD_DESC?=		httpd output streaming support
HTTPS_DESC?=		HTTPS protocol support
HUNSPELL_DESC?=		Spell checking support via Hunspell
ICONS_DESC?=		Install icon theme(s)
ICONV_DESC?=		Encoding conversion support via iconv
ICU_DESC?=		Unicode support via ICU
ID3_DESC?=		ID3 tags support
ID3TAG_DESC?=		ID3 v1/v2 tags support
IDN_DESC?=		International Domain Names support
IMAGEMAGICK_DESC?=	ImageMagick image processing support
IMLIB_DESC?=		Imlib image library support
IMLIB2_DESC?=		Imlib 2 image library support
INI_DESC?=		INI file/format/parser support
IODBC_DESC?=		ODBC backend via iODBC
IPV4_DESC?=		IPv4 protocol support
IPV6_DESC?=		IPv6 protocol support
ISPELL_DESC?=		Spell checking support via Ispell
JABBER_DESC?=		Jabber communications protocol support
JACK_DESC?=		JACK audio server support
JASPER_DESC?=		JPEG 2000 support via JasPer
JAVA_DESC?=		Java platform support
JBIG_DESC?=		JBIG image format support
JHEAD_DESC?=		jhead EXIF manipulator support
JPEG_DESC?=		JPEG image format support
JPEG2000_DESC?=		JPEG 2000 support
JSON_C_DESC?=		JSON file/format parser support via json-c
JSON_DESC?=		JSON file/format/parser support
KDE4_DESC?=		KDE 4 desktop environment support
KERBEROS_DESC?=		Kerberos support
KERBEROS4_DESC?=	Kerberos 4 support
KERBEROS5_DESC?=	Kerberos 5 support
KML_DESC?=		Keyhole Markup Language (KML) support
KWALLET_DESC?=		KWallet password manager support
LADSPA_DESC?=		LADSPA audio plugins support
LAME_DESC?=		LAME MP3 audio encoder support
LANG_AF_DESC?=		Afrikaans language support
LANG_AK_DESC?=		Akan language support
LANG_AM_DESC?=		Armenian language support
LANG_AR_DESC?=		Arabic language support
LANG_AST_DESC?=		Asturian language support
LANG_BB_DESC?=		Bengali (Bangladesh) language support
LANG_BE_DESC?=		Belarusian language support
LANG_BG_DESC?=		Bulgarian language support
LANG_BN_DESC?=		Bengali language support
LANG_BR_DESC?=		Breton language support
LANG_BS_DESC?=		Bosnian language support
LANG_CA_DESC?=		Catalan language support
LANG_CN_DESC?=		Chinese language support
LANG_CS_DESC?=		Czech language support
LANG_CY_DESC?=		Welsh language support
LANG_DA_DESC?=		Danish language support
LANG_DE_DESC?=		German language support
LANG_EL_DESC?=		Greek language support
LANG_EO_DESC?=		Esperanto language support
LANG_ES_DESC?=		Spanish language support
LANG_ET_DESC?=		Estonian language support
LANG_EU_DESC?=		Basque language support
LANG_FA_DESC?=		Persian language support
LANG_FI_DESC?=		Finnish language support
LANG_FR_DESC?=		French language support
LANG_FY_DESC?=		Frisian language support
LANG_GA_DESC?=		Irish language support
LANG_GB_DESC?=		English (GB) language support
LANG_GD_DESC?=		Gaelic (Scotland) language support
LANG_GL_DESC?=		Galician language support
LANG_GU_DESC?=		Gujarati language support
LANG_HE_DESC?=		Hebrew language support
LANG_HI_DESC?=		Hindi language support
LANG_HR_DESC?=		Croatian language support
LANG_HU_DESC?=		Hungarian language support
LANG_ID_DESC?=		Indonesian language support
LANG_IS_DESC?=		Icelandic language support
LANG_IT_DESC?=		Italian language support
LANG_JA_DESC?=		Japanese language support
LANG_JP_DESC?=		Japanese (ja-JP-mac) language support
LANG_KK_DESC?=		Kazakh language support
LANG_KN_DESC?=		Kannada language support
LANG_KO_DESC?=		Korean language support
LANG_KU_DESC?=		Kurdish language support
LANG_LG_DESC?=		Luganda language support
LANG_LK_DESC?=		Tamil (Sri Lanka) language support
LANG_LT_DESC?=		Lithuanian language support
LANG_LV_DESC?=		Latvian language support
LANG_MAI_DESC?=		Maithili language support
LANG_MK_DESC?=		Macedonian language support
LANG_ML_DESC?=		Malayalam language support
LANG_MN_DESC?=		Mongolian language support
LANG_MR_DESC?=		Marathi language support
LANG_NB_DESC?=		Norwegian language support
LANG_NL_DESC?=		Dutch language support
LANG_NN_DESC?=		Norwegian Nynorsk language support
LANG_NSO_DESC?=		Northern Sotho language support
LANG_OR_DESC?=		Oriya language support
LANG_PA_DESC?=		Punjabi language support
LANG_PBR_DESC?=		Portuguese (Brazil) language support
LANG_PL_DESC?=		Polish language support
LANG_PT_DESC?=		Portuguese language support
LANG_RM_DESC?=		Romansh language support
LANG_RO_DESC?=		Romanian language support
LANG_RU_DESC?=		Russian language support
LANG_SA_DESC?=		Spanish (Argentina) language support
LANG_SC_DESC?=		Spanish (Chile) language support
LANG_SE_DESC?=		Swedish language support
LANG_SI_DESC?=		Sinhala language support
LANG_SK_DESC?=		Slovak language support
LANG_SL_DESC?=		Slovenian language support
LANG_SM_DESC?=		Spanish (Mexico) language support
LANG_SON_DESC?=		Songhai language support
LANG_SQ_DESC?=		Albanian language support
LANG_SR_DESC?=		Serbian language support
LANG_SV_DESC?=		Swedish language support
LANG_TA_DESC?=		Tamil language support
LANG_TE_DESC?=		Telugu language support
LANG_TH_DESC?=		Thai language support
LANG_TR_DESC?=		Turkish language support
LANG_TW_DESC?=		Taiwanese language support
LANG_UA_DESC?=		Ukrainian language support
LANG_UK_DESC?=		Ukrainian language support
LANG_US_DESC?=		English (US) language support
LANG_VI_DESC?=		Vietnamese language support
LANG_ZA_DESC?=		English (South Africa) language support
LANG_ZU_DESC?=		Zulu language support
LASH_DESC?=		LASH audio support
LASTFM_DESC?=		Last.fm streaming support
LATEX_DESC?=		LaTeX support
LCMS2_DESC?=		Little CMS 2.x support
LDAP_DESC?=		LDAP protocol support
LDAPS_DESC?=		LDAP protocol over SSL support
LENSFUN_DESC?=		Camera lens database support via LensFun
LFS_DESC?=		Large files support
LIBBLURAY_DESC?=	Blu-ray discs support via libbluray
LIBEDIT_DESC?=		Command line editing via libedit
LIBEV_DESC?=		High-performance events support via libev
LIBEXIF_DESC?=		EXIF metadata support via libexif
LIBEXTRACTOR_DESC?=	Metadata extraction support
LIBLO_DESC?=		Open Sound Control support via liblo
LIBMNG_DESC?=		MNG animated images support via libmng
LIBOIL_DESC?=		Inner loop optimization support via liboil
LIBPAPER_DESC?=		Paper size selection support via libpaper
LIBRSVG2_DESC?=		SVG vector graphics support via librsvg2
LIBVIRT_DESC?=		Virtualization support via libvirt
LIBVISUAL_DESC?=	Audio visualization support via libvisual
LIBWMF_DESC?=		Windows Metafile format support
LIBWRAP_DESC?=		TCP wrapper support
LIBXINE_DESC?=		Multimedia codec support via libxine
LIBXML2_DESC?=		XML parser support via libxml2
LIGHTTPD_DESC?=		Lighttpd server support
LIRC_DESC?=		Infrared remote control support
LITE_DESC?=		Reduced features or memory footprint
LIVEMEDIA_DESC?=	Multimedia streaming support via liveMedia
LQR_DESC?=		Liquid Rescale support
LSOF_DESC?=		LiSt Open Files utility support
LUA_DESC?=		Lua scripting language support
LZ4_DESC?=		LZ4 compression support
LZMA_DESC?=		LZMA compression support
LZO_DESC?=		LZO compression support
MAD_DESC?=		MAD MP3 audio decoder support
MAGICK_DESC?=		ImageMagick image processing library support
MANPAGES_DESC?=		Build and/or install manual pages
MAPSERVER_DESC?=	Mapserver support
MATE_DESC?=		MATE desktop environment support
MATROSKA_DESC?=		Matroska container format support
MBEDTLS_DESC?=		SSL/TLS support via mbed TLS
MDNSRESPONDER_DESC?=	Zeroconf support via mDNSResponder
METALINK_DESC?=		Metalink support
MIKMOD_DESC?=		MOD audio format support
MIXER_DESC?=		Audio mixer support
MJPEGTOOLS_DESC?=	MJPEG Tools support
MMKEYS_DESC?=		Multimedia keys support
MMS_DESC?=		MMS streaming support
MMX_DESC?=		Use MMX optimized routines
MODPERL_DESC?=		mod_perl protocol support
MODPLUG_DESC?=		ModPlug decoder support
MONGO_DESC?=		MongoDB support
MONO_DESC?=		Mono bindings or support
MONPLUGINS_DESC?=	Plugins from monitoring-plugins.org
MOTIF_DESC?=		Motif widget library support
MOUSE_DESC?=		Mouse support
MP3_DESC?=		MP3 audio format support
MP4_DESC?=		MP4 media format support
MPEG2_DESC?=		MPEG-2 video support via libmpeg2
MPG123_DESC?=		MP3 decoding support via mpg123
MPI_DESC?=		MPI (Message Passing Interface) support
MPICH_DESC?=		Parallel processing support via MPICH 3
MPICH2_DESC?=		Parallel processing support via MPICH 2
MPLAYER_DESC?=		MPlayer media player support
MPLS_DESC?=		MPLS support
MPP_DESC?=		Musepack audio format support
MSQL_DESC?=		mSQL database support
MSSQL_DESC?=		Microsoft SQL Server support
MTP_DESC?=		Media Transfer Protocol support
MULTIBYTE_DESC?=	Multibyte character encoding support
MUSEPACK_DESC?=		MPC audio format support
MYSQL_DESC?=		MySQL database support
MYSQL_JDBC_DESC?=	JDBC connection to MySQL databases
NAGPLUGINS_DESC?=	Plugins from nagios-plugins.org
NAS_DESC?=		Network Audio System support
NCURSES_DESC?=		Console (text) interface support
NETCDF_DESC?=		NetCDF data format support
NETLIB_DESC?=		Blas implementation from Netlib
NETPBM_DESC?=		Netpbm graphics toolkit support
NFS_DESC?=		Network File System support
NIS_DESC?=		Network Information Services/YP support
NLS_DESC?=		Native Language Support
NMAP_DESC?=		NMAP security scanning support
NNTP_DESC?=		NNTP (News) support
NOTIFY_DESC?=		Desktop notification support
NSS_DESC?=		SSL/TLS support via NSS
NTLM_DESC?=		NTLM authentication support
NUMPY_DESC?=		NumPy mathematical computing support
OBJC_DESC?=		Objective-C language support
ODBC_DESC?=		ODBC database backend
ODF_DESC?=		Open Document Format (ODF) file support
OGG_DESC?=		Ogg media format support
OPENAL_DESC?=		Audio support via OpenAL
OPENBLAS_DESC?=		OpenBLAS blas implementation
OPENCL_DESC?=		Heterogeneous computing via OpenCL
OPENCV_DESC?=		Computer Vision support via OpenCV
OPENEXR_DESC?=		HDR image format support via OpenEXR
OPENGL_DESC?=		2D/3D rendering support via OpenGL
OPENJPEG_DESC?=		Enhanced JPEG graphics support
OPENMP_DESC?=		Parallel processing support via OpenMP
OPENMPI_DESC?=		Parallel processing support via Open MPI
OPENRAW_DESC?=		RAW camera format support
OPENSSL_DESC?=		SSL/TLS support via OpenSSL
OPTIMIZED_CFLAGS_DESC?=	Use extra compiler optimizations
OPUS_DESC?=		Opus audio codec support
ORACLE_DESC?=		Oracle database support
ORACLE_JDBC_DESC?=	JDBC connection to Oracle databases
OSD_DESC?=		On-screen display support
OSS_DESC?=		Open Sound System support
PAM_DESC?=		Pluggable authentication module support
PANGO_DESC?=		Pango rendering library support
PCRE_DESC?=		Use Perl Compatible Regular Expressions
PDF_DESC?=		PDF document support
PERL_DESC?=		Perl scripting language support
PGO_DESC?=		Use Profile-Guided Optimization
PGSQL_DESC?=		PostgreSQL database support
PGSQL_JDBC_DESC?=	JDBC connection to PostgreSQL databases
PHONON_DESC?=		Multimedia support via Phonon
PHP_DESC?=		PHP bindings or support
PIXBUF_DESC?=		GDK-PixBuf library support
PLUGINS_DESC?=		Build and/or install plugins
PNG_DESC?=		PNG image format support
PNM_DESC?=		PNM image format support
PODOFO_DESC?=		PDF file support via PoDoFo
POLARSSL_DESC?=		SSL/TLS support via PolarSSL
POPPLER_DESC?=		PDF and PS file support via poppler
PORTAUDIO_DESC?=	PortAudio library support
POSTGIS_DESC?=		PostGIS geographic support for PostgreSQL
PRINT_DESC?=		Printer support
PROFILE_DESC?=		Build with profiling support
PROJ_DESC?=		PROJ.4 cartographic projections support
PROXY_DESC?=		Proxy support
PS_DESC?=		PostScript document support
PSL_DESC?=		Public Suffix List support
PTH_DESC?=		Threading/multiprocessing via GNU Pth
PULSEAUDIO_DESC?=	PulseAudio sound server support
PYMALLOC_DESC?=		Use Python's internal malloc()
PYTHON_DESC?=		Python bindings or support
PYTHON2_DESC?=		Python 2.x bindings or support
PYTHON3_DESC?=		Python 3.x bindings or support
QT4_DESC?=		Qt 4 toolkit support
QT5_DESC?=		Qt 5 toolkit support
QUICKTIME_DESC?=	QuickTime media support
RADIUS_DESC?=		RADIUS protocol support
RAW_DESC?=		RAW format support
READLINE_DESC?=		Command line editing via libreadline
REDIS_DESC?=		Redis key-value store database support
REGEX_DESC?=		Regular expression support
RESIN3_DESC?=		Resin 3.x support
RTMP_DESC?=		RTMP protocol support via librtmp
RTMPDUMP_DESC?=		RTMP protocol support via rtmpdump
RTSP_DESC?=		Real Time Streaming Protocol (RTSP) support
RUBY_DESC?=		Ruby bindings or support
SAMPLERATE_DESC?=	Sample rate conversion support
SANE_DESC?=		SANE API scanner support
SASL_DESC?=		SASL authentication support
SCHROEDINGER_DESC?=	Dirac video codec support via libschroedinger
SCIPY_DESC?=		SciPy scientific computing support
SDL_DESC?=		Simple Direct Media Layer support
SEM_DESC?=		POSIX semaphores support
SFCGAL_DESC?=		3D operations support via SFCGAL
SHOUTCAST_DESC?=	SHOUTcast and Ogg Icecast support
SIMD_DESC?=		Use CPU-specific optimizations
SLANG_DESC?=		S-Lang console graphics library support
SMB_DESC?=		SMB network protocol support
SNAPPY_DESC?=		Snappy compression library support
SNDFILE_DESC?=		Audio conversion support via libsndfile
SNDIO_DESC?=		Sndio audio support
SNMP_DESC?=		SNMP network protocol support
SOCKS_DESC?=		SOCKS proxy support
SOUND_DESC?=		Sound (audio) support
SOUNDTOUCH_DESC?=	Sound processing support via SoundTouch
SOXR_DESC?=		SoX resampler support via libsoxr
SPANDSP_DESC?=		SpanDSP faxing support
SPATIALITE_DESC?=	SpatiaLite support
SPDY_DESC?=		SPDY network protocol support
SPEEX_DESC?=		Speex audio format support
SQL_DESC?=		SQL database support
SQLITE_DESC?=		SQLite database support
SQLITE2_DESC?=		SQLite 2 database support
SQLITE3_DESC?=		SQLite 3 database support
SSE_DESC?=		Use SSE optimized routines
SSH_DESC?=		SSH protocol support
SSL_DESC?=		SSL protocol support
STATIC_DESC?=		Build static executables and/or libraries
STRIP_DESC?=		Strip binaries before installation
STROKE_DESC?=		Mouse gestures support via libstroke
SVG_DESC?=		SVG vector image format support
SVGALIB_DESC?=		SVGA graphics support
SVN_DESC?=		Subversion support
SWFDEC_DESC?=		Flash support via Swfdec
SWIG_DESC?=		SWIG binding/wrapper support
SYBASE_DESC?=		Sybase SQL Server support
SYSLOG_DESC?=		Syslog logging support
SZIP_DESC?=		Szip compression support
TCL_DESC?=		Tcl scripting language support
TCLTK_DESC?=		Tcl/Tk GUI toolkit support
TELNET_DESC?=		Telnet support
TEST_DESC?=		Build and/or run tests
TFTP_DESC?=		TFTP support
THEORA_DESC?=		Ogg Theora video codec support
THREADS_DESC?=		Threading support
TIDY_DESC?=		Tidy HTML cleaner support
TIFF_DESC?=		TIFF image format support
TINYXML_DESC?=		XML parser support via TinyXML
TK_DESC?=		Tk GUI toolkit support
TLS_DESC?=		Secure network connection support via TLS
TOMCAT6_DESC?=		Tomcat 6.x support
TOMCAT7_DESC?=		Tomcat 7.x support
TOMCAT8_DESC?=		Tomcat 8.x support
TOMCAT85_DESC?=		Tomcat 8.5.x support
TOMCAT9_DESC?=		Tomcat 9.x support
TOOLAME_DESC?=		TooLAME MP2 audio encoder support
TREMOR_DESC?=		Tremor audio decoder support
TTA_DESC?=		TTA lossless audio format support
TWOLAME_DESC?=		TwoLAME MP2 audio encoder support
UCS2_DESC?=		Unicode UCS-2 encoding support
UCS4_DESC?=		Unicode UCS-4 encoding support
UDUNITS_DESC?=		Unidata units library (udunits) support
UDUNITS2_DESC?=		Unidata units library (udunits) support
UNICODE_DESC?=		Unicode support
UNIXODBC_DESC?=		ODBC backend via unixODBC
UNRAR_DESC?=		RAR decompression support
UNZIP_DESC?=		Zip decompression support
UPNP_DESC?=		UPnP protocol support
UTF16_DESC?=		Unicode UTF-16 encoding support
UTF8_DESC?=		Unicode UTF-8 encoding support
V4L_DESC?=		Video 4 Linux support
VAAPI_DESC?=		VAAPI (GPU video acceleration) support
VAPI_DESC?=		Build VALA API files
VDPAU_DESC?=		VDPAU (GPU video acceleration) support
VIDEO_DESC?=		Video support
VO_AACENC_DESC?=	AAC audio encoding via vo-aacenc
VO_AMRWBENC_DESC?=	AMR Wide Band encoding via vo-amrwbenc
VORBIS_DESC?=		Ogg Vorbis audio codec support
VPX_DESC?=		VP8/VP9 video codec support
WAV_DESC?=		WAV audio format support
WAVPACK_DESC?=		WavPack lossless audio format support
WAYLAND_DESC?=		Wayland (graphics) support
WEBGL_DESC?=		WebGL 2D/3D graphics rendering support
WEBKIT_DESC?=		WebKit webpage renderer support
WEBP_DESC?=		WebP image format support
WEBSERVER_DESC?=	Build and/or install internal web server
WEBUI_DESC?=		Build and/or install web user interface
WMA_DESC?=		Windows Media Audio audio format support
WMF_DESC?=		Windows Metafile image format support
WOLFSSL_DESC?=		SSL/TLS support via wolfSSL
WXGTK_DESC?=		wxGTK GUI toolkit support
X11_DESC?=		X11 (graphics) support
X264_DESC?=		H.264 video codec support via x264
X265_DESC?=		H.265 video codec support via x265
XALAN_DESC?=		Xalan XSLT processor support
XCURSOR_DESC?=		Cursor themes support
XERCES_DESC?=		XML parser support via Xerces
XFT_DESC?=		Xft font library support
XINE_DESC?=		Multimedia support via Xine
XINERAMA_DESC?=		X11 Xinerama extension support
XKLAVIER_DESC?=		Keyboard layout settings
XML_DESC?=		XML format or parser support
XPM_DESC?=		XPM pixmap image format support
XRANDR_DESC?=		X11 XRandR extension support
XS_DESC?=		Use XS libraries for speed boost
XSPF_DESC?=		XSPF playlist format support
XVID_DESC?=		Xvid MPEG-4 video codec support
XVIDEO_DESC?=		X11 Video extension library support
XVMC_DESC?=		X11 XvMC video extension support
YAML_DESC?=		YAML format or parser support
ZLIB_DESC?=		zlib compression support
ZOPE_DESC?=		Zope web application framework support
ZSH_DESC?=		Install programmable completions for zsh
ZSTD_DESC?=		Zstandard compression support
