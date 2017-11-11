<template>
  <app-page name="design-components">
    <ly-text-container>
      <h1>Components</h1>

      <p>Components are bricks of the interface. You can see them as Lego
      bricks you put together to build a bigger construction.</p>

      <p>The most atomic components are prepended by <code>ly-</code> (short
      for <strong>L</strong>ess<strong>y</strong>). Always try to use these
      components instead of the too-generic <code>div</code> and <code>span</code>
      tags when you are not designing a ly-component.</p>

      <p>There are also <code>app-</code> components that are used to build the
      general layout. You might find interesting to have a look to them but if
      you are not designing a new page, you should not have to worry about
      them.</p>

      <h2>ly-badge</h2>

      <p>Use badges to provide contextual information.</p>

      <p>
        <ly-badge>info</ly-badge>
        <ly-badge type="primary">primary</ly-badge>
        <ly-badge type="success">success</ly-badge>
        <ly-badge type="warning">warning</ly-badge>
        <ly-badge type="alert">alert</ly-badge>
      </p>

      <p>You can change size depending on the importance of the information.</p>

      <p>
        <ly-badge size="small">small</ly-badge>
        <ly-badge>normal</ly-badge>
        <ly-badge size="large">large</ly-badge>
      </p>

      <h2>ly-button</h2>

      <p>Buttons execute an action or change state of application. For
      instance, it can be a submit button or a button that displays a hidden
      input. Please always provide a text label.</p>

      <h3>Primary</h3>
      <p>Primary buttons draw attention to a specific action. Try to limit one
      primary button per view.</p>

      <ly-button type="primary">Submit</ly-button>

      <h3>Default</h3>
      <p>Default buttons are used for secondary actions when combined with a
      primary button.</p>

      <ly-button>Reset</ly-button>

      <h3>Ghost</h3>
      <p>Ghost buttons are similar to default buttons but with a less impactant
      design. Its background is adapted from its parents' background.</p>

      <ly-button type="ghost">Reset</ly-button>

      <h3>Icon</h3>
      <p>You can provide an icon for a more visual impacted button.</p>

      <ly-button icon="search">Search</ly-button>

      <h3>Size</h3>
      <p>You can change buttons' size depending on the impact of the
      button.</p>

      <ly-button size="small">Small</ly-button>
      <ly-button>Normal</ly-button>
      <ly-button size="large">Large</ly-button>

      <h3>Disabled</h3>
      <p>A button can be disabled if action cannot be performed for some
      specific reasons. Always provide reasons of deactivation.</p>

      <ly-button disabled v-tooltip.top="'Disabled for some reasons'">Disabled</ly-button>
      <ly-button type="primary" disabled v-tooltip.top="'Disabled for some reasons'">Disabled</ly-button>
      <ly-button type="ghost" disabled v-tooltip.top="'Disabled for some reasons'">Disabled</ly-button>

      <h2>ly-card</h2>
      <p>Cards are a content container. They can be used to present different
      kind of information such as text, images or more complex components.</p>

      <ly-card>
        Veniam quae corporis consequatur aliquam. Aut vero blanditiis enim.
        Enim expedita aut ut debitis voluptatem eveniet blanditiis sint.
        Corporis a placeat et quos officia pariatur est at. Qui illo commodi
        rerum et maxime odio. Nostrum praesentium sint magni ipsum.
      </ly-card>

      <h3>Header and footer</h3>
      <p>Add a header and/or a footer to provide additional information.</p>

      <ly-card>
        <template slot="header">
          Lorem Ipsum
        </template>

        Veniam quae corporis consequatur aliquam. Aut vero blanditiis enim.
        Enim expedita aut ut debitis voluptatem eveniet blanditiis sint.
        Corporis a placeat et quos officia pariatur est at. Qui illo commodi
        rerum et maxime odio. Nostrum praesentium sint magni ipsum.

        <template slot="footer">
          <small>— Some wise man</small>
        </template>
      </ly-card>

      <h3>Image</h3>
      <p>You can provide an image to illustrate a card. Be careful when you use
      images since it has a strong impact on interface.</p>

      <ly-card class="text-on-dark" image="/static/visuals.jpg">
        Veniam quae corporis consequatur aliquam.<br />
        Aut vero blanditiis enim.<br />
        Enim expedita aut ut debitis voluptatem eveniet blanditiis sint.<br />
      </ly-card>

      <h3>Placeholder</h3>
      <p>You can indicate a card is acting as a placeholder.</p>

      <ly-card type="placeholder">
        Veniam quae corporis consequatur aliquam. Aut vero blanditiis enim.
      </ly-card>

      <h2>ly-card-deck</h2>
      <p>Cards can be grouped per deck if they present similar information. All
      cards of a deck have the same height.</p>

      <ly-card-deck>
        <ly-card>
          <template slot="header">A header</template>
          Veniam quae corporis consequatur aliquam. Aut vero blanditiis enim.
          Enim expedita aut ut debitis voluptatem eveniet blanditiis sint.
          <template slot="footer">A footer</template>
        </ly-card>
        <ly-card>
          <template slot="header">A second header</template>
          Corporis a placeat et quos officia pariatur est at.
          <template slot="footer">A second footer</template>
        </ly-card>
      </ly-card-deck>

      <h2>ly-icon</h2>
      <p>Use icons to add visual help to user. Icons must be used carefully and
      always be accompanied by a text alternative.</p>

      <p>
        <ly-icon name="question-circle"></ly-icon>
        What's new?
      </p>

      <p>Size of icons can be changed by making them <code>large</code>.</p>

      <p>
        <ly-icon name="home" size="large"></ly-icon>
      </p>

      <p>You can indicate a task is processing with the <code>circle-o-notch</code>
      icon and by making it rotating with the <code>spin</code> attribute.</p>

      <p>
        <ly-icon name="circle-o-notch" size="large" spin></ly-icon>
      </p>

      <h2>ly-list and ly-list-item</h2>
      <p>Lists and list items are used to show a set of related elements.</p>

      <ly-list>
        <ly-list-item>Element 1</ly-list-item>
        <ly-list-item>Element 2</ly-list-item>
        <ly-list-item>Element 3</ly-list-item>
        <ly-list-item>Element 4</ly-list-item>
      </ly-list>

      <p>You should always provide a placeholder in case of the list is
      empty.</p>

      <ly-list placeholder="This list is empty">
      </ly-list>

      <p>You can make list' items draggable to reorganize elements.</p>

      <ly-list draggable>
        <ly-list-item key="1" with-handle>Element 1</ly-list-item>
        <ly-list-item key="2" with-handle>Element 2</ly-list-item>
        <ly-list-item key="3" with-handle>Element 3</ly-list-item>
      </ly-list>

      <p>Items can include different components such as buttons, badges or
      icons.</p>

      <ly-list>
        <ly-list-item>
          <ly-icon name="thumbs-up"></ly-icon>
          <ly-list-item-adapt>thumbs-up</ly-list-item-adapt>
          <ly-badge type="success">great</ly-badge>
          <ly-button>do nothing</ly-button>
        </ly-list-item>
        <ly-list-item>
          <ly-icon name="thumbs-down"></ly-icon>
          <ly-list-item-adapt>thumbs-down</ly-list-item-adapt>
          <ly-badge type="alert">not great</ly-badge>
          <ly-button>do nothing</ly-button>
        </ly-list-item>
      </ly-list>

      <h2>ly-section</h2>
      <p>Use sections to group components and to name sections.</p>

      <ly-section title="5 fruits">
        <ly-list>
          <ly-list-item>Blueberry</ly-list-item>
          <ly-list-item>Raspberry</ly-list-item>
          <ly-list-item>Apple</ly-list-item>
          <ly-list-item>Pear</ly-list-item>
          <ly-list-item>Strawberry</ly-list-item>
        </ly-list>
      </ly-section>

      <h2>ly-text-container</h2>
      <p>Text container is used to make sure width of text lines follows
      <router-link to="/design/typography">typography rules</router-link>. This
      page is wrapped in this component.</p>

      <p>Use the <code>margined</code> attribute to center the text block.</p>
    </ly-text-container>
  </app-page>
</template>
