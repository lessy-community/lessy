<template>
  <ly-modal :title="$t('tasks.modals.completeDay.title')">
    <p>
      {{ $t('tasks.modals.completeDay.intro') }}
    </p>

    <p class="text-important">
      {{ summary }}
    </p>

    <p v-if="this.unfinishedCount > 0" class="text-secondary">
      {{ $t('tasks.modals.completeDay.unfinishedToBacklog') }}
    </p>

    <ly-button icon="check" type="primary" @click="$emit('complete')">
      {{ $t('tasks.modals.completeDay.ok') }}
    </ly-button>
    <ly-button @click="$emit('close')">
      {{ $t('tasks.modals.completeDay.cancel') }}
    </ly-button>
  </ly-modal>
</template>

<script>
  export default {
    props: {
      finishedCount: { type: Number, required: true },
      unfinishedCount: { type: Number, required: true },
    },

    computed: {
      summary () {
        if (this.unfinishedCount === 0 && this.finishedCount === 0) {
          return this.$t('tasks.modals.completeDay.summary.nothingPlanned')
        }
        if (this.unfinishedCount === 0 && this.finishedCount > 0) {
          return this.$t('tasks.modals.completeDay.summary.allDone')
        }
        if (this.unfinishedCount > 0 && this.finishedCount === 0) {
          return this.$t('tasks.modals.completeDay.summary.nothingDone')
        }
        if (this.unfinishedCount > 0 && this.finishedCount > 0) {
          return this.$tc('tasks.modals.completeDay.summary.neutral', this.finishedCount, {
            finishedCount: this.finishedCount,
            totalCount: this.finishedCount + this.unfinishedCount,
          })
        }
      },
    },
  }
</script>
