<template>
  <form @submit.prevent="stop">
    <div v-if="isInError('Project')" class="form-errors">
      {{ getErrors('Project') }}
    </div>

    <form-group
      :label="$t('forms.finishProject.finishedLabel')"
      target="finished-at"
      required
      :tip="getErrors('Project', 'finishedAt') || $t('forms.finishProject.finishedTip')"
      :invalid="isInError('Project', 'finishedAt')"
    >
      <date-field id="finished-at" v-model="finishedAt" required />
    </form-group>

    <form-group actions vertical>
      <btn submit>{{ $t('forms.finishProject.submit') }}</btn>
      <btn type="cancel" @click="onCancel">{{ $t('forms.finishProject.cancel') }}</btn>
    </form-group>
  </form>
</template>

<script>
  import moment from 'moment'
  import ErrorsHandler from '../mixins/ErrorsHandler'

  export default {

    name: 'finish-project-form',

    mixins: [ErrorsHandler],

    props: {
      'project': { type: Object, required: true },
      'onSuccess': { type: Function, required: true },
      'onCancel': { type: Function, required: true },
    },

    data () {
      return {
        finishedAt: moment().unix(),
      }
    },

    methods: {
      stop () {
        this.$store
          .dispatch('projects/finish', {
            project: this.project,
            finishedAt: this.finishedAt,
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
