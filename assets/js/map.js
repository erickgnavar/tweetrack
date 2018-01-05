import L from "leaflet"

export const TweetsMap = {
  run: () => {
    const attrs = document.querySelector('#attrs')

    fetch(`/api/v1/searches/${attrs.dataset.searchId}/tweets/`)
      .then(response => response.json())
      .then(json => json.data)
      .then(data => loadMarkers(data))

    let map = L.map('map').setView([34.19213, -118.48301], 3)

    L.tileLayer('//{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    let renderTweet = t => {
      return `
  ${t.text.replace('\n', '<br>')}
  <br>
  <br>
  @${t.handle}
  <br>
  <img src="${t.profile_image_url}" widht="50px" height="50px" />
  `
    }

    let loadMarkers = (tweets) => {
      tweets.filter(t => t.latitude !== null)
        .forEach(t => {
          let marker = L.marker([t.latitude, t.longitude])
          marker.addTo(map)
          marker.bindPopup(renderTweet(t))
        })
    }

  }
}
