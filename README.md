# Moonbase

Moonbase is a website management and deployment system, designed for [Student Server Space](https://github.com/studentserverspace/). Moonbase is written in Ruby, and is designed for use on Ubuntu. Currently, Moonbase supports static and script-generated websites.

## Usage

Moonbase is supported on Ubuntu and Mac OSX. As Moonbase is developed with Ruby, it requires Ruby to run.

To run one-time setup, run:

```
$ ./setup
```

Setup creates a few files, as well as prompting you to set an initial password.

To start the server, run:

```
$ ./start
```

By default, Moonbase runs on `localhost:3000`. You can change this in `config.yml`.

If you would like to regenerate the password, run:

```
$ ./key-gen.sh
```

Settings can be configured in `config.yml`; more documentation on how it works is coming soon.

## Contributing

If you'd like to contribute to Moonbase, that would be awesome! Follow the Usage instructions to set up a local copy on your machine, and then start developing! After you've completed your changes, send us a pull request.

## Credits
* [@jacksarick](https://github.com/jacksarick/) - original creator
* [@malsf21](https://github.com/malsf21/) - long-term maintainer
* [@obrien66](https://github.com/obrien66) - developer
