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
      unauthorized: 'You’re not authorize to perform this action, please refresh the page and re-login.',
    },

    project: {
      parameter_missing: 'Project is required.',
      record_not_found: 'Project does not exist.',

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
      record_not_found: 'Task does not exist.',

      label: {
        parameter_missing: 'Label is required.',
      },

      state: {
        invalid_transition: 'You try to perform an action which should not be possible normally, we are sorry about that!',
      },
    },

    user: {
      parameter_missing: 'User is required.',
      record_not_found: 'User does not exist.',

      email: {
        parameter_missing: 'Username is required.',
        taken: 'This email address is not available.',
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

      detailsTitle: 'A respectful and ethical time manager',
      timeTitle: 'Time is a precious resource',
      timeDetails: 'Time is a one-way road and never can be recovered but it’s never too late to start to use it consciously. If you feel it’s time to change a little something in your habits, Lessy will help you to explore the path thoroughly.',
      lessTitle: 'Less cognitive load, less stress',
      lessDetails: 'Lessy supports you in your daily routine by presenting what you most likely want to do first.<br />Do you feel exhausted of your day already? Don’t worry, we all follow our own pace and Lessy knows that.',
      communityTitle: 'Built by an open community',
      communityDetails: 'Time is too important to be handed over to private companies. Lessy is a free software built by a welcoming community of users with same concerns as yours.<br /><a href="https://github.com/marienfressinaud/lessy/blob/master/CONTRIBUTING.md"> You can participate to make it better too!</a>',

      moreTitle: 'Go further',
      exploreTitle: 'Explore source code',
      exploreDetails: 'Because Lessy is <a href="https://github.com/marienfressinaud/lessy/blob/master/LICENSE">free</a> and always will be.',
      hostTitle: 'Host it',
      hostDetails: 'Data are yours and we don’t want to be a centralized service.',
      donateTitle: 'Donate',
      donateDetails: 'It helps us to maintain the service opened to everyone.',

      madeWithLove: 'Made with ♥ by <a href="https://github.com/marienfressinaud/lessy/blob/master/CONTRIBUTORS.md">amazing contributors</a>.',
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
    },
  },

  projects: {
    card: {
      datesDescription: 'Started on <b>{start}</b><br />Due on <b>{due}</b>',
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
      cancel: 'No, I did not yet',
      finishedLabel: 'Finished on',
      finishedCaption: 'It cannot be after today',
      submit: 'I did it!',
    },

    finishPage: {
      intro: "Really? You've finished <b>{projectName}</b>? That's great!<br />Let us know when you finished it:",
    },

    inboxPage: {
      createProject: 'Create a project',
      finishedLabel: 'finished on {date}',
      finishedProjects: 'Finished projects',
      futureProjects: 'Future projects',
      hideFinishedProjects: 'Hide your project | Hide your projects',
      projectsPlaceholder: "You don't have any project yet, what are you working on?",
      seeFinishedProjects: 'See your finished project | See your {count} finished projects',
      pausedOn: 'paused on {date}',
      tasksCount: '{finishedCount} / {totalCount} task | {finishedCount} / {totalCount} tasks',
    },

    layout: {
      inbox: 'Inbox',
      project: 'Project',
      title: 'Projects',
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
      dueCaption: 'The due date have to be after today',
      nameLabel: 'Name',
      submit: 'Start it now',
    },

    timeline: {
      diff: '{days} day | {days} days',
      dueOn: 'Due on {date}',
      dueToday: 'due today',
      finishedOn: 'finished on {date}',
      late: 'late',
      notStarted: 'not started',
      pausedOn: 'paused on {date}',
      reachedMaxInProgress: 'You already reached the maximum of started projects.',
      startedOn: 'Started on {date}',
      untilDueDate: 'before due date',
    },
  },

  tasks: {
    backlogPage: {
      tasksNumber: '{count} task in backlog | {count} tasks in backlog',
    },

    createForm: {
      cancel: 'Cancel',
      submit: 'Create',
      warningTooMany: 'You might face difficulties to achieve all your tasks if you try to do too much.',
    },

    editForm: {
      cancel: 'Cancel',
      submit: 'Update',
    },

    item: {
      abandon: 'Abandon',
      confirmAbandon: 'Oh? The task will be marked as abandoned and will disappear from the list. Can you confirm?',
      startedSinceWeeks: 'You’ve started this task 1 week ago | You’ve started this task {count} weeks ago, it may be time to abandon it, don’t you think?',
      dueOn: 'due on {date}',
      edit: 'Edit',
      markAsDone: 'Mark as done',
      markAsUndone: 'Mark as undone',
      plan: 'Plan for today',
      replan: 'Replan for today',
      restarted: 'You’ve restarted this task once | You’ve restarted this task {count} times, what about splitting or renaming it so it would be easier to achieve?',
      toggle: 'Toggle done',
    },

    list: {
      empty: 'There are no tasks here…',
    },

    layout: {
      backlog: 'Backlog',
      statistics: 'Statistics',
      title: 'Tasks',
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
      passwordLabel: 'Password',
      submit: 'Log in',
      register: 'Create an account',
      usernameLabel: 'Username',
    },

    loginLayout: {
      title: 'Log in',
    },

    registerForm: {
      emailLabel: 'Email',
      emailPlaceholder: 'john@doe.com',
      login: 'Have an account? Log in',
      submit: 'Create your account',
    },
  },
}
