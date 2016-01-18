---
layout: post.html
title: Splitting up pull requests
date: 2016-01-10
---

I've been working on greenfield projects for the past month. A side-effect
of this has been that my branches that start out with a small, limited scope have
tended to balloon. This has meant that I've needed to break down branches and
branches and pull requests. [Git](https://www.git-scm.com/) makes this easy
(depending of course on the level of historical commit history one intends to maintain).

Git offers different tools to assist in breaking up a branch.

1. Checking out hunks from files
2. Cherry-picking commits
3. Rebasing

Note, one can use each of these tools *together* -- they are not mutually exclusive.

## Checking out patches
I use this tool when the branch containing the work needs to split up, and its
commit history doesn't contain much useful information.

The main command to use here is:

```bash
# checkout a fresh branch for the smaller scope
git checkout master
git checkout -b branch-with-smaller-scope
# start checking out work from the source branch
git checkout -p the-branch-with-all-of-the-work -- src/foo/thing.clj
```
This command will allow you to stage hunks from `src/foo/thing.clj` just as you
would if you were using `git add -p ...`. Just like `git add -p` this allows you
to interactively select hunks from a file if `git` cannot come up with point on
which to split.

By running this command over all files containing work you would like to add,
you can extract material work from one branch and place it in another.

[//]: # Clean this up, you are most interested in saying "this uses"
[//]: # the standard patch interface...
