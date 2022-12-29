module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # current_userメソッドと、current_user=メソッドの2つが作られる
    identiffied_by :current_user

    # clientが接続するしたときに呼ばれる
    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      # ログイン済みのユーザーIDを取得できると仮定
      # ActionCableをサブドメインで運用している場合は、両方のドメインでcookieを共有できるように設定が必要
      if verified_user = User.find_by(id: cookies.signed[:user_id])
        verified_user
      else
        # websocketでの接続点を取り止めるメソッド
        reject_unauthorized_connection
      end
    end

  end
end
