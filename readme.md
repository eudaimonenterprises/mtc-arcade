![arcade](https://i.imgur.com/Pw0TNkD.png)

# Arcade
This resource enhances the Arcade experience within the Qbox Framework environment.
QBCore compatability has been removed.

## 💾 Dependencies
- [ox_lib](https://github.com/overextended/ox_lib/releases)

## 🔌 Installation
To get started with the MTC Polaroid resource, follow these steps:

1. Clone this repository and place the files into your designated resources folder.

# ox_inventory/data/items.lua addition
```
['gametoken'] = {
    label = 'Game Token',
    weight = 100,
    stack = true,
    close = false,
    description = 'Game token.',
    client = {
        image = 'gametoken.png'
    }
}
```

# server.cfg addition
```
ensure mtc-arcade
```

## 🏠 MLO's
The Arcade is compatible with a wide range of MLO's for your FiveM experience. One such MLO option is the Arcade MLO developed by Gabz. However, we recommend using the Arcade Bar MLO created by [Kiiya](https://www.gta5-mods.com/maps/arcade-bar-interior-mlo-fivem-sp). The location for that map in the game is: `vector3(-1286.24, -302.04, 36.03)`

## 📦 Items
You can find the images for the items mentioned below in the ```images``` directory.
To change the item you  can edit ```server/sv_main.lua``` and change the item.

## 🪙 Credits
A special thanks to the following people:
- [Xogy](https://github.com/Xogy/rcore_arcade) - for the original base of the code.

## 👉 Join our community

[![Discord](https://discord.com/api/guilds/1075048579758035014/widget.png?style=banner2)](https://discord.gg/cFuv5BMWzK)
