---
layout: post.html
title: My git workflow
date: 2014-02-28
---
Git is excellent. It keeps me sane.
-----------------------------------
Over the past few years, I've noticed that not all uses of Git are alike. There seems to be a definite correct way to use Git that results in a repository being easy to understand and navigate.

Personally, I want my repositories to read like a story. I want to be able to look over a commit history and understand why each merge was made instead of just what the merge was.

Here are a few rules that I like to follow and why I find them beneficial.

1. Use feature branches all the time
------------------------------------
Branching in Git is cheap, easy, fun, and safe. It allows a software developer to create a sandbox in which all experimental changes can be safely tried.

While working in an experimental branch, one can branch into even further experimental sub-branches. Think master -> feature -> sub-feature -> implementation_test1.

By doing this, the amount of changes in each feature branch is relatively small. Each branch operates as its own contextual unit. I like to apply this idea of local context in how I name branches, e.g., **add_transfer_status** or **validate_position_entry**. Having a branch name with a specific purpose seems to help reign in do-all/fix-all type branches. It seems to at least make the developer cognizant of the fact that the current branch has a *specific* purpose.

2. Squash/rebase when merging feature branches
----------------------------------------------
When you are ready to merge a branch, squash the commits of this branch into a single descriptive commit. First, use the following command to stage the files for the merge.

.. code:: sh

	  git commit --squash merge feature_branch

Then type

.. code:: sh

	  git commit

to write the actual commit message.

This single commit should contain a subject that states the point of the branch. What problem does the branch solve? The body of the message should describe what each logical unit of the new feature does. If there have been changes to several semi-related changes to the codebase, describe why they have changed.

An example commit message would be:

.. code:: 
    
    Consolidate search string creation into single module

    Instead of having multiple search objects that take either
    position, budget, or actual objects and translate them into
    strings, use a single function that can parse each of these
    objects using their attributes.

    The previous method violated DRY pretty badly. There were
    three seperate record parsers, {Actual, Position, Budget}Parser
    that all did the same exact thing.

The idea in writing commit messages is to preserve the reasons for having changed or written new code.

Writing a commit consisting only of

.. code::

    Merged branch 'fix stuff'

doesn't tell another developer anything about **why** changes were made.

3. Newly merged feature branches require tests
----------------------------------------------
This is not really Git related, but bears mentioning. Writing a new feature should result in the ability to write or improve on the current battery of tests. There are occasions where new features can result in no tests, but most of the time a change in functionality should be testable. Doing so makes it extremely easy to check for regressions and helps other developers see how the newly written code is intended to be used.

4. Use tags
-----------
Git tags provide the ability to highlight certain commits as having significance. Typically, I only tag my master branch with version releases, e.g. 1.2.

This makes it easy for other users of the repository to track down significant changes.



5. Once merged, delete feature branches
---------------------------------------

.. admonition:: cancelled
	:class: strike

		Now that you have merged the branch and with it written an excellent and highly descriptive commit message, the commit history saved in the feature branch no longer serves any purpose. All it can do at this point is pollute your workspace with old branch names and cause confusion while working on new features.

		The solution: delete the feature branch once it has been merged.

		There are a few ways to delete remote branches and tags. I use:

		.. code:: sh

			  git push origin :refs/tags/<tag-name>

			  # delete remote branches
			  git push origin :<feature-branch1> :<feature-branch2>

			  To delete from the local repository after the merge:

		.. code:: sh

			  # make sure you have actually branched your branch before doing this,
			  # git branch -D will force delete the branch
			  # git branch --merged won't show squashed merges!
			  git branch -D <feature-branch>

Update 10-02-2014
-----------------
After a bit more thought, trial and error, and experimentation. I've noticed there is no real need to delete feature branches.
If they have been squashed in, it can be helpful to be able to look through the development process again.
But - this is purely a personal decision. As long as the changesets remain small enough for a group of developers to understand, then this process (squashin in features) will work.
