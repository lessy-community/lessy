<template>
  <app-page name="design-index">
    <ly-text-container>
      <h1>Lessy Design Guide</h1>

      <p>This guide is intended for frontend developers. It is aimed to help
      you to build an intuitive, coherent and beautiful interface for Lessy. It
      presents guidelines, UI components and various resources.</p>

      <p>This design guide should evolve while we are facing new challenges
      with UI. Feel free to <a href="https://github.com/lessy-community/lessy/issues/">open
        a ticket</a> if you get stuck with a new problem.</p>

      <p>All credits go to the <a href="http://design.firefox.com/photon/welcome.html">Photon
      Design System</a>, by the Firefox team. Our guide is heavily adapted from
      it.</p>
    </ly-text-container>

    <ly-card-deck>
      <ly-card class="text-on-dark" image="/static/grid.jpg">
        <router-link to="/design/grid">Grid</router-link>
      </ly-card>
      <ly-card class="text-on-dark" image="/static/typography.jpg">
        <router-link to="/design/typography">Typography</router-link>
      </ly-card>
      <ly-card class="text-on-dark" image="/static/colors.jpg">
        <router-link to="/design/colors">Colors</router-link>
      </ly-card>
    </ly-card-deck>

    <ly-card-deck>
      <ly-card class="text-on-dark" image="/static/visuals.jpg">
        <router-link to="/design/visuals">Visuals</router-link>
      </ly-card>
      <ly-card class="text-on-dark" image="/static/components.jpg">
        <router-link to="/design/components">Components</router-link>
      </ly-card>
      <ly-card class="text-on-dark" image="/static/wording.jpg">
        <router-link to="/design/wording">Wording</router-link>
      </ly-card>
    </ly-card-deck>

    <ly-text-container>
      <h2>Illustration credits</h2>
      <p>The six illustrations used above are under free licenses and have been
      adapted:</p>

      <ul>
        <li><a href="https://flic.kr/p/ggPV6k">Grid, by Bart Everson</a></li>
        <li><a href="https://flic.kr/p/bBLfcQ">dutracé p64, by patricia m</a></li>
        <li><a href="https://flic.kr/p/PW6bN">colors, by Emi Yañez</a></li>
        <li><a href="https://flic.kr/p/cLMr9w">fox pile, by Katie O'Hagan</a></li>
        <li><a href="https://flic.kr/p/5cenX">Lego DNA, by Michael Knowles</a></li>
        <li><a href="https://flic.kr/p/a671pA">July 8-14, 2011, by osseus</a></li>
      </ul>
    </ly-text-container>
  </app-page>
</template>

<style lang="scss">
  .app-page-design-index .ly-card .ly-card-body a {
    display: block;
    margin: -1rem;
    padding-top: 3rem;
    padding-bottom: 3rem;

    text-align: center;
    font-weight: bold;
  }
</style>
