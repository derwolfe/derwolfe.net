---
layout: post.html
title: I love the fish shell
date: 2014-10-15
---
I have been using the fish shell for the past six months and have been loving every minute of it.
I wanted to tell you about it because it is vastly simpler to use than I ever felt both bash and zsh ever were.
But, be advised, while I'm comparing these shells I only have had a *working* knowledge of how to be productive using bash and zsh.

Why do I use my shell?
----------------------
I use my shell mostly for day to day programming work.
Lots of boring directory changes, grepping output, piping commands together, etc.
I also write a fair amount of python and need to switch between virtualenvs frequently.


What do I want?
---------------
Autocomplete should work excellently.
The shell should feel quick and responsive.
The default configuration language for my shell should be simple and obvious.
Global variables should be used sparingly if at all.
Reading code written for the shell should not make me want to cry.

Why do I like fish?
-------------------
fish has some excellent defaults that feel natural from the start.
fish uses a sane and simple configuration language in which paths can be set easily.
For example, here is my fish.config file in which I've setup pyenv, homebrew and the default paths.

.. code:: sh

	  set default_path /usr/bin /usr/sbin /bin /sbin
	  set homebrew /usr/local/bin /usr/local/sbin
	  set brew_pyenv /usr/local/var/pyenv/shims
	  set -gx PATH $homebrew $brew_pyenv $default_path

With fish, the convention is only to save functions that will *always* be evaluated on shell startup in the main config.fish file.
All functions are defined individually and saved inside of ~/.config/fish/functions.
fish comes with an in-shell editor that makes it easy to both create and update functions.
``funced`` is the in-shell editor and I have found it to be indespenible.
To edit any function attached to the fish shell, you just type

.. code:: bash

	  funced function_name

This will open up a simple editor allowing you to edit the function in place.
New functions can be defined using ``funced`` as well.
To save a function permanently; that is longer than the life of your current shell, funcsave needs to be used:

.. code:: bash

	  funcsave function_name

This updates the persisted copy of the function or creates a new function inside of ~/.config/fish/functions

Here is a picture of ``funced`` in action.

.. image:: /assets/images/funced.png

In addition to the wonderful handling of user defined functions, the prompts included with fish are excellent.
By default, fish displays only the first letter of each parent directory's name in relation to the present working directory, e.g.:

.. image:: /assets/images/prompt.png

The prompt can be edited several ways.
The easiest way to edit the prompt is to open up the web-based configuration utility.
I'm normally not a fan of using web configurations, bit fish's is simple and straigtforward.
To access the configuration utility, type

.. code:: bash

	  fish_config

This takes you to a page where the prompt can be chosen easily. I just use their **classic + git** choice.

The other way is to edit the prompt directly.
This can be done by editing the fish_prompt.fish file directely.
It is conveniently saved in ~/.config/fish/functions.

Wrapping up
===========
I love using fish because it doesn't surpise me.
It has excellent user documentation, makes itpleasent to define new functions, and is extremely easy to reconfigure.
If you haven't done so yet, I'd highly recommend giving fish a try; installation directions can be found at the `fish site`_.

.. _fish site: http://fishshell.com
