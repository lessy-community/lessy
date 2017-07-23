# Release process

## Start a new release

To start a new release, open a [new ticket on GitHub](https://github.com/marienfressinaud/project-zero/issues/new)
named "Release XXX", with the following content:

```
- [ ] close all [XXX tickets](https://github.com/marienfressinaud/project-zero/milestone/XXX)
- [ ] write blog article
- [ ] update changelog
- [ ] tag last commit with XXX
```

## End a release

Once you ended all the tickets related to the new release and you prepared the
article for the blog, you'll have to update the changelog. You can help
yourself with the following bash commands:

```bash
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep add:
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep imp:
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep fix:
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep doc:
```

`tec` commits can be ommited but feel free to add relevant ones! Don't forget
to create links to GitHub when a ticket is associated.

Commit your changes (e.g. `[release]: #release-ticket-id Version XXX`) and tag
the last commit with `XXX`.
