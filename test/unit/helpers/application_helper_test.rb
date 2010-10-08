require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test 'link_to_action_partial_if does not execute block if condition is false' do
    assert_nothing_raised do
      link_to_action_partial_if(false, 'do something', 'image') { raise }
    end
  end

  test 'link_to_action_partial_if renders link of condition is true' do
    link = link_to_action_partial_if(true, 'do something', 'image') { root_url }
    assert link.match(/^\<a.*\>/)
    assert link.include?(root_url)
  end

end
