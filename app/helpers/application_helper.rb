module ApplicationHelper
  def mypage?
    current_user && current_user == user_of_context
  end
end
