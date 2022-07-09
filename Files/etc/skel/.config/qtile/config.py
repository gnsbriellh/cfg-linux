# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FRO#eadedaM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#    _      _ _                    _           
#   | |    (_) |                  (_)          
#   | |     _| |__  _ __ __ _ _ __ _  ___  ___ 
#   | |    | | '_ \| '__/ _` | '__| |/ _ \/ __|
#   | |____| | |_) | | | (_| | |  | |  __/\__ \
#   |______|_|_.__/|_|  \__,_|_|  |_|\___||___/
#                                              

from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile import bar, layout, widget, qtile, hook
from libqtile.lazy import lazy
import subprocess
import os
from colors import colors, icons

#     _____             __ _           
#    / ____|           / _(_)          
#   | |     ___  _ __ | |_ _  __ _ ___ 
#   | |    / _ \| '_ \|  _| |/ _` / __|
#   | |___| (_) | | | | | | | (_| \__ \
#    \_____\___/|_| |_|_| |_|\__, |___/
#                             __/ |    
#                            |___/     

auto_fullscreen = False                 # Prevents a Window to automaticaly set itself to fullscreen when not asked
bring_front_click = True                # Bring a Window to Front When Clicked
cursor_warp = False                     # Cursor Follows window selection, and warps to center
follow_mouse_focus = False              # Mouse Hover to Change Window Focus
focus_on_window_activation = "smart"    # _NET_ACTIVATE_WINDOW Behavior
reconfigure_screens = True              # Automatic Screen Reconfiguration
auto_minimize = True                    # Allow apps to auto-minimize themselves when losing focus
wl_input_rules = None                   # Wayland Input Devices

#    ____  _                  _           
#   |  _ \(_)                (_)          
#   | |_) |_ _ __   __ _ _ __ _  ___  ___ 
#   |  _ <| | '_ \ / _` | '__| |/ _ \/ __|
#   | |_) | | | | | (_| | |  | |  __/\__ \
#   |____/|_|_| |_|\__,_|_|  |_|\___||___/
#                                         

myTerminal = "alacritty" # Default Terminal;

#    _  __            ____  _           _ _                 
#   | |/ /           |  _ \(_)         | (_)                
#   | ' / ___ _   _  | |_) |_ _ __   __| |_ _ __   __ _ ___ 
#   |  < / _ \ | | | |  _ <| | '_ \ / _` | | '_ \ / _` / __|
#   | . \  __/ |_| | | |_) | | | | | (_| | | | | | (_| \__ \
#   |_|\_\___|\__, | |____/|_|_| |_|\__,_|_|_| |_|\__, |___/
#              __/ |                               __/ |    
#             |___/                               |___/     

mod = "mod4"

