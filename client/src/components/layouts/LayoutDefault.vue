<template>
  <app-layout name="default" no-legacy>
    <header class="header-default" slot="header">
      <div class="header-default-container">
        <router-link class="header-default-brand" to="/">{{ $t('layouts.default.lessy') }}</router-link>
      </div>
    </header>

    <slot></slot>
  </app-layout>
</template>

<style lang="scss">
  .app-layout-default .app-layout-main {
    background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                        $ly-color-grey-20 80%,
                                        $ly-color-grey-20 81%,
                                        $ly-color-grey-10 81%,
                                        $ly-color-grey-10 83%,
                                        $ly-color-grey-20 83%);
  }

  .header-default {
    padding: 1rem 2rem;

    background: linear-gradient(45deg, $ly-color-grey-20,
                                       $ly-color-grey-20 calc(100% - 11rem),
                                       $ly-color-pine-60 calc(100% - 11rem),
                                       $ly-color-pine-60 calc(100% - 10.5rem),
                                       $ly-color-grey-20 calc(100% - 10.5rem),
                                       $ly-color-grey-20 calc(100% - 10rem),
                                       $ly-color-pine-60 calc(100% - 10rem));
  }

  .header-default-container {
    max-width: 80rem;
    margin-left: auto;
    margin-right: auto;
  }

  .header-default-brand {
    color: $ly-color-grey-90;
    font-size: 1.2rem;
    font-weight: bold;
    text-decoration: none;
  }
</style>
