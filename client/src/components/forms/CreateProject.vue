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

    <btn submit>Create</btn>
    <btn type="cancel" @click="onCancel">Cancel</btn>
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
