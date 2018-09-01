<template>
  <app-page name="design-colors" layout="design">
    <ly-text-container>
      <h1>Colors</h1>

      <p>Colors are used to give visual impact and should be chosen carefully,
      according to the context. Each color comes with shade variations, knowing
      that 50 is the main shade.</p>

      <p>You always must use SCSS variables to access these colors. It can be
      done by prepending shade name by <code>$ly-color-</code>. For example, to
      access green-70, the SCSS variable is <code>$ly-color-green-70</code>.

      <p>Please always make sure that contrast is OK so the text stays readable
      by everyone.</p>

      <h2>Pine</h2>
      <p>Pine color is used as our primary color to hightlight main actions
      such as primary buttons or links. It is also used for the layout of the
      interface.</p>
      <design-color-scheme name="pine" :shades="[50, 60, 70, 80, 90]"></design-color-scheme>

      <h2>Green</h2>
      <p>Green is used to indicate success.</p>
      <design-color-scheme name="green" :shades="[50, 70, 90]"></design-color-scheme>

      <h2>Gold</h2>
      <p>Gold is used to indicate warnings.</p>
      <design-color-scheme name="gold" :shades="[50, 70, 90]"></design-color-scheme>

      <h2>Red</h2>
      <p>Red is used to alert or to indicate errors.</p>
      <design-color-scheme name="red" :shades="[50, 70, 90]"></design-color-scheme>

      <h2>Grey</h2>
      <p>Grey is used for text and to add different interface variations. For
      example, it is used to diffentiate successive items in lists. You can
      learn how to use grey variations for text in the <router-link to="/design/typography">
      typography section</router-link>.</p>
      <design-color-scheme name="grey" :shades="[10, 20, 30, 40, 50, 60, 70, 80, 90]"></design-color-scheme>
    </ly-text-container>
  </app-page>
</template>

<script>
  import DesignColorScheme from './DesignColorScheme'

  export default {
    components: {
      DesignColorScheme,
    },
  }
</script>
