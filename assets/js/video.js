import Player from "./player"

let Video = {
  init(socket, element) {
    if (!element) { return }

    let videoId = element.getAttribute("data-id")
    let playerId = element.getAttribute("data-player-id")
    socket.connect()

    Player.init(element.id, playerId, () => {
      this.onReady(videoId, socket)
    })
  },

  onReady(videoId, socket) {
    let msgContainer = document.getElementById("msg-container")
    let msgInput = document.getElementById("msg-input")
    let msgPostBtn = document.getElementById("msg-submit")
    let videoChannel = socket.channel(`videos:${videoId}`)

    videoChannel.join()
      .receive("ok", resp => { console.log("Joined Video successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    videoChannel.on("ping", ({count}) => { console.log("PING", count)})

    msgPostBtn.addEventListener("click", function(){
      let payload = {body: msgInput.value, at: Player.getCurrentTime()}
      videoChannel.push("new_annotation", payload).receive("error", e => console.log(e))
      msgInput.value = ""
    })

    videoChannel.on("new_annotation", (resp) => {
      this.renderAnnotation(msgContainer, resp)
    })
  },

  esc(str) {
    let div = document.createElement("div")
    div.appendChild(document.createTextNode(str))
    return div.innerHTML
  },

  renderAnnotation(msgContainer, {user, body, at}) {
    let template = document.createElement("div")
    template.innerHTML = `
    <a href="#" data-seek="${this.esc(at)}">
      <b>${this.esc(user.username)}</b>: ${this.esc(body)}
    </a>
    `
    msgContainer.appendChild(template)
    msgContainer.scrollTop = msgContainer.scrollHeight
  }
}

export default Video
