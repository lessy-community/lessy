# Changelog

## Aquarius XXXX-YY-ZZ

### API changes

- `task.createdAt` becomes `task.startedAt`
- `project.stoppedAt` becomes `project.pausedAt`
- `project.slug` is added

## Apus 2017-11-26

### Improvements

- [#23](https://github.com/marienfressinaud/lessy/issues/23) Redesign the frontend
- [#198](https://github.com/marienfressinaud/lessy/issues/198) Add a tip for project names
- [#203](https://github.com/marienfressinaud/lessy/issues/203) Improve welcome page

### Technical

- Disable Pronto
- Update Dockerfile images to use npm 5
- Remove useless npm modules
- Replace vue-directive-tooltip by vue-tooltip
- [#204](https://github.com/marienfressinaud/lessy/issues/204) Add tests configuration for frontend

## Antlia 2017-10-29

### Documentation

- Provide a CONTRIBUTORS file
- [#159](https://github.com/marienfressinaud/lessy/issues/159) Provide a CODE\_OF\_CONDUCT
- [#158](https://github.com/marienfressinaud/lessy/issues/158) Improve CONTRIBUTING's content
- [#157](https://github.com/marienfressinaud/lessy/issues/157) Improve README's content
- [#161](https://github.com/marienfressinaud/lessy/issues/161) Provide a pull request template
- [#160](https://github.com/marienfressinaud/lessy/issues/160) Improve technical documentation

### Bug fixes

- [#155](https://github.com/marienfressinaud/lessy/issues/155) Fix pagination when there is no item
- [#162](https://github.com/marienfressinaud/lessy/issues/162) Fix typo in task order API example

## Andromeda 2017-10-08

**Project Zero becomes Lessy!**

### Technical

- Configure Pronto on CI
- Improve seeds
- Bump ruby to 2.4.2
- Update gems to newest versions
- Does not return oldest tasks
- [#105](https://github.com/marienfressinaud/lessy/issues/105) Provide Docker configuration
- [#136](https://github.com/marienfressinaud/lessy/issues/136) Improve API endpoints
- [#137](https://github.com/marienfressinaud/lessy/issues/137) Consolidate state and order
- [#144](https://github.com/marienfressinaud/lessy/issues/144) Extract a generic state machine
- [#138](https://github.com/marienfressinaud/lessy/issues/138) Improve API errors handling
- [#149](https://github.com/marienfressinaud/lessy/issues/149) Paginate index endpoints

### Documentation

- [#141](https://github.com/marienfressinaud/lessy/issues/141) Start API documentation
- [#150](https://github.com/marienfressinaud/lessy/issues/150) Rework and document endpoints' output

### Migration notes

- `PROJECTZERO_HOST` becomes `LESSY_HOST`
- `PROJECTZERO_HTTPS` becomes `LESSY_HTTPS`

## 0.3 2017-07-23

### Features

- [#96](https://github.com/marienfressinaud/lessy/issues/96) Add a project's deadline visualisation
- [#104](https://github.com/marienfressinaud/lessy/issues/104) Provide a statistics page
- [#95](https://github.com/marienfressinaud/lessy/issues/95) Associate tasks to project

### Improvements

- [#97](https://github.com/marienfressinaud/lessy/issues/97) Improve design on small devices
- [#114](https://github.com/marienfressinaud/lessy/issues/114) Hide indicators on finished tasks
- [#111](https://github.com/marienfressinaud/lessy/issues/111) Add autofocus on edit task form
- [#112](https://github.com/marienfressinaud/lessy/issues/112) Remove planning page
- [#122](https://github.com/marienfressinaud/lessy/issues/122) Disable actions popover on ended tasks

### Bug fixes

- [#91](https://github.com/marienfressinaud/lessy/issues/91) Hide abandoned tasks when listing

### Documentation

- [#90](https://github.com/marienfressinaud/lessy/issues/90) Document release process

## 0.2 2017-06-05

### Features

- [#64](https://github.com/marienfressinaud/lessy/issues/64) Provide basic task support
- Restart finished tasks
- [#65](https://github.com/marienfressinaud/lessy/issues/65) Add today's planning
- [#69](https://github.com/marienfressinaud/lessy/issues/69) Provide tasks backlog
- [#30](https://github.com/marienfressinaud/lessy/issues/30) Set max length on some attributes
- [#61](https://github.com/marienfressinaud/lessy/issues/61) Autosize textarea according to content
- [#66](https://github.com/marienfressinaud/lessy/issues/66) Add more actions on tasks
- [#68](https://github.com/marienfressinaud/lessy/issues/68) Add help on repeated tasks
- [#67](https://github.com/marienfressinaud/lessy/issues/67) Order tasks
- [#88](https://github.com/marienfressinaud/lessy/issues/88) Add a badge about task's creation date
- Transform link in tasks' label

### Bug fixes

- Unload tasks on logout
- Load user correctly on authorize and activate

### Documentation

- [#74](https://github.com/marienfressinaud/lessy/issues/74) Add a section about application's updates
- Update backend's installation instructions

### Migration notes

- `PROJECTZERO_SMTP_HOST` becomes `PROJECTZERO_HOST`
- Add `export PROJECTZERO_HTTPS=true` in your .bashrc if you provide https

## 0.1 2017-01-29

### Features

- [#2](https://github.com/marienfressinaud/lessy/issues/2) Provide account creation
- [#3](https://github.com/marienfressinaud/lessy/issues/3) List and create projects
- [#4](https://github.com/marienfressinaud/lessy/issues/4) Show and edit projects
- [#5](https://github.com/marienfressinaud/lessy/issues/5) Start projects
- [#6](https://github.com/marienfressinaud/lessy/issues/6) Finish projects
- [#7](https://github.com/marienfressinaud/lessy/issues/7) Stop projects
- [#8](https://github.com/marienfressinaud/lessy/issues/8) Add placeholder to ask first project
- [#19](https://github.com/marienfressinaud/lessy/issues/19) Manage user session
- [#38](https://github.com/marienfressinaud/lessy/issues/38) Support Markdown in project' description
