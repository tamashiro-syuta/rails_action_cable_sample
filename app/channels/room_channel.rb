# WebSocket処理のサーバーサイドを受け持つファイル
class RoomChannel < ApplicationCable::Channel
  # 購読後に呼ばれるメソッド
  def subscribed
    # "room_channel"というブロードキャスト用のストリーム名を設定
    # broadcast = 全購読者への送信
    stream_from "room_channel"
  end

  # 購読解除後に呼ばれるメソッド
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # clientから呼び出された時に呼ばれるメソッド
  def speak(data)
    puts "data"
    puts data
    message = Message.create!(content: data["message"])
    # クライアントからメッセージが届くと、ActionCable.server.broadcastメソッドを使って、ストリーム名"room_channel"で通信しているクライアントすべてに届いたメッセージを送信
    ActionCable.server.broadcast(
      "room_channel", { message: render_message(message) }
    )
  end

  private
  def render_message(message)
    # ApplicationController.renderは、外部のテンプレートのレンダリングを行えます
    ApplicationController.render(
      # view/messages/_message.html.erbをレンダリングしている
      partial: "messages/message",
      locals: { message: message}
    )
  end
end