keys = [

    Key([mod], "i", lazy.layout.up(),
        desc = "Move focus up"
    ),

    Key([mod], "j", lazy.layout.left(),
        desc = "Move focus to left"
    ),

    Key([mod], "k", lazy.layout.down(),
        desc = "Move focus down"
    ),

    Key([mod], "l", lazy.layout.right(),
        desc = "Move focus to right"
    ),

    Key([mod, "shift"], "i", lazy.layout.shuffle_up(),
        desc = "Move window up"
    ),

    Key([mod, "shift"], "j", lazy.layout.swap_left(),
        desc = "Move window to the left"
    ),

    Key([mod, "shift"], "k", lazy.layout.shuffle_down(),
        desc = "Move window down"
    ),

    Key([mod, "shift"], "l", lazy.layout.swap_right(),
        desc = "Move window to the right"
    ),

    Key([mod, "control"], "i", lazy.layout.grow(),
        desc = "Grow window up"
    ),

    Key([mod, "control"], "j", lazy.layout.shrink_main(),
        desc = "Grow window to the left"
    ),

    Key([mod, "control"], "k", lazy.layout.shrink(),
        desc = "Grow window down"
    ),

    Key([mod, "control"], "l", lazy.layout.grow_main(),
        desc = "Grow window to the right"
    ),

    Key([mod], "space", lazy.layout.flip(),
        desc = "Reset all window sizes"
    ),

    Key([mod, "control"], "f", lazy.window.toggle_fullscreen(),
        desc = "Toggle between split and unsplit sides of stack"
    ),

    Key([mod], "r", lazy.layout.reset(),
        desc = "Reset all window sizes"
    ),

    Key([mod], "f", lazy.layout.maximize(),
        desc = "Toggle Fullscreen"
    ),

    Key([mod], "v", lazy.window.toggle_floating(),
        desc = "Toggle Floating Layout"
    ),

    Key([mod], "c", lazy.window.kill(),
        desc = "Kill Focused Window"
    ),

    Key([mod], "F9", lazy.reload_config(),
        desc = "Reload Qtile Config"
    ),

    Key([mod], "F10", lazy.restart(),
        desc = "Restart Qtile"
    ),

    Key([mod, "control"], "F12", lazy.shutdown(),
        desc = "Shutdown Qtile"
    ),

    Key([mod], "d", lazy.screen.next_group(),
        desc = "Swith to the Next Workspace"
    ),

    Key([mod], "a", lazy.screen.prev_group(),
        desc = "Swith to the Previous Workspace"
    ),

#                                _ _           _   _                 
#              /\               | (_)         | | (_)                
#             /  \   _ __  _ __ | |_  ___ __ _| |_ _  ___  _ __  ___ 
#            / /\ \ | '_ \| '_ \| | |/ __/ _` | __| |/ _ \| '_ \/ __|
#           / ____ \| |_) | |_) | | | (_| (_| | |_| | (_) | | | \__ \
#          /_/    \_\ .__/| .__/|_|_|\___\__,_|\__|_|\___/|_| |_|___/
#                   | |   | |                                        
#                   |_|   |_|                                        

    Key([mod], "Return", lazy.spawn(myTerminal),
        desc = "Launch terminal"
    ),

    Key([mod, "control"], "c", lazy.spawn("slock"),
        desc = "Lock Screen with slock"
    ),

    Key([mod, "control"], "Return", lazy.spawn("rofi -modi drun,run -show drun"),
        desc = "Launch Rofi"
    ),

    Key([mod], "period", lazy.spawn("rofi -modi emoji -show emoji"),
        desc = "Launch Rofi Emoji"
    ),

    Key([mod], "F1", lazy.spawn("firefox"),
        desc = "Launch Firefox"
    ),

    Key([mod], "F2", lazy.spawn("code"),
        desc = "Launch VSCode"
    ),

    Key([mod], "F3", lazy.spawn("thunar"),
        desc = "Launch File Manager"
    ),

    Key([mod], "F4", lazy.spawn("spotify"),
        desc = "Launch Spotify"
    ),

    Key([mod], "F5", lazy.spawn("steam"),
        desc = "Launch Steam"
    ),

#    Key([mod], "F6", lazy.spawn(""),
#        desc = "Launch xfreerdp"
#    ),

]

mouse = [
    Drag([mod], "Button3",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),

    Drag([mod], "Button1", 
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),

    Click([mod], "Button2",
    lazy.window.bring_to_front()
    ),
]

#    ______   _                   _     _                     _                                        _   
#   |  ____| | |                 | |   (_)                   | |                                      | |  
#   | |__    | |   ___     __ _  | |_   _   _ __     __ _    | |        __ _   _   _    ___    _   _  | |_ 
#   |  __|   | |  / _ \   / _` | | __| | | | '_ \   / _` |   | |       / _` | | | | |  / _ \  | | | | | __|
#   | |      | | | (_) | | (_| | | |_  | | | | | | | (_| |   | |____  | (_| | | |_| | | (_) | | |_| | | |_ 
#   |_|      |_|  \___/   \__,_|  \__| |_| |_| |_|  \__, |   |______|  \__,_|  \__, |  \___/   \__,_|  \__|
#                                                    __/ |                      __/ |                      
#                                                   |___/                      |___/                       

