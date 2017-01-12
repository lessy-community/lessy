<template>
  <form @submit.prevent="create">
    <input v-model="name" type="text" id="name" pattern="[a-z]{1}([a-z0-9_\-]{1,})*[a-z]{1}" required />
    <input type="submit" value="Create project" />
  </form>
</template>

<script>
export default {
  name: 'create-project-form',
  data () {
    return {
      name: '',
    }
  },
  methods: {
    create () {
      this.$store.dispatch('projects/create', {
        name: this.name,
      }).then(() => { this.name = '' })
    },
  },
}
</script>
