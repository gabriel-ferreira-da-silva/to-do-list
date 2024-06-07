require "test_helper"

class TarefasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tarefas_new_url
    assert_response :success
  end

  test "should get create" do
    get tarefas_create_url
    assert_response :success
  end
end
