layout: post.html
title: Easy Twisted development with virtualenv and pyenv
date: 2014-10-19
---

This is meant as a how-to for programmers interested in developing the `Twisted networking library`.
My goal is to explain how using virtualenvs and pyenv can simplify the process of working on Twisted.
This how-to assumes you are working from a linux/unix based development environment.
At a later date, I'll see if the same setup can be used on windows.

The goal
========
Make developing twisted easy on both python2 and python3.
Also make it simple to created seperate isolated development environments.
This should make it easy to work on different modules related to twisted inside of different environments.
It should make it easier to manage dependencies.

The problem
===========
When using python to develop a project, it is too easy to accidentally muck up your system's python installation.
Virtualenv is a tool that creates isolated python environments.
When one uses pip (or pip3) to a install a new dependency, instead of directly installing the package into your system python's path, the package is installed into a directory that can be seen only by your virtualenv.

Virtualenvs in themselves still use the python that is available if your ``$PATH`` environment variable.
While it is helpful to be able to create isolated virtualenvs, it can be even more helpful to be able to create them using different python interpreters.

XXX example of how to activate and use.

Pyenv
=====
Pyenv is a tool that aids in the managememnt of python interpreters.
Instead of needing to manually manipulate your $PATH to swtich to a different interpreter, pyenv allows you to specify which python you would like to use.
For example, to find and install pypy (with pyenv installed) you only need to type the following:

.. code:: bash
	  // displays a list of python version names
	  $ pyenv install -l | grep pypy
	  // select the pypy version you'd like to install
	  $ pyenv install pypy-2.4.0

Once this command completes, pypy-2.4.0 will be installed.
You can access it by typing

.. code:: bash

	  $ pyenv shell pypy-2.4.0

On it's own, this is an improvement.
You no longer have to manually manipulate your path in order to switch versions.
But, there is another tool that merges pyenv and virtualenvs.

Pyenv-virtualenv
================
With this tool installed, you can create new virtualenvs tied to a specific interpreter.
This is helpful for Twisted development, because it can allow you to test python3 compatibility without too much work.
XXX - this should be rewritten.
I'd recommend Tox here as well, but since Twisted's testing suite for python 3 works a bit differently than on python2, tox doesn't seem to be a solution.

With pyenv-virtualenv, the syntax for creating a new virtualenv pinned to a specific interpreter is this easy:

.. code:: bash

	  $ pyenv virtualenv 2.7.8 twisted278

The command creates a new virtualenv named ``twisted278`` which uses the the ``2.7.8`` interpreter.
If you wanted to create a new virtualenv for python3, without having python 3 installed, you would do the following.

.. code:: bash

	  // find the python version you'd like to install
	  $ pyenv install -l

	  // 3.3.6 looks right
	  $ pyenv install 3.3.6

	  // make a new virtualenv
	  $ pyenv virtualenv 3.3.6 twisted336


XXX installation steps and complete example.


.. _here: https://virtualenv.pypa.io/en/latest/virtualenv.html#installation
