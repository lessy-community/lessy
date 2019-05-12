<template>
  <app-page name="design-typography" layout="design">
    <ly-text-container>
      <h1>Typography</h1>

      <h2>Font</h2>
      <p>We use the system font stack as typeface. Learn more about system font
      stack on <a href="https://css-tricks.com/snippets/css/system-font-stack/">CSS-tricks</a>.</p>

      <p>The base font size is set to 20px on desktop and 16px on mobile.</p>

      <p>Line length must be between 45 and 75 characters, best is around 66.
      Please use <code>ly-text-container</code> component to ensure that.</p>

      <p>To emphasis text, use <code>strong</code> tag or <code>.text-important</code>
      class. Please never use italic or <code>em</code> tag.</p>

      <h2>Scaling</h2>
      <p>Font size scales depending on the content hierarchy:</p>

      <table>
        <thead>
          <tr>
            <th>Element</th>
            <th>Scaling</th>
            <th>Line height</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><code>h1</code></td>
            <td>2rem</td>
            <td>2.5rem</td>
          </tr>
          <tr>
            <td><code>h2</code></td>
            <td>1.5rem</td>
            <td>2rem</td>
          </tr>
          <tr>
            <td><code>h3</code></td>
            <td>1rem</td>
            <td>1.5rem</td>
          </tr>
          <tr>
            <td>Body</td>
            <td>1rem</td>
            <td>1.5rem</td>
          </tr>
        </tbody>
      </table>

      <h2>Colors</h2>
      <p>Use primary color for main titles and body:</p>

      <div class="design-blocks">
        <div class="design-block light-background">
          grey-90<br />
          <small>on light background</small>
        </div>
        <div class="design-block dark-background text-on-dark">
          white<br />
          <small>on dark background</small>
        </div>
      </div>

      <p>Use secondary color for additional text, to accompany primary text:</p>

      <div class="design-blocks">
        <div class="design-block light-background text-secondary">
          grey-60<br />
          <small>on light background</small>
        </div>
        <div class="design-block dark-background text-on-dark text-secondary">
          grey-30<br />
          <small>on dark background</small>
        </div>
      </div>

      <p>Use additional colors to highlight specific information:</p>

      <ly-list>
        <ly-list-item class="text-primary">Primary text</ly-list-item>
        <ly-list-item class="text-success">Success text</ly-list-item>
        <ly-list-item class="text-warning">Warning text</ly-list-item>
        <ly-list-item class="text-alert">Alert text</ly-list-item>
      </ly-list>

      <p>Please note they can’t be used on dark backgrounds.</p>
    </ly-text-container>
  </app-page>
</template>

<style scoped lang="scss">
  .design-blocks {
    display: flex;
    margin-top: -.5rem;
    margin-bottom: 1rem;
  }
  .design-block {
    padding: 2rem 1rem;

    flex: 1 0 0;

    text-align: center;

    &.light-background {
      box-shadow: 0 0 1px $ly-color-grey-90;
    }
    &.dark-background {
      background-color: $ly-color-grey-90;
      box-shadow: 0 0 1px $ly-color-grey-90;
    }
  }
</style>
