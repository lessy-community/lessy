<template>
  <ly-form @submit="start" :error="getErrors()">
    <ly-form-group>
      <ly-form-select
        name="projectId"
        v-model="projectId"
        :options="options"
        :label="$t('projects.startNewForm.projectLabel')"
        ref="projectIdInput"
        required
      ></ly-form-select>
    </ly-form-group>

    <ly-form-group>
      <ly-form-input
        type="date"
        name="due-at"
        v-model="dueAt"
        :label="$t('projects.startNewForm.dueLabel')"
        :caption="$t('projects.startNewForm.dueCaption')"
        :error="getErrors('/project/due_at')"
        required
      ></ly-form-input>
    </ly-form-group>

    <ly-form-group type="actions">
      <ly-button type="primary" submit>
        {{ $t('projects.startNewForm.submit') }}
      </ly-button>
      <ly-button @click="$emit('cancel')">
        {{ $t('projects.startNewForm.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-form>
</template>

<script>
  import { mapGetters } from 'vuex'
  import { objectsToOptions } from 'src/utils'
  import moment from 'moment'
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      autofocus: { type: Boolean },
    },

    data () {
      return {
        projectId: null,
        dueAt: moment().add(2, 'week').unix(),
      }
    },

    computed: {
      ...mapGetters({
        projects: 'projects/listFuture',
        projectByIds: 'projects/findById',
      }),

      options () {
        return objectsToOptions(this.projects, 'id', 'name')
      },

      project () {
        return this.projectByIds(this.projectId)
      },
    },

    methods: {
      start () {
        this.$store
          .dispatch('projects/start', {
            project: this.project,
            dueAt: this.dueAt,
          })
          .then(() => this.$emit('success', this.project))
          .catch(this.setFailureErrors)
      },
    },

    mounted () {
      if (this.autofocus) {
        this.$refs.projectIdInput.focus()
      }
    },
  }
</script>