floating_layout = layout.Floating(
    float_rules = [
        *layout.Floating.default_float_rules,     # Default Rules;
        Match(wm_class = "confirmreset"),         # gitk;
        Match(wm_class = "makebranch"),           # gitk;
        Match(wm_class = "maketag"),              # gitk;
        Match(wm_class = "ssh-askpass"),          # ssh-askpass;
        Match(title = "branchdialog"),            # gitk;
        Match(title = "pinentry")                 # GPG key password entry;
    ],
    border_focus = colors["ffbr"],       # Focused Floating Window - Boder Color;
    border_normal = colors["fnbr"],      # Unfocused Floating Window - Border Color;
    border_width = 2,                    # Border Width;
    fullscreen_border_width = 0,         # Border Width When in Fullscreen;
    max_border_width = 2                 # Maximum Border Width;
)

#    _______   _   _   _                     _                                        _   
#   |__   __| (_) | | (_)                   | |                                      | |  
#      | |     _  | |  _   _ __     __ _    | |        __ _   _   _    ___    _   _  | |_ 
#      | |    | | | | | | | '_ \   / _` |   | |       / _` | | | | |  / _ \  | | | | | __|
#      | |    | | | | | | | | | | | (_| |   | |____  | (_| | | |_| | | (_) | | |_| | | |_ 
#      |_|    |_| |_| |_| |_| |_|  \__, |   |______|  \__,_|  \__, |  \___/   \__,_|  \__|
#                                   __/ |                      __/ |                      
#                                  |___/                      |___/                       

layout_theme = {
        "border_focus": colors["fbr"],      # Focused Window - Border Color;
        "border_normal": colors["nbr"],     # Unfocused Window - Border Color;
        "border_width": 2,                  # Border Width;
        "margin": 10                        # Margin (Gap);
}

## ORDER MATTER ##

layouts = [
#    layout.Max(**layout_theme)
#    layout.Stack(num_stacks=2)
#    layout.Bsp(**layout_theme)
#    layout.Matrix(**layout_theme)
#    layout.MonadWide(**layout_theme)
#    layout.RatioTile(**layout_theme)
#    layout.Tile(**layout_theme)
#    layout.TreeTab(**layout_theme)
#    layout.VerticalTile(**layout_theme)
#    layout.Zoomy(**layout_theme)
    layout.MonadTall(**layout_theme,
        #align = "MonadTall._right"
        ratio=0.6,
        max_ratio=0.75,
        min_ratio=0.25,
        min_secondary_size=85,
        change_ratio=0.03,
        change_size=20,
        new_client_position="bottom",
        single_border_width=0,
        single_margin=10
    ),

    layout.Columns(
        **layout_theme
    )
]

#   __          __        _                                  
#   \ \        / /       | |                                 
#    \ \  /\  / /__  _ __| | _____ _ __   __ _  ___ ___  ___ 
#     \ \/  \/ / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
#      \  /\  / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
#       \/  \/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
#                                 | |                        
#                                 |_|                        

groups = [
    Group(
        name="1",
        label = icons["workspace_1"],
        layout="monadtall"
    ),

    Group(
        name="2", 
        label =icons["workspace_2"],
        layout="monadtall"
    ),

    Group(
        name="3", 
        label =icons["workspace_3"],
        layout="MonadTall"
    ),

    Group(
        name="4", 
        label =icons["workspace_4"],
        layout="MonadTall"
    ),

    Group(
        name="5", 
        label =icons["workspace_5"],
        layout="MonadTall"
    ),

    Group(
        name="6",
        label =icons["workspace_6"],
        layout="MonadTall"
    ),

#    Group(
#        name="7",
#        label =icons["workspace_7"]
#    ),

#    Group(
#        name="8",
#        label =icons["workspace_8"]
#    ),

#    Group(
#        name="9",
#        label =icons["workspace_9"]
#    ),
]

for i in groups:
    keys.extend(
        [
            Key([mod], i.name,
                lazy.group[i.name].toscreen(),
                desc = "Switch to group {}".format(i.name)
            ),

            Key([mod, "shift"], i.name,
                lazy.window.togroup(i.name, switch_group = True),
                desc = "Move focused window to group {}".format(i.name)
            ),

            Key([mod, "control"], i.name,
                lazy.window.togroup(i.name),
                desc = "move focused window to group {}".format(i.name)
            ),
        ]
    )

