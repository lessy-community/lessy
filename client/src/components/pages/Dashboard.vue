<template>
  <div class="dashboard-page">
    <p v-if="!user.activated" v-html="$t('pages.dashboard.activationInstructions', { email: user.email })"></p>

    <container v-if="inProgressProjects" row>
      <card v-for="project in inProgressProjects" :title="project.name" :to="project.urlShow">
        <span v-html="$t('pages.dashboard.dueOn', { date: project.dueAtLabel })" ></span>
      </card>
    </container>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {

    name: 'dashboard-page',

    computed: {
      ...mapGetters({
        user: 'users/current',
        inProgressProjects: 'projects/listInProgress',
      }),
    },

  }
</script>

<style>

  .dashboard-page .container.row > .card {
    flex-grow: 1;
    flex-shrink: 1;
    flex-basis: 0;
  }

</style>
