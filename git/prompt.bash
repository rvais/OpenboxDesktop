#-
# Copyright (C) 2015 Mikolaj Izdebski
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

_gitbash_prompt_script=$(unset CDPATH && cd $(dirname "${BASH_SOURCE[0]}") && echo "${PWD}")/prompt.py

if [[ -x "${_gitbash_prompt_script}" ]]; then
    PROMPT_COMMAND=_gitbash_prompt
else
    echo ERROR: Unable to find prompt.py script.
fi

function _gitbash_prompt() {
    PS1=$("${_gitbash_prompt_script}")
}