#    __          ___     _            _       
#    \ \        / (_)   | |          | |      
#     \ \  /\  / / _  __| | __ _  ___| |_ ___ 
#      \ \/  \/ / | |/ _` |/ _` |/ _ \ __/ __|
#       \  /\  /  | | (_| | (_| |  __/ |_\__ \
#        \/  \/   |_|\__,_|\__, |\___|\__|___/
#                           __/ |             
#                          |___/              

## Configs ##

widget_defaults = dict(
    font="Hack NF",
    fontsize=12,
    padding=3
)
extension_defaults = widget_defaults.copy()

widget_separator_a = {
    "font": "Powerline Extra Symbols",
    "text": "",
    "fontsize": 30,
    "background": colors["tr"],
    "foreground": colors["bg"],
    "padding": 0
}

widget_separator_b = {
    "text": "",
    "font": "Powerline Extra Symbols",
    "fontsize": 30,
    "background": colors["bg"],
    "foreground": colors["sbg"],
    "padding": 0
}

widget_separator_c = {
    "font": "Powerline Extra Symbols",
    "text": "",
    "fontsize": 30,
    "background": colors["sbg"],
    "foreground": colors["bg"],
    "padding": 0
}

widget_separator_d = {
    "font": "Powerline Extra Symbols",
    "text": "",
    "fontsize": 30,
    "background": colors["tr"],
    "foreground": colors["bg"],
    "padding": 0
}

bar_icons = {
    "font": "Material Design Icons Desktop",
    "fontsize": 18,
    "background": colors["bg"],
    "foreground": colors["fg"],
    "padding": 1
}

## Mouse Callbacks ##

open_exitmenu = {
    "Button1": lazy.spawn("exitmenu")
}

open_btop = {
    "Button1": lazy.spawn(myTerminal + " -e btop")
}

open_htop = {
    "Button1": lazy.spawn(myTerminal + " -e htop")
}

open_pulsemixer = {
    "Button1": lazy.spawn(myTerminal + " -e pulsemixer")
}

