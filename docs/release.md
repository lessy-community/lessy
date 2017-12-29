# Release process

Our release process is based on iterations which are actually represented by
[GitHub projects](https://github.com/marienfressinaud/lessy/projects). An
iteration groups a set of related [issues](https://github.com/marienfressinaud/lessy/issues)
and must be finishable within two or three weeks of effective work. Iterations
are named after [constellations' name](https://en.wikipedia.org/wiki/88_modern_constellations).

Releasing a new version of Lessy must stay as simple as possible. It is done by
updating the [changelog file](../CHANGELOG.md) once all issues of current
iteration are closed:

1. set the current date
2. complete "Features", "Improvements", "Bug fixes", "Documentation" and
   "Internationalisation" sections
3. make sure migration notes are complete

You can generate sections with the following Git commands:

```console
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep add:
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep imp:
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep fix:
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep doc:
$ git log --pretty=format:%s --first-parent --reverse [last tag]..HEAD | grep i18n:
```

Just make sure to generate links to corresponding GitHub issues.

Once the changelog is up-to-date, commit your changes (e.g. `release: Version XXX`)
and tag the last commit with `XXX` (where `XXX` is the name of the iteration):

```console
$ git commit -m 'release: Version XXX'
$ git tag XXX
$ git push && git push --tags
```

To finish, create [a new release on GitHub](https://github.com/marienfressinaud/lessy/releases/new)
containing changelog content, write an article, announce the new release on
social networks and celebrate with the community!
