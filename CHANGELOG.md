# Changelog

## 0.3 2017-07-23

### Features

- [#96](https://github.com/marienfressinaud/project-zero/issues/96) Add a project's deadline visualisation
- [#104](https://github.com/marienfressinaud/project-zero/issues/104) Provide a statistics page
- [#95](https://github.com/marienfressinaud/project-zero/issues/95) Associate tasks to project

### Improvements

- [#97](https://github.com/marienfressinaud/project-zero/issues/97) Improve design on small devices
- [#114](https://github.com/marienfressinaud/project-zero/issues/114) Hide indicators on finished tasks
- [#111](https://github.com/marienfressinaud/project-zero/issues/111) Add autofocus on edit task form
- [#112](https://github.com/marienfressinaud/project-zero/issues/112) Remove planning page
- [#122](https://github.com/marienfressinaud/project-zero/issues/122) Disable actions popover on ended tasks

### Bug fixes

- [#91](https://github.com/marienfressinaud/project-zero/issues/91) Hide abandoned tasks when listing

### Documentation

- [#90](https://github.com/marienfressinaud/project-zero/issues/90) Document release process

## 0.2 2017-06-05

### Features

- [#64](https://github.com/marienfressinaud/project-zero/issues/64) Provide basic task support
- Restart finished tasks
- [#65](https://github.com/marienfressinaud/project-zero/issues/65) Add today's planning
- [#69](https://github.com/marienfressinaud/project-zero/issues/69) Provide tasks backlog
- [#30](https://github.com/marienfressinaud/project-zero/issues/30) Set max length on some attributes
- [#61](https://github.com/marienfressinaud/project-zero/issues/61) Autosize textarea according to content
- [#66](https://github.com/marienfressinaud/project-zero/issues/66) Add more actions on tasks
- [#68](https://github.com/marienfressinaud/project-zero/issues/68) Add help on repeated tasks
- [#67](https://github.com/marienfressinaud/project-zero/issues/67) Order tasks
- [#88](https://github.com/marienfressinaud/project-zero/issues/88) Add a badge about task's creation date
- Transform link in tasks' label

### Bug fixes

- Unload tasks on logout
- Load user correctly on authorize and activate

### Documentation

- [#74](https://github.com/marienfressinaud/project-zero/issues/74) Add a section about application's updates
- Update backend's installation instructions

### Migration notes

- `PROJECTZERO_SMTP_HOST` becomes `PROJECTZERO_HOST`
- Add `export PROJECTZERO_HTTPS=true` in your .bashrc if you provide https

## 0.1 2017-01-29

### Features

- [#2](https://github.com/marienfressinaud/project-zero/issues/2) Provide account creation
- [#3](https://github.com/marienfressinaud/project-zero/issues/3) List and create projects
- [#4](https://github.com/marienfressinaud/project-zero/issues/4) Show and edit projects
- [#5](https://github.com/marienfressinaud/project-zero/issues/5) Start projects
- [#6](https://github.com/marienfressinaud/project-zero/issues/6) Finish projects
- [#7](https://github.com/marienfressinaud/project-zero/issues/7) Stop projects
- [#8](https://github.com/marienfressinaud/project-zero/issues/8) Add placeholder to ask first project
- [#19](https://github.com/marienfressinaud/project-zero/issues/19) Manage user session
- [#38](https://github.com/marienfressinaud/project-zero/issues/38) Support Markdown in project' description
