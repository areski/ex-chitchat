let Room = {
  init(socket, el) {
    let roomId = el.getAttribute("data-id");
    console.log(`Element: ${el}, roomId: ${roomId}`)
    socket.connect()
    this.onReady(roomId, socket)
  },
  onReady(roomId, socket) {
    let msgContainer = document.getElementById("msg-container")
    let msgInput = document.getElementById("msg-input")
    let postButton = document.getElementById("msg-submit")
    let RoomChannel = socket.channel("rooms:" + roomId)

    postButton.addEventListener("click", e => {
      RoomChannel.push("new_chat", { body: msgInput.value })
        .receive("error", e => console.log(e))

      msgInput.value = ""
    })

    RoomChannel.on("new_chat", resp => {
      console.log(resp)
      this.renderChat(msgContainer, resp)
    })

    RoomChannel.join()
      .receive("ok", resp => console.log("joined room channel:", resp))
      .receive("error", reason => console.log("failed to join:", reason));
  },

  esc(input) {
    let div = document.createElement("div")
    div.appendChild(document.createTextNode(input))
    return div.innerHTML
  },

  renderChat(msgContainer, { body }) {
    let div = document.createElement("div")

    div.innerHTML = `
    <span>
      <strong>Anonymous</strong>: ${this.esc(body)}
    </span>
    `

    msgContainer.appendChild(div)
    msgContainer.scrollTop = msgContainer.scrollHeight
  }
}
export default Room;