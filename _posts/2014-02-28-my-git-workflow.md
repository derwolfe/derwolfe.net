---layout: post.html title: My git workflow date: 2014-02-28 ---

git is excellent. It keeps me sane.
===================================

Over the past few years, I've noticed that not all uses of git are
alike. There seems to be a definite correct way to use git that results
in a repository being easy to understand and navigate.

Personally, I want my repositories to read like a story. I want to be
able to look over a commit history and understand why each merge was
made instead of just what the merge was.

Here are a few rules that I like to follow and why I find them
beneficial.

1. Use feature branches all the time
====================================

Branching in git is cheap, easy, fun, and safe. It allows a software
developer to create a sandbox in which all experimental changes can be
safely tried.

While working in an experimental branch, one can branch into even
further experimental sub-branches. Think master -\> feature -\>
sub-feature -\> implementation\_test1.

By doing this, the amount of changes in each feature branch is
relatively small. Each branch operates as its own contextual unit. I
like to apply this idea of local context in how I name branches, e.g.,
**add\_transfer\_status** or **validate\_position\_entry**. Having a
branch name with a specific purpose seems to help reign in
do-all/fix-all type branches. It seems to at least make the developer
cognizant of the fact that the current branch has a *specific* purpose.

Updated March 6, 2014

I know longer believe that squashing and rebasing is the correct
strategy to use. Even though your history might contain a large number
of warts, it is history that can show what you may have experimented
with while developing. This information can be valuable to other
developers looking through your code as it can help them to avoid trying
the same experiments. By keeping the dirty, ugly history intact,
developers new to your source code are provided with context in which to
view the code in front of them. If one would like to describe a set of
changes as a single unit, a merge commit can handle this.

~~2. Squash/rebase when merging feature branches~~
~~==============================================~~
~~~~
~~When you are ready to merge a branch, squash the commits of this branch~~
~~into a single descriptive commit. First, use the following command to~~
~~stage the files for the merge.~~
~~~~
~~``` {.sourceCode .sh}~~
~~git commit --squash merge feature_branch~~
~~```~~
~~~~
~~Then type~~
~~~~
~~``` {.sourceCode .sh}~~
~~git commit~~
~~```~~
~~~~
~~to write the actual commit message.~~
~~~~
~~This single commit should contain a subject that states the point of the~~
~~branch. What problem does the branch solve? The body of the message~~
~~should describe what each logical unit of the new feature does. If there~~
~~have been changes to several semi-related changes to the codebase,~~
~~describe why they have changed.~~
~~~~
~~An example commit message would be:~~
~~~~
~~``` {.sourceCode .}~~
~~Consolidate search string creation into single module~~
~~
~~Instead of having multiple search objects that take either~~
~~position, budget, or actual objects and translate them into~~
~~strings, use a single function that can parse each of these~~
~~objects using their attributes.~~
~~
~~The previous method violated DRY pretty badly. There were~~
~~three seperate record parsers, {Actual, Position, Budget}Parser~~
~~that all did the same exact thing.~~
~~```~~
~~
~~The idea in writing commit messages is to preserve the reasons for~~
~~having changed or written new code.~~
~~
~~Writing a commit consisting only of~~
~~
~~``` {.sourceCode .}~~
~~Merged branch 'fix stuff'~~
~~```~~
~~
~~doesn't tell another developer anything about **why** changes were made.~~

3. Newly merged feature branches require tests
==============================================

This is not really git related, but bears mentioning. Writing a new
feature should result in the ability to write or improve on the current
battery of tests. There are occasions where new features can result in
no tests, but most of the time a change in functionality should be
testable. Doing so makes it extremely easy to check for regressions and
helps other developers see how the newly written code is intended to be
used.

4. Use tags
===========

git tags provide the ability to highlight certain commits as having
significance. Typically, I only tag my master branch with version
releases, e.g. 1.2.

This makes it easy for other users of the repository to track down
significant changes.

5. Once merged, delete feature branches
=======================================

Now that you have merged the branch and with it written an excellent and
highly descriptive commit message, the commit history saved in the
feature branch no longer serves any purpose. All it can do at this point
is pollute your workspace with old branch names and cause confusion
while working on new features.

The solution: delete the feature branch once it has been merged.

There are a few ways to delete remote branches and tags. I use:

``` {.sourceCode .sh}
# delete remote tags
git push origin :refs/tags/<tag-name>

# delete remote branches
git push origin :<feature-branch>
```

To delete from the local repository after the merge:

``` {.sourceCode .sh}
git branch -D <feature-branch>
```