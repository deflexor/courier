require 'test_helper'

class CourierTasksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courier_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create courier_task" do
    assert_difference('CourierTask.count') do
      post :create, :courier_task => { }
    end

    assert_redirected_to courier_task_path(assigns(:courier_task))
  end

  test "should show courier_task" do
    get :show, :id => courier_tasks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => courier_tasks(:one).to_param
    assert_response :success
  end

  test "should update courier_task" do
    put :update, :id => courier_tasks(:one).to_param, :courier_task => { }
    assert_redirected_to courier_task_path(assigns(:courier_task))
  end

  test "should destroy courier_task" do
    assert_difference('CourierTask.count', -1) do
      delete :destroy, :id => courier_tasks(:one).to_param
    end

    assert_redirected_to courier_tasks_path
  end
end
