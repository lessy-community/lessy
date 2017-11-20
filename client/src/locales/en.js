export default {
  app: {
    appHeader: {
      logout: 'Logout',
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
    Project: {
      base: {
        already_finished: 'This project has already been finished',
        already_started: 'This project has already been started',
        already_stopped: 'This project has already been stopped',
        missing: 'Project is required. It may be an application’s problem, please contact developers.',
        not_found: 'Project does not exist',
        reached_max_started: 'You cannot start more than three projects',
      },
      dueAt: {
        before_started_at: 'The due date cannot be set before the started date',
        missing: 'Due date is required',
      },
      finishedAt: {
        missing: 'Finished date is required',
        outside_started_at_and_today: 'Finished date must be between started date and today',
      },
      name: {
        blank: 'Name is required',
        invalid: 'Name does not match required pattern (only letters, numbers, underscores and hiphens are accepted)',
        missing: 'Name is required',
        taken: 'This name is not available',
        too_long: 'Name is too long (max 100 caracters)',
      },
    },

    Task: {
      label: {
        missing: 'Label is missing',
      },
    },

    User: {
      base: {
        login_failed: 'Oops we failed to log you, it seems your credentials were wrong…',
        missing: 'User is required. It may be an application’s problem, please contact developers.',
        not_found: 'User does not exist',
      },
      email: {
        missing: 'Email is required',
        taken: 'This email address is not available',
      },
      password: {
        missing: 'Password is required',
      },
      username: {
        exclusion: 'Username is a reserved word',
        invalid: 'Username does not match required pattern (only lowercase letters, underscore and hiphen are accepted)',
        missing: 'Username is required',
        taken: 'This username is not available',
        too_long: 'Username is too long (max 25 caracters)',
      },
    },
  },

  fields: {
    password: {
      reveal: 'Reveal',
    },
  },

  general: {
    defaultMenu: {
      dashboard: 'Dashboard',
      projects: 'Projects',
      tasks: 'Tasks',
    },

    homeLayout: {
      intro: 'A new era begins for the project managers.',
      title: 'Welcome on Lessy!',
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
      nameTip: 'Only letters, numbers, underscores (_) and hiphens (-)',
    },

    editForm: {
      cancel: 'Cancel',
      descriptionLabel: 'Description',
      descriptionTip: 'Description supports Markdown',
      dueLabel: 'Due on',
      nameLabel: 'Name',
      nameTip: 'Only letters, numbers, underscores (_) and hiphens (-)',
      submit: 'Validate',
    },

    finishForm: {
      cancel: 'No, I did not yet',
      finishedLabel: 'Finished on',
      finishedTip: 'It cannot be after today',
      submit: 'I did it!',
    },

    finishPage: {
      intro: "Really? You've finished <b>{projectName}</b>? That's great!<br />Let us know when you finished it:",
    },

    inboxPage: {
      createProject: 'Create a project',
      finishedLabel: '(finished on {date})',
      finishedProjects: 'Finished projects',
      futureProjects: 'Future projects',
      hideFinishedProjects: 'Hide your project | Hide your projects',
      projectsPlaceholder: "You don't have any project yet, what are you working on?",
      seeFinishedProjects: 'See your finished project | See your {count} finished projects',
      stoppedOn: '(stopped on {date})',
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
      dueTip: 'The due date have to be after today',
      nameLabel: 'Name',
      submit: 'Start it now',
    },

    timeline: {
      confirmPause: 'The project will be marked as paused. Can you confirm?',
      diff: '{days} day | {days} days',
      dueOn: 'Due on {date}',
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
      warningTooMany: 'It can be difficult to achieve all our tasks when we have too much to do.',
    },

    editForm: {
      cancel: 'Cancel',
      submit: 'Update',
    },

    item: {
      abandon: 'Abandon',
      confirmAbandon: 'Oh? The task will be marked as abandoned and will disappear from the list. Can you confirm?',
      createdSinceWeeks: 'You’ve created this task 1 week ago | You’ve created this task {count} weeks ago, it may be time to abandon it, don’t you think?',
      dueOn: 'due on {date}',
      edit: 'Edit',
      markAsDone: 'Mark as done',
      markAsUndone: 'Mark as undone',
      more: 'Additional actions',
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
      usernameTip: 'Only lowercase letters, underscore and dash',
    },

    activateLayout: {
      intro: 'To continue, you have to pick a unique username and a password so you can login to your account later.',
      title: 'Activate your account',
    },

    loginForm: {
      passwordLabel: 'Password',
      submit: 'Login',
      usernameLabel: 'Username',
    },

    loginLayout: {
      title: 'Login',
    },

    registerForm: {
      emailLabel: 'Email',
      login: 'login',
      or: 'or',
      submit: 'Create your account',
    },
  },
}
