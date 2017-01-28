export default {
  fields: {
    password: {
      tip: 'Show password in plain text',
    },
  },

  forms: {
    activateUser: {
      passwordLabel: 'Password',
      submit: 'Activate my account',
      usernameLabel: 'Username',
      usernameTip: 'Only lowercase letters, underscore and dash',
    },

    createProject: {
      cancel: 'Cancel',
      submit: 'Create',
    },

    editProject: {
      cancel: 'Cancel',
      descriptionLabel: 'Description',
      descriptionTip: 'Description supports Markdown',
      dueLabel: 'Due on',
      nameLabel: 'Name',
      nameTip: 'Only lowercase letters, numbers, underscore and dash',
      submit: 'Validate',
    },

    finishProject: {
      cancel: 'No, I lied :(',
      finishedLabel: 'Finished on',
      finishedTip: 'It cannot be after today',
      submit: 'I did it!',
    },

    login: {
      passwordLabel: 'Password',
      submit: 'Login',
      usernameLabel: 'Username',
    },

    register: {
      emailLabel: 'Email',
      submit: 'Let me in',
    },

    startProject: {
      cancel: 'Cancel',
      dueLabel: 'Due on',
      nameLabel: 'Name',
      submit: 'Start it now',
    },
  },

  layout: {
    login: 'Login',
    logout: 'Logout',
    projectZero: 'Project Zero',

    project: {
      settings: 'Settings',
    },
  },

  pages: {
    activateUser: {
      intro: 'To continue, you have to pick a unique username and a password so you can login to your account later.',
      title: 'Activate your account',
    },

    dashboard: {
      activationInstructions: 'We sent you an email at {email}.<br />Follow its instructions to be able to access your projects later.',
      createProject: '+ create a project',
      dueOn: 'Due on <b>{date}</b>',
      finishedLabel: '(finished on {date})',
      hideFinishedProjects: 'Hide your project | Hide your projects',
      projectsPlaceholder: "You don't have any project yet, what are you working on?",
      seeFinishedProjects: 'See your finished project | See your {count} finished projects',
      stoppedOn: '(stopped on {date})',
    },

    error: {
      title: 'Oops…',
    },

    home: {
      intro: 'A new era begins for the project managers.',
      title: 'Welcome on Project Zero!',
    },

    loading: {
      inProgress: 'Loading in progress…',
    },

    login: {
      title: 'Login',
    },

    notFound: {
      home: 'Home page',
      intro: "It looks like this page doesn't exist…",
      title: 'Page not found',
    },

    projects: {
      finish: {
        intro: "Really? You've finished <b>{projectName}</b>? That's great!<br />Let us know when you finished it:",
      },

      show: {
        askEdit: 'Edit?',
        confirmStop: 'Oh? The project will be marked as stopped. Can you confirm?',
        dueLabel: 'Due on',
        finishedLabel: 'Finished on',
        finishProject: 'Finish it',
        noDescription: 'There is no description for this project yet.',
        reachedMaxInProgress: 'You already reached the maximum of started projects',
        startedLabel: 'Started on',
        startProject: 'Start this project',
        stoppedLabel: 'Stopped on',
        stopProject: 'Stop it, now',
      },
    },
  },
}
