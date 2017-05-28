<template>
  <form @submit.prevent="start">
    <div v-if="isInError('Project')" class="form-errors">
      {{ getErrors('Project') }}
    </div>

    <form-group
      :label="$t('forms.startProject.nameLabel')"
    >
      <static-field :value="project.name" />
    </form-group>

    <form-group
      :label="$t('forms.startProject.dueLabel')"
      target="due-at"
      required
      :tip="getErrors('Project', 'dueAt') || $t('forms.startProject.dueTip')"
      :invalid="isInError('Project', 'dueAt')"
    >
      <date-field id="due-at" v-model="dueAt" required />
    </form-group>

    <form-group actions>
      <btn submit>{{ $t('forms.startProject.submit') }}</btn>
      <btn type="cancel" @click="onCancel">{{ $t('forms.startProject.cancel') }}</btn>
    </form-group>
  </form>
</template>

<script>
  import moment from 'moment'
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    name: 'start-project-form',

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
