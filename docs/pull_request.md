# Opening a pull request

So you took an [issue](https://github.com/lessy-community/lessy/issues) by
yourself and your patch is ready? It's time to open your [pull request](https://github.com/lessy-community/lessy/pulls)!

When you'll open it, your message will be prefilled with a message based on [a
template](pull_request_template.md). It contains a checklist to make sure you
didn't forget anything. It is very important to verify you did everything
mentioned so documentation is up-to-date, the commit history stays clear and
the code is always stable.

The rest of this document explains specific points.

## Rebasing your branch on `master`

Rebasing a branch is useful to make sure your code is based on the last version
of Lessy and there is no conflicts. Please never merge `master` in your branch
or it will generate an awful Git history! To rebase a branch:

```console
$ git checkout master # go on master branch
$ git pull            # pull the last version of master
$ git checkout -      # go back to your branch
$ git rebase master   # rebase your branch on master
```

If you feel confident, you can use `git rebase -i master` to rewrite your
history and make it clearer.

## Commit format

It is very important your commit messages follow our standard format because
changelog is generated from them. All commits in `master` branch must match
this template:

```raw
[type]: #[ticket id] Commit message

Optional description
```

Where type is:

- `add`: feature addition
- `imp`: improvement
- `fix`: bug fix
- `doc`: documentation addition
- `tec`: technical commit
- `i18n`: internationalisation addition or improvement
- `release`: release commit (don't worry about this one!)

Ticket id is optional if there is no related ticket.

If your branch contains more than one commit, this template does not apply
since we will merge them with a single commit. However, it is not a reason to
write unclear or very generic messages. Please remember Git history is read by
other developers. For example, here is an extract of current history:

```raw
* b7a2e44 - release: #99 Version 0.3
* 7e9720a - doc: #90 Document release process
* 2d516cd - fix: #124 Hide statistics button when not logged
*   5b65801 - add: #95 Associate tasks to project
|\
| * f3b3b6a - Show info about tasks in current projects card
| * bd629e8 - Add a link to related project on tasks
| * a0f710b - Add a backlog per project
| * 9c91cb7 - Add relation between a task and a project
|/
* 86064ee - tec: Refactor index projects request specs
```

Please have a look to the current history if you have doubts.

## Coding style

We do not maintain an exhaustive list of coding style rules. It could be done
in the future but it would be overwhelming to try to think to all cases.

We wanted to use [Pronto](https://github.com/prontolabs/pronto) to
automatically check your changes and comment your pull request but we had some
troubles when we configured it so it is disabled for the moment.

If we detect issues in your code, we will point them to you and add them to a
list.
