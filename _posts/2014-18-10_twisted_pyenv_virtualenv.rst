---
layout: post.html
title: Easy Twisted development with virtualenv and pyenv
date: 2014-10-19
---
This is meant as a how-to for programmers interested in developing the `Twisted networking library`_.
My goal is to explain how using virtualenvs and pyenv can simplify the process of working on Twisted and other libraries.
This how-to assumes you are working from a linux/unix based development environment.
At a later date, I'll see if the same setup can be used on windows.

The goal
========
Create isolated development environments that target different interpreters and require different dependencies.


The problem
===========
When using python to develop a project, it is very easy to accidentally install packages that can be found by your system python.
This is a problem because it makes it difficult to isolate dependencies on a per project basis.
It is a better approach to create isolated environments in which dependencies can be installed.
`Virtualenv`_ is a tool that creates isolated python environments.
When using a virtualenv,  pip installs dependencies into a location that is only accessible by the virtualenv itself.
Virtualenvs are wonderful because you can test out different versions of libraries without worring about accidentally upgrading a dependency that would affect another project.

With python2, one needed to install the virtualenv application to be able to use it, in python3 it is baked in to the standard installation.
However, the method I'm suggesting you use doesn't require you to manually mana
ge the virtaualenv installation at all.

By default, virtualenv is setup to target a specific python interpreter, normally the one that is available in your ``$PATH`` environment variable.
While Virtualenv is excellent, it only solves the problem of being able to install dependencies in an isolated environment.
It doesn't solve the problem of a user wanting to target a different interpreter that is installed on the host system.
This is where pyenv comes in.

Pyenv
=====
`Pyenv`_ manages the installation and removal of python interpreters.
Instead of needing to manually manipulate your `$PATH` to switch to a different interpreter, pyenv allows you to specify which python you would like to use.
For example, to find and install pypy (with pyenv installed) you only need to type the following:

.. code:: bash

	  # displays a list of python version names
	  $ pyenv install -l | grep pypy

	  # select the pypy version you'd like to install
	  $ pyenv install pypy-2.4.0

Once this command completes, pypy-2.4.0 will be installed.
You can access a new pypy shell by typing

.. code:: bash

	  $ pyenv shell pypy-2.4.0

This is an improvement as you no longer have to manually manipulate your path in order to switch versions.
But, if you are not careful, you can still relatively easily install what would be system level dependencies.
(By this I mean, you can still install a package at the pypy-2.4.0 env-level).
Luckily, there is a tool that makes it easy to create virtualenvs using your pyenvs.

Pyenv-virtualenv
================
`Pyenv-virtualenv`_ makes it easy to create virtualenvs that are paired to a specific python interpreter.
With pyenv-virtualenv, the syntax for creating a new virtualenv pinned to a specific interpreter is this easy:

.. code:: bash

	  $ pyenv virtualenv 2.7.8 twisted278

The command creates a new virtualenv named ``twisted278`` which uses the the ``python 2.7.8`` interpreter.
If you wanted to create a new virtualenv for python3, without having python 3 installed, you would do the following.

.. code:: bash

	  # find the python version you'd like to install
	  $ pyenv install -l

	  # 3.3.5 looks right, install it
	  $ pyenv install 3.3.5

	  # make a new virtualenv
	  $ pyenv virtualenv 3.3.5 twisted336


Note, it isn't required to append the name of your interpreter to the virtualenv.
I use this convention to make it easy to quickly see which interpreter I'm actually targeting.

Twisted relevancy
=================
As part of the `Twisted porting process`_, all Twisted code must be verified to work on python 2.6, python 2.7, and python 3.3.
Using pyenv and virtualenv it is easy to create a set of environments from which all of the tests can be easily run.
I'm going to explain the setup process and how to run the tests for python2 and python3.

If you are using a mac and have homebrew installed, installing pyenv and pyenv-virtualenv is extremely easy, simply do

.. code:: bash

	  $ brew install pyenv pyenv-virtualenv

As of right now, you should install 2.6.9, 2.7.8 and 3.3.5.
These can be done with the following command

.. code:: bash

	  $ pyenv install 2.6.9 2.7.8 3.3.5

Once these have installed successfully, you can create the virtualenvs using the following commands.
It also does not matter in what directory these commands are executed.

.. code:: bash

	  $ pyenv virtualenv 2.6.9 twisted269
	  $ pyenv virtualenv 2.7.8 twisted278
	  $ pyenv virtualenv 3.3.5 twisted335

