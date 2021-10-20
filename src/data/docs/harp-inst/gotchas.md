# Harp Installation Gotchas

### A one approach to bypass installing Node Sass which causes `node-gyp` segfaulting

Consider a situation when during installation of **[Harp](https://harpjs.com "Harp, the static web server with built-in preprocessing")**, it collects and installs all its dependencies and, at the time of installing Node Sass, it complains to unable fulfilling this procedure because Node Sass has to be built using `node-gyp`, but the latter causes segfault just after launching it.

The aforementioned error may occur during installation of **Harp** on a machine with limited system resources running **Arch Linux 32**. The following command/log entry shows this (intermediate output omitted):

```
$ sudo LIBSASS_EXT="no" npm i harp -g --unsafe-perm
...
$
$ journalctl -f
...
Feb 11 00:17:25 <hostname> systemd-coredump[29086]: Process 29073 (node-gyp) of user 0 dumped core.
...
```

Then when trying to run **Harp**, it prints out the following error along with respective stack trace:

```
$ harp
/usr/lib/node_modules/harp/node_modules/node-sass/lib/binding.js:13
      throw new Error(errors.unsupportedEnvironment());
      ^

Error: Node Sass does not yet support your current environment: Linux 32-bit with Unsupported runtime (67)
For more information on which environments are supported please see:
https://github.com/sass/node-sass/releases/tag/v4.9.3
    at module.exports (/usr/lib/node_modules/harp/node_modules/node-sass/lib/binding.js:13:13)
    at Object.<anonymous> (/usr/lib/node_modules/harp/node_modules/node-sass/lib/index.js:14:35)
    at Module._compile (internal/modules/cjs/loader.js:734:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:745:10)
    at Module.load (internal/modules/cjs/loader.js:626:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:566:12)
    at Function.Module._load (internal/modules/cjs/loader.js:558:3)
    at Module.require (internal/modules/cjs/loader.js:663:17)
    at require (internal/modules/cjs/helpers.js:20:18)
    at Object.<anonymous> (/usr/lib/node_modules/harp/node_modules/terraform/lib/stylesheet/processors/scss.js:1:74)
```

However, if there is no need to use Node Sass at all but the **Harp** with other its facilities, this error can easily be bypassed just by simply editing the module shown in the last line of the stack trace &ndash; `scss.js`... and another one &ndash; `sass.js`:

```
$ sudo vim /usr/lib/node_modules/harp/node_modules/terraform/lib/stylesheet/processors/scss.js \
           /usr/lib/node_modules/harp/node_modules/terraform/lib/stylesheet/processors/sass.js
```

The modified modules `scss.js` and `sass.js` can be downloaded ([scss.js](/data/docs/harp-inst/scss.js), [sass.js](/data/docs/harp-inst/sass.js)) to watch on how exactly they need to be modified, but they are not exposed completely here on this page because they are very similar to each other. The only thing it needs to do is to comment out both `var`s at the top of both modules and to comment out the whole body of the `exports.compile` function:

```
//var scss = require("node-sass")
//var TerraformError = require("../../error").TerraformError

exports.compile = function(filePath, dirs, fileContents, callback){
/*  scss.render({
...
  });*/
}
```

After that **Harp** is ready to use with its full inventory, except of course Node Sass, which is supposed here not needed to deal with:

```
$ harp

  Usage: harp [options] [command]

  Commands:

    init [options] [path]  Initialize a new Harp project in current directory
    server [options] [path] Start a Harp server in current directory
    multihost [options] [path] Start a Harp server to host a directory of Harp projects
    compile [options] [projectPath] [outputPath] Compile project to static assets (HTML, JS and CSS)

  Options:

    -h, --help     output usage information
    -V, --version  output the version number

  Use 'harp <command> --help' to get more information or visit http://harpjs.com/ to learn more.
```

Happy Harping in Arch Linux 32 ! :+1:
