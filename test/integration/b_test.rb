require 'test_helper'

class BTest < ActionDispatch::IntegrationTest
  test 'B1' do
    assert true
  end
  test 'B2' do
    assert true
  end
  test 'B3' do
    assert true
  end
  test 'B4' do
    assert_nil User.has_permission
  end
end
