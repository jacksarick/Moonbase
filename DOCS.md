# Developer Documentation

## Debugging
Moonbase pipes all errors to `stderr`. These are not (yet) stored in any sort of log file, so if you want to capture/record error messages, I suggest using *nix pipes. Debug messages are not special in any respect, they are mostly just `print` statements thrown in at important breakpoints. TODO: add a proper output interface, eventually.

## Programming
The core of Moonbase was written by [Jack Sarick](https://github.com/jacksarick). This was his first project in Ruby, coming from a primarily functional background. His code reflects this. Very often, there are multiple callback statements chained together in a series. Lists, hashes, and the functions that support them are relied on heavily. Though it is one way to program an application, it is not the only way. If you feel more comfortable writing in a more Object-Oriented fashion, that is totally OK. The only catch is that it must be compatible. As long as a function works, and doesn't bother other functions, it is good to go. This means that global variables are a big no-no. Exactly how the functions work, though, is totally up to the person writing them.

## Documentation
Document your work. I'm already long gone, so I don't care. But do it for your own health. Consider how often **YOU** wish **I** had left better documentation. Now, imagine that you're leaving the project in the hands of a psychopath who wishes you had left documentation, but he is willing hunt you down in the middle of the night with a baseball if he has questions about documentation. You don't want to get knee-capped by an angry sys-admin at six AM, trust me. (Note: if you are the psycho maintainer, please don't kill me.)

## Dependencies
Moonbase (for now) requires no gems. That means that it can be downloaded, and then run entirely offline. There are no updates from external sources, which is a blessing and a curse. As long as your ruby is up to date, Moonbase will run. It also means that everything in Moonbase is needed by Moonbase, no extra fluff from an unused package, and that if anything breaks, the exact cause of the breakage can be easily found. The downside is that it sometimes requires a lot of extra work.

## Writing Scripts
The `scripting` directory is language agnostic. This means you can write a script in whatever language you choose. In the original version of Moonbase, they were all Rust binaries. All that backend is doing is running the script with *nix execution. As long as the file is runnable (this means that compiled languages must be pre-compiled and scripts need shebangs), Moonbase can handle it no problem.

## Application Structure
General breakdown of how the application is structured. It's quite a bit more tangled than this, as a lot of things depend on each other and the like. I've left out `utility`, as it is used by all files.

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

The server setup can be confusing at first. `start` picks ONE server, then passes it to `app`. `app` requires a server to run, but it is really just calling one function from that server, so it doesn't really care which one it gets. So `start` calls the dependency, but `app` is the one that actually puts it to use.

## Custom Servers
On a related note, Moonbase can theoretically run on a different server structure. `start` just calls a server with `new()` and `start()`. `app` just uses sockets. If you needed it to run over a different protocol, as long as it could handle sockets, Moonbase wouldn't notice. This is how it runs the same over HTTP and HTTPS, though I've never come across another protocol I'd want to implement. Note: this is all hypothetical. Just because you can doesn't mean you should.