<template>
  <section :class="['app-page', `app-page-${name}`]">
    <component :is="`layout-${layout}`" :centered="centered" :home="home">
      <slot name="menu" slot="menu"></slot>
      <slot name="header" slot="header"></slot>
      <slot></slot>
    </component>
  </section>
</template>

<script>
  export default {
    props: {
      name: { type: String, required: true },
      layout: { type: String, default: 'default' },
      centered: { type: Boolean },
      home: { type: String, default: '/' },
    },
  }
</script>
