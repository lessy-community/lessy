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

      <h2>ly-form-input</h2>
      <p>Use inputs to interact with user. An input should always be inside a
      <code>form-group</code>.</p>

      <ly-form-group>
        <ly-form-input
          type="text"
          name="example-1"
          value=""
        ></ly-form-input>
      </ly-form-group>

      <h3>Label</h3>
      <p>You should provide a label most of the time unless the purpose of
      input is obvious.</p>

      <ly-form-group>
        <ly-form-input
          type="text"
          name="username-1"
          value=""
          label="Username"
        ></ly-form-input>
      </ly-form-group>

      <h3>Required</h3>
      <p>An input not required is marked as optional. You should try to avoid
      optional inputs: filling forms is not fun, we should keep them as light
      as possible.</p>

      <ly-form-group>
        <ly-form-input
          type="text"
          name="username-2"
          value=""
          label="Username"
          required
        ></ly-form-input>
      </ly-form-group>

      <h3>Pattern</h3>
      <p>Provide a pattern to force a given format.</p>

      <h3>Caption</h3>
      <p>Provide additional information or advices on how to fill the input
      with a caption.</p>

      <ly-form-group>
        <ly-form-input
          type="text"
          name="username-3"
          value=""
          label="Username"
          pattern="[a-z_\-]{1,25}"
          caption="Only lowercase letters, underscores and hiphens. Max 25 characters."
          required
        ></ly-form-input>
      </ly-form-group>

      <h3>Placeholder</h3>
      <p>Placeholder gives an example to user to guide him to fill an input.
      Please note <strong>placeholders must never be used as labels</strong>.</p>

      <ly-form-group>
        <ly-form-input
          type="email"
          name="email-1"
          value=""
          placeholder="dale@cooper.com"
          label="Email"
          required
        ></ly-form-input>
      </ly-form-group>

      <h3>Error</h3>
      <p>Always show errors concerning a specific input next to it with the
      <code>error</code> attribute.</p>

      <ly-form-group>
        <ly-form-input
          type="text"
          name="username-4"
          value="john"
          label="Username"
          pattern="[a-z_\-]{1,25}"
          caption="Only lowercase letters, underscores and hiphens. Max 25 characters."
          error="This username already exists."
          required
        ></ly-form-input>
      </ly-form-group>

      <h3>Type</h3>
      <p>Always choose the most appropriate type for your input since specific
      design or interactions may apply.</p>

      <ly-form-group>
        <ly-form-input
          type="date"
          name="date-1"
          value=""
          label="Date of birth"
          required
        ></ly-form-input>
      </ly-form-group>

      <ly-form-group>
        <ly-form-input
          type="password"
          name="password-1"
          v-model="password"
          label="Password"
          required
        ></ly-form-input>
      </ly-form-group>

      <ly-form-group>
        <ly-form-textarea
          name="description-1"
          value=""
          label="Description"
        ></ly-form-textarea>
      </ly-form-group>

      <ly-form-group>
        <ly-form-select
          name="select-1"
          v-model="city"
          label="Capital city"
          :options="cityOptions"
        ></ly-form-select>
      </ly-form-group>

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

      <h3>Stripped</h3>
      <p>Stripped lists are generally easier to read when there is a lot of
      items.</p>

      <ly-list stripped>
        <ly-list-item>Element 1</ly-list-item>
        <ly-list-item>Element 2</ly-list-item>
        <ly-list-item>Element 3</ly-list-item>
        <ly-list-item>Element 4</ly-list-item>
      </ly-list>

      <h3>Placeholder</h3>
      <p>You should always provide a placeholder in case of the list is
      empty.</p>

      <ly-list placeholder="This list is empty">
      </ly-list>

      <h3>Draggable</h3>
      <p>You can make list' items draggable to reorganize elements.</p>

      <ly-list stripped draggable>
        <ly-list-item key="1" with-handle>Element 1</ly-list-item>
        <ly-list-item key="2" with-handle>Element 2</ly-list-item>
        <ly-list-item key="3" with-handle>Element 3</ly-list-item>
      </ly-list>

      <h3>Generic</h3>
      <p>Items can include different components such as buttons, badges or
      icons.</p>

      <ly-list stripped>
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

      <h3>Groups</h3>
      <p>Organize items per alphabetical group when text and interactions are
      very limited.</p>

      <ly-list>
        <ly-list-group name="A">
          <ly-list-item>Andromeda</ly-list-item>
          <ly-list-item>Antlia</ly-list-item>
          <ly-list-item>Apus</ly-list-item>
        </ly-list-group>
        <ly-list-group name="C">
          <ly-list-item>Caelum</ly-list-item>
          <ly-list-item>Cassiopeiae</ly-list-item>
        </ly-list-group>
        <ly-list-group name="M">
          <ly-list-item>Mensa</ly-list-item>
          <ly-list-item>Monoceros</ly-list-item>
          <ly-list-item>Musca</ly-list-item>
        </ly-list-group>
      </ly-list>

      <h2>ly-modal</h2>
      <p>Modals can handle complex interactions but with the need to keep
      current context (i.e. user should stay on the same page).<p>

      <ly-button @click="showModal1 = true">Click to open modal</ly-button>
      <ly-modal v-if="showModal1" title="Some complex form">
        <ly-form @submit="showModal1 = false">
          <ly-form-group>
            <ly-form-input
              type="text"
              name="modal-1"
              label="A complex field"
              value=""
              required
            ></ly-form-input>
          </ly-form-group>

          <ly-form-group type="actions">
            <ly-button type="primary" submit>
              Submit
            </ly-button>
            <ly-button @click="showModal1 = false">
              Cancel
            </ly-button>
          </ly-form-group>
        </ly-form>
      </ly-modal>

      <h2>ly-popover, ly-popover-item and ly-popover-separator</h2>
      <p>Popovers can be used to hide additional actions.</p>

      <ly-popover>
        <ly-button slot="toggle">
          Open popover
        </ly-button>

        <template slot="menu">
          <ly-popover-item>Show</ly-popover-item>
          <ly-popover-item>Edit</ly-popover-item>
          <ly-popover-separator></ly-popover-separator>
          <ly-popover-item>More actions</ly-popover-item>
        </template>
      </ly-popover>

      <h2>ly-section</h2>
      <p>Use sections to group components and to name sections.</p>

      <ly-section title="5 fruits">
        <ly-list stripped>
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

