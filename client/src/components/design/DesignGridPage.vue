<template>
  <app-page name="design-grid">
    <ly-text-container>
      <h1>Grid</h1>

      <p>Grid is used to make interface more consistent by aligning components
      correctly. The grid is based on a 0.25rem square. It is relative to the
      font-size defined on the <code>html</code> tag. It corresponds to 5px on
      desktop and 4px on mobile.</p>

      <p>Each element must align and be spaced following this grid. For
      example, it means you must avoid using <code>border</code> with a width
      of 1px since it would break spacing… or you must offset with
      corresponding margins. You can simulate a border with a box shadow as
      following: <code>box-shadow: 0 0 1px $ly-color-grey-50;</code>. Please
      note we use px unit but since it is shadow, it does not count in box
      size.</p>
    </ly-text-container>
  </app-page>
</template>
