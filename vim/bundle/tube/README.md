## Tube.vim

*Tube* provides a tiny interface for sending commands from MacVim to a
separate iTerm or Terminal window without leaving MacVim.


## Requirements

* Mac OS X 10.6+
* iTerm2 or Terminal already installed
* MacVim compiled with python 2.6+


## Installation

Extract the plugin folder to `~/.vim` or use a plugin manager such as
[Vundle](https://github.com/gmarik/vundle), [Pathogen](https://github.com/tpope/vim-pathogen)
or [Neobundle](https://github.com/Shougo/neobundle.vim).

By default *Tube* opens `Terminal.app` but if you prefer using `iTerm.app` set
the following variable in your `.vimrc` file:

```vim
let g:tube_terminal = "iterm"
```


## Visual tour

### A simple example
```
                 focus remains here
 MacVim         /                                     Terminal
---------------°---------------------                -------------------------------------
| # hello_world.py                  |                | ...                               |
|                                   |                | $ ls                              |
| print "Hello World!"              |                | hello_world.py                    |
|                                   |        ------> | $ python hello_world.py           |
|                                   |       |        | Hello World!                      |
|___________________________________|       |        |                                   |
|:Tube python %                     |-------'        |                                   |
--------------°----------------------                -------------------------------------
               \
                The % character stands for the current buffer name. If you want
                no expansion at all, just escape it with another % character (%%).
                Note the absence of quotes around the command.
```

### Selection injection
```
                 focus remains here
 MacVim         /                                     Terminal
---------------°---------------------                -------------------------------------
| # hello_world.py                  |                | ...                               |
|                                   |                | $ python                          |
| print "this is a selected line"   |        ------> | >>> print "this is a selected.. " |
|                                   |       |        | this is a selected line           |
|                                   |       |        |                                   |
|___________________________________|       |        |                                   |
|:'<,'>Tube @                       |-------'        |                                   |
-------------°-----------------------                -------------------------------------
              \
               The @ character stand for the current selection. If you just happen to be
               on a line in normal mode then the @ character stands for the current
               line (in this case you'll use the plain :Tube @). If the selection spans
               multiple lines they are passed to the terminal as they are, that is,
               whitespaces are preserved.
```

### Function injection
```
                       focus remains here
 MacVim               /                               MacVim (invisible state)
---------------------°---------------                ....................................
|                                   |                .                                  .
|                                   |                .                                  .
| // beautifully crafted code       |                . // beautifully crafted code      .
|                                   | -------------> .                                  .
|                                   |                .                                  .
|___________________________________|                ....................................
|:Tube cd #{Foo(1^^'@')} && do sth  |          _____ |:Tube cd project_root && do sth   |
--------------|---°------------------         |      ....................................
              |    \_____________________     |
 Your .vimrc  |                          |    |       Terminal
--------------|----------------------    |    |      ------------------------------------
|                                   |    |    `----> | $ cd project_root && do sth      |
| fu! Foo(arg1, arg2)               |    |           | ...                              |
|  // really heavy computation      |    |           |                                  |
|  return "project_root"            |    |           |                                  |
| endfu                             |    |           |                                  |
|                                   |    |           |                                  |
-------------------------------------    |           ------------------------------------
                                         |
                    +--------------------+--------------------------+
                    |                                               |
 In this example we used the special         As you can see only string arguments require
 character @ as one of the arguments.        quotes. Also, you do not have to bother about
 Doing so we pass the selection right        escaping yourself the string since it's done
 into the function as a normal argument      automatically for you.
 (note the quotes). This might be useful
 if you need to perform some kind of         Note the awkward ^^ arguments separator. Since
 formatting on the selection before          you are not required to escape yourself the
 passing it to the function.                 arguments (since they might come from an arbitrary
                                             selection and injected via the @ character) there
                                             is no way to determine where an arguments start or
                                             end. Commas just don't fit as separator since they
                                             are so common, so I picked up a sequence of characters
                                             scarcely used (at least by the author). You can change
                                             the separator sequence via the g:tube_funargs_separator
                                             setting.
```


### Aliasing
```
                       focus remains here
 MacVim               /                               MacVim (invisible state)
---------------------°---------------                ....................................
|                                   |                .                                  .
| // a very                         |                . // a very                        .
| // long long                      |                . // long long                     .
| // paragraph                      | -------------> . // paragraph                     .
|                                   |                .                                  .
|___________________________________|                ....................................
|:TubeAlias cmd                     |          _____ |:Tube do something                |
---------------|---------------------         |      ....................................
               |                              |
 Your .vimrc   |                              |       Terminal
---------------|---------------------         |      ------------------------------------
|                                   |         `----> | $ do something                    |
| let g:tube_aliases = {            |                | ...                               |
|  \ 'cmd': 'do something'          |                |                                   |
|  \ }                              |                |                                   |
|                                   |                |                                   |
--------°----------------------------                -------------------------------------
        |
        |
      You can define aliases in your .vimrc file.
      Selection, function and buffer injection still work with aliasing.
```

## Changelog

See [CHANGELOG.md](CHANGELOG.md).


## License

Copyright (c) 2013 Giacomo Comitti

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
