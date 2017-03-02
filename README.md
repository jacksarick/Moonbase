# Moonbase

Moonbase is a website management and deployment system, designed for [Student Server Space](https://github.com/studentserverspace/). Moonbase is written in Ruby, and is designed for use on Ubuntu. Currently, Moonbase supports static and script-generated websites.

## Usage

Moonbase is supported on Ubuntu and Mac OSX. As Moonbase is developed with Ruby, it requires Ruby to run.

To run one-time setup, run:

```
$ ./setup
```

Setup creates a few files, as well as a prompt to set an initial password.

To start the server, run:

```
$ ./start
```

By default, Moonbase runs on `localhost:3000`.


To regenerate the password, run:

```
$ ./key-gen.sh
```

## Configuration

`config.yml` is the config file. The sample configuration file will work without any modifications, and is created by the `setup` command. By default, it should look like this:

```yaml
address: localhost
port: 3000
root: site
projects: projects
user-key: ./user/login.key
database: ./user/projects.yml
```

Line by line, here is the purpose of each setting in the configuration file:

1. `address` is the public IP address that Moonbase will attach too. *Note: IPv6 may not work. Currently unable to test due to a budget of $0*.
2. `port` is the port that Moonbase will listen to. Port 88 is standard for HTTP websites. 
3. `root` is the path that Moonbase will look in for files to serve.
4. `projects` is the path where Moonbase will store all projects that it is currently serving.
5. `user-key` is the file that Moonbase expects to find a hashed password.
6. `database` is the file that Moonbase uses to store data about projects.

## Contributing

If you would like to contribute to Moonbase, that would be awesome! Follow the Usage instructions to set up a local copy on your machine, and then start developing! After you've completed your changes, send us a pull request.

## Credits
* [@jacksarick](https://github.com/jacksarick/) - original creator
* [@malsf21](https://github.com/malsf21/) - long-term maintainer
* [@obrien66](https://github.com/obrien66) - developer
