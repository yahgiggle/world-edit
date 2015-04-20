# World Edit

Rising World editing tool.


## Introduction

This script is based on the original World Edit script by andyzee. The main difference with the original script are the commands.

Instead of `/we-select`, players must type `/we select` (no dash). Also, `/we-fillblock` has been replaced with `/we place` with extended arguments parameters.


## Installation

This modules has two dependencies, therefore you need to make sure both of them are properly installed before using this script!

### Using Git

Go to the `scripts` folder of your Rising World installation and type

```
git clone --recursive https://github.com/RisingWorld/world-edit.git
```

### Manually

Download the Zip file for [this](https://github.com/RisingWorld/world-edit/archive/master.zip) repository and extract it to your Rising World's `scripts/world-edit` folder.

Download the Zip file for the [i18n](https://github.com/RisingWorld/i18n/archive/master.zip) sub-module, and extract it inside the `i18n` folder of this script.

Download the Zip file for the [command parser](https://github.com/RisingWorld/command-parser/archive/master.zip) sub-module, and extract it inside the `command-parser` folder of this script.

Your final script folder should look somewhat like this

```
./risingworld/scripts/world-edit
   ./command-parser
      ./parse-args.lua
   ./i18n
      ./i18n.lua
   ./lc_messages
      ./en.locale
   ./listeners
      ./commandListener.lua
   ./definition.xml
   ./blocks.lua
   ./config.properties
   ./security.lua
   ./table-ext.lua
   ./worldedit.lua
```

(**Note**: there are more files, but only the necessary ones are shown, here.)


## Usage

In-game, enter `/we help` for more information.


## Contributors

* LordFoobar (Yanick Rochon)
* andyzee (Andy Zee)

### Translators

* NDMR (German)


## License

Copyright (c) 2015 Rising World Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.