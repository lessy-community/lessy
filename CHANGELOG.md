# Changelog

## Ara 2018-xx-yy

### API changes

- Provide `POST /api/users/password_resets` endpoint
- Provide `POST /api/users/passwords` endpoint

## Aries 2018-08-27

### Features

- [#63](https://github.com/lessy-community/lessy/issues/63) Provide an administration
- [#303](https://github.com/lessy-community/lessy/issues/303) Allow admin to disable the registration
- [#176](https://github.com/lessy-community/lessy/issues/176) Provide Terms of service feature

### Improvements

- [#257](https://github.com/lessy-community/lessy/issues/257) Improve starting project

### Documentation

- [#288](https://github.com/lessy-community/lessy/issues/288) Document new development process
- Remove all references to pronto
- [#285](https://github.com/lessy-community/lessy/issues/285) Document HoundCI
- Add naming convention for feature flags
- Fix miscellaneous typos
- Document production with image from hub
- Update information to setup first user

### Bug fixes

- [#305](https://github.com/lessy-community/lessy/issues/305) Fix Docker build
- [#301](https://github.com/lessy-community/lessy/issues/301) Fix race condition on task order
- Handle HTTP response 204

### Technical

- Make backend reachable from outside of Docker
- Update rubocop configuration for Hound
- [#287](https://github.com/lessy-community/lessy/issues/287) Add support for feature flags
- Remove docker-compose-test.yml
- Configure Hound for JS
- Fix linters configuration
- Restart docker containers when appropriate
- Fix Travis build
- Provide `with_advisory_lock` gem
- Provide `shoulda-matchers` gem
- Update dependencies

### API changes

- `user.admin` is added
- `user.hasAcceptedTos` is added
- Provide `GET /api` endpoint
- Provide `GET /api/terms_of_services/current` endpoint
- Provide `POST /api/users/me/terms_of_services` endpoint
- `POST /api/users` now raises an error if `feature_registration` flag is
  disabled
- Most of the authenticated requests now require that users accepted terms of
  service

### Migration notes

- To disable registration, run `Flipper.disable :feature_registration` in a
  Rails console

## Aquila 2018-01-21

### Improvements

- [#224](https://github.com/lessy-community/lessy/issues/224) Add placeholder on create forms of project and task
- [#130](https://github.com/lessy-community/lessy/issues/130) Set default duration for project to 2 weeks
- [#263](https://github.com/lessy-community/lessy/issues/263) Display user errors on activation form

### Documentation

- Document how to create new iterations
- [#246](https://github.com/lessy-community/lessy/issues/246) Update links to lessy-community repo
- [#263](https://github.com/lessy-community/lessy/issues/263) Document db schema load for production
- [#245](https://github.com/lessy-community/lessy/issues/245) Add link to Framateam

### Internationalisation

- [#239](https://github.com/lessy-community/lessy/issues/239) Change error message for existing emails

### Bug fixes

- [#220](https://github.com/lessy-community/lessy/issues/220) Improve front sync between task and project
- [#243](https://github.com/lessy-community/lessy/issues/243) Remove finished projects of future list
- [#261](https://github.com/lessy-community/lessy/issues/261) Force order on paginated endpoints
- [#260](https://github.com/lessy-community/lessy/issues/260) Force colors to prevent system overrides
- [#267](https://github.com/lessy-community/lessy/issues/267) Sync task's state on project change

### Technical

- Update npm dependencies
- Update gem dependencies
- Rename Dockerfile.prod in Dockerfile
- [#140](https://github.com/lessy-community/lessy/issues/140) Provide live syncing system

### API changes

- Remove project attributes on task relationships
- Task's state is synced with its related project on `PATCH /api/tasks/:id`
  (please refer to tasks API documentation to know more about it)
- Remove `project.isInProgress` (equivalent to `project.state === 'started'`)
- Provide `GET /api/projects/:id` endpoint
- Provide `GET /api/tasks/:id` endpoint
- `project.createdAt` and `project.updatedAt` are added
- `task.createdAt` and `task.updatedAt` are added

### Migration notes

- `Dockerfile.prod` is renamed in `Dockerfile`
- Remove unofficial support of Ruby 2.3 (for test suite)
- Repository moves from https://github.com/marienfressinaud/lessy to https://github.com/lessy-community/lessy
- Redis is now required, please read specific section in production documentation to know more about it and adapt Nginx configuration

## Aquarius 2017-12-29

### Features

- [#182](https://github.com/lessy-community/lessy/issues/182) Don't list tasks in backlog for unrunning projects
- [#214](https://github.com/lessy-community/lessy/issues/214) Attach existing tasks to project
- [#179](https://github.com/lessy-community/lessy/issues/179) Enable transformation of task in project

### Improvements

- [#168](https://github.com/lessy-community/lessy/issues/168) Relax requirements for project names
- Improve ordering of project list
- [#234](https://github.com/lessy-community/lessy/issues/234) Handle task abandon through a modal

### Documentation

- Improve PR template for API changes
- Improve release process

### Internationalisation

- Improve English translation file
- [#171](https://github.com/lessy-community/lessy/issues/171) Provide French locale

Note that we still can't change lang so English is still the only one we can
use!

### Technical

- Provide a ly-modal component
- Provide a ly-form-select component

### API changes

- `task.createdAt` becomes `task.startedAt`
- `project.stoppedAt` becomes `project.pausedAt`
- `project.slug` is added
- `task.projectId` can now be patched

## Apus 2017-11-26

### Improvements

- [#23](https://github.com/lessy-community/lessy/issues/23) Redesign the frontend
- [#198](https://github.com/lessy-community/lessy/issues/198) Add a tip for project names
- [#203](https://github.com/lessy-community/lessy/issues/203) Improve welcome page

### Technical

- Disable Pronto
- Update Dockerfile images to use npm 5
- Remove useless npm modules
- Replace vue-directive-tooltip by vue-tooltip
- [#204](https://github.com/lessy-community/lessy/issues/204) Add tests configuration for frontend

## Antlia 2017-10-29

### Documentation

- Provide a CONTRIBUTORS file
- [#159](https://github.com/lessy-community/lessy/issues/159) Provide a CODE\_OF\_CONDUCT
- [#158](https://github.com/lessy-community/lessy/issues/158) Improve CONTRIBUTING's content
- [#157](https://github.com/lessy-community/lessy/issues/157) Improve README's content
- [#161](https://github.com/lessy-community/lessy/issues/161) Provide a pull request template
- [#160](https://github.com/lessy-community/lessy/issues/160) Improve technical documentation

### Bug fixes

- [#155](https://github.com/lessy-community/lessy/issues/155) Fix pagination when there is no item
- [#162](https://github.com/lessy-community/lessy/issues/162) Fix typo in task order API example

## Andromeda 2017-10-08

**Project Zero becomes Lessy!**

### Technical

- Configure Pronto on CI
- Improve seeds
- Bump ruby to 2.4.2
- Update gems to newest versions
- Does not return oldest tasks
- [#105](https://github.com/lessy-community/lessy/issues/105) Provide Docker configuration
- [#136](https://github.com/lessy-community/lessy/issues/136) Improve API endpoints
- [#137](https://github.com/lessy-community/lessy/issues/137) Consolidate state and order
- [#144](https://github.com/lessy-community/lessy/issues/144) Extract a generic state machine
- [#138](https://github.com/lessy-community/lessy/issues/138) Improve API errors handling
- [#149](https://github.com/lessy-community/lessy/issues/149) Paginate index endpoints

### Documentation

- [#141](https://github.com/lessy-community/lessy/issues/141) Start API documentation
- [#150](https://github.com/lessy-community/lessy/issues/150) Rework and document endpoints' output

### Migration notes

- `PROJECTZERO_HOST` becomes `LESSY_HOST`
- `PROJECTZERO_HTTPS` becomes `LESSY_HTTPS`

## 0.3 2017-07-23

### Features

- [#96](https://github.com/lessy-community/lessy/issues/96) Add a project's deadline visualisation
- [#104](https://github.com/lessy-community/lessy/issues/104) Provide a statistics page
- [#95](https://github.com/lessy-community/lessy/issues/95) Associate tasks to project

### Improvements

- [#97](https://github.com/lessy-community/lessy/issues/97) Improve design on small devices
- [#114](https://github.com/lessy-community/lessy/issues/114) Hide indicators on finished tasks
- [#111](https://github.com/lessy-community/lessy/issues/111) Add autofocus on edit task form
- [#112](https://github.com/lessy-community/lessy/issues/112) Remove planning page
- [#122](https://github.com/lessy-community/lessy/issues/122) Disable actions popover on ended tasks

### Bug fixes

- [#91](https://github.com/lessy-community/lessy/issues/91) Hide abandoned tasks when listing

### Documentation

- [#90](https://github.com/lessy-community/lessy/issues/90) Document release process

## 0.2 2017-06-05

### Features

- [#64](https://github.com/lessy-community/lessy/issues/64) Provide basic task support
- Restart finished tasks
- [#65](https://github.com/lessy-community/lessy/issues/65) Add today's planning
- [#69](https://github.com/lessy-community/lessy/issues/69) Provide tasks backlog
- [#30](https://github.com/lessy-community/lessy/issues/30) Set max length on some attributes
- [#61](https://github.com/lessy-community/lessy/issues/61) Autosize textarea according to content
- [#66](https://github.com/lessy-community/lessy/issues/66) Add more actions on tasks
- [#68](https://github.com/lessy-community/lessy/issues/68) Add help on repeated tasks
- [#67](https://github.com/lessy-community/lessy/issues/67) Order tasks
- [#88](https://github.com/lessy-community/lessy/issues/88) Add a badge about task's creation date
- Transform link in tasks' label

### Bug fixes

- Unload tasks on logout
- Load user correctly on authorize and activate

### Documentation

- [#74](https://github.com/lessy-community/lessy/issues/74) Add a section about application's updates
- Update backend's installation instructions

### Migration notes

- `PROJECTZERO_SMTP_HOST` becomes `PROJECTZERO_HOST`
- Add `export PROJECTZERO_HTTPS=true` in your .bashrc if you provide https

## 0.1 2017-01-29

### Features

- [#2](https://github.com/lessy-community/lessy/issues/2) Provide account creation
- [#3](https://github.com/lessy-community/lessy/issues/3) List and create projects
- [#4](https://github.com/lessy-community/lessy/issues/4) Show and edit projects
- [#5](https://github.com/lessy-community/lessy/issues/5) Start projects
- [#6](https://github.com/lessy-community/lessy/issues/6) Finish projects
- [#7](https://github.com/lessy-community/lessy/issues/7) Stop projects
- [#8](https://github.com/lessy-community/lessy/issues/8) Add placeholder to ask first project
- [#19](https://github.com/lessy-community/lessy/issues/19) Manage user session
- [#38](https://github.com/lessy-community/lessy/issues/38) Support Markdown in project' description
