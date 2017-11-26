<template>
  <div :class="['ly-list', {
    [`ly-list-${name}`]: name,
    'ly-list-stripped': stripped,
    'ly-list-draggable': draggable,
  }]">
    <div v-if="!$slots.default && placeholder" class="ly-list-placeholder">
      {{ placeholder }}
    </div>

    <draggable
      v-if="$slots.default && draggable"
      v-model="computedDraggableModel"
      @change="draggableChange"
      :options="{ handle: '.my-handle', draggable: '.ly-list-item' }"
    >
      <transition-group>
        <slot></slot>
      </transition-group>
    </draggable>

    <slot v-if="$slots.default && !draggable"></slot>
  </div>
</template>

<script>
  import draggable from 'vuedraggable'

  export default {
    props: {
      name: { type: String },
      placeholder: { type: String },
      stripped: { type: Boolean },
      draggable: { type: Boolean },
      'draggable-model': { type: Array },
    },

    components: {
      draggable,
    },

    computed: {
      computedDraggableModel: {
        get () {
          return this.draggableModel
        },
        set () {
          // do nothing on purpose
        },
      },
    },

    methods: {
      draggableChange (event) {
        this.$emit('draggable-change', event)
      },
    },
  }
</script>

<style lang="scss">
  .ly-list {
    margin-bottom: 1rem;

    .ly-list-placeholder {
      padding: .5rem;

      color: $ly-color-grey-50;
    }

    &.ly-list-stripped .ly-list-item:nth-child(even) {
      background-color: $ly-color-grey-20;
    }
  }
</style>
