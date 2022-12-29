require "test_helper"

class RoomChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    # テスト用に購読者作成するをシュミレート
    subscribe
    # subscriptionメソッドでRoomChannelオブジェクトを取得できるので、confirmメソッドで正しく購読できているかを確認
    assert subscription.confirmed?
    # 引数と同じ名前のstreamが作成されているかを確認
    assert_has_stream "room_channel"
  end

  test 'braodcast' do
    subscribe
    text = 'hello'
    braodcast_text = ApplicationController.render(
      partial: "messages/message",
      locals: { message: Message.new(content: text)}
    )

    # broadcast用のヘルパーメソッドを使って、speakメソッドを呼び出し、私た文字列(text)を含むHTMLがブロードキャストされたか確認
    assert_broadcast_on('room_channel', message: braodcast_text) do
      perform :speak, message: text
    end
  end
end
