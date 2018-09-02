<template>
  <app-layout name="default">
    <app-header slot="header" :brand="$t('layouts.default.brand')">
    </app-header>

    <slot></slot>
  </app-layout>
</template>

<style lang="scss">
  .app-layout-default {
    .app-layout-main {
      background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                          $ly-color-grey-20 80%,
                                          $ly-color-grey-20 81%,
                                          $ly-color-grey-10 81%,
                                          $ly-color-grey-10 83%,
                                          $ly-color-grey-20 83%);
    }

    .app-header {
      background: linear-gradient(45deg, $ly-color-grey-20,
                                         $ly-color-grey-20 calc(100% - 11rem),
                                         $ly-color-pine-60 calc(100% - 11rem),
                                         $ly-color-pine-60 calc(100% - 10.5rem),
                                         $ly-color-grey-20 calc(100% - 10.5rem),
                                         $ly-color-grey-20 calc(100% - 10rem),
                                         $ly-color-pine-60 calc(100% - 10rem));
    }
  }

  @media(max-width: $small-screen-width) {
    .app-layout-default .app-header {
      background: linear-gradient(45deg, $ly-color-grey-20,
                                         $ly-color-grey-20 calc(100% - 5rem),
                                         $ly-color-pine-60 calc(100% - 5rem),
                                         $ly-color-pine-60 calc(100% - 4.5rem),
                                         $ly-color-grey-20 calc(100% - 4.5rem),
                                         $ly-color-grey-20 calc(100% - 4rem),
                                         $ly-color-pine-60 calc(100% - 4rem));
    }
  }
</style>
