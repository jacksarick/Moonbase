# Developer Documentation


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