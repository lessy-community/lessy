export default {
  dashboard: {
    page: {
      activationInstructions: 'Nous avons envoyé un courriel à {email}.<br />Suivez les instructions qui s’y trouvent pour avoir accès à vos projets par la suite.',
      createdTasks: 'tâches créées',
      finishedTasks: 'tâches terminées',
      projectsInProgress: 'Projets en cours',
      noTasks: 'Il n’y a aucune tâche à afficher…',
      resendActivationInstructions: 'Renvoyer les instructions',
      resendActivationInstructionsDone: 'Fait',
      tasksHistory: 'Historique des tâches',
      title: 'Tableau de bord',
    },
  },

  errors: {
    _: {
      login_failed: 'Oups ! Nous n’avons pas pu vous connecter, vos identifiants ne semblent pas valides.',
      missing_endpoint: 'Il semble que vous tentiez d’accéder à des ressources inconnues. Vous n’y êtes probablement pour rien et nous en sommes désolés. Nous faisons de notre mieux pour régler ce problème au plus vite !',
      registration_disabled: 'Les inscriptions ont été désactivées, vous n’êtes pas autorisé à vous créer un compte.',
      tos_not_accepted: 'Les conditions d’utilisation du service ont évolué. Veuiller rafraîchir la page pour continuer.',
      unauthorized: 'Vous n’avez pas la permission d’effectuer cette action, veuillez rafraîchir la page et vous reconnecter.',
    },

    project: {
      parameter_missing: 'Un projet est nécessaire.',
      record_not_found: 'Le projet n’a pas été trouvé.',

      due_at: {
        cannot_be_before_started_at: 'La date d’échéance ne peut précéder la date d’aujourd’hui.',
        cannot_be_set: 'La date d’échéance ne peut pas être indiquée pour le moment.',
        must_be_set: 'La date d’échéance est nécessaire.',
        parameter_missing: 'La date d’échéance est nécessaire.',
      },

      finished_at: {
        cannot_be_after_today: 'La date de fin ne peut être au-delà de la date d’aujourd’hui.',
        cannot_be_before_started_at: 'La date d’échéance ne peut pas précéder la date de début de tâche.',
        cannot_be_set: 'La date de fin ne peut pas être indiquée pour le moment.',
        must_be_set: 'La date de fin est nécessaire.',
        parameter_missing: 'La date de fin est nécessaire.',
      },

      name: {
        blank: 'Le nom est nécessaire.',
        parameter_missing: 'Le nom est nécessaire.',
        too_long: 'Le nom est trop long (100 caractères maximum).',
      },

      slug: {
        invalid: 'Quelque chose s’est mal passé lors de l’enregistrement du projet, son nom contient-il des caractères particuliers ? Veuillez essayer avec un autre nom.',
        taken: 'Ce nom est proche de celui d’un autre projet, veuillez en essayer un autre.',
      },

      state: {
        invalid_transition: 'Vous tentez d’accomplir une action que vous ne devriez pas pouvoir faire normalement, nous en sommes désolé·es !',
        reached_max_started: 'Vous ne pouvez pas démarrer plus que trois projets.',
      },
    },

    task: {
      parameter_missing: 'Une tâche est nécessaire.',
      record_not_found: 'La tâche n’a pas été trouvée.',

      label: {
        parameter_missing: 'Le libellé est nécessaire.',
      },

      state: {
        invalid_transition: 'Vous tentez d’accomplir une action que vous ne devriez pas pouvoir faire normalement, nous en sommes désolé·es !',
      },
    },

    user: {
      parameter_missing: 'Un utilisateur/une utilisatrice est nécessaire.',
      record_not_found: 'L’utilisateur/utilisatrice n’a pas été trouvé·e.',
      user_inactive: 'Votre compte n’a jamais été activé.',

      email: {
        parameter_missing: 'Le nom d’utilisateur/utilisatrice est nécessaire.',
        taken: 'Un compte existe déjà avec cette adresse courriel.',
      },

      password: {
        parameter_missing: 'Un nom d’utilisateur/utilisatrice est nécessaire.',
      },

      username: {
        exclusion: 'Ce nom d’utilisateur/utilisatrice est un mot réservé.',
        invalid: 'Le nom d’utilisateur/utilisatrice ne remplit pas les conditions demandées.',
        parameter_missing: 'Un nom d’utilisateur/utilisatrice est nécessaire.',
        taken: 'Ce nom d’utilisateur/utilisatrice n’est pas disponible.',
        too_long: 'Ce nom d’utilisateur/utilisatrice est trop long (max. 25 caractères).',
      },
    },
  },

  general: {
    homePage: {
      browserTitle: 'Bienvenue',
      title: 'Maîtrisez votre temps',
      intro: 'Concentrez vos efforts sur ce qui est vraiment essentiel, ne dites plus jamais « Je n’ai pas le temps ».',

      registrationDisabled: 'Malheureusement, les inscriptions sont <strong>fermées</strong> pour le moment.',
      login: 'Vous avez déjà un compte ? Connectez-vous',

      detailsTitle: 'Un gestionnaire de temps éthique et respectueux',
      timeTitle: 'Le temps est une ressource précieuse',
      timeDetails: 'Le temps perdu ne se rattrape pas mais il n’est jamais trop tard pour l’utiliser du mieux possible. Si vous trouvez qu’il est temps de modifier un peu vos habitudes, Lessy va justement vous aider à avancer sur cette voie.',
      lessTitle: 'Moins de charge cognitive, moins de stress',
      lessDetails: 'Lessy vous aide dans vos habitudes quotidiennes en vous présentant ce que vous pouvez probablement faire en premier.<br />Vous êtes déjà exténué·e de votre journée ? Ne vous en faites pas, chacun va à son rythme et Lessy le prend en compte.',
      communityTitle: 'Créé par une communauté ouverte',
      communityDetails: 'Votre temps est trop précieux pour être confié à des entreprises privées. Lessy est un logiciel libre créé par une communauté accueillante d’utilisateurs et utilisatrices qui partagent vos préoccupations.<br /><a href="https://github.com/lessy-community/lessy/blob/master/CONTRIBUTING.md"> Vous aussi, participez au projet Lessy pour le rendre encore meilleur !</a>',

      moreTitle: 'Aller plus loin',
      exploreTitle: 'Explorer le code source',
      exploreDetails: 'parce que Lessy est <a href="https://github.com/lessy-community/lessy/blob/master/LICENSE">un logiciel libre</a> et le sera toujours.',
      hostTitle: 'Hébergez-le',
      hostDetails: 'Vos données vous appartiennent et nous ne souhaitons pas qu’elles soient stockées dans un service centralisé.',
      donateTitle: 'Faire un don',
      donateDetails: 'Cela nous aidera à maintenir le service ouvert pour tout le monde.',

      madeWithLove: 'Créé avec ♥ par de supers <a href="https://github.com/lessy-community/lessy/blob/master/CONTRIBUTORS.md">contributeurs et contributrices</a>.',
      greetings: 'Passez une bonne journée !',
    },

    loadingPage: {
      reset: 'Réinitialiser votre session',
      title: 'Chargement en cours…',
      tooLong: 'Le chargement prend beaucoup de temps. Il est parfois utile de réinitialiser votre session et de vous reconnecter.',
      wait: '— Asseyez-vous et détendez-vous —',
    },

    notFoundPage: {
      home: 'Accueil',
      intro: 'Vous venez de vous perdre. Mais pas d’inquiétude, l’accueil n’est pas bien loin…',
      title: 'Page introuvable',
    },

    sudoModal: {
      cancel: 'Annuler',
      intro: 'Nous devons vérifier votre identité, merci d’entrer votre mot de passe actuel pour continuer.',
      more: 'Vous entrez en mode « sudo ». Nous ne vous demanderons plus votre mot de passe pour les 15 prochaines minutes.',
      passwordLabel: 'Mot de passe',
      submit: 'Confirmer',
      title: 'Vérification d’identité',
    },

    termsOfServicePage: {
      accept: 'J’ai lu et accepte les conditions',
      changed: 'Les conditions d’utilisation du service ont changé, veuillez les lire avec attention.',
      goBack: 'Revenir à la page principale',
      loading: 'Chargement en cours, veuillez patienter…',
      title: 'Conditions d’utilisation du service',
      version: 'Version : {version}',
    },

    termsOfServiceModal: {
      intro: 'Hey là ! Nos conditions d’utilisation ont récemment été modifiées. Nous voulons nous assurer que vous les avez lues et que vous comprenez leur implication.',
      mustAccept: 'Afin de continuer à utiliser ce service, vous devez accepter ces nouvelles conditions.',
      read: 'Lire les conditions d’utilisation',
      title: 'Conditions d’utilisation du service',
    },
  },

  layouts: {
    application: {
      brand: 'Lessy',
      dashboard: 'Tableau de bord',
      projects: 'Projets',
      tasks: 'Tâches',
      today: 'Aujourd’hui',
    },

    default: {
      brand: 'Lessy',
    },

    empty: {
      brand: 'Lessy',
    },

    singleForm: {
      brand: 'Lessy',
    },

    profile: {
      backToApp: 'Retour à l’application',
      brand: 'Lessy',
      profile: 'Profil',
      title: 'Profil',
    },
  },

  ly: {
    form: {
      input: {
        optional: 'facultatif',
        revealPassword: 'Montrer',
      },

      select: {
        change: 'Changer',
        noOptions: 'Le filtre ne correspond à aucune option',
        unselect: 'Désélectionner',
      },
    },
  },

  profile: {
    deleteAccount: {
      submit: 'Supprimez votre compte',
      understand: 'Je comprends',
      understandLabel: 'Saisissez « Je comprends » pour pouvoir supprimer votre compte',
      warn: '<strong>Attention</strong>, vous ne pourrez pas annuler la suppression de votre compte et toutes vos données seront perdues.',
    },

    identityEditForm: {
      emailLabel: 'Email',
      passwordLabel: 'Nouveau mot de passe',
      saved: 'Enregistré !',
      submit: 'Modifiez votre identité',
      usernameCaption: 'Utilisez seulement des minuscules, le caractère soulignement et/ou le trait d’union (25 caractères maximum).',
      usernameLabel: 'Nom d’utilisateur/utilisatrice',
    },

    languageForm: {
      languageLabel: 'Langue de l’interface',
      saved: 'Enregistré !',
    },

    page: {
      account: 'Compte',
      activationInstructions: 'Certaines sections du profil ne sont pas activées car vous devez d’abord activer votre compte. Nous avons envoyé un courriel à {email}.<br />Suivez les instructions qui s’y trouvent pour avoir accès à vos projets par la suite.',
      identity: 'Identité',
      language: 'Langue',
      password: 'Mot de passe',
      resendActivationInstructions: 'Renvoyer les instructions',
      resendActivationInstructionsDone: 'Fait',
      timeZone: 'Fuseau horaire',
    },

    passwordNewForm: {
      passwordLabel: 'Nouveau mot de passe',
      saved: 'Enregistré !',
      submit: 'Changez votre mot de passe',
    },

    timeZoneForm: {
      autodetect: 'Configurer automatiquement',
      autodetectInfo: 'Nous avons détecté que votre fuseau horaire actuel est différent de celui défini par votre système d’exploitation. Il est vivement recommandé de les synchroniser.',
      saved: 'Enregistré !',
      timeZoneCaption: 'Nous utilisons votre fuseau horaire pour manipuler les dates correctement.',
      timeZoneLabel: 'Nouveau fuseau horaire',
      timeZonePlaceholder: 'Europe/Paris',
    },
  },

  projects: {
    card: {
      shouldAddTasks: 'Des tâches devraient être associées pour vous assurer que le projet avance.',
      tasksCount: '{finishedCount} / {totalCount} tâche | {finishedCount} / {totalCount} tâche | {finishedCount} / {totalCount} tâches',
    },

    cardDeck: {
      empty: 'Aucun projet',
      emptyLink: 'Démarrer un projet existant',
    },

    createForm: {
      cancel: 'Annuler',
      submit: 'Créer',
      nameCaption: 'Maximum 100 caractères.',
      placeholder: 'Vacances à Paris',
    },

    editForm: {
      cancel: 'Annuler',
      descriptionLabel: 'Description',
      descriptionCaption: 'La description peut être rédigée en Markdown',
      dueLabel: 'Date d’échéance',
      nameLabel: 'Nom',
      nameCaption: 'Maximum 100 caractères.',
      submit: 'Valider',
    },

    finishForm: {
      cancel: 'Annuler',
      finishedLabel: 'Terminé le',
      finishedCaption: 'Cette date ne peut pas être après la date d’aujourd’hui',
      submit: 'Terminer le projet',
    },

    item: {
      pausedOn: 'mis en pause le {date}',
      tasksCount: '{finishedCount} / {totalCount} tâche | {finishedCount} / {totalCount} tâche | {finishedCount} / {totalCount} tâches',
    },

    itemFinished: {
      finishedLabel: 'terminé le {date}',
      tasksCount: '{finishedCount} / {totalCount} tâche | {finishedCount} / {totalCount} tâche | {finishedCount} / {totalCount} tâches',
    },

    header: {
      title: 'Projets',
    },

    modals: {
      deleteTitle: 'Supprimer un projet',
      deleteIntro: 'Êtes-vous certain·e de vouloir supprimer le projet « {projectName} » ? Les tâches associées seront abandonnées et vous ne pourrez plus y accéder.',
      deleteConfirm: 'Supprimer le projet',
      deleteCancel: 'Annuler',

      editDueDateTitle: 'Modifier la date d’échéance',
      finishTitle: 'Terminer le projet',
      finishIntro: 'Vous avez achevé le projet « {projectName} » ? Cool ! Dites-nous quand vous l’avez terminé :',
      startNewTitle: 'Démarrer un projet',
      startTitle: 'Démarrer le projet',
    },

    page: {
      createProject: 'Créer un projet',
      finishedProjects: 'Projets terminés',
      futureProjects: 'Projets à venir',
      projectsInProgress: 'Projets en cours',
      projectsPlaceholder: 'Vous n’avez encore aucun projet, sur quoi travaillez-vous ?',
    },

    showPage: {
      associatedTasks: 'Tâches associées',
      delete: 'Supprimer',
      edit: 'Modifier',
      finishedTasks: 'Tâches terminées',
      noDescription: 'Ce projet n’a pas encore de description.',
      timeline: 'Chronologie',
    },

    startForm: {
      cancel: 'Annuler',
      dueLabel: 'Date d’échéance',
      dueCaption: 'La date d’échéance doit être postérieure à la date d’aujourd’hui',
      nameLabel: 'Nom',
      submit: 'Démarrer maintenant',
    },

    startNewForm: {
      cancel: 'Annuler',
      dueLabel: 'Date d’échéance',
      dueCaption: 'La date d’échéance doit être postérieure à la date d’aujourd’hui',
      noProjects: 'Vous n’avez encore aucun projet, commençons par en créer un !',
      projectLabel: 'Projet',
      submit: 'Démarrer le projet',
    },

    timeline: {
      diff: '{days} jour | {days} jours',
      dueOn: 'échéance le {date}',
      dueOnEdit: 'Modifier la date d’échéance',
      dueToday: 'échéance aujourd’hui',
      finish: 'Terminer',
      finishedOn: 'terminé le {date}',
      late: 'en retard',
      notStarted: 'pas débuté',
      pause: 'Mettre en pause',
      pausedOn: 'mis en pause le {date}',
      reachedMaxInProgress: 'Vous avez déjà atteint le nombre maximum de projets entamés.',
      restart: 'Démarrer à nouveau',
      start: 'Démarrer',
      startedOn: 'Débuté le {date}',
      untilDueDate: 'avant la date d’échéance',
    },
  },

  tasks: {
    attachProjectForm: {
      cancel: 'Annuler',
      projectLabel: 'Projet',
      submit: 'Attacher',
    },

    chart: {
      created: 'tâches créées',
      finished: 'tâches terminées',
    },

    completeDay: {
      addFinishedTasks: 'Si vous avez terminé d’autres tâches durant la journée, vous pouvez les ajouter maintenant.',
      cancel: 'Continuer de travailler',
      intro: 'C’est la fin de journée, vous avez mérité de prendre un peu de repos.',
      ok: 'Terminer',
      summary: {
        allDone: 'Vous avez terminé toutes les tâches que vous aviez planifiées, bravo !',
        neutral: 'Vous avez terminé {finishedCount} tâche sur {totalCount}. | Vous avez terminé {finishedCount} tâches sur {totalCount}.',
        nothingDone: 'Vous n’avez terminé aucune tâche aujourd’hui, tant pis !',
        nothingPlanned: 'Vous n’aviez rien planifié aujourd’hui, c’est bien aussi !',
      },
      unfinishedToBacklog: 'Les tâches que vous n’avez pas terminées seront disponibles demain dans la liste d’attente.',
    },

    createForm: {
      cancel: 'Annuler',
      created: 'Créée',
      submit: 'Créer',
      warningTooMany: 'Vous pourriez rencontrer des difficultés pour mener à bien les tâches si vous tentez d’en entreprendre un trop grand nombre.',
      placeholder: 'Promener le chien',
    },

    editForm: {
      cancel: 'Annuler',
      submit: 'Mettre à jour',
    },

    indicators: {
      replanned: 'Vous avez déjà planifié cette tâche une fois | Vous avez planifié cette tâche {count} fois, que pensez-vous de l’idée de la scinder en plusieurs parties ou de la renommer afin qu’elle soit plus facile à accomplir ?',
      startedSinceWeeks: 'Vous avez créé cette tâche il y a une semaine | Vous avez créé cette tâche il y a {count} semaines, peut-être est-il temps de l’abandonner, qu’en pensez-vous ?',
      week: '{count}s',
    },

    item: {
      abandon: 'Abandonner',
      attachToProject: 'Attacher à un projet',
      edit: 'Modifier',
      markAsDone: 'Marquer comme effectuée',
      markAsUndone: 'Marquer comme à faire',
      transformInProject: 'Transformer en projet',
      unplan: 'Annuler la planification',
    },

    list: {
      empty: 'Aucune tâche ici…',
    },

    modals: {
      attachProjectTitle: 'Attacher la tâche à un projet',
      cancel: 'Annuler',
      confirmAbandon: 'La tâche « {label} » sera marquée comme abandonnée et disparaîtra de la liste. Confirmez-vous ?',
      confirmAbandonTitle: 'Abandonner la tâche',
      orPickFromBacklog: 'ou sélectionnez-en une depuis votre liste d’attente',
      planTitle: 'Planifiez une tâche pour aujourd’hui',
      submitAbandon: 'Confirmer l’abandon',
      transformInProjectTitle: 'Transformer la tâche en projet',
    },

    page: {
      tasksNumber: '0 tâche en liste d’attente | 1 tâche en liste d’attente | {count} tâches en liste d’attente',
      title: 'Tâches',
    },

    planner: {
      additionalTask: 'Les tâches que vous allez planifier à partir de maintenant ne doivent pas être critiques pour votre journée.',
      additionalMostImportantTask: 'Il doit s’agir de l’une des tâches les plus importantes à réaliser pour vous aujourd’hui.',
      allFinished: 'Vous avez terminé toutes vos tâches, bien joué !',
      empty: 'Vous n’avez pas encore planifié de tâche.',
      firstMostImportantTask: 'Il doit s’agir de la tâche la plus importante à réaliser pour vous aujourd’hui, choisissez-là avec soin.',
      importantTaskPlaceholder: [
        'Planifiez la seconde tâche la plus importante de votre journée… | Planifiez la troisième tâche la plus importante de votre journée.',
        '… et la troisième.',
      ],
      planTask: 'Planifier une tâche',
      startJourney: 'Démarrer votre journée',
      tasksForToday: '{count} tâche pour aujourd’hui | {count} tâche pour aujourd’hui | {count} tâches pour aujourd’hui',
      tasksFinishedToday: '{count} tâche terminée aujourd’hui | {count} tâche terminée aujourd’hui | {count} tâches terminées aujourd’hui',
    },
  },

  today: {
    page: {
      dayCompleted: 'Votre journée est terminée, passez une bonne soirée !',
      finishDay: 'Terminer votre journée',
      title: 'Aujourd’hui',
    },
  },

  users: {
    activateForm: {
      passwordLabel: 'Mot de passe',
      submit: 'Activez votre compte',
      usernameLabel: 'Nom d’utilisateur/utilisatrice',
      usernameCaption: 'Utilisez seulement des minuscules, le caractère soulignement et/ou le trait d’union (25 caractères maximum).',
    },

    activatePage: {
      intro: 'Pour continuer, vous devez choisir un nom d’utilisateur/utilisatrice unique et un mot de passe qui vous permettront vous connecter à votre compte par la suite.',
      title: 'Activez votre compte',
    },

    loginForm: {
      passwordForgotten: 'Mot de passe oublié ?',
      passwordLabel: 'Mot de passe',
      submit: 'Se connecter',
      register: 'Créer un compte',
      usernameLabel: 'Nom d’utilisateur/utilisatrice',
    },

    loginPage: {
      title: 'Se connecter',
    },

    passwordNewForm: {
      passwordLabel: 'Mot de passe',
      submit: 'Changez votre mot de passe',
    },

    passwordNewPage: {
      intro: 'Vous êtes sur le point de changer votre mot de passe. Une fois cela fait, vous serez connecté et redirigé vers le tableau de bord.',
      title: 'Changez votre mot de passe',
    },

    passwordResetForm: {
      emailLabel: 'Email',
      login: 'Vous vous souvenez de votre mot de passe ?',
      register: 'Créer un compte',
      submit: 'Réinitialisez votre mot de passe',
    },

    passwordResetPage: {
      accountInactive: 'Vous n’avez pas activé votre compte et nous ne pouvons pas réinitialiser votre mot de passe. Avez-vous bien reçu le mail contenant les instructions d’activation ?',
      emailIntro: 'Veuillez entrer l’adresse email de votre compte afin de vous envoyer un lien permettant de réinitialiser votre mot de passe.',
      emailSentTo: 'Nous venons de vous envoyer un lien à l’adresse {email} afin que vous puissiez vous définir un nouveau mot de passe. Si vous ne recevez pas d’email, veuillez vérifier vos spams.',
      login: 'Vous vous souvenez de votre mot de passe ?',
      resendActivationInstructions: 'Renvoyer les instructions',
      resendActivationInstructionsDone: 'Fait',
      title: 'Réinitialisez votre mot de passe',
    },

    popover: {
      administration: 'Administrer',
      logout: 'Se déconnecter',
      profile: 'Modifier le profil',
    },

    registerForm: {
      emailLabel: 'Adresse courriel',
      emailPlaceholder: 'dupuis@morizeau.com',
      login: 'Vous avez déjà un compte ? Connectez-vous',
      submit: 'Créez votre compte',
      tosMustAccept: 'En cliquant sur “Créez votre compte”, vous acceptez nos',
      tosLink: 'conditions d’utilisation',
    },
  },
}
