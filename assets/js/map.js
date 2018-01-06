import L from "leaflet"
import socket from "./socket"

export const TweetsMap = {
  run: () => {
    const attrs = document.querySelector('#attrs')
    const module = TweetsMap

    fetch(`/api/v1/searches/${attrs.dataset.searchId}/tweets/`)
      .then(response => response.json())
      .then(json => json.data)
      .then(data => loadMarkers(data))

    let map = L.map('map').setView([34.19213, -118.48301], 3)

    L.tileLayer('//{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    let loadMarkers = (tweets) => {
      tweets.filter(t => t.latitude !== null)
        .forEach(t => {
          module.putMarker(t, map)
        })
    }

    module.handleSocket(attrs.dataset.searchId, map)
  },

  renderTweet: t => {
    return `
  ${t.text.replace('\n', '<br>')}
  <br>
  <br>
  @${t.handle}
  <br>
  <img src="${t.profile_image_url}" widht="50px" height="50px" />
  `
  },

  putMarker: (tweet, map) => {
    const module = TweetsMap
    let marker = L.marker([tweet.latitude, tweet.longitude])

    marker.addTo(map)
    marker.bindPopup(module.renderTweet(tweet))
  },

  handleSocket: (id, map) => {
    let channel = socket.channel(`search:${id}`, {})
    const module = TweetsMap

    channel.join()
      .receive('ok', resp => { console.log('Joined successfully', resp) })
      .receive('error', resp => { console.log('Unable to join', resp) })

    channel.on('new_tweet', payload => {
      if (payload.data.latitude !== null) {
        module.putMarker(payload.data, map)
      }
    })
  }
}
