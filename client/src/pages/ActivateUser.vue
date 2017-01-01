<template>
  <div class="activate-user-page">
    <activate-user-form
      :token="token"
      :on-success="onActivationSuccess"
    />
  </div>
</template>

<script>
import ActivateUserForm from '../forms/ActivateUser'

export default {
  name: 'activate-user-page',
  components: {
    ActivateUserForm,
  },
  data () {
    return {
      token: this.$route.params.token,
    }
  },
  methods: {
    onActivationSuccess () {
      this.$router.push('/dashboard')
    },
  },
}
</script>
