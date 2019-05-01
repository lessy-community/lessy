<template>
  <ly-modal :title="$t('general.termsOfServiceModal.title')" noclose>
    <p>
      {{ $t('general.termsOfServiceModal.intro') }}
    </p>
    <p>
      {{ $t('general.termsOfServiceModal.mustAccept') }}
    </p>

    <ly-form-group type="actions">
      <router-link to="/terms-of-service">
        {{ $t('general.termsOfServiceModal.read') }}
      </router-link>
    </ly-form-group>
  </ly-modal>
</template>
