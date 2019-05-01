<template>
  <ly-modal
    :title="$t('tasks.modals.confirmAbandonTitle')"
    @close="$emit('close')"
  >
    <p>
      {{ $t('tasks.modals.confirmAbandon', { label: task.label }) }}
    </p>

    <ly-form-group type="actions">
      <ly-button type="primary" @click="abandon">
        {{ $t('tasks.modals.submitAbandon') }}
      </ly-button>
      <ly-button @click="$emit('close')">
        {{ $t('tasks.modals.cancel') }}
      </ly-button>
    </ly-form-group>
  </ly-modal>
</template>

<script>
  export default {
    props: {
      task: { type: Object, required: true },
    },

    methods: {
      abandon () {
        const { task } = this
        this.$store
          .dispatch('tasks/abandon', { task })
          .then(() => this.$emit('close'))
      },
    },
  }
</script>
