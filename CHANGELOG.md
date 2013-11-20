## HEAD:

* Update to fog 1.18
* Update to excon 0.28
* Added additional dependencies ucf ucf_ext

## v0.7.6 (10/30/13):

* Updated to bind to excon 0.25.3
* Updated to latest fog 1.15
* Added feature for issue 169 to remove values which are set to nil
* Added feature for issue 191 to read in input stack for clone command
* Fixed issue 176 where multiple deploys did not exit if first deploy failed
* Fixed find_xml_file error when a blank exception is thrown from cloudformation.
* Add 'envs' command as a shortcut for 'environments'

## v0.7.5 (07/02/13):

* Fixed bug with forced deployment in 0.7.4

## v0.7.4:

* Updated the update command so it can now take a new template

## v0.7.3 (05/17/2013):

* Merged the simple_deploy and stackster gems
* Replaced the tinder gem with the esbit gem for campfire communications
* Refactored the combined source code to make it easier to maintain

## v0.7.2 (03/20/2013):

* Fix issue when trying to use ssh command (fixes #172)
* Upgrade to stackster 0.4.4 to address issue with getting instances
* Modified backoff to help prevent exceeding API limits

## v0.7.1:

* Updated template download logic in clone to fix issu #160

## v0.7.0:

* Added --as-command-args argument to outputs command
* Added support to read stack parameters from other stack outputs
* Better handling of errors for deploy/execute commands (#149, #150, #155)

## v0.6.7:

* Upgraded to stackster 0.4.2

## v0.6.6:

* Downreving tinder to play nice w/ berkshelf

## v0.6.5:

* Fixed instances command handling of nil IP addresses
* Upgraded to stackster 0.4.1
* Remove 'ssh' command
* Update output format for 'attributes', 'instances', 'parameters' commands
* Update help output
* Minor internal cli refactor
* Removed unused env argument passed into Stackster::Stack
* Added log_level to clone cli class
* Catching stackster exceptions in CLI
* Refactored shared specs

## v0.6.4:

* Check for artifact encryption via attribute name_encrypted (where name is name of archive)
* Appendes .gpg to URL for encrypted archives

## v0.6.3:

* Instances return different message when no instances vs non existent stack
* Updating rvm to ruby 1.9.3-p327
* Updated to stackster version 0.4.0

## v0.6.2

* Corrected the deploy command so it exits if a stack update fails
* Fixed help so it shows all commands
* Refactored the outputs command to show less whitespace

## v0.6.1

* Corrected the clone command so it accepts new attributes
* Added ability to pass config data into Config class which avoids having to have a .simple_deploy.yml file.
* Config file reads SIMPLE_DEPLOY_CONFIG_FILE for alternate config file location.

## v0.6.0

* Updated so it no longer caches simpledb attributes so it works better with stackster changes
* Upgraded to stackster 0.3.2
* Added execute subcommand to run arbitray commands against stack
* Refactored deployment to use ssh library
* Added specs

## v0.5.6

* Corrected the instances command so it returns all instances
* Updated the clone command so it can take a new template for the new stack
* Added region to the message notifications
* Fixed deployments so they don't try to deploy if the attributes fail to update

## v0.5.5

* Added backoff functionality to updates so they work better with the force option
* Now publishes a message when the deployment starts

## v0.5.4

* Added support for internal networking to the deploy and instances commands
* Added backoff functionality to deployments so they work better with the force option

## v0.5.3

* Added a clone command that clones a stack
* Updated the protect command so it allows multiple stacks
* Updated the instances command so it tells the user when the stack does not exist
* Updated the outputs command to make the output values easier to read

## v0.5.2

* Upgrade to stackster 0.3.0
* Corrected handling of attributes on stack creation

## v0.5.1:

* Corrected the use of the domain attribute in URLs during deployments
* Corrected the use of the force option during deployments
* Added help text on SSH usage to the deploy command
* Corrected the acceptable options for the protect command

## v0.5.0:

* Updated the update command so it accepts a force option
* Refactored deployments to read bucket_prefix and domain from attributes instead of the yaml file
* Added a protect command that allows users to toggle whether stacks should be protected from destroy calls
* Refactored the deployment locking logic
* Corrected the destroy command so it no longer creates a deployment
* Gracefully exit if the .simple_deploy.yml file is missing or corrupt
* Corrected the update command so it now checks the deployment lock at the beginning of the process

## v0.4.8:

* Added as_command_args option to attributes cli

## v0.4.7:

* Added specs
* Updated deployment to set primary host properly in classic
* Updated ssh to return classic commands properly

## v0.4.6:

* Added spec tests
* Passing logger object into Capistrano deploy
* Updated logger to accept puts from Capistrano
* Refactored deployment
* Added support for both classic & vpc deployments
* Removed unused stack_reader & stack_lister classes

## v0.4.5:

* Corrected SSL verification options

## v0.4.4:

* Set verify SSL to false for real

## v0.4.3:

* Gracefully exit if no notification settings
* Send info level notification starting message
* Set verify SSL to false

## v0.4.2:

* Upgrade to stackster v0.2.9
* Added -v to main cli options

## v0.4.1:

* Added notifier class and campfire notifications
* Added primary host env to deployment command
* Upgraded to stackster v0.2.8

## v0.4.0:

* Added support for passing updates with deploy command
* Added support for deploying updates to multiple stacks
* Updated log outputs
* Abstracted CLI into individual classes

## v0.3.7:

* Updated stackster

## v0.3.6:

* Added -l to set log level
* Change -l to -c to limit results
* Updated output of ssh command

## v0.3.5:

* Added ssh command

## v0.3.4:

* List stacks in order based on name

## v0.3.3:

* Exist if -e is not a valid environment
* Updated to version 0.2.4 of stackster

## v0.3.2:

* Improved debuging
* Added version
* Updated to version 0.2.3 of stackster

## v0.3.1:

* Fixed bug in creating new stacks

## v0.3.0:

* Updating to new ~/.simpledeploy.yml format.

    artifacts: 
      chef_repo:
        bucket_prefix: prefix_to_bucket
        domain: name_of_object
      app:
        bucket_prefix: prefix_to_bucket
        domain: name_of_object
      cookbooks:
        bucket_prefix: prefix_to_bucket

    environments:
      preprod_shared_us-west-1:
        access_key: XXX
        secret_key: YYY
        region: us-west-1
      infrastructure_us-west-1:
        access_key: XXX
        secret_key: YYY
        region: us-west-1
      infrastructure_us-east-1:
        access_key: XXX
        secret_key: YYY
        region: us-east-1

* Adding locking to deployment.
* Added limit to number of events coming out with -l flag.
