<script setup>
import { computed, onBeforeMount, onMounted, ref } from 'vue'
import Toast from '../lib/toast'
import { icon } from 'leaflet'

let L = null

const loadLeaflet = async () => {
  if (!L) {
    L = await import('leaflet')
    await import('leaflet/dist/leaflet.css')
  }
}

/* define dynamic data state */
const userPos = ref(null)
const destinationPos = ref({ lat: -7.787704, lon: 110.368738, radius: 100 })

/* define state */
const map = ref(null)
const user = ref(null)
const destionation = ref(null)
const distance = ref(0)
const line = ref(null)
const isInRadius = ref(null)
const showWarningModal = ref(false)
let watch = null
let permissions = ref(true)

/* fungsi untuk mengecek izin geolokasi */
const isGeolocationActivated = async () => {
  if(!navigator.geolocation){
    permissions.value = false
    return false
  }

  try{
    const permission = await navigator.permissions.query({name: 'geolocation'})

    if(permission.state === 'denied'){
      permissions.value = false
      return false
    }
    else if(permission.state === 'prompt'){
      permissions.value = true
      return true
    }
    else if(permission.state === 'granted'){
      permissions.value = true
      return true
    }
  }

  catch(error){
    // Jika permissions API tidak didukung, coba langsung getCurrentPosition
    return new Promise((resolve) => {
      navigator.geolocation.getCurrentPosition(
        () => {
          permissions.value = true
          resolve(true)
        },
        () => {
          permissions.value = false
          resolve(false)
        },
        {
          enableHighAccuracy: true,
          timeout: 5000,
          maximumAge: 0
        }
      )
    })
  }
}

/* fungsi untuk tracking dengan gps */
const track = async () => {
  const isActivated = await isGeolocationActivated()
  
  if (!isActivated) {
    return
  }

  watch = navigator.geolocation.getCurrentPosition(
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
  
  const dist = R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  isRadius(dist, destinationPos.value.radius)

  return dist
}

/* fungsi untuk menentukan didalam radius atau tidak */
const isRadius = (distance, radius) => {
   if(distance <= radius){
      isInRadius.value = 0
      showWarningModal.value = false
   }
   else{
      isInRadius.value = 1
      showWarningModal.value = true
   }
}

/* update marker user */
const updateMarker = () => {
  if (!userPos.value) return

  const latlng = [userPos.value.lat, userPos.value.lon]

  if (!user.value) {
    const userIcon = L.icon({
      iconUrl: '/img/nopic.jpg',
      iconSize: [32, 32],
      iconAnchor: [16, 32]
    })

    user.value = L.marker(latlng, { icon: userIcon })
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

onBeforeMount(() => {
  if (watch) {
    navigator.geolocation.clearWatch(watch)
  }

  if (map.value) {
    map.value.remove()
  }
})

onMounted(async () => {
  await loadLeaflet()

  const destIcon = L.icon({
      iconUrl: '/img/nopic.jpg',
      iconSize: [32, 32],
      iconAnchor: [16, 32],
    })

  map.value = L.map('map', {
    zoomControl: false,
    attributionControl: false
  }).setView(
    [destinationPos.value.lat, destinationPos.value.lon],
    17
  )

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
  }).addTo(map.value)

  // marker destinasi
  destionation.value = L.marker([
    destinationPos.value.lat,
    destinationPos.value.lon
  ], { icon: destIcon })
    .addTo(map.value)
    .bindPopup('Kantor')

  // radius kehadiran
  L.circle(
    [destinationPos.value.lat, destinationPos.value.lon],
    {
      radius: destinationPos.value.radius,
      color: 'blue',
      weight: 3,
      fillOpacity: 0.05,
      fillColor: 'blue',
      fill: true,
      interactive: false
    }
  ).addTo(map.value)

  track()
  if(isInRadius == '1'){
    Toast.fire({
      icon: 'info',
      title: 'Anda berada di luar radius!',
      timer: 3000,
      showConfirmButton: false
    })
  }
})

/* modal functions */
const closeWarningModal = () => {
  showWarningModal.value = false
}

/* fungsi untuk format jarak yang mudah dibaca */
const formatDistance = (distanceInMeters) => {
  if (distanceInMeters >= 1000) {
    return (distanceInMeters / 1000).toFixed(1) + ' km'
  } else {
    return distanceInMeters + ' m'
  }
}
</script>

<template>
  <div class="text-center text-sm text-muted mt-1 fs-21">Jarak : {{ formatDistance(distance) }} - <span :class="isInRadius == 0 ? 'text-success fw-semibold':'text-danger fw-semibold'">{{ isInRadius == 0 ? 'Didalam Radius ':'Diluar Radius' }}</span></div>
  <div id="map" style="height: 100px; width: 100%; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;"></div>

  <Teleport to="body">
	  <div v-if="!permissions" class="modal fade show d-block" style="background-color: rgba(0,0,0,0.5);" tabindex="-1" data-bs-backdrop="static">
		<div class="modal-dialog modal-dialog-centered mx-4">
		  <div class="modal-content">
			<div class="modal-header border-0">
			  <h5 class="modal-title text-danger fs-13">
				Peringatan
			  </h5>
			  <button type="button" class="btn-close" @click="closeWarningModal"></button>
			</div>
			<div class="modal-body">
			  <div class="text-center">
				<i class="bi bi-geo-alt-fill text-danger" style="font-size: 2rem;"></i>
				<h6 class="mt-3 fs-13">Fitur lokasi anda tidak aktif !</h6>
				<p class="text-muted fs-21">Pastikan fitur lokasi anda aktif dan izinkan akses ke lokasi anda.</p>
			  </div>
			</div>
			<div class="modal-footer border-0 justify-content-center">
			  <button type="button" class="btn btn-dark btn-sm" @click="track">
				<i class="bi bi-arrow-clockwise me-1"></i>
				Refresh
			  </button>
			</div>
		  </div>
		</div>
	  </div>

	  <div v-if="showWarningModal" class="modal fade show d-block" style="background-color: rgba(0,0,0,0.5);" tabindex="-1" data-bs-backdrop="static">
		<div class="modal-dialog modal-dialog-centered mx-4">
		  <div class="modal-content">
			<div class="modal-header border-0">
			  <h5 class="modal-title text-danger fs-13">
				Peringatan
			  </h5>
			  <button type="button" class="btn-close" @click="closeWarningModal"></button>
			</div>
			<div class="modal-body">
			  <div class="text-center">
				<i class="bi bi-geo-alt-fill text-danger" style="font-size: 2rem;"></i>
				<h6 class="mt-3 fs-13">Anda berada di luar radius!</h6>
				<p class="text-muted fs-21">Jarak Anda dari lokasi: <strong>{{ formatDistance(distance) }}</strong></p>
			  </div>
			</div>
			<div class="modal-footer border-0 justify-content-center">
			  <button type="button" class="btn btn-dark btn-sm" @click="track">
				<i class="bi bi-arrow-clockwise me-1"></i>
				Refresh
			  </button>
			</div>
		  </div>
		</div>
	  </div>
  </Teleport>
</template>

<style scoped>
.fs-21{
  font-size: 12px;
}
.fs-13{
  font-size: 14px;
}
</style>
