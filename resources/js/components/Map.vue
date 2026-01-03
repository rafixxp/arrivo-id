<script setup>
import { onBeforeMount, onMounted, ref } from 'vue'
import * as L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import Toast from '../lib/toast'

/* define dynamic data state */
const userPos = ref(null)
const destinationPos = ref({ lat: -7.793385, lon: 110.360792 })

/* define state */
const map = ref(null)
const user = ref(null)
const destionation = ref(null)
const distance = ref(0)
const line = ref(null)
let watch = null

/* fungsi untuk tracking dengan gps */
const track = () => {
  if (!navigator.geolocation) {
    Toast.fire({
      icon: 'error',
      title: 'Geolokasi tidak didukung pada perangkat anda !'
    })
    return
  }

  watch = navigator.geolocation.watchPosition(
    (post) => {
      const { latitude, longitude } = post.coords

      userPos.value = {
        lat: latitude,
        lon: longitude
      }

      updateMarker()
      updateDistance()
      updateLine()
    },
    () => {
      Toast.fire({
        icon: 'error',
        title: 'Geolokasi tidak berfungsi !'
      })
    },
    {
      enableHighAccuracy: true,
      timeout: 6000,
      maximumAge: 1000
    }
  )
}

/* fungsi untuk menghitung distance */
const distanceMeter = (lat1, lon1, lat2, lon2) => {
  const R = 6371000
  const dLat = (lat2 - lat1) * Math.PI / 180
  const dLon = (lon2 - lon1) * Math.PI / 180

  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(lat1 * Math.PI / 180) *
    Math.cos(lat2 * Math.PI / 180) *
    Math.sin(dLon / 2) ** 2

  return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
}

/* update marker user */
const updateMarker = () => {
  if (!userPos.value) return

  const latlng = [userPos.value.lat, userPos.value.lon]

  if (!user.value) {
    user.value = L.marker(latlng)
      .addTo(map.value)
      .bindPopup('Rafi Ahfa')
  } else {
    user.value.setLatLng(latlng)
  }
}

/* update distance realtime */
const updateDistance = () => {
  distance.value = Math.round(
    distanceMeter(
      userPos.value.lat,
      userPos.value.lon,
      destinationPos.value.lat,
      destinationPos.value.lon
    )
  )
}

/* update garis jarak */
const updateLine = () => {
  if (!userPos.value) return

  const points = [
    [destinationPos.value.lat, destinationPos.value.lon],
    [userPos.value.lat, userPos.value.lon]
  ]

  if (!line.value) {
    line.value = L.polyline(points, {
      color: 'black',
      weight: 1,
      dashArray: '4,4'
    }).addTo(map.value)
  } else {
    line.value.setLatLngs(points)
  }
}

onMounted(() => {
  map.value = L.map('map', {
    zoomControl: false,
    attributionControl: false
  }).setView(
    [destinationPos.value.lat, destinationPos.value.lon],
    16
  )

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
  }).addTo(map.value)

  // marker destinasi
  destionation.value = L.marker([
    destinationPos.value.lat,
    destinationPos.value.lon
  ])
    .addTo(map.value)
    .bindPopup('Kantor')

  // radius kehadiran
  L.circle(
    [destinationPos.value.lat, destinationPos.value.lon],
    {
      radius: 50,
      color: 'blue',
      weight: 3,
      fillOpacity: 0.05,
      fillColor: 'blue',
      fill: true,
      interactive: false
    }
  ).addTo(map.value)

  track()
})

onBeforeMount(() => {
  if (watch) {
    navigator.geolocation.clearWatch(watch)
  }

  if (map.value) {
    map.value.remove()
  }
})
</script>

<template>
  <div
    id="map"
    style="height: 110px; width: 100%; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;"
  ></div>
</template>
