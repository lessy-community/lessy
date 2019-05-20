<template>
  <app-page v-if="resourcesReady" name="onboarding" layout="empty">
    <ly-text-container margined>
      <p class="text-secondary">
        {{ $t('onboarding.page.steps', { step, maxSteps }) }}
        <span v-if="step >= maxSteps">
          {{ $t('onboarding.page.end') }}
        </span>
        <span v-else-if="step >= maxSteps - 2">
          {{ $t('onboarding.page.almostEnd') }}
        </span>
      </p>

      <template v-if="step === 1">
        <h1>{{ $t('onboarding.page.step1.title') }}</h1>

        <profile-language-form light></profile-language-form>

        <p>
          {{ $t('onboarding.page.step1.intro') }}
        </p>
        <p>
          {{ $t('onboarding.page.step1.skipInfo') }}
        </p>
      </template>

      <template v-else-if="step === 2">
        <h1>{{ $t('onboarding.page.step2.title') }}</h1>

        <p>
          {{ $t('onboarding.page.step2.intro') }}
        </p>

        <ul>
          <li>{{ $t('onboarding.page.step2.advice.0') }}</li>
          <li>{{ $t('onboarding.page.step2.advice.1') }}</li>
          <li>{{ $t('onboarding.page.step2.advice.2') }}</li>
        </ul>

        <p>
          {{ $t('onboarding.page.step2.action') }}
        </p>

        <task-create-form auto-focus :main="tasks.length < 3"></task-create-form>

        <p>
          {{ $t('onboarding.page.step2.next') }}
        </p>
      </template>

      <template v-else-if="step === 3">
        <h1>{{ $t('onboarding.page.step3.title') }}</h1>

        <p>
          {{ $t('onboarding.page.step3.intro') }}
        </p>

        <task-list nopopover notoggle :tasks="tasks"></task-list>

        <p>
          {{ $t('onboarding.page.step3.live') }}
        </p>

        <p>
          {{ $t('onboarding.page.step3.indicator') }}
        </p>

        <ly-list stripped>
          <task-item :task="twoWeeksLateTask" nopopover notoggle nohandle></task-item>
          <task-item :task="threeWeeksLateTask" nopopover notoggle nohandle></task-item>
        </ly-list>

        <p>
          {{ $t('onboarding.page.step3.advice') }}
        </p>
      </template>

      <template v-else-if="step === 4">
        <h1>{{ $t('onboarding.page.step4.title') }}</h1>

        <p>
          {{ $t('onboarding.page.step4.intro') }}
        </p>

        <p>
          {{ $t('onboarding.page.step4.planning') }}
        </p>

        <div class="start-journey-placeholder">
          <ly-button
            :type="toggleStartJourneyNoop ? 'default' : 'primary'"
            icon="rocket"
            size="large"
            @click="toggleStartJourneyNoop = !toggleStartJourneyNoop"
          >
            {{ $t('onboarding.page.step4.startJourney') }}
          </ly-button>

          <p v-if="toggleStartJourneyNoop" class="text-secondary">
            {{ $t('onboarding.page.step4.startJourneyNoop') }}
          </p>
        </div>

        <p>
          {{ $t('onboarding.page.step4.ending') }}
        </p>
      </template>

      <template v-else-if="step === 5">
        <h1>{{ $t('onboarding.page.step5.title') }}</h1>

        <p>
          {{ $t('onboarding.page.step5.intro') }}
        </p>

        <p>
          {{ $t('onboarding.page.step5.what') }}
        </p>

        <p>
          {{ $t('onboarding.page.step5.bigTask') }}
        </p>

        <p>
          {{ $t('onboarding.page.step5.action') }}
        </p>

        <project-create-form
          nocancel
          autofocus
          :main="!defaultProject"
        ></project-create-form>

        <p class="text-secondary">
          {{ $t('onboarding.page.step5.note') }}
        </p>
      </template>

      <template v-else-if="step === 6">
        <h1>{{ $t('onboarding.page.step6.title') }}</h1>

        <p>
          {{ $t('onboarding.page.step6.intro') }}
        </p>

        <div class="running-project">
          <p v-if="runningProject">
            {{ $t('onboarding.page.step6.started') }}
          </p>
          <p v-else>
            {{ $t('onboarding.page.step6.start') }}
          </p>

          <project-card v-if="runningProject" :project="runningProject" nolink></project-card>
          <projects-start-new-form
            v-else
            :initialProject="defaultProject"
            autofocus
            nocancel
          ></projects-start-new-form>
        </div>

        <p>
          {{ $t('onboarding.page.step6.alwaysTasks') }}
        </p>

        <p>
          {{ $t('onboarding.page.step6.finish') }}
        </p>
      </template>

      <template v-else-if="step === 7">
        <h1>{{ $t('onboarding.page.step7.title') }}</h1>

        <p>
          {{ $t('onboarding.page.step7.intro') }}
        </p>

        <p>
          {{ $t('onboarding.page.step7.tool') }}
        </p>

        <p>
          {{ $t('onboarding.page.step7.community') }}

          <a href="https://github.com/lessy-community/lessy/blob/master/CONTRIBUTING.md#contributing-to-lessy">
            {{ $t('onboarding.page.step7.join') }}
          </a>
        </p>
      </template>

      <hr />

      <ly-form-group type="actions-block">
        <ly-button
          v-if="step === maxSteps"
          size="large"
          type="primary"
          @click="goHome"
          >
          {{ $t('onboarding.page.finish') }}
        </ly-button>

        <template v-else>
          <ly-button size="large" :type="buttonNextType" @click="next">
            {{ $t('onboarding.page.next') }}
          </ly-button>
          <ly-button type="default" @click="goHome">
            {{ $t('onboarding.page.skip') }}
          </ly-button>
        </template>
      </ly-form-group>
    </ly-text-container>
  </app-page>
  <loading-page v-else></loading-page>
