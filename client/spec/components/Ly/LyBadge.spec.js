import { mount } from 'vue-test-utils'
import LyBadge from '@/components/Ly/LyBadge'

describe('LyBadge', () => {
  describe('type class', () => {
    test('is set to default by default', () => {
      const wrapper = mount(LyBadge)

      expect(wrapper.hasClass('ly-badge-default')).toBeTruthy()
    })

    test('is set to the given type prop', () => {
      const wrapper = mount(LyBadge)

      wrapper.setProps({ type: 'primary' })

      expect(wrapper.hasClass('ly-badge-primary')).toBeTruthy()
    })

    test('is set to the first enabled type if prop is an object', () => {
      const wrapper = mount(LyBadge)

      wrapper.setProps({ type: {
        primary: false,
        success: true,
      } })

      expect(wrapper.hasClass('ly-badge-success')).toBeTruthy()
    })

    test('is set to default if all types are false if prop is an object', () => {
      const wrapper = mount(LyBadge)

      wrapper.setProps({ type: {
        primary: false,
        success: false,
      } })

      expect(wrapper.hasClass('ly-badge-default')).toBeTruthy()
    })
  })

  describe('name class', () => {
    test('is set to the given name prop', () => {
      const wrapper = mount(LyBadge)

      wrapper.setProps({ name: 'hello' })

      expect(wrapper.hasClass('ly-badge-hello')).toBeTruthy()
    })
  })

  describe('size class', () => {
    test('is set to normal by default', () => {
      const wrapper = mount(LyBadge)

      expect(wrapper.hasClass('ly-badge-normal')).toBeTruthy()
    })

    test('is set to the given size prop', () => {
      const wrapper = mount(LyBadge)

      wrapper.setProps({ size: 'small' })

      expect(wrapper.hasClass('ly-badge-small')).toBeTruthy()
    })
  })
})
