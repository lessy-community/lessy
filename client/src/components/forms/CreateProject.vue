<template>
  <form @submit.prevent="create">
    <div>
      <input
        v-model="name"
        type="text"
        id="name"
        pattern="[a-z]{1}([a-z0-9_\-]{1,})*[a-z]{1}"
        required
        ref="nameInput"
      />
    </div>

    <input type="submit" value="Create" />
    <a href="#" @click.prevent="onCancel">Cancel</a>
  </form>
</template>

<script>
  export default {

    name: 'create-project-form',

    props: {
      'onCancel': { type: Function, required: true },
    },

    data () {
      return {
        name: '',
      }
    },

    methods: {
      create () {
        this.$store.dispatch('projects/create', {
          name: this.name,
        }).then(() => {
          this.name = ''
          this.$refs.nameInput.focus()
        })
      },
    },

    mounted () {
      this.$refs.nameInput.focus()
    },

  }
</script>
