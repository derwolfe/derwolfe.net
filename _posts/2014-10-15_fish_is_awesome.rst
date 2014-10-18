---
layout: post.html
title: Fish is awesome
date: 2014-10-15
---
I have been using the Fish shell for the past six months and have been loving every minute of it.
I wanted to tell you about it because it is vastly simpler to use than I ever felt both bash and zsh ever were.
But, be advised, while I'm comparing these shells I only have had a *working* knowledge of how to be productive using bash and zsh.

Why do I use my shell?
----------------------
I use my shell mostly for day to day programming work.
Lots of boring directory changes, grepping output, piping commands together, etc.
I also write a fair amount of python and need to switch between virtualenvs frequently.


What do I want?
---------------
Autocomplete should work... well.
The shell should feel quick and responsive.
The default configuration language for my shell to be simple and obvious.
This language should *not* rely on the modification of global variables, but should rely on the evaluation of functions.
Reading code written for the shell should not make me want to cry.

Why do I like fish?
-------------------
Fish has some excellent defaults that feel natural from the start.
Fish has a sane and simple configuration language in which paths can be set extremely easily.
For example, here is my fish.config file in which I've setup pyenv, homebrew and the default paths.

.. code:: sh

	  set default_path /usr/bin /usr/sbin /bin /sbin
	  set homebrew /usr/local/bin /usr/local/sbin
	  set brew_pyenv /usr/local/var/pyenv/shims
	  set -gx PATH $homebrew $brew_pyenv $default_path

With fish, the convention is only to save functions that will *always* be evaluated on shell startup in the main config.fish file.
Another wonderful thing is that functions are saved and created inside of a specific directory.
There is no convention here, if you would like your functions to be picked up, create them inside of ~/.config/fish/functions.
Fish also has its own function editor *funced* that allows you to edit functions direcly from the shell itself.
All a user has to do to edit a function is type *funced functionname* and the function will be opened.

.. image:: /assets/images/funced.png
