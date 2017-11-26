import { mount } from 'vue-test-utils'
import LyButton from '@/components/Ly/LyButton'
import LyIcon from '@/components/Ly/LyIcon'

describe('LyButton', () => {
  describe('type class', () => {
    test('is set to default by default', () => {
      const wrapper = mount(LyButton)

      expect(wrapper.hasClass('ly-button-default')).toBeTruthy()
    })

    test('is set to the given type prop', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ type: 'primary' })

      expect(wrapper.hasClass('ly-button-primary')).toBeTruthy()
    })
  })

  describe('size class', () => {
    test('is set to normal by default', () => {
      const wrapper = mount(LyButton)

      expect(wrapper.hasClass('ly-button-normal')).toBeTruthy()
    })

    test('is set to the given size prop', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ size: 'small' })

      expect(wrapper.hasClass('ly-button-small')).toBeTruthy()
    })
  })

  describe('submit prop is given', () => {
    test('type attribute is set to submit', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ submit: true })

      expect(wrapper.hasAttribute('type', 'submit')).toBeTruthy()
    })
  })

  describe('disabled prop is given', () => {
    test('class is set to disabled', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ disabled: true })

      expect(wrapper.hasClass('disabled')).toBeTruthy()
    })

    test('disabled attribute is set', () => {
      const wrapper = mount(LyButton)

      wrapper.setProps({ disabled: true })

      expect(wrapper.hasAttribute('disabled', 'disabled')).toBeTruthy()
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
