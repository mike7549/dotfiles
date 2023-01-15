#!/usr/bin/python

# This script requires i3ipc-python package (install it from a system package manager
# or pip).
# It adds icons to the workspace name for each open window.
# Set your keybindings like this: set $workspace1 workspace number 1
# Add your icons to WINDOW_ICONS.
# Based on https://github.com/maximbaz/dotfiles/blob/master/bin/i3-autoname-workspaces

import argparse
import i3ipc
import logging
import re
import signal
import sys

FA_CHROME = '\uf268' #
FA_CODE = '\uf121' #
FA_FILE_PDF_O = '\uf1c1' #
FA_FILE_TEXT_O = '\uf0f6' #
FA_FILES_O = '\uf0c5' #
FA_FIREFOX = '\uf269' #
FA_MUSIC = '\uf001' #
FA_VIDEO = '\uf144' #
FA_PICTURE_O = '\uf03e' 
FA_SPOTIFY = '\uf1bc'
FA_TERMINAL = '\uf120'
FA_GAME = '\uf11b'
FA_STEAM = '\uf1b6'
FA_VOIP = '\uf2a0'
FA_MAIL = '\uf0e0'
FA_CHAT = '\uf27a'
FA_PIC = '\uf03e'
FA_DL = '\uf019'
FA_TEXT = '\uf0f6'
FA_VOL = '\uf028'
FA_IMAGE = '\uf03e'
FA_ANDROID = '\ue70e'
FA_VS = '\ue70c'

WINDOW_ICONS = {
    'code' : FA_VS,
    'gimp-2.10' : FA_PIC,
    'oss-code' : FA_VS,
    'evince' : FA_FILE_PDF_O,
    'Navigator' : FA_FIREFOX,
    'Pavucontrol' : FA_VOL,
    'qBittorrent' : FA_DL,
    'urxvt': FA_TERMINAL,
    'gimp': FA_PIC,
    'code-oss' : FA_CODE,
    'kile': FA_TEXT,
    'libreoffice': FA_TEXT,
    'Thunderbird': FA_MAIL,
    'smplayer': FA_VIDEO,
    'baka-mplayer': FA_VIDEO,
    'jetbrains-webstorm': FA_CODE,
    'jetbrains-idea': FA_CODE,
    'Okular': FA_FILE_PDF_O,
    'jetbrains-studio': FA_ANDROID,
    'MonoDevelop' : FA_CODE,
    'mtp-ng-qt': FA_FILES_O,
    'termite': FA_TERMINAL,
    'google-chrome': FA_CHROME,
    'chromium': FA_CHROME,
    'jetbrains-clion': FA_CODE,
    'libreoffice': FA_FILE_TEXT_O,
    'feh': FA_PICTURE_O,
    'mupdf': FA_FILE_PDF_O,
    'nautilus': FA_FILES_O,
    'mpv': FA_VIDEO,
    'texstudio' : FA_TEXT,
    'explorer.exe' : FA_GAME,
    'discord' : FA_VOIP,
    'Steam' : FA_STEAM,
    'telegram-desktop' : FA_CHAT,
    'Telegram' : FA_CHAT,
    'dolphin-emu' : FA_GAME,
    'spotify': FA_SPOTIFY,
    'Google-chrome': FA_CHROME,
    'kitty': FA_TERMINAL,
    'ranger': FA_FILES_O,
    'Inkscape': FA_PIC,
}

DEFAULT_ICON = '\u003f'


def icon_for_window(window):
    name = None
    if window.app_id is not None and len(window.app_id) > 0:
        name = window.app_id.lower()
    elif window.window_class is not None and len(window.window_class) > 0:
        name =  window.window_class.lower()

    if name in WINDOW_ICONS:
        return WINDOW_ICONS[name]

    logging.info("No icon available for window with name: %s" % str(name))
    return DEFAULT_ICON

def rename_workspaces(ipc):
    for workspace in ipc.get_tree().workspaces():
        name_parts = parse_workspace_name(workspace.name)
        icon_tuple = ()
        for w in workspace:
            if w.app_id is not None or w.window_class is not None:
                icon = icon_for_window(w)
                if not ARGUMENTS.duplicates and icon in icon_tuple:
                    continue
                icon_tuple += (icon,)
        name_parts["icons"] = "  ".join(icon_tuple) + " "
        new_name = construct_workspace_name(name_parts)
        ipc.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))


def undo_window_renaming(ipc):
    for workspace in ipc.get_tree().workspaces():
        name_parts = parse_workspace_name(workspace.name)
        name_parts["icons"] = None
        new_name = construct_workspace_name(name_parts)
        ipc.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))
    ipc.main_quit()
    sys.exit(0)


def parse_workspace_name(name):
    return re.match(
        "(?P<num>[0-9]+):?(?P<shortname>\w+)? ?(?P<icons>.+)?", name
    ).groupdict()


def construct_workspace_name(parts):
    new_name = str(parts["num"])
    if parts["shortname"] or parts["icons"]:
        new_name += ":"

        if parts["shortname"]:
            new_name += parts["shortname"]

        if parts["icons"]:
            new_name += " " + parts["icons"]

    return new_name


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="This script automatically changes the workspace name in sway depending on your open applications."
    )
    parser.add_argument(
        "--duplicates",
        "-d",
        action="store_true",
        help="Set it when you want an icon for each instance of the same application per workspace.",
    )
    parser.add_argument(
        "--logfile",
        "-l",
        type=str,
        default="/tmp/sway-autoname-workspaces.log",
        help="Path for the logfile.",
    )
    args = parser.parse_args()
    global ARGUMENTS
    ARGUMENTS = args

    logging.basicConfig(
        level=logging.INFO,
        filename=ARGUMENTS.logfile,
        filemode="w",
        format="%(message)s",
    )

    ipc = i3ipc.Connection()

    for sig in [signal.SIGINT, signal.SIGTERM]:
        signal.signal(sig, lambda signal, frame: undo_window_renaming(ipc))

    def window_event_handler(ipc, e):
        if e.change in ["new", "close", "move"]:
            rename_workspaces(ipc)

    ipc.on("window", window_event_handler)

    rename_workspaces(ipc)

    ipc.main()
