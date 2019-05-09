<template>
  <div class="tasks-complete-day">
    <p>
      {{ $t('tasks.completeDay.intro') }}
    </p>

    <p class="text-important">
      {{ summary }}
    </p>

    <p v-if="this.unfinishedCount > 0" class="text-secondary">
      {{ $t('tasks.completeDay.unfinishedToBacklog') }}
    </p>

    <ly-button icon="check" type="primary" @click="$emit('complete')">
      {{ $t('tasks.completeDay.ok') }}
    </ly-button>
    <ly-button @click="$emit('cancel')">
      {{ $t('tasks.completeDay.cancel') }}
    </ly-button>
  </div>
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
          return this.$t('tasks.completeDay.summary.nothingPlanned')
        }
        if (this.unfinishedCount === 0 && this.finishedCount > 0) {
          return this.$t('tasks.completeDay.summary.allDone')
        }
        if (this.unfinishedCount > 0 && this.finishedCount === 0) {
          return this.$t('tasks.completeDay.summary.nothingDone')
        }
        if (this.unfinishedCount > 0 && this.finishedCount > 0) {
          return this.$tc('tasks.completeDay.summary.neutral', this.finishedCount, {
            finishedCount: this.finishedCount,
            totalCount: this.finishedCount + this.unfinishedCount,
          })
        }
      },
    },
  }
</script>
