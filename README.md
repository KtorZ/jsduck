JsDuck
======

Simple JavaScript Duckumentation generator.

           ,~~.
          (  6 )-_,
     (\___ )=='-'
      \ .   ) )
       \ `-' /    hjw
    ~'`~'`~'`~'`~

JsDuck aims to be a better documentation generator for [ExtJS][].
While it tries to do everything that [ext-doc][] does, it isn't
satisfied with it and aims to make your life much easier.

Basically JsDuck thinks that the following doc-comment really sucks:

    /**
     * @class Ext.form.TextField
     * @extends Ext.form.Field
     * <p>Basic text field.  Can be used as a direct replacement for traditional
     * text inputs, or as the base class for more sophisticated input controls
     * (like {@link Ext.form.TextArea} and {@link Ext.form.ComboBox}).</p>
     * <p><b><u>Validation</u></b></p>
     * <p>The validation procedure is described in the documentation for
     * {@link #validateValue}.</p>
     * <p><b><u>Alter Validation Behavior</u></b></p>
     * <p>Validation behavior for each field can be configured:</p>
     * <div class="mdetail-params"><ul>
     * <li><code>{@link Ext.form.TextField#invalidText invalidText}</code> :
     * the default validation message to show if any validation step above does
     * not provide a message when invalid</li>
     * <li><code>{@link Ext.form.TextField#maskRe maskRe}</code> :
     * filter out keystrokes before any validation occurs</li>
     * <li><code>{@link Ext.form.TextField#stripCharsRe stripCharsRe}</code> :
     * filter characters after being typed in, but before being validated</li>
     * </ul></div>
     *
     * @constructor Creates a new TextField
     * @param {Object} config Configuration options
     *
     * @xtype textfield
     */
    Ext.form.TextField = Ext.extend(Ext.form.Field,  {

Not quite so readable is it?  The source of ExtJS is filled with
comments just like that, and when you use ext-doc, you too are forced
to write such comments.

JsDuck does not like it.  Although it can handle comments like this,
it would like that you wrote comments like that instead:

    /**
     * Basic text field.  Can be used as a direct replacement for traditional
     * text inputs, or as the base class for more sophisticated input controls
     * (like Ext.form.TextArea and Ext.form.ComboBox).
     *
     * Validation
     * ----------
     *
     * The validation procedure is described in the documentation for
     * {@link #validateValue}.
     *
     * Alter Validation Behavior
     * -------------------------
     *
     * Validation behavior for each field can be configured:
     *
     * - `{@link Ext.form.TextField#invalidText invalidText}` :
     *   the default validation message to show if any validation step above
     *   does not provide a message when invalid
     * - `{@link Ext.form.TextField#maskRe maskRe}` :
     *   filter out keystrokes before any validation occurs
     * - `{@link Ext.form.TextField#stripCharsRe stripCharsRe}` :
     *   filter characters after being typed in, but before being validated
     *
     * @xtype textfield
     */
    Ext.form.TextField = Ext.extend(Ext.form.Field,  {

As you can see, JsDuck supports formatting comments with friendly
[Markdown][] syntax.  And it can infer several things from the code
(like @class and @extends in this case), so you don't have to repeat
yourself.  Also the constructor documentation is inherited from parent
class - so you don't have to restate that it takes a config object
again.

That's basically it.  Have fun.

[ExtJS]: http://www.sencha.com/products/js/
[ext-doc]: http://ext-doc.org/
[Markdown]: http://daringfireball.net/projects/markdown/


Getting it
----------

Standard rubygems install should do:

    $ [sudo] gem install jsduck

For hacking fork it from github.

    $ git clone git://github.com/nene/jsduck.git
    $ cd jsduck
    $ rake --tasks

JsDuck depends on [json][], [RDiscount][], and [parallel][] plus [RSpec][] for tests.

[json]: http://flori.github.com/json/
[RDiscount]: https://github.com/rtomayko/rdiscount
[parallel]: https://github.com/grosser/parallel
[RSpec]: http://rspec.info/


Usage
-----

Just call it from command line with output directory and a directory
containing your JavaScript files:

    $ jsduck --verbose --output some/dir  your/project/js

The `--verbose` flag creates a lot of output, but at least you will
see that something is happening.

You pass in both directories and JavaScript files.  For example to
generate docs for ExtJS 3, the simplest way is the following:

    $ jsduck -v -o output/ ext-3.3.1/src/

But this will give you a bunch of warnings, so you should better
create a script that takes just the files really needed and passes
them through `xargs` to `jsduck`:

    $ find ext-3.3.1/src/ -name '*.js' | egrep -v 'locale/|test/|adapter/' | xargs jsduck -v -o output/

Here's how the resulting documentation will look (ExtJS 3.3.1):

* [JsDuck generated documentation](http://triin.net/temp/jsduck/)
* [Official ExtJS documentation](http://dev.sencha.com/deploy/dev/docs/) (for comparison)

Here's the same for ExtJS 4:

* [JsDuck generated documentation](http://triin.net/temp/jsduck4/)
* [Official ExtJS documentation](http://docs.sencha.com/ext-js/4-0/api) (for comparison)


Documentation
-------------

Overview of documenting your code with JsDuck:

* [Class](https://github.com/nene/jsduck/wiki/Class)
* [Constructor](https://github.com/nene/jsduck/wiki/Constructor)
* [Config options](https://github.com/nene/jsduck/wiki/Cfg)
* [Properties](https://github.com/nene/jsduck/wiki/Property)
* [Methods](https://github.com/nene/jsduck/wiki/Method)
* [Events](https://github.com/nene/jsduck/wiki/Event)

More details:

* [List of supported @tags][tags]
* [List of doc-comment errors(?) found in ExtJS source][errors]

[tags]: https://github.com/nene/jsduck/wiki/List-of-supported-@tags
[errors]: https://github.com/nene/jsduck/wiki/List-of-doc-comment-errors(%3F)-found-in-ExtJS-source


Features and differences from ext-doc
-------------------------------------

JsDuck has some strong opinions, so some things are intentionally
missing.

* Support for Markdown in comments
* More things inferred from the code
* No XML configuration file, just command line options
* Class documentation header doesn't separately list Package and Class -
  these are IMHO redundant.
* Class documentation header doesn't duplicate toolbar buttons -
  another redundancy
* Ext.Component has a component icon too, not only its descendants


Missing features and TODO
-------------------------

* Support for custom @tags. Ext-doc supports this, I personally have
  never used this feature, so I'm thinking it's not really needed.


Copying
-------

JsDuck is distributed under the terms of the GNU General Public License version 3.

JsDuck was developed by [Rene Saarsoo](http://triin.net),
with contributions from [Ondřej Jirman](https://github.com/megous)
and [Nick Poulden](https://github.com/nick).


Changelog
---------

* 2.0.pre - Prerelease of the Ext4-themed version.  Generates docs in
  exactly the same style as the official ExtJS4 docs.  Lots and lots
  of changes.  But also possibly several bugs.  Use the --pre option
  to install:

       $ gem install --pre jsduck

  To run it on ExtJS4:

      $ jsduck  --output your/docs/  ext-4.0.2a/src  --ignore-global

  This will generate a lot of warnings.  Those should be fixed in some
  upcoming release of ExtJS4.  You can disable them with `--no-warnings`.
  Additionally you will need to copy over the images:

      $ cp -r ext-4.0.2a/docs/doc-resources your/docs/doc-resources

  You can also get the class-listing to the main page by downloading
  [overviewData.json][] and passing it to JSDuck with:

      --categories overviewData.json

  This file should in the future be found inside the ExtJS4 release,
  along with the source code for guides.

* 0.6 - JsDuck is now used for creating the official ExtJS4 documentation.
  * Automatic linking of class names found in comments.  Instead of writing
    `{@link Ext.Panel}` one can simply write `Ext.Panel` and link will be
    automatically created.
  * In generated docs, method return types and parameter types are also
    automatically linked to classes if such class is included to docs.
  * Support for `{@img}` tag for including images to documentation.
    The markup created by `{@link}` and `{@img}` tags can now be customized using
    the --img and --link command line options to supply HTML templates.
  * Links to source code are no more simply links to line numbers.
    Instead the source code files will contain ID-s like `MyClass-cfg-style`.
  * New tags: `@docauthor`, `@alternateClassName`, `@mixins`.
    The latter two Ext4 class properties are both detected from code and
    can also be defined (or overriden) in doc-comments.
  * Global methods are now placed to separate "global" class.
    Creation of this can be turned off using `--ignore-global`.
  * Much improved search feature.
    Search results are now ordered so that best matches are at the top.
    No more is there a select-box to match at beginning/middle/end -
    we automatically search first by exact match, then beginning and
    finally by middle.  Additionally the search no more lists a lot of
    duplicates - only the class that defines a method is listed, ignoring
    all the classes that inherit it.
  * Support for doc-comments in [SASS](http://sass-lang.com/) .scss files:
    For now, it's possible to document SASS variables and mixins.
  * Several bug fixes.

* 0.5 - Search and export
  * Search from the actually generated docs (not through sencha.com)
  * JSON export with --json switch.
  * Listing of mixed into classes.
  * Option to control or disable parallel processing.
  * Accepting directories as input (those are scanned for .js files)
  * Many bug fixes.

* 0.4 - Ext4 support
  * Support for Ext.define() syntax from ExtJS 4.
  * Showing @xtype and @author information on generated pages.
  * Showing filename and line number in warnings.
  * Fix for event showing the same doc as method with same name.

* 0.3 - Performance improvements
  * Significant peed improvements - most importantly utilizing
    multiple CPU-s (if available) to speed things up.  On my 4-core
    box JsDuck is now even faster than ext-doc.
  * Printing of performance info in verbose mode
  * Support for comma-first coding style
  * Few other fixes to JavaScript parsing

* 0.2 - most features of ext-doc supported.
  * Links from documentation to source code
  * Syntax highlighting of code examples
  * Tree of parent classes
  * List of subclasses

* 0.1 - initial version.

[overviewData.json]: https://raw.github.com/nene/jsduck/3ee0653554da1ddc54576e7df442d08c9a6d22fd/template/overviewData.json