This will create three new virtualenvs inside of ~/.pyenv/versions

Then navigate to where ever your Twisted repository is stored, mine, for example, is stored in ~/Code/twisted.
If you are using bash or zsh, you can run the activate script for each of the environments using the following

.. code:: bash

	  # after the following command is run, then the your prompt will
	  # likely be prefixed by the name of your virtualenv
	  # this means the virtualenv is active.
	  $ source ~/.pyenv/versions/twisted269/bin/activate
	  (twisted269)$

Once this is done, you can begin installing and dependencies you might need.
If nothing else, Twisted's test suite requires zope.interface to be installed.
This will need to be installed in each of the virtualenvs in which you would like to run tests.
The way I handle this is to activate each virtualenv and install the dependencies in each.
If you know each will require a certain set of dependencies, you could create a requirements.txt file and install the dependencies using the following command:

.. code:: bash

	  $ cd ~/Code/twisted
	  $ echo "zope.interface" > requirements.txt
	  $ pip install -r requirements.txt

It isn't the most efficient but it has worked so far. Shameless plug - if you'd like to have twisted use the extra_requires syntax available from setuptools to install dependencies, you could review `ticket #3696`_!

But, if you were to install the dependencies by hand, you could do the following.

.. code:: bash

	  $ cd ~/Code/twisted
	  $ echo "zope.interface" > requirements.txt

 	  # install zope.interface into the twisted269 virtualenv
	  $ source ~/.pyenv/versions/twisted269/bin/activate
	  (twisted269)$ pip install -r requirements.txt
	  (twisted269)$ deactivate

 	  # install zope.interface into the twisted278 virtualenv
	  $ source ~/.pyenv/versions/twisted278/bin/activate
	  (twisted278)$ pip install -r requirements.txt
	  (twisted278)$ deactivate

 	  # install zope.interface into the twisted335 virtualenv
	  $ source ~/.pyenv/versions/twisted335/bin/activate
	  (twisted335)$ pip3 install -r requirements.txt
	  (twisted335)$ deactivate

Once all of these environments have been created, it is very easy to switch between them and run tests.
My typical workflow is to have several terminal windows open, each using a different virtualenv/pyenv combination.
This way, if I make a change to the source, I can run the tests for each interpreter one by one, without having to constantly activate and deactivate virtualenvs.

To run the tests for python 2, you just enter the following

.. code:: bash

	  $ source ~/.pyenv/versions/twisted269/bin/activate
	  (twisted269)$ cd ~/Code/twisted
	  (twisted269)$ ./bin/trial twisted

The same goes for python 2.7.8.

For python3, the tests are run using a small utility script saved inside of twisted/admin.

.. code:: bash

	  $ source ~/.pyenv/versions/twisted335/bin/activate
	  (twisted335)$ cd ~/Code/twisted
	  (twisted335)$ ./admin/run-python3-tests

Issues
======
If you haven't already noticed, a lot of the activation code is cumbersome and overly verbose.
I use the fish shell and have defined a function to activate virtualenvs.
I would also think that yet another library, `Virtualenv-wrapper`_ can be used to simplify activating virtualenvs.

But, if you are interested in the fish function, it only works with pyenvs that provide an activate.fish command.
Here is the code:

.. code:: bash

	  function actenv --description 'activate the virtualenv with the given name'
	     . ~/.pyenv/versions/$argv/bin/activate.fish
	  end

Finishing up
============
If you have gotten this far and followed the examples, you should have been able to create new virtualenvs that are pinned to specific interpreters.
You should also have been able to run tests for twisted using these virtualenvs.

If you notice any errors in this, please get in touch with `me here`.

.. _Virtualenv: https://virtualenv.pypa.io/en/latest/virtualenv.html
.. _Pyenv: https://github.com/yyuu/pyenv
.. _Pyenv-virtualenv: https://github.com/yyuu/pyenv-virtualenv
.. _Twisted networking library: https://www.twistedmatrix.com
.. _Twisted porting process: https://twistedmatrix.com/trac/wiki/Plan/Python3
.. _ticket #3696: https://twistedmatrix.com/trac/ticket/3696
.. _Virtualenv-wrapper: http://virtualenvwrapper.readthedocs.org/en/latest/
.. _me here: http:/derwolfe.net/contact/
