# API Server Wrapper

****************BASH SCRIPT FOR GAME API SERVER HOSTING********************

This is a Bourne Again SHell (script) is for the initial setup of a server
that is meant to host a CRUD API for player data in a Massively Multiplayer 
Online Game.

The intended use of this server is:
HTTP based API hosting
Turn based delayed data that is updated no more than once every 15 minutes.  
Up to 1 million total users
Up to 20,000 Max Concurrent users 

It will give you a quick 64 bit Ubuntu 14.04 virtual development server with:

PHP 7.2

nginx

MySQL 5.7

Composer



There is also a Vagrant server setup file.  Tested using VirtualBox and Vagrant.

-------------------------------------------------------------------------------------------

VAGRANT INSTRUCTIONS:

First install Vagrant and VirtualBox

1. Copy this repository
2. Open command prompt and change to the directory of the repository (use CD command) 
3. Type: vagrant up 


