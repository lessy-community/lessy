export default {
  app: {
    appHeader: {
      logout: 'Log out',
    },
  },

  dashboard: {
    layout: {
      title: 'Dashboard',
    },

    page: {
      activationInstructions: 'We sent you an email at {email}.<br />Follow its instructions to be able to access your projects later.',
      backlog: 'pick some from backlog',
      createTask: 'Add tasks for today',
      or: 'or',
      projectsInProgress: 'Projects in progress',
      tasksForToday: '{count} task for today | {count} tasks for today',
    },
  },

  errors: {
    _: {
      login_failed: 'Oops we failed to log you, it seems your credentials are wrong.',
      missing_endpoint: 'It seems you try to access an unknown resource. It’s probably not your fault and we are sorry about that. We’ll try to fix it quickly!',
      registration_disabled: 'The registration is disabled, you’re not authorized to create an account.',
      tos_not_accepted: 'Terms of service have changed. Please refresh the page to continue.',
      unauthorized: 'You’re not authorize to perform this action, please refresh the page and re-login.',
    },

    project: {
      parameter_missing: 'Project is required.',
      record_not_found: 'Project cannot be found.',

      due_at: {
        cannot_be_before_started_at: 'Due date cannot be set before today.',
        cannot_be_set: 'Due date cannot be set yet.',
        must_be_set: 'Due date is required.',
        parameter_missing: 'Due date is required.',
      },

      finished_at: {
        cannot_be_after_today: 'Finished date cannot be set after today.',
        cannot_be_before_started_at: 'Due date cannot be set before started date.',
        cannot_be_set: 'Finished date cannot be set yet.',
        must_be_set: 'Finished date is required.',
        parameter_missing: 'Finished date is required.',
      },

      name: {
        blank: 'Name is required.',
        parameter_missing: 'Name is required.',
        too_long: 'Name is too long (max 100 characters).',
      },

      slug: {
        invalid: 'Something went wrong when saving the project (does its name contain any special character?). Please choose another name.',
        taken: 'This name is close to another of your project names, please try to change it.',
      },

      state: {
        invalid_transition: 'You try to perform an action which should not be possible normally, we are sorry about that!',
        reached_max_started: 'You cannot start more than three projects.',
      },
    },

    task: {
      parameter_missing: 'Task is required.',
      record_not_found: 'Task cannot be found.',

      label: {
        parameter_missing: 'Label is required.',
      },

      state: {
        invalid_transition: 'You try to perform an action which should not be possible normally, we are sorry about that!',
      },
    },

    user: {
      parameter_missing: 'User is required.',
      record_not_found: 'User cannot be found.',

      email: {
        parameter_missing: 'Username is required.',
        taken: 'An account already exists with this email address.',
      },

      password: {
        parameter_missing: 'Username is required.',
      },

      username: {
        exclusion: 'Username is a reserved word.',
        invalid: 'Username does not match the required pattern.',
        parameter_missing: 'Username is required.',
        taken: 'This username is not available.',
        too_long: 'Username is too long (max 25 characters).',
      },
    },
  },

  general: {
    defaultMenu: {
      dashboard: 'Dashboard',
      projects: 'Projects',
      tasks: 'Tasks',
    },

    homeLayout: {
      title: 'Recover your power to manage time',
      intro: 'Collect, organize and focus on what really matters, never say “I don’t have time” again.',

      registrationDisabled: 'Unfortunately, registrations are <strong>closed</strong> for the moment.',
      login: 'Have an account? Log in',

      detailsTitle: 'A respectful and ethical time manager',
      timeTitle: 'Time is a precious resource',
      timeDetails: 'Time is a one-way road and never can be recovered but it’s never too late to start to use it consciously. If you feel it’s time to change a little something in your habits, Lessy will help you to explore the path thoroughly.',
      lessTitle: 'Less cognitive load, less stress',
      lessDetails: 'Lessy supports you in your daily routine by presenting what you most likely want to do first.<br />Do you feel exhausted of your day already? Don’t worry, we all follow our own pace and Lessy knows that.',
      communityTitle: 'Built by an open community',
      communityDetails: 'Time is too important to be handed over to private companies. Lessy is a free software built by a welcoming community of users with same concerns as yours.<br /><a href="https://github.com/lessy-community/lessy/blob/master/CONTRIBUTING.md"> You can participate to make it better too!</a>',

      moreTitle: 'Go further',
      exploreTitle: 'Explore source code',
      exploreDetails: 'Because Lessy is <a href="https://github.com/lessy-community/lessy/blob/master/LICENSE">free</a> and always will be.',
      hostTitle: 'Host it',
      hostDetails: 'Data are yours and we don’t want to be a centralized service.',
      donateTitle: 'Donate',
      donateDetails: 'It helps us to maintain the service opened to everyone.',

      madeWithLove: 'Made with ♥ by <a href="https://github.com/lessy-community/lessy/blob/master/CONTRIBUTORS.md">amazing contributors</a>.',
      greetings: 'Have a great day!',
    },

    loadingLayout: {
      inProgress: 'Loading, please wait…',
    },

    notFoundLayout: {
      home: 'Home page',
      intro: "It looks like this page doesn't exist…",
      title: 'Page not found',
    },

    termsOfServiceLayout: {
      accept: 'I read and accept terms',
      changed: 'Terms of service have changed, you should read them carefully.',
      goBack: 'Go back to the main page',
      loading: 'Loading, please wait…',
      title: 'Terms of service',
      version: 'Version: {version}',
    },

    termsOfServiceModal: {
      intro: 'Heads up! Our terms of service have recently changed and we want to be sure that you read it and you understand their implications.',
      mustAccept: 'To continue to use our service, you’ll have to agree to those new terms.',
      read: 'Read the terms of service',
      title: 'Terms of service',
    },

    welcomeHeader: {
      lessy: 'Lessy',
    },
  },

  ly: {
    form: {
      input: {
        optional: 'optional',
        revealPassword: 'Reveal',
      },

      select: {
        moreOptions: '+1 additional option | +{number} additional options',
        unselect: 'Unselect',
      },
    },
  },

  projects: {
    card: {
      shouldAddTasks: 'Usually, a living project holds unfinished tasks.',
      tasksCount: '{finishedCount} / {totalCount} task | {finishedCount} / {totalCount} tasks',
    },

    cardDeck: {
      empty: 'No project',
      emptyLink: 'Start a project from your inbox',
    },

    createForm: {
      cancel: 'Cancel',
      submit: 'Create',
      nameCaption: 'Maximum 100 characters.',
      placeholder: 'Holidays in Paris',
    },

    editForm: {
      cancel: 'Cancel',
      descriptionLabel: 'Description',
      descriptionCaption: 'Description supports Markdown',
      dueLabel: 'Due on',
      nameLabel: 'Name',
      nameCaption: 'Max 100 characters.',
      submit: 'Validate',
    },

    finishForm: {
      cancel: 'Cancel',
      finishedLabel: 'Finished on',
      finishedCaption: 'It cannot be after today',
      submit: 'Finish project',
    },

    inboxPage: {
      createProject: 'Create a project',
      finishedProjects: 'Finished projects',
      futureProjects: 'Future projects',
      hideFinishedProjects: 'Hide your project | Hide your projects',
      projectsPlaceholder: "You don't have any project yet, what are you working on?",
      seeFinishedProjects: 'See your finished project | See your {count} finished projects',
    },

    item: {
      pausedOn: 'paused on {date}',
      tasksCount: '{finishedCount} / {totalCount} task | {finishedCount} / {totalCount} tasks',
    },

    itemFinished: {
      finishedLabel: 'finished on {date}',
      tasksCount: '{finishedCount} / {totalCount} task | {finishedCount} / {totalCount} tasks',
    },

    layout: {
      inbox: 'Inbox',
      project: 'Project',
      title: 'Projects',
    },

    modals: {
      editDueDateTitle: 'Edit project’s due date',
      finishTitle: 'Finish project',
      finishIntro: 'You’ve finished « {projectName} »? That’s great! Let us know when you finished it:',
      startNewTitle: 'Start a project',
      startTitle: 'Start project',
    },

    showPage: {
      associatedTasks: 'Associated tasks',
      edit: 'Edit',
      noDescription: 'There is no description for this project yet.',
      timeline: 'Timeline',
    },

    startForm: {
      cancel: 'Cancel',
      dueLabel: 'Due on',
      dueCaption: 'The due date has to be after today',
      nameLabel: 'Name',
      submit: 'Start it now',
    },

    startNewForm: {
      cancel: 'Cancel',
      dueLabel: 'Due on',
      dueCaption: 'The due date have to be after today',
      noProjects: 'You have no projects in your inbox so let’s create one!',
      projectLabel: 'Project',
      submit: 'Start the project',
    },

    timeline: {
      diff: '{days} day | {days} days',
      dueOn: 'Due on {date}',
      dueOnEdit: 'Edit due date',
      dueToday: 'due today',
      finish: 'Finish',
      finishedOn: 'finished on {date}',
      late: 'late',
      notStarted: 'not started',
      pause: 'Pause',
      pausedOn: 'paused on {date}',
      reachedMaxInProgress: 'You already reached the maximum of started projects.',
      restart: 'Restart',
      start: 'Start',
      startedOn: 'Started on {date}',
      untilDueDate: 'before due date',
    },
  },

  tasks: {
    attachProjectForm: {
      cancel: 'Cancel',
      projectLabel: 'Project',
      submit: 'Attach',
    },

    backlogPage: {
      tasksNumber: '{count} task in backlog | {count} tasks in backlog',
    },

    createForm: {
      cancel: 'Cancel',
      submit: 'Create',
      warningTooMany: 'You might face difficulties to achieve all your tasks if you try to do too much.',
      placeholder: 'Walk the dog',
    },

    editForm: {
      cancel: 'Cancel',
      submit: 'Update',
    },

    item: {
      abandon: 'Abandon',
      attachToProject: 'Attach to a project',
      plannedOn: 'planned on {date}',
      edit: 'Edit',
      markAsDone: 'Mark as done',
      markAsUndone: 'Mark as undone',
      plan: 'Plan for today',
      replan: 'Replan for today',
      replanned: 'You’ve replanned this task once | You’ve replanned this task {count} times, what about splitting or renaming it so it would be easier to achieve?',
      startedSinceWeeks: 'You’ve started this task 1 week ago | You’ve started this task {count} weeks ago, it may be time to abandon it, don’t you think?',
      transformInProject: 'Transform in project',
    },

    list: {
      empty: 'There are no tasks here…',
    },

    layout: {
      backlog: 'Backlog',
      statistics: 'Statistics',
      title: 'Tasks',
    },

    modals: {
      attachProjectTitle: 'Attach task to a project',
      cancel: 'Cancel',
      confirmAbandon: 'The task « {label} » will be marked as abandoned and will disappear from the list. Can you confirm?',
      confirmAbandonTitle: 'Abandon task',
      submitAbandon: 'Confirm abandon',
      transformInProjectTitle: 'Transform task in a project',
    },

    statisticsPage: {
      chartName: 'Tasks statistics',
    },
  },

  users: {
    activateForm: {
      passwordLabel: 'Password',
      submit: 'Activate your account',
      usernameLabel: 'Username',
      usernameCaption: 'Only lowercase letters, underscore and dash (max 25 characters).',
    },

    activateLayout: {
      intro: 'To continue, you have to pick a unique username and a password so you can login to your account later.',
      title: 'Activate your account',
    },

    loginForm: {
      passwordForgotten: 'You can’t remember your password?',
      passwordLabel: 'Password',
      submit: 'Log in',
      register: 'Create an account',
      usernameLabel: 'Username',
    },

    loginLayout: {
      title: 'Log in',
    },

    passwordResetForm: {
      emailLabel: 'Email',
      login: 'You remember your password?',
      register: 'Create an account',
      submit: 'Reset your password',
    },

    passwordResetLayout: {
      emailIntro: 'Please enter the email address related to your account so we’ll send you a link to reset your password.',
      emailSentTo: 'We’ve just sent an email to {email} so you’ll be able to create a new password in a few minutes. If you receive no emails, please check your spams.',
      login: 'You remember your password?',
      title: 'Reset your password',
    },

    registerForm: {
      emailLabel: 'Email',
      emailPlaceholder: 'john@doe.com',
      login: 'Have an account? Log in',
      submit: 'Create your account',
      tosMustAccept: 'By clicking “Create your account”, you accept our',
      tosLink: 'terms of service',
    },
  },
}
