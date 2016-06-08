# notmuch-address Vim completion

Uses [notmuch](https://notmuchmail.org/)'s `address` command to complete email addresses when composing
email with [Vim](http://www.vim.org/).

No need to maintain your own address book, just start typing an address
and notmuch will find matches from your maildir.


## Install

There are many ways to install Vim plugins.


### Pathogen

If you use [pathogen](https://github.com/tpope/vim-pathogen).

    $ mkdir -p ~/.vim/bundle
    $ cd ~/.vim/bundle
    $ git clone https://github.com/adborden/vim-notmuch-address.git


### Vundle

If you use [Vundle](https://github.com/VundleVim/Vundle.vim), add this to your `.vimrc`.

    Plugin 'adborden/vim-notmuch-address'


### Autoload

Copy `plugin/notmuch_address.vim` to your `~/.vim/autoload` directory.


## Usage

The plugin hooks into Vim's user defined completion. On any address line (`To:`,
`Cc:`, etc.), use `ctrl-x, ctrl-u` to activate the completion.


### Notmuch queries

If your phrase includes a `:`, the plugin will treat it as a notmuch query.


### Managing an address book

You can limit the search to a single tag by setting `g:notmuch_address_tag`.

    let g:notmuch_address_tag = 'addressbook'

And tag your contacts with your `addressbook` tag.

    notmuch tag +addressbook -- from:friend@example.com


## License

vim-notmuch-address
Copyright (C) 2016  Aaron D Borden

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.
