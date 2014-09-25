from libqtile.config import Key, Screen, Group
from libqtile.command import lazy

sup = "mod4"
alt = "mod1"

keys = [

    Key(
        [alt, "shift"], "r",
        lazy.restart()
    ),

    Key(
        [alt, "shift"], "e",
        lazy.shutdown()
    ),

    Key(
        [alt], "r",
        lazy.spawncmd()
    ),

    # Applications

    Key(
        [alt], "Return",
        lazy.spawn("urxvt")
    ),

]

groups = [Group(name) for name in "1234"]

for group in groups:

    keys.append(
        Key([alt], group.name, lazy.group[group.name].toscreen())
    )

    keys.append(
        Key([alt, "shift"], group.name, lazy.window.togroup(group.name))
    )
