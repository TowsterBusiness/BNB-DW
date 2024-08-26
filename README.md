# Welcome

This is the start of a larger project but I thought I would chunk this out since at this point, this would be a really good rythm game starter

All the functions are there for you to make a rythm heaven style rythm game

Theres also an endstate that you can costomize from the score you get in the game.

# Building (Building)[https://github.com/ShadowMario/FNF-PsychEngine/edit/main/BUILDING.md]

### Dependencies

- `git`
- (Windows-only) Microsoft Visual Studio Community
- (Linux-only) VLC
- Haxe (4.2.5 or greater)

### Windows & Mac

For `git`, you're likely gonna want [git-scm](https://git-scm.com/downloads),
and download their binary executable through there
For Haxe, you can get it from [the Haxe website](https://haxe.org/download/)

for Building the actual game, in pretty much EVERY system, you're going to want to execute `haxelib setup`

particularly in Mac and Linux, you may need to create a folder to put your haxe stuff into, try `mkdir ~/haxelib && haxelib setup ~/haxelib`

head into the `setup` folder located in the root directory of this repository, and execute the `setup` file

`lime test <platform>`

where `<platform>` gets replaced with `windows`, `linux`, or `mac`
