require 'test_helper'

class CourierMailerTest < ActionMailer::TestCase

  def test_fetch_couriers
    assert_equal "?", fetch_couriers, "couriers list"
  end

  def _test_finished_task
    @expected.subject = 'CourierMailer#finished_task'
    @expected.body    = read_fixture('finished_task')
    @expected.date    = Time.now

    assert_equal @expected.encoded, CourierMailer.create_finished_task(@expected.date).encoded
  end

end
