import { mount } from 'vue-test-utils'
import LyButton from '@/components/Ly/LyButton'
import LyIcon from '@/components/Ly/LyIcon'

describe('LyButton', () => {
  describe('type class', () => {
    test('is set to default by default', () => {
      const wrapper = mount(LyButton)

      expect(wrapper.classes()).toContain('ly-button-default')
    })

    test('is set to the given type prop', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ type: 'primary' })

      expect(wrapper.classes()).toContain('ly-button-primary')
    })
  })

  describe('size class', () => {
    test('is set to normal by default', () => {
      const wrapper = mount(LyButton)

      expect(wrapper.classes()).toContain('ly-button-normal')
    })

    test('is set to the given size prop', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ size: 'small' })

      expect(wrapper.classes()).toContain('ly-button-small')
    })
  })

  describe('submit prop is given', () => {
    test('type attribute is set to submit', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ submit: true })

      expect(wrapper.attributes().type).toBe('submit')
    })
  })

  describe('disabled prop is given', () => {
    test('class is set to disabled', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ disabled: true })

      expect(wrapper.classes()).toContain('disabled')
    })

    test('disabled attribute is set', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ disabled: true })

      expect(wrapper.attributes().disabled).toBe('disabled')
    })
  })

  describe('icon prop is given', () => {
    test('ly-icon is rendered inside', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ icon: 'heart' })

      expect(wrapper.contains(LyIcon)).toBeTruthy()
    })
  })
})
