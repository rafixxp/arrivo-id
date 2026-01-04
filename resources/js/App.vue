<template>
    <router-view></router-view>
</template>

<script setup>
import { watch } from 'vue'
import useNetworkStatus from './lib/networkstatus'
import Toast from './lib/toast'

const { isOnline } = useNetworkStatus()

watch(isOnline, (status) => {
  if (!status) {
    Toast.fire({
      icon: 'warning',
      title: 'Koneksi anda terputus !'
    })
  } else {
    Toast.fire({
      icon: 'success',
      title: 'Anda terhubung kembali !'
    })
  }
})
</script>