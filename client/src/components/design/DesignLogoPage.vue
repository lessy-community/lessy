<template>
  <app-page name="design-logo" layout="design">
    <ly-text-container>
      <h1>Logo</h1>

      <p>The logo represents the identity of Lessy. You must follow some
      conditions in order to use it correctly. A component exists to avoid
      mistakes (<code>app-logo</code>, which is used on this page).</p>

      <p>It comes in three different flavours: a normal, an inversed and a black
      one.</p>
    </ly-text-container>

    <div class="logo-line">
      <app-logo size="large" nobrand></app-logo>
      <app-logo size="large" nobrand flavour="inversed"></app-logo>
      <app-logo size="large" nobrand flavour="black"></app-logo>
    </div>

    <ly-text-container>
      <p>The logo must:</p>

      <ul>
          <li>be surrounded by a padding of, at least, 25% of its height;</li>
          <li>appear as a square;</li>
          <li>be on the <code>pine-70</code> color if in the inversed flavour.</li>
      </ul>

      <p>The logo can also be followed by the brand (Lessy):</p>
    </ly-text-container>

    <app-logo size="large"></app-logo>
    <app-logo size="large" flavour="inversed"></app-logo>
    <app-logo size="large" flavour="black"></app-logo>

    <ly-text-container>
      <p>In this case, the logo:</p>

      <ul>
          <li>must be surrounded by a padding of, at least, 25% of its height <strong>only on top and bottom</strong>;</li>
          <li>don’t have any specific shape;</li>
          <li>use the <a href="https://www.fontsquirrel.com/fonts/permanent-marker">Permanent Marker</a> regular font;
          <li>must appear on its own line;</li>
          <li>must be on the <code>pine-70</code> color if in the inversed flavour.</li>
      </ul>
    </ly-text-container>
  </app-page>
</template>

<style scoped lang="scss">
  .logo-line {
    display: flex;

    justify-content: space-around;
  }

  .app-logo {
    margin-bottom: 1rem;
  }

  @media(max-width: $small-screen-width) {
    .logo-line {
      flex-direction: column;
      align-items: center;
    }
  }
</style>
