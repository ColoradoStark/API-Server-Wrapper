# API Server Wrapper

BASH SCRIPT FOR GAME SERVER 

This Bourne Again SHell (BASH) script is for the initial setup of a server
that is meant to host a CRUD API for player stats and world data.  

The intended use case of this server is:

1. To add MMO elements to a game that is played mostly locally
2. To store data that will be updated once every 10 minutes
3. To host an HTTP based CRUD API 


It is will configure a 64 bit Ubuntu 14.04 server with:

PHP 7.2

nginx

MySQL 5.7

Composer






The script is made to work both on the setup of an AWS EC2 instance or on Vagrant.
There is also a Vagrant server setup file.  Tested using VirtualBox and Vagrant.

-------------------------------------------------------------------------------------------

VAGRANT INSTRUCTIONS:

First install Vagrant and VirtualBox

1. Copy this repository
2. Open command prompt and change to the directory of the repository (use CD command) 
3. Type: vagrant up 


