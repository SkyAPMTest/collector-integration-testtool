The script is started with a container project for the main project and test project based on the github account of the fork and is used for project testing. The boot parameter provides the global configuration of yaml through the docker project.

To do this, execute the build.sh file, enter the fork user name according to the prompt, and then start executing and starting the project.

The output result is expected to start the docker container for the main project and test project, and start the corresponding database service container according to the environment variable.


----

## To start using Kubernetes

To start developing  Collector-integration-testtool

If you want to use collector-integration-testtool right away there are the options:

Set up the database environment variable, which is es-transport, es-rest, h2.

##### You have a working [Docker environment].

```
$ export TEST_DATABASE=es-transport
$ ./build -u your account  
```



# Contact Us
* Submit an issue
* [Gitter](https://gitter.im/openskywalking/Lobby)
* QQ Group: 392443393

# License
[Apache 2.0 License.](/LICENSE)