# WebSocket処理のサーバーサイドを受け持つファイル
class RoomChannel < ApplicationCable::Channel
  # 購読後に呼ばれるメソッド
  def subscribed
    # stream_from "some_channel"
  end

  # 購読解除後に呼ばれるメソッド
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # clientから呼び出された時に呼ばれるメソッド
  def speak
  end
end
