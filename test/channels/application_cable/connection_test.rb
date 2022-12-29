require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  # 作成されたコネクションの認証ユーザー情報がcookieのユーザー情報と一致するかテスト
  test "connection accepts" do
    # ユーザーの作成し、cookieにidを代入
    user = User.first
    cookies.signed[:user_id] = user.id

    # コネクションを接続(これでConnectionオブジェクトが取得できるようになる)
    connect

    # (identifired_byで作成された)current_userメソッドを呼び出して、上でセットしたユーザーIDと同じか検証
    assert_equal connection.current_user.id, user.id
  end

  # 認証エラーになるパターンをテスト
  test "connection rejects" do
    # cookieをnilに設定
    cookies.signed[:user_id] = nil
    # cookieにユーザーIDがない状態で、connect(コネクションの作成)をすると、接続ができないことを検証
    assert_reject_connection { connect }
  end
end
