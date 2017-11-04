<template>
  <table :class="['design-color-scheme', `design-color-scheme-${name}`]">
    <thead>
      <tr>
        <th></th>
        <th>Name</th>
        <th>Contrast</th>
        <th>Text</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="shade in shades" :class="`design-color shade-${shade}`">
        <td><div class="shade-square"></div></td>
        <td>{{ name }}-{{ shade }}</td>
        <td><div class="text-color"></div></td>
        <td><div class="back-color"></div></td>
      </tr>
    </tbody>
  </table>
</template>

<script>
  export default {
    props: {
      name: { type: String, required: true },
      shades: { type: Array, required: true },
    },
  }
</script>

<style scoped lang="scss">
  .design-color-scheme .design-color {
    margin-bottom: .5rem;

    .shade-square {
      width: 2rem;
      height: 2rem;

      border-radius: .25rem;
    }

    .back-color::before {
      padding: .25rem;

      border-radius: .25rem;
    }
  }

  @mixin shade-color($shade, $text, $label, $contrast:"OK") {
    .shade-square {
      background-color: $shade;
    }
    .back-color::before {
      color: $text;

      background-color: $shade;

      content: "#{$label}";
    }
    .text-color::before {
      color: $shade;
      content: "#{$contrast}";
    }
  }

  .design-color-scheme-grey .design-color {
    &.shade-10 {
      @include shade-color($ly-color-grey-10, $ly-color-grey-90, "grey-90", "Fails");
      .shade-square,
      .back-color::before {
        box-shadow: 0 0 1px $ly-color-grey-50;
      }
    }
    &.shade-20 {
      @include shade-color($ly-color-grey-20, $ly-color-grey-90, "grey-90", "Fails");
      .shade-square,
      .back-color::before {
        box-shadow: 0 0 1px $ly-color-grey-50;
      }
    }
    &.shade-30 {
      @include shade-color($ly-color-grey-30, $ly-color-grey-90, "grey-90", "Fails");
    }
    &.shade-40 {
      @include shade-color($ly-color-grey-40, $ly-color-grey-90, "grey-90", "Fails");
    }
    &.shade-50 {
      @include shade-color($ly-color-grey-50, $ly-color-white, "white");
    }
    &.shade-60 {
      @include shade-color($ly-color-grey-60, $ly-color-white, "white");
    }
    &.shade-70 {
      @include shade-color($ly-color-grey-70, $ly-color-white, "white");
    }
    &.shade-80 {
      @include shade-color($ly-color-grey-80, $ly-color-white, "white");
    }
    &.shade-90 {
      @include shade-color($ly-color-grey-90, $ly-color-white, "white");
    }
  }

  .design-color-scheme-pine .design-color {
    &.shade-50 {
      @include shade-color($ly-color-pine-50, $ly-color-white, "white");
    }
    &.shade-60 {
      @include shade-color($ly-color-pine-60, $ly-color-white, "white");
    }
    &.shade-70 {
      @include shade-color($ly-color-pine-70, $ly-color-white, "white");
    }
    &.shade-80 {
      @include shade-color($ly-color-pine-80, $ly-color-white, "white");
    }
    &.shade-90 {
      @include shade-color($ly-color-pine-90, $ly-color-white, "white");
    }
  }

  .design-color-scheme-green .design-color {
    &.shade-50 {
      @include shade-color($ly-color-green-50, $ly-color-white, "white");
    }
    &.shade-70 {
      @include shade-color($ly-color-green-70, $ly-color-white, "white");
    }
    &.shade-90 {
      @include shade-color($ly-color-green-90, $ly-color-white, "white");
    }
  }

  .design-color-scheme-gold .design-color {
    &.shade-50 {
      @include shade-color($ly-color-gold-50, $ly-color-white, "white", "Fails");
    }
    &.shade-70 {
      @include shade-color($ly-color-gold-70, $ly-color-white, "white");
    }
    &.shade-90 {
      @include shade-color($ly-color-gold-90, $ly-color-white, "white");
    }
  }

  .design-color-scheme-red .design-color {
    &.shade-50 {
      @include shade-color($ly-color-red-50, $ly-color-white, "white");
    }
    &.shade-70 {
      @include shade-color($ly-color-red-70, $ly-color-white, "white");
    }
    &.shade-90 {
      @include shade-color($ly-color-red-90, $ly-color-white, "white");
    }
  }
</style>
