import 'leaflet/dist/leaflet.css';
import L from 'leaflet';

export default {
  mounted() {
    this.initMap();
  },
  methods: {
    initMap() {
      const map = L.map('user-map').setView([-6.2, 106.816666], 13); // Default Jakarta
      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap'
      }).addTo(map);
      // Optionally, add marker for user location
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(pos => {
          const lat = pos.coords.latitude;
          const lng = pos.coords.longitude;
          L.marker([lat, lng]).addTo(map).bindPopup('Lokasi Anda').openPopup();
          map.setView([lat, lng], 16);
        });
      }
    }
  }
};
