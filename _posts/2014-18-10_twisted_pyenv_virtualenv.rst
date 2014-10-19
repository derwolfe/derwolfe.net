layout: post.html
title: Easy Twisted development with virtualenv and pyenv
date: 2014-10-19
---

This is meant as a how-to for programmers interested in developing the `Twisted networking library`.
My goal is to explain how using virtualenvs and pyenv can simplify the process of working on Twisted.

Isolated environments simplify things
=====================================
XXX - this should be specific to Twisted!

Most all operating systems come with a version of python pre-installed.
However, as certain system libraries likely depend on this version of python, it can be wise to avoid depending on this version of python directly.
Also, installing packages visible to your system python can be problematic.
If you accidentally delete a package on which your system depends, it can be a bit of a pain to fix.

The solution to this is to avoid using your system python altogether.
There are several ways that this can be done.
The way that I like the most is using virtualenv and pyenv.

What are virtualenvs?
=====================
Virtualenvs are isolated python environments.
These environments make it so packages can be installed and removed without affecting your system python installation.
This simplifies your life as it makes it easy for you to see which components are actually directly needed by your application.
For example, say your system depends on needing an old library in order to run.
But, you are developing a new project that has no dependency on this older library.
A virtualenv enables you to develop your new application without having to be concerned with the older package somehow ending up in your application's namespace.
The solution is to create a virtualenv, activate it, and pip install your dependencies.


How do I get started?
=====================
If you are using python 2 the external virtualenv library needs to be installed.
On python 3, virtualenvs are baked in to the base python installation.
But, I don't think you should use virtualenv directly.
My reason for this is, while virtualenv allows to you to create isolated python environments, it does not make it easy to target different interpreters.

Pyenv is the answer.
It is excellent tool that allows you to install different python interpreters.
It allows you to target a specific interpreter with a virtualenv.
This means, you can create different virtualenvs for python 2.6, python 2.7, pypy and python3.


Pyenv
=====
The following command

.. code:: bash

	  $ pyenv virtualenv 2.7.8 twisted278

will create a new virtualenv that uses the python 2.7.8 interpreter (as long as the 2.7.8 interpreter is installed).
Pyenv also makes it extremely easy to install and remove interpreters from a given system.
Typing

.. code:: bash

	  $ pyenv versions

will display all of the different interpreters that pyenv is able to see.


.. _here: https://virtualenv.pypa.io/en/latest/virtualenv.html#installation
