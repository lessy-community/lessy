# How to contribute?

## Submit an idea

Just open a ticket [on GitHub](https://github.com/marienfressinaud/lessy/issues)
but please note Lessy is still a personnal project and I have my priorities.

If you have questions and think documentation is incomplete (and it is!), do
not hesitate to open a ticket as well.

## Report a bug

Open a ticket [on GitHub](https://github.com/marienfressinaud/lessy/issues)
and please be as specific as possible:

- Lessy version
- environment (Ruby and Rails version, OS, etc.)
- related logs
- what was expected
- steps to reproduce

## Contribute to code

Please always open a ticket before doing large change. Pull request is required
and tests must pass before being merged. `master` is the main branch, all
contributions must start from it.

Try to keep clear commit messages. All commits in `master` branch must follow
this template:

```
[type]: [ticket id] Commit message
```

where `type` is:

- `add`: feature addition
- `fix`: bug fix
- `tec`: technical commit
- `doc`: documentation addition

`ticket id` must include the hash (#) so it creates a link to the ticket in
GitHub. It is optional if there is no related ticket.

Following these conventions make the commits' history easier to read and
changelog easier to write.

Commits in sub-branches do not have to follow these conventions. Please have a
look to the current history if you have doubts.

Before asking for a review, please rebase your work on `master` branch and
clean your commits (`git rebase -i` is your friend).
