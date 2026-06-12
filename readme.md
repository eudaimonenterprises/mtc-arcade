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
Use [the heist Arcade MLO created by MrBrown1999] (https://github.com/eudaimonenterprises/MrBrown1999-MLO-The-Diamond-Heist-WIP).

## 📦 Items
You can find the images for the items mentioned below in the ```images``` directory.
To change the item you  can edit ```server/sv_main.lua``` and change the item.

## 🪙 Credits
A special thanks to the following people:
- [Xogy](https://github.com/Xogy/rcore_arcade) - for the original base of the code.
- [morethancodenl](https://github.com/morethancodenl/mtc-arcade)

## 👉 Join our community
