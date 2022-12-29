// WebSocket処理のクライアントサイドを受け持つファイル

import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  // 接続時に呼ばれるコールバック
  connected() {
    // Enterを押した時にテキストフィールドの値に対して、speakを実行
    document.
      querySelector('input[data-behavior="room_speaker"]').
      addEventListener('keypress', (event) => {
      if (event.key === 'Enter') {
        this.speak(event.target.value)
        event.target.value = ''
        return event.preventDefault()
      }
    })
  },

  // 接続解除時に呼ばれるコールバック
  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // サーバーからのデータを受信した時に呼ばれるコールバック
  received(data) {
    // 受け取ったメッセージをHTML上に追加
    const element = document.querySelector('#messages')
    element.insertAdjacentHTML('beforeend', data['message'])
  },

  speak: function (message) {
    // Room channelクラスのspeakメソッドをWebSocket経由で呼び出している
    // サーバーサイドへメッセージを送信
    return this.perform('speak', { message: message });
  }
});
