#!/usr/bin/python3
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

from subprocess import Popen, PIPE

import os
import sys
import pickle


def run(cmd, strip=False, split=False):
    sub = Popen(cmd, stdout=PIPE, stderr=PIPE)
    out, err = sub.communicate()
    out = out.decode('utf-8')
    err = err.decode('utf-8')
    if sub.poll() or 'fatal' in err:
        return None
    if strip:
        out = out.strip()
    if split:
        out = out.splitlines()
    return out


def init_colors():
    path = os.path.expanduser('~/.cache/gitbash.pickle')
    if os.path.isfile(path):
        with open(path, 'rb') as f:
            return pickle.load(f)
    colors = ['black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white']
    attrs = dict([[c, '\\[%s\\]' % run(['tput', 'setaf', str(i)])] for i, c in enumerate(colors)])
    attrs['bold'] = '\\[%s\\]' % run(['tput', 'bold'])
    attrs['reset'] = '\\[%s\\]' % run(['tput', 'sgr0'])
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'wb') as f:
        pickle.dump(attrs, f)
    return attrs


symbols = {'git': '\\W',
           'nongit': '\\u@\\h \\W',
           'detached': ':',
           'begin': '[',
           'end': ']',
           'prefix': '(',
           'suffix': ')',
           'separator': '|',
           'prompt': '\\$ ',
           'ahead': '↑',
           'behind': '↓',
           'staged': '•',
           'conflict': '×',
           'changed': '+',
           'untracked': '…',
           'clean': '*'}


symbols.update(init_colors())


def prompt(fmt, text=None, cond=None):
    if cond is None:
        cond = text
        if cond is None:
            cond = True
    if text is None:
        text = ''
    if cond:
        print(fmt.format(**symbols) + str(text) + symbols['reset'], end='')


config = run(['git', 'config', '--local', '-l'], split=True)
if not config:
    prompt('{begin}{nongit}{end}{prompt}')
    sys.exit(0)
config = dict([f.split('=', 1) for f in config])

remote_diff = []
head = ''

branch = (run(['git', 'symbolic-ref', 'HEAD'], strip=True) or '')[11:]
if not branch:
    head = run(['git', 'rev-parse', '--short', 'HEAD'], strip=True)
else:
    remote = config.get('branch.%s.remote' % branch)
    merge = config.get('branch.%s.merge' % branch)
    if remote and remote != '.':
        remote_diff = run(['git', 'rev-list', '--left-right', 'refs/remotes/%s/%s...HEAD' % (remote, merge[11:])], split=True)
        if remote_diff is None:
            remote_diff = run(['git', 'rev-list', '--left-right', '%s...HEAD' % merge], split=True)


changed_list = run(['git', 'diff', '--name-status'], split=True)
staged_list = run(['git', 'diff', '--staged','--name-status'], split=True)
untracked_list = run(['git', 'ls-files', '--others', '--exclude-standard'], split=True)

behind = sum(1 for f in remote_diff if f[0] != '>')
ahead = len(remote_diff) - behind
changed = sum(1 for f in changed_list if f[0] != 'U')
staged = sum(1 for f in staged_list if f[0] != 'U')
conflicts = len(staged_list) - staged
untracked = len(untracked_list)
clean = not changed and not staged and not conflicts and not untracked


prompt('{begin}{cyan}{git}{reset}{end}')
prompt('{prefix}')
prompt('{bold}{magenta}{detached}', head)
prompt('{bold}{magenta}', branch)
prompt('{bold}{yellow}{behind}', behind)
prompt('{bold}{yellow}{ahead}', ahead)
prompt('{separator}')
prompt('{red}{staged}', staged)
prompt('{red}{conflict}', conflicts)
prompt('{blue}{changed}', changed)
prompt('{untracked}', cond=untracked)
prompt('{bold}{green}{clean}', cond=clean)
prompt('{reset}{suffix}{prompt}')
