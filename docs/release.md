# Release process

Our release process is based on iterations which are actually represented by
[GitHub milestones](https://github.com/lessy-community/lessy/milestones).

## Prepare an iteration

To prepare an iteration, you'll need to pack a set of related [issues](https://github.com/lessy-community/lessy/issues)
together. This pack forms an iteration and it must be finishable within two or
three weeks of effective work. Iterations are named after [constellations'
name](https://en.wikipedia.org/wiki/88_modern_constellations).

To find available issues for a new iteration, you can search them on GitHub by
mixing [`no:milestone` and `-label:"Not ready"` filters](https://github.com/lessy-community/lessy/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+no%3Amilestone+-label%3A%22Not+ready%22+).
You can add the filter `label:"P: High"` to find the most urgent ones.

Once you know the issues you want to group, [create a new milestone](https://github.com/lessy-community/lessy/milestones/new)
by taking the next constellation in alphabetical order. For instance, after
iteration `Aquila` is the iteration `Ara`.

Please always follow this format for iteration names: `X. NAME` where
`X` is the last iteration number incremented by one and `NAME` is the name of
the constellation.

## Current work board

The ["Current work" board](https://github.com/lessy-community/lessy/projects/9)
keeps track of the ongoing work on Lessy. There are few rules to follow so the
board stays clear and useful.

When starting a new iteration, please add all the concerned issues to the
"To Do" column of the board. New issues can be added during an iteration,
especially if they are about critical bugs.

New pull requests and ongoing issues must be added to the "In progress" column
so we don't forget them.

Once an issue is closed or a pull request is merged to `master`, the related
card must move to the "In master branch" column. But that doesn't mean it's all
finished!

Next step is for an admin to deploy `master` on lessy.io so it becomes testable
in production. Once done, move the concerned cards to "In production" column.
If the feature is conditioned by a feature flag, please put the card below the
"Feature flag enabled" note.

Once feature or fix have been tested in production and feature flag disabled,
you can eventually move the card to the "Done" column.

## Release a new version

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

To finish, create [a new release on GitHub](https://github.com/lessy-community/lessy/releases/new)
containing changelog content, write an article, announce the new release on
social networks and celebrate with the community!
