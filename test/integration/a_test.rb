require 'test_helper'

class ATest < ActionDispatch::IntegrationTest
  test 'A1' do
    assert true
  end
  test 'A2' do
    User.has_permission = false if rand(2).zero?
    assert true
  end
  test 'A3' do
    assert true
  end
  test 'A4' do
    assert true
  end
end
