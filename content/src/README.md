# Assorted sources

### `srcs -> content/src`

A series of scripts located [here](https://github.com/rgolubtsov/rgolubtsov.github.io/tree/master/content/src "Assorted sources on GitHub"), written in various programming languages, is meant at demonstrating techniques to directly port the code from one programming language to another. This is very beneficial when learning new programming languages based on those already learned and used previously or using currently.

For the moment there are two independent algorithms were chosen and implemented as scripts:

1. To search for and return an equilibrium index of a given array of integers.
2. To make replacements in words of a given sentence and return an updated sentence.

Both algorithms are implemented in the same set of programming languages, sequentially. Or sometimes simultaneously.

Historically, the first programming language chosen to write a script implementing those two aforementioned algorithms was JavaScript, targeting the Node.js runtime environment. But actually the `find_equil_index.js` script (1) was the first and the only complete program that was resided in this repo alone for a year or so. Later on it was a decision to enrich the repo with similar snippets or pieces of code that might be considered like standalone and independent scripts, but resembling the original one (1) as with their inputs as well with their outputs.

However, prior to this there was a new script born, of course written again in JavaScript. It has implemented the second algorithm (2) &ndash; `replace_txt_chunks.js`. And right after that both directions were eloborated deeper by learning new programming languages and following the educational paradigm commonly known as **learning by doing**. :smiley:

In general, each subsequent script in both directions is based on their respective JavaScript implementation, an initial one. But this is commonly true only for imperative/OOP languages; as with functional languages, there was made the following porting chain:

```
        JavaScript ---> . . .

             . . . ---> Erlang ---+---> Elixir
                                  |
                                  +---> LFE ---> Clojure
```

Scripts written in the following programming languages are presented here:

1. JavaScript (ES5/Node.js)
2. Erlang
3. LFE ([Lisp Flavoured Erlang](http://lfe.io "Lisp Flavoured Erlang"))
4. Elixir
5. Perl 5
6. Python 3
7. Lua
8. C script ([TCC](https://bellard.org/tcc "Tiny C Compiler"))
9. Bash
10. Go
11. Clojure
12. Groovy

They are all tailored and treated exactly as scripts, that means they are interpreted or compiled on the fly and executed using their respective interpreter/compiler and runtime environment/virtual machine.

In the beginning of each script, in the header block comment there is the usage info showing how to run it: in all cases it is a compound one-liner command which downloads the script, makes it executable, and launches it up. The only prerequisite is the `curl` utility and, of course respective runtime environment. The latter is indicated just after the usage info in each script.

The `_templates` subdirectory that resides here is not related to these scripts anyhow. It contains minimal application templates written in Perl and Python which are prepared to run on [uWSGI](https://uwsgi-docs.readthedocs.io "The uWSGI project") application server, and a header block comment in both templates clearly explains this.
