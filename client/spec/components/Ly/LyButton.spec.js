import { mount } from 'vue-test-utils'
import LyCard from '@/components/Ly/LyCard'

describe('LyCard', () => {
  describe('name class', () => {
    test('is set to the given prop', () => {
      const wrapper = mount(LyCard)

      wrapper.setProps({ name: 'hello' })

      expect(wrapper.classes()).toContain('ly-card-hello')
    })
  })

  describe('image prop', () => {
    test('a background image is set', () => {
      const wrapper = mount(LyCard)

      wrapper.setProps({ image: '/static/back.jpg' })

      const renderedCard = wrapper.html()
      expect(renderedCard).toMatch(/background-image: url\(\/static\/back.jpg\)/)
    })
  })
})
