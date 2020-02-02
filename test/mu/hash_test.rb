require 'test_helper'

class Mu::HashTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Mu::Hash::VERSION
  end

  def test_
    source = {
      'service' => {
          'username' => 'foo',
          'password' => 'bar',
      },
    }

    content = Mu::Hash.new(source)

    assert content.service.username.unwrap == 'foo'
    assert content.service.password.unwrap == 'bar'

    assert content.service.unwrap == { 'username' => 'foo', 'password' => 'bar' }

    assert content.service['username'].unwrap == 'foo'
    assert content.service['password'].unwrap == 'bar'

    assert content['service']['username'].unwrap == 'foo'
    assert content['service']['password'].unwrap == 'bar'

    assert_raises(Mu::Hash::Error) do
      content.service.something_that_does_not_exist
    end
  end
end
