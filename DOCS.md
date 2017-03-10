# Developer Documentation

## Debugging

Moonbase pipes all errors to `stderr`. These are not (yet) stored in any sort of log file, so if you want to capture/record error messages, I suggest using *nix pipes. Debug messages are not special in any respect, they are mostly just `print` statements thrown in at important breakpoints. TODO: add a proper output interface, eventually.

## Writing Scripts

The `scripting` directory is language agnostic. This means you can write a script in whatever language you choose. In the original version of Moonbase, they were all Rust binaries. All that backend is doing is running the script with *nix execution. As long as the file is runnable (this means that compiled languages must be pre-compiled and scripts need shebangs), Moonbase can handle it no problem.

## Application Structure

General breakdown of how the application is structed. It's quite a bit more tangled than this, as a lot of things depend on each other and the like. I've left out `utility`, as it is used by all files.

```
start
├── http-server OR https-server
│          │
└── app <──┘
   │
   ├── backend
   │   ├── composer
   │   │   └── http-lib
   │   ├── http-lib
   │   └── USER SCRIPTS
   │
   └── frontend
       └── composer
           └── http-lib
```

The server setup can be confusing at first. `start` picks ONE server, then passes it to `app`. `app` requires a server to run, but it is really just calling one function from that server, so it doesn't really care which one it gets. So `start` calls the dependancy, but `app` is the one that actually puts it to use.

## Custom Servers
On a related note, Moonbase can theoretically run on a different server structure. `start` just calls a server with `new()` and `start()`. `app` just uses sockets. If you needed it to run over a different protocol, as long as it could handle sockets, Moonbase wouldn't notice. This is how it runs the same over HTTP and HTTPS, though I've never come across another protocol I'd want to implement. Note: this is all hypothetical. Just because you can doesn't mean you should.