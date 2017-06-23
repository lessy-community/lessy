<template>
  <div v-if="project" class="project-layout">
    <container row align="center">
      <h1 class="adapt">{{ project.name }}</h1>
      <router-link :to="project.urlEdit" class="btn btn-settings">
        <icon name="pencil"></icon>
        {{ $t('layout.project.settings') }}
      </router-link>
    </container>
    <router-view v-if="project" :project="project"></router-view>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        project: 'projects/current',
      }),
    },

    mounted () {
      const { projectName } = this.$route.params
      this.$store.commit('projects/setCurrent', projectName)
    },
  }
</script>

<style scoped>

  .btn-settings.router-link-active {
    color: #666;
  }
  .btn-settings.router-link-active:hover {
    text-decoration: none;
  }

</style>
