<template>
  <table :class="['design-color-scheme', `design-color-scheme-${name}`]">
    <thead>
      <tr>
        <th></th>
        <th>Name</th>
        <th>Background</th>
        <th>Text</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="shade in shades" :class="`design-color shade-${shade}`">
        <td><div class="shade-square"></div></td>
        <td>{{ name }}-{{ shade }}</td>
        <td>
          <div class="color-ratio-text">
            {{ textColorForShade(shade) }}
          </div>
        </td>
        <td>
          <div class="color-ratio-background-10">
            <span v-if="ratio(shade, 'grey-10') >= 7">OK</span>
            <span v-else-if="ratio(shade, 'grey-10') >= 4.5">Accepted</span>
            <span v-else>Fails</span>
          </div>

          <div class="color-ratio-background-20">
            <span v-if="ratio(shade, 'grey-20') >= 7">OK</span>
            <span v-else-if="ratio(shade, 'grey-20') >= 4.5">Accepted</span>
            <span v-else>Fails</span>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
</template>

<script>
  import colors from '@/styles/variables/colors.json'

  import { hexLuminance, luminanceRatio } from '@/utils/color'

  export default {
    props: {
      name: { type: String, required: true },
      shades: { type: Array, required: true },
    },

    methods: {
      ratio (shade, backColor) {
        const baseColorLuminance = hexLuminance(colors[`ly-color-${backColor}`])
        const currentColorLuminance = hexLuminance(colors[`ly-color-${this.name}-${shade}`])
        return luminanceRatio(baseColorLuminance, currentColorLuminance)
      },

      textColorForShade (shade) {
        const whiteColorLuminance = hexLuminance(colors['ly-color-white'])
        const greyColorLuminance = hexLuminance(colors['ly-color-grey-90'])
        const currentColorLuminance = hexLuminance(colors[`ly-color-${this.name}-${shade}`])

        const whiteRatio = luminanceRatio(whiteColorLuminance, currentColorLuminance)
        const greyRatio = luminanceRatio(greyColorLuminance, currentColorLuminance)

        if (greyRatio < 4.5 && whiteRatio < 4.5) {
          return 'none'
        } else if (greyRatio >= whiteRatio) {
          return `grey-90 (${greyRatio.toFixed(1)}:1)`
        } else {
          return `white (${whiteRatio.toFixed(1)}:1)`
        }
      },
    },
  }
</script>

<style lang="scss">
  .design-color-scheme .design-color {
    margin-bottom: .5rem;

    .shade-square {
      width: 2rem;
      height: 2rem;

      border-radius: .25rem;
    }

    .color-ratio-text {
      padding: .25rem;

      border-radius: .25rem;
    }

    .color-ratio-background-10 {
      padding: .25rem;

      background-color: $ly-color-grey-10;
      box-shadow: 0 0 1px $ly-color-grey-50;
      border-radius: .25rem .25rem 0 0;
    }

    .color-ratio-background-20 {
      padding: .25rem;

      background-color: $ly-color-grey-20;
      box-shadow: 0 0 1px $ly-color-grey-50;
      border-radius: 0 0 .25rem .25rem;
    }
  }

  @mixin shade-color($shade, $text) {
    .shade-square {
      background-color: $shade;
    }

    .color-ratio-text {
      color: $text;

      background-color: $shade;
    }

    .color-ratio-background-10,
    .color-ratio-background-20 {
      color: $shade;
    }
  }

  .design-color-scheme-grey .design-color {
    &.shade-10 {
      @include shade-color($ly-color-grey-10, $ly-color-grey-90);

      .shade-square,
      .color-ratio-text {
        box-shadow: 0 0 1px $ly-color-grey-50;
      }
    }
    &.shade-20 {
      @include shade-color($ly-color-grey-20, $ly-color-grey-90);

      .shade-square,
      .color-ratio-text {
        box-shadow: 0 0 1px $ly-color-grey-50;
      }
    }
    &.shade-30 { @include shade-color($ly-color-grey-30, $ly-color-grey-90); }
    &.shade-40 { @include shade-color($ly-color-grey-40, $ly-color-grey-90); }
    &.shade-50 { @include shade-color($ly-color-grey-50, $ly-color-white); }
    &.shade-60 { @include shade-color($ly-color-grey-60, $ly-color-white); }
    &.shade-70 { @include shade-color($ly-color-grey-70, $ly-color-white); }
    &.shade-80 { @include shade-color($ly-color-grey-80, $ly-color-white); }
    &.shade-90 { @include shade-color($ly-color-grey-90, $ly-color-white); }
  }

  .design-color-scheme-pine .design-color {
    &.shade-50 { @include shade-color($ly-color-pine-50, $ly-color-grey-90); }
    &.shade-60 { @include shade-color($ly-color-pine-60, $ly-color-grey-90); }
    &.shade-70 { @include shade-color($ly-color-pine-70, $ly-color-white); }
    &.shade-80 { @include shade-color($ly-color-pine-80, $ly-color-white); }
    &.shade-90 { @include shade-color($ly-color-pine-90, $ly-color-white); }
  }

  .design-color-scheme-green .design-color {
    &.shade-50 { @include shade-color($ly-color-green-50, $ly-color-grey-90); }
    &.shade-60 { @include shade-color($ly-color-green-60, $ly-color-grey-90); }
    &.shade-70 { @include shade-color($ly-color-green-70, $ly-color-white); }
    &.shade-80 { @include shade-color($ly-color-green-80, $ly-color-white); }
    &.shade-90 { @include shade-color($ly-color-green-90, $ly-color-white); }
  }

  .design-color-scheme-gold .design-color {
    &.shade-50 { @include shade-color($ly-color-gold-50, $ly-color-grey-90); }
    &.shade-60 { @include shade-color($ly-color-gold-60, $ly-color-grey-90); }
    &.shade-70 { @include shade-color($ly-color-gold-70, $ly-color-white); }
    &.shade-80 { @include shade-color($ly-color-gold-80, $ly-color-white); }
    &.shade-90 { @include shade-color($ly-color-gold-90, $ly-color-white); }
  }

  .design-color-scheme-red .design-color {
    &.shade-50 { @include shade-color($ly-color-red-50, $ly-color-white); }
    &.shade-60 { @include shade-color($ly-color-red-60, $ly-color-white); }
    &.shade-70 { @include shade-color($ly-color-red-70, $ly-color-white); }
    &.shade-80 { @include shade-color($ly-color-red-80, $ly-color-white); }
    &.shade-90 { @include shade-color($ly-color-red-90, $ly-color-white); }
  }
</style>
