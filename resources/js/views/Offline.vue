<template>
  <div class="offline-container">
    <main>
      <svg class="wifi" viewBox="0 0 64 64">
        <path class="wave wave1" d="M16 40 Q32 24 48 40" />
        <path class="wave wave2" d="M12 34 Q32 16 52 34" />
        <path class="wave wave3" d="M8 28 Q32 8 56 28" />
        <circle class="dot" cx="32" cy="44" r="4" />
      </svg>
      <h1>Koneksi Terputus</h1>
      <p>Anda sedang offline.<br />Cek koneksi internet Anda dan coba lagi.</p>
      <button class="retry-btn" @click="retryConnection">Coba Lagi</button>
    </main>
  </div>
</template>

<script>
export default {
  name: 'OfflineView',
  mounted() {
    // Auto-retry every 10 seconds if user stays on page
    this.retryInterval = setInterval(() => {
      if (navigator.onLine) {
        window.location.reload();
      }
    }, 10000);
  },
  beforeUnmount() {
    if (this.retryInterval) {
      clearInterval(this.retryInterval);
    }
  },
  methods: {
    retryConnection() {
      window.location.reload();
    }
  }
};
</script>

<style scoped>
.offline-container {
  height: 100%;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #f7fafc 0%, #e3e9f6 100%);
  font-family: 'Inter', Arial, sans-serif;
}

main {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100vw;
  min-height: 100vh;
  text-align: center;
}

.wifi {
  width: 90px;
  height: 90px;
  margin: 0 auto 1.5rem auto;
  display: block;
}

.wifi .wave {
  fill: none;
  stroke: #2d3748;
  stroke-width: 5;
  stroke-linecap: round;
  opacity: 0.15;
  transform-origin: 50% 70%;
  animation: wifi-wave 2.2s infinite ease-in-out;
}

.wifi .wave2 { animation-delay: 0.3s; }
.wifi .wave3 { animation-delay: 0.6s; }

@keyframes wifi-wave {
  0%, 100% { 
    opacity: 0.15; 
    transform: scale(0.95); 
  }
  50% { 
    opacity: 1; 
    transform: scale(1.05); 
  }
}

.wifi .dot {
  fill: #f56565;
  animation: dot-blink 1.2s infinite alternate;
}

@keyframes dot-blink {
  0%, 100% { fill: #f56565; }
  50% { fill: #e53e3e; }
}

h1 {
  font-size: 2rem;
  color: #2d3748;
  margin-bottom: 0.5rem;
}

p {
  color: #4a5568;
  font-size: 1.1rem;
  margin-bottom: 1.5rem;
  line-height: 1.6;
}

.retry-btn {
  background: linear-gradient(90deg, #667eea 0%, #5a67d8 100%);
  color: #fff;
  border: none;
  padding: 0.75rem 2rem;
  border-radius: 999px;
  font-size: 1rem;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(90, 103, 216, 0.08);
  transition: background 0.3s, transform 0.2s;
}

.retry-btn:active {
  transform: scale(0.97);
}

@media (max-width: 600px) {
  main {
    padding: 1.5rem 1rem;
  }
  h1 { 
    font-size: 1.4rem; 
  }
  .wifi { 
    width: 64px; 
    height: 64px; 
  }
}

@media (min-width: 700px) and (max-width: 1024px) {
  main { 
    max-width: 500px; 
    padding: 2.5rem 3rem; 
  }
  h1 { 
    font-size: 2.2rem; 
  }
}
</style>