## Screens ##

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    **widget_separator_a
                ),

                widget.GroupBox(
                    background = colors["bg"],
                    active = colors["fg"],
                    inactive = colors["fg"],
                    highlight_method ="block",
                    block_highlight_text_color = colors["fg"],
                    borderwidth = 3,
                    rounded = True,
                    center_aligned = True,
                    disable_drag = True,
                    fontsize = 24,
                    highlight_color = colors["urg"],
                    margin = 3,
                    this_current_screen_border = colors["sbg"],
                    urgent_alert_method = "line",
                    urgent_border = colors["urg"],
                    urgent_text = colors["urg"],
                    padding = 6
                ),

                widget.TextBox(
                    **widget_separator_d
                ),

                widget.WindowName(
                    foreground= colors["bg"],
                    for_current_screen=True,
                    format= " {name}",
                    max_chars=60
                ),

                widget.Systray(
                    background = colors["tr"]
                ),

                widget.TextBox(
                    **widget_separator_a
                ),

                widget.TextBox(
                    **widget_separator_b
                ),

                widget.TextBox(
                    **widget_separator_c,
                    mouse_callbacks= open_pulsemixer
                ),

                widget.TextBox(
                    **bar_icons,
                    text = icons["vol"],
                    mouse_callbacks= open_pulsemixer
                ),

                widget.PulseVolume(
                    background= colors["bg"],
                    foreground= colors["fg"],
                    limit_max_volume= True,
                    step= 1,
                    volume_app="pulsemixer",
                    mouse_callbacks= open_pulsemixer
                ),

                widget.Sep(
                    foreground= colors["bg"],
                    background= colors["bg"],
                ),

                widget.TextBox(
                    **widget_separator_b
                ),

                widget.TextBox(
                    **widget_separator_c,
                    mouse_callbacks= open_btop
                ),

                widget.TextBox(
                    **bar_icons,
                    text = icons["cpu"],
                    mouse_callbacks= open_btop
                ),

                widget.CPU(
                    background= colors["bg"],
                    foreground= colors["fg"],
                    format='{freq_current}GHz {load_percent}%',
                    update_interval=0.5,
                    mouse_callbacks= open_btop
                ),

                widget.Sep(
                    foreground= colors["bg"],
                    background= colors["bg"]
                ),

                widget.TextBox(
                    **widget_separator_b
                ),

                widget.TextBox(
                    **widget_separator_c
                ),

                widget.TextBox(
                    **bar_icons,
                    text = icons["gpu"]
                ),

                widget.ThermalSensor(
                    background= colors["bg"],
                    foreground= colors["fg"],
                    tag_sensor= "Package id 0"
                ),

                widget.Sep(
                    foreground= colors["bg"],
                    background= colors["bg"]
                ),

                widget.TextBox(
                    **widget_separator_b
                ),

                widget.TextBox(
                    **widget_separator_c,
                    mouse_callbacks= open_htop
                ),

                widget.TextBox(
                    **bar_icons,
                    text = icons["mem"],
                    mouse_callbacks= open_htop
                ),

                widget.Memory(
                    background= colors["bg"],
                    foreground= colors["fg"],
                    format='{MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}',
                    mouse_callbacks= open_htop
                ),

                widget.Sep(
                    foreground= colors["bg"],
                    background= colors["bg"]
                ),

                widget.TextBox(
                    **widget_separator_b
                ),

                widget.TextBox(
                    **widget_separator_c
                ),

                widget.TextBox(
                    **bar_icons,
                    text = icons["pom"]
                ),

                widget.Pomodoro(
                    background= colors["bg"],
                    color_active= colors["fg"],
                    color_inactive= colors["fg"],
                    color_break= colors["sbg"],
                    prefix_active="",
                    prefix_break="Take a Break ! ",
                    prefix_long_break="Take a Break ! ",
                    length_pomodori=25,
                    length_short_break=5,
                    length_long_break=15,
                    prefix_inactive="25min "
                ),

                widget.Sep(
                    foreground= colors["bg"],
                    background= colors["bg"]
                ),

                widget.TextBox(
                    **widget_separator_b
                ),

                widget.TextBox(
                    **widget_separator_c
                    #mouse_callbacks= open_calendar
                ),

                widget.TextBox(
                    **bar_icons,
                    text = icons["clo"]
                    #mouse_callbacks= open_calendar
                ),

                widget.Clock(
                    background= colors["bg"],
                    foreground= colors["fg"],
                    format="%a %d - %I:%M %p "
                    #mouse_callbacks= open_calendar
                ),

                widget.TextBox(
                    **widget_separator_b
                    #mouse_callbacks= open_calendar
                ),

                widget.TextBox(
                    **widget_separator_c,
                    mouse_callbacks= open_exitmenu
                ),

                widget.QuickExit(
                    background= colors["bg"],
                    foreground= colors["fg"],
                    default_text= icons["shu"],
                    fontsize=18,
                    countdown_start=16,
                    countdown_format='{}s',
                    padding=0,
                    mouse_callbacks= open_exitmenu
                ),

                widget.TextBox(
                    **widget_separator_d,
                    mouse_callbacks= open_exitmenu
                ),
            ],
            size=34,
            margin=[10, 10, 0, 10],
            border_width=0,
            border_color= colors["tr"],
            background= colors["tr"],
            opacity=1.0
        ),
    ),
]

#                  _                    _____ _             _   
#       /\        | |                  / ____| |           | |  
#      /  \  _   _| |_ ___    ______  | (___ | |_ __ _ _ __| |_ 
#     / /\ \| | | | __/ _ \  |______|  \___ \| __/ _` | '__| __|
#    / ____ \ |_| | || (_) |           ____) | || (_| | |  | |_ 
#   /_/    \_\__,_|\__\___/           |_____/ \__\__,_|_|   \__|
#                                                               

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
