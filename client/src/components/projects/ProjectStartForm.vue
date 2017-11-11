<template>
  <form @submit.prevent="start">
    <div v-if="isInError('Project')" class="form-errors">
      {{ getErrors('Project') }}
    </div>

    <form-group
      :label="$t('projects.startForm.nameLabel')"
    >
      <static-field :value="project.name" />
    </form-group>

    <form-group
      :label="$t('projects.startForm.dueLabel')"
      target="due-at"
      required
      :tip="getErrors('Project', 'dueAt') || $t('projects.startForm.dueTip')"
      :invalid="isInError('Project', 'dueAt')"
    >
      <date-field id="due-at" v-model="dueAt" required />
    </form-group>

    <form-group actions>
      <ly-button type="primary" submit>{{ $t('projects.startForm.submit') }}</ly-button>
      <ly-button @click="onCancel">{{ $t('projects.startForm.cancel') }}</ly-button>
    </form-group>
  </form>
</template>

<script>
  import moment from 'moment'
  import ErrorsHandler from 'src/components/mixins/ErrorsHandler'

  export default {
    mixins: [ErrorsHandler],

    props: {
      'project': { type: Object, required: true },
      'onSuccess': { type: Function, required: true },
      'onCancel': { type: Function, required: true },
    },

    data () {
      return {
        dueAt: moment().add(1, 'month').unix(),
      }
    },

    methods: {
      start () {
        this.$store
          .dispatch('projects/start', {
            project: this.project,
            dueAt: this.dueAt,
          })
          .then(this.onSuccess)
          .catch(this.setFailureErrors)
      },
    },
  }
</script>

<style lang="scss" scoped>
  .form-errors {
    margin-bottom: 20px;

    text-align: center;

    color: $color-danger;
  }
</style>
