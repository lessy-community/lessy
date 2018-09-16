<template>
  <app-layout name="design">
    <app-menu brand="Lessy Design Guide" home="/design" slot="menu">
      <app-menu-link to="/design/grid">Grid</app-menu-link>
      <app-menu-link to="/design/typography">Typography</app-menu-link>
      <app-menu-link to="/design/colors">Colors</app-menu-link>
      <app-menu-link to="/design/visuals">Visuals</app-menu-link>
      <app-menu-link to="/design/components">Components</app-menu-link>
      <app-menu-link to="/design/wording">Wording</app-menu-link>
      <app-menu-link to="/today" icon="home">Back to home</app-menu-link>
    </app-menu>

    <slot></slot>
  </app-layout>
</template>
