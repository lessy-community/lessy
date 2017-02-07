<template>
  <i :class="['fa', 'fa-fw',  `fa-${name}`, {
    'fa-spin': spin,
    'fa-pulse': pulse,
    [`fa-${size}x`]: size,
  }]" aria-hidden="true"></i>
</template>

<script>
  export default {

    name: 'icon',

    props: {
      'name': { type: String, required: true },
      'size': { type: [Number, String] },
      'spin': { type: Boolean },
      'pulse': { type: Boolean },
    },

  }
</script>
