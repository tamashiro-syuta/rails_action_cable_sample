// WebSocket処理のクライアントサイドを受け持つファイル

import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  // 接続時に呼ばれるコールバック
  connected() {
    // Called when the subscription is ready for use on the server
  },

  // 接続解除時に呼ばれるコールバック
  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // サーバーからのデータを受信した時に呼ばれるコールバック
  received(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  speak: function () {
    // Room channelクラスのspeakメソッドをWebSocket経由で呼び出している
    return this.perform('speak');
  }
});
