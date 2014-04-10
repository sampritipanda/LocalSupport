module ControllerHelpers
  def make_current_user_admin
    admin_user = double :user, admin: true
    request.env['warden'].stub :authenticate! => admin_user
    controller.stub :current_user => admin_user
    admin_user
  end
  def make_current_user_non_admin
    non_admin_user = double :user, admin: false
    request.env['warden'].stub :authenticate! => non_admin_user
    controller.stub :current_user => non_admin_user
    non_admin_user
  end
end

module RequestHelpers
  def login(user)
    post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end
end