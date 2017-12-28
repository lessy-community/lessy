<template>
  <ly-form @submit="submit" :error="getErrors()">
    <ly-form-group>
      <ly-form-select
        name="projectId"
        v-model="projectId"
        :options="options"
        :label="$t('tasks.attachProjectForm.projectLabel')"
        :error="getErrors('/tasks/projectId')"
        ref="projectIdInput"
      ></ly-form-select>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" submit>
        {{ $t('tasks.attachProjectForm.submit') }}
      </ly-button>
      <ly-button @click="$emit('cancel')">
        {{ $t('tasks.attachProjectForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import { mapGetters } from 'vuex'
  import { objectsToOptions } from 'src/utils'
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      'task': { type: Object, required: true },
      'autofocus': { type: Boolean },
    },

    data () {
      return {
        projectId: this.task.projectId,
      }
    },

    computed: {
      ...mapGetters({
        startedProjects: 'projects/listInProgress',
        notStartedProjects: 'projects/listNotStarted',
      }),

      options () {
        return [
          ...objectsToOptions(this.startedProjects, 'id', 'name'),
          ...objectsToOptions(this.notStartedProjects, 'id', 'name'),
        ]
      },
    },

    methods: {
      submit () {
        this.$store
          .dispatch('tasks/update', {
            task: this.task,
            projectId: this.projectId,
          })
          .then((taskId) => {
            this.cleanErrors()
            this.$emit('success')
          })
          .catch((failure) => {
            this.setFailureErrors(failure)
            this.$refs.projectIdInput.focus()
          })
      },
    },

    mounted () {
      if (this.autofocus) {
        this.$refs.projectIdInput.focus()
      }
    },
  }
</script>
