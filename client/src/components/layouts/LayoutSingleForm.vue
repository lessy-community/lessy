<template>
  <app-layout name="single-form">
    <app-header slot="header" :brand="$t('layouts.singleForm.brand')">
    </app-header>

    <div class="single-form-container">
      <slot></slot>
    </div>
  </app-layout>
</template>

<style lang="scss">
  .app-layout-single-form {
    .app-layout-main {
      background: linear-gradient(225deg, $ly-color-grey-10 80%,
                                          $ly-color-grey-20 80%,
                                          $ly-color-grey-20 81%,
                                          $ly-color-grey-10 81%,
                                          $ly-color-grey-10 83%,
                                          $ly-color-grey-20 83%);

      h1 {
        text-align: center;
      }
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

    .single-form-container {
      max-width: 30rem;
      margin-left: auto;
      margin-right: auto;
    }
  }

  @media(max-width: $small-screen-width) {
    .app-layout-single-form .app-header {
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
