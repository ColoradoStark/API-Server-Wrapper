# API Server Wrapper

BASH SCRIPT FOR GAME SERVER 

This Bourne Again SHell (BASH) script is for the initial setup of a server.
It will configure a server with all of the components needed to create a web
application that will host a CRUD API for player stats and world data.  

The intended use case of this server is:

1. To add MMO elements to a game that is played mostly locally
2. To store data that will be updated once every 10 minutes
3. To host an HTTP based CRUD API 

It will configure a 64 bit Ubuntu 16.04 server with:

nginx

PHP 7.2

MySQL 5.7

Composer

Slim Framework


The script is made to work both on the setup of a Free Tier Amazon EC2 instance or 
on local development enviroment using Vagrant.   A lot of the vagrant setup scripts
I found had settings very different from the standard live servers on Amazon.  And
I  ended up looking up all sorts of console commands to get everything working.  

Later I forgot what I did and the two environments were very different.  I wrote this
script with the intention of creating an environment on the local machine identical to the
production environment on AWS.  With all of the necessary tools to build a game data hosting
web API

Tested on AWS using AMI - Ubuntu Server 16.04 LTS (HVM), SSD Volume Type
Tested using VirtualBox and Vagrant.

-------------------------------------------------------------------------------------------

AMAZON AWS INSTRUCTIONS:

1. Follow the first 5 steps to Launch a Linux instance on this page: 
   https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/launching-instance.html#launch-instance-console
   For the Instance Type Select:  Ubuntu Server 16.04 LTS (HVM), SSD Volume Type
   
2.  When you reach step 6 toward the bottom of the page there will be an advanced Details menu
    Click that and then under User Data click the "As File" checkbox.  Click the choose file button
    then upload the file provisioner.sh.
    
3.  Finish launching the instance.
   

---------------------------------------------------------------------------------------------

VAGRANT INSTRUCTIONS:

First install Vagrant and VirtualBox

1. Copy this repository
2. Open command prompt and change to the directory of the repository (use CD command) 
3. Type: vagrant up 


