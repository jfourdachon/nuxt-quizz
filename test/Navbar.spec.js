import { mount } from '@vue/test-utils'
import Navbar from '@/components/'

describe('Navbar', () => {
  test('is a Vue instance', () => {
    const wrapper = mount(Navbar)
    expect(wrapper.vm).toBeTruthy()
  })
})