</template>

<script>
  import { mapGetters } from 'vuex'

  import ResourcesLoader from '@/components/mixins/ResourcesLoader'

  import ProfileLanguageForm from '@/components/profile/ProfileLanguageForm'

  import TaskCreateForm from '@/components/tasks/TaskCreateForm'
  import TaskList from '@/components/tasks/TaskList'
  import TaskItem from '@/components/tasks/TaskItem'

  import ProjectCreateForm from '@/components/projects/ProjectCreateForm'
  import ProjectCard from '@/components/projects/ProjectCard'
  import ProjectsStartNewForm from '@/components/projects/ProjectsStartNewForm'

  export default {
    mixins: [ResourcesLoader],

    components: {
      ProfileLanguageForm,
      TaskCreateForm,
      TaskList,
      TaskItem,
      ProjectCreateForm,
      ProjectCard,
      ProjectsStartNewForm,
    },

    data () {
      return {
        maxSteps: 7,
        twoWeeksLateTask: {
          formattedLabel: this.$tc('onboarding.page.step3.tasksLabel', 2),
          startedSinceWeeks: 2,
        },
        threeWeeksLateTask: {
          formattedLabel: this.$tc('onboarding.page.step3.tasksLabel', 3),
          startedSinceWeeks: 3,
        },
        toggleStartJourneyNoop: false,
      }
    },

    computed: {
      ...mapGetters({
        tasks: 'tasks/listBacklog',
        projectsFuture: 'projects/listFuture',
        projectsInProgress: 'projects/listInProgress',
      }),

      step () {
        return parseInt(this.$route.params.step, 10)
      },

      defaultProject () {
        return this.projectsFuture[0]
      },

      runningProject () {
        return this.projectsInProgress[0]
      },

      buttonNextType () {
        if (
          (this.step === 2 && this.tasks.length < 3) ||
          (this.step === 4 && !this.toggleStartJourneyNoop) ||
          (this.step === 5 && this.defaultProject == null) ||
          (this.step === 6 && this.runningProject == null)
        ) {
          return 'default'
        } else {
          return 'primary'
        }
      },
    },

    methods: {
      next () {
        if (this.step < this.maxSteps) {
          this.$router.push(`/onboarding/${this.step + 1}`)
        }
      },

      goHome () {
        this.$router.push('/today')
      },
    },

    mounted () {
      if (this.step < 1 || isNaN(this.step)) {
        this.$router.push('/onboarding/1')
      }
      if (this.step > this.maxSteps) {
        this.$router.push(`/onboarding/${this.maxSteps}`)
      }
    },
  }
</script>

<style lang="scss">
  .app-page-onboarding .start-journey-placeholder {
    margin-bottom: 1rem;

    text-align: center;
  }
</style>