<script>
  export default {
    data () {
      return {
        password: 'secret',

        showModal1: false,

        city: null,
        cityOptions: [
          { value: 2, label: 'Accra' },
          { value: 3, label: 'Amsterdam' },
          { value: 6, label: 'Athens' },
          { value: 7, label: 'Caracas' },
          { value: 8, label: 'Cayenne' },
          { value: 9, label: 'Conakry' },
          { value: 10, label: 'Edinburgh of the Seven Seas' },
          { value: 11, label: 'Fort-de-France' },
          { value: 12, label: 'Flying Fish Cove' },
          { value: 13, label: 'Hamilton' },
          { value: 14, label: 'Hanga Roa' },
          { value: 15, label: 'Helsinki' },
          { value: 16, label: 'Kabul' },
          { value: 17, label: 'Kiev' },
          { value: 18, label: 'Kingstown' },
          { value: 19, label: 'Madrid' },
          { value: 20, label: 'Malé' },
          { value: 21, label: 'Manila' },
          { value: 22, label: 'Oslo' },
          { value: 23, label: 'Paris' },
          { value: 24, label: 'Paramaribo' },
          { value: 25, label: 'Prague' },
          { value: 26, label: 'Phnom Penh' },
          { value: 27, label: 'Rabat' },
          { value: 28, label: 'Rome' },
          { value: 29, label: 'Roseau' },
          { value: 30, label: 'Stanley' },
          { value: 31, label: 'Suva' },
          { value: 32, label: 'Tallinn' },
          { value: 33, label: 'Tórshavn' },
          { value: 34, label: 'The Valley' },
          { value: 35, label: 'Vienna' },
          { value: 36, label: 'Vilnius' },
          { value: 37, label: 'Warsaw' },
          { value: 38, label: 'Windhoek' },
          { value: 39, label: 'Yaoundé' },
          { value: 40, label: 'Yaren' },
          { value: 41, label: 'Yerevan' },
          { value: 42, label: 'Zagreb' },
        ],
      }
    },
  }
</script>
