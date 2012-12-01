tabIndent.coffee
============

Introduction 
-----
**tabIndent.coffee** is a Coffeescript fork of [julianlam/tabIndent.js](https://github.com/julianlam/tabIndent.js) that depends on [jQuery](https://github.com/jquery/jquery). It provides the same functionality as tabIndent.js but with a few important differences.

1. It removes the usage of **Shift + Tab** to un-indent.
2. It supports the usage of **Command + {** and **Command + }** to un-indent and indent respectively.
3. It auto inserts the correct indentation level on creation of new-lines.

Usage
---------

To use **tabIndent.coffee** you will need to have jQuery already loaded in your code. You bind tabIndent to an element(s) like so:

	$( ".tabIndent" ).tabIndent()

### Unattach

To completely unattach the tabIndent code from a specific textarea, you can call the `destroy` method like so:

 	$( ".tabIndent" ).tabIndent( "destroy" )

or you can access the TabIndent object and call the `destroy` method directly

	$( ".tabIndent" ).data( 'tabIndent' ).destroy()
	

### Auto Bind

If you would like to use **tabIndent** on all elements (and future elements) that match a specific selector, you can use the `autobind` method. By default, `autobind` will bind **tabIndent** to all elements that have the `.tabIndent` class, but you can pass your own selector if you wish to. For example:


	$.tabIndent.autobind() # binds to all existing and future elements with the class name "tabIndent"
	$.tabIndent.autobind( "textarea" ) # binds to all existing and future elements of the textarea node type

You can unautobind by using the `.unautobind` method with the same arguments.

Be aware though, that if you are using the `autobind` method, then the `destroy` method as described above will not work as expected (as tabIndent will be re-bound on `focus`).

Bugs
----
This code is not yet used in production and may contain bugs. If you encounter any, please report them via the Issues page.

Thanks
------
This codebase is pretty much a direct Javascript -> Coffeescript port of [julianlam/tabIndent.js](https://github.com/julianlam/tabIndent.js) so my thanks to Julian Lam for writing the original project.

License
-------
(The MIT License)

Copyright (c) 2009-2012 Simon Fletcher <simon@wakecodeslep.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.