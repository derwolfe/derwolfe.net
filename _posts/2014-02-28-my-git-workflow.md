---
layout: post.html
title: My git workflow - updated March 6, 2015
date: 2014-02-28
---

git is excellent. It keeps me sane.
===================================

Over the past years, I've noticed that not all uses of git are
alike. There seems to be a definite correct way to use git that results
in a repository being easy to understand and navigate.

Personally, I want my repositories to read like a story. I want to be
able to look over a commit history and understand why code was merged
instead of just when it was merged.

1. Use feature branches all the time
====================================

Branching in git is cheap, easy, fun, and safe. It allows a software
developer to create a sandbox in which all experimental changes can be
safely tried.

While working in an experimental branch, one can branch into even
further experimental sub-branches. Think master -\> feature -\>
sub-feature -\> implementation\_test1.

By doing this, the amount of changes in each feature branch is
small. Each branch operates as its own contextual unit. I
like to apply this idea of local context in how I name branches, e.g.,
**add\_transfer\_status** or **validate\_position\_entry**. Having a
branch name with a specific purpose seems to help reign in
do-all/fix-all type branches. It seems to at least make the developer
cognizant of the fact that the current branch has a *specific* purpose.

2.Preserve all history when merging feature branches
=====================================================

*Updated March 6, 2014*

I no longer believe that squashing or rebasing is the correct
strategy to use when mergining in new code.

Even though your history might contain a large number
of warts, it is a representation of facts that represent the history of a
features development over time. While `oops` commits might produce noise,
they help provide valuable knowledge about its development history. The
developer may have needed to go through a fair amount of experimentation to
produce the resulting feature. This experimentation may provide future
developers with helpful information about what to try and what to avoid.
Further, If a feature has long development history, it can
signal that there was great difficulty in developing the feature or working
with an API.

By keeping the dirty, ugly history intact, developers new to your source
have an accurate historical context through which they can view
your code.

Rebasing and squashing rewrites (read deletes) the history of development.
When a repository uses a squashing as the merge strategy, the granularity
is intentionally limited to the feature itself instead of to the work involved
in developing the feature.

In closing: use merge commits to describe why of a set of commits is important
and leave the history of your branch alone. If you did the work, it
should stay in the repository.


3. Newly merged feature branches require tests
==============================================

This is not really git related, but bears mentioning. Writing a new
feature should result in the ability to write or improve on the current
battery of tests. There are occasions where new features can result in
no tests, but most of the time a change in functionality should be
testable. Doing so makes it easy to check for regressions and
helps other developers see how the newly written code should be used.

4. Use tags
===========

git tags provide the ability to highlight certain commits as having
significance. Typically, I only tag my master branch with version
releases, e.g. 1.2.

This makes it easy for other users of the repository to track down
significant changes.

5. Once merged, delete feature branches
=======================================

Now that you have merged the branch and with it written a
highly descriptive commit message, the commit history saved in the
feature branch no longer serves any purpose. All it can do at this point
is pollute your workspace with old branch names and cause confusion
while working on new features.

The solution: delete the feature branch once merged.

There are multiple ways to delete remote branches and tags. I use:

```console
# delete remote tags
git push origin :refs/tags/<tag-name>

# delete remote branches
git push origin :<feature-branch>
```

To delete from the local repository after the merge:

```console
git branch -D <feature-branch>
```
