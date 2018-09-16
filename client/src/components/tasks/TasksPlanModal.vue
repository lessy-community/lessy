<template>
  <ly-modal :title="$t('tasks.modals.planTitle')" width="large">
    <p v-if="intro" class="text-secondary">
      {{ intro }}
    </p>

    <task-create-form
      :plannedAt="plannedAt"
      :onCancel="() => { this.$emit('close') }"
      :onSuccess="() => { this.$emit('close') }"
      autoFocus
    ></task-create-form>

    <ly-section v-if="tasks.length > 0" :title="$t('tasks.modals.orPickFromBacklog')">
      <task-select-list
        :tasks="tasks"
        @select="startTask"
      ></task-select-list>
    </ly-section>
  </ly-modal>
</template>

<script>
  import moment from 'moment'

  import { mapGetters } from 'vuex'

  import TaskCreateForm from 'src/components/tasks/TaskCreateForm'
  import TaskSelectList from './TaskSelectList'

  export default {
    props: {
      intro: { type: String }
    },

    components: {
      TaskCreateForm,
      TaskSelectList,
    },

    data () {
      return {
        plannedAt: moment(),
      }
    },

    computed: {
      ...mapGetters({
        tasks: 'tasks/listBacklog',
      }),
    },

    methods: {
      startTask (task) {
        this.$store.dispatch('tasks/start', { task })
        this.$emit('close')
      },
    },
  }
</script>
