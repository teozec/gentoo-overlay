# Copyright 2026 Matteo Zeccoli Marazzini

# This ebuild is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This ebuild is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this ebuild. If not, see <https://www.gnu.org/licenses/>.

EAPI=8

inherit desktop qmake-utils xdg

MY_PN="DoomRunner"

DESCRIPTION="Preset-oriented graphical launcher of ZDoom and derivatives"
HOMEPAGE="https://github.com/Youda008/DoomRunner"
SRC_URI="https://github.com/Youda008/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,network,widgets]
	virtual/minizip
"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake6 ${MY_PN}.pro CONFIG+=release
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	domenu "Install/XDG/${MY_PN}.desktop"

	local size
	for size in 16 24 32 48 64 128; do
		newicon -s ${size} "Install/XDG/${MY_PN}.${size}x${size}.png" ${PN}.png
	done

	einstalldocs
	dodoc changelog.txt
}
