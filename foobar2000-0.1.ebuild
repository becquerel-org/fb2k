# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils git

EGIT_REPO_URI="git://git.jyujin.de/creidiki/fb2k.git"

DESCRIPTION="Icon, wrapper script and desktop files for running foobar2000 on WINE."
HOMEPAGE=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-util/desktop-file-utils"
RDEPEND="app-emulation/wine"

S=${WORKDIR}/${PN}

pkg_setup() {
	built_with_use --missing true app-emulation/wine X || \
		eerror "Xcuse me, I'm gonna need WINE with X support, kthnx."
}

src_unpack() {
	git_src_unpack || die
}

src_compile() {
	true
}

src_install() {
	dobin foobar2000
	domenu *.desktop
	doicon foobar2000.png
}

pkg_postinst() {
	einfo "In order for the script to work you have to set"
	einfo "the RUN_FOOBAR2000 environment variable for each user."
	einfo "This should either be 'wine <path-to-bf2k>' or simply"
	einfo "'<path-to-fb2k>' if you have registered WINE with binfmt_misc."
}
