#!/bin/bash

# i3gutter - pads the current window with gutters on either side

# good for distraction free working or narrowing terminals for reading text
# inspired by i3zen https://www.reddit.com/r/i3wm/comments/6x8ajm/oc_i3zen/

# Written by Salim Virani
# Requires jq

# USAGE
# 1. Save this script somewhere, make it executable
# 2. Bind it to some keys from your i3 config, like so:
#    bindsym Mod4+Shift+z exec /home/salim/scr/i3gutter


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


function ghostwindow {
# This function copied from i3gw: https://www.reddit.com/r/i3wm/comments/6x5vgp/oc_i3gw/
  name=${1:?"usage: i3gw MARK, you didn't request a mark."}

  w=$(i3-msg open)
  i3-msg [con_id=${w:22:-2}] floating disable, mark $name
}

# current focused window
cfw=$(i3-msg -t get_tree | jq "..|select(.focused?==true).id")

# current workspace
cws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

#gutter windows for this window
gutters=$(i3-msg -t get_marks | grep gutter$cfw )

# gutter doesn't exist
if [[ -z $gutters ]]; then
  i3-msg [workspace=$cws] layout splith

  ghostwindow leftgutter$cfw
  i3-msg [con_mark=leftgutter$cfw] move left

  ghostwindow rightgutter$cfw
  i3-msg [con_mark=rightgutter$cfw] move right

  # resize
  i3-msg [con_mark=leftgutter$cfw] resize shrink width 90
  i3-msg [con_mark=rightgutter$cfw] resize shrink width 90

# gutters exist, so toggle them off
else
  i3-msg [con_mark=leftgutter$cfw] kill
  i3-msg [con_mark=rightgutter$cfw] kill
fi

#return focus to the starting window
i3-msg [con_id=$cfw] focus