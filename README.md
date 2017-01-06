CipherMyText
============
CipherMyText is a set of tools for enciphering messages. Previously the tools were written in Python and only worked with the [autokey cipher](https://en.wikipedia.org/wiki/Autokey_cipher), but the tools have been ported to Scheme and are designed in a more modular way to allow them to be used with a wide array of mono- and polyalphabetic pen-and-paper ciphers.

Dependencies
------------
Although the GUI application requires Chicken and libui, the suite itself is written in portable R7RS Scheme. View your implementation documentation for details about installing R7RS libraries.

Notice
------
These ciphers are generally not appropriate for real world strong cryptography. There are well known techniques for breaking most pen-and-paper ciphers, except the one-time-pad and stream ciphers. User beware: this software should be used as a toy and nothing more.

License
-------
Code is licensed under GPLv3 or later. See LICENSE for details.

