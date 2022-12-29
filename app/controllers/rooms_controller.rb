class RoomsController < ApplicationController
  def show
    # ログイン機能の仮コード(cookieにユーザーIDを保存)
    cookies.signed[:user_id] = User.first.id
    @messages = Message.all
  end
end
