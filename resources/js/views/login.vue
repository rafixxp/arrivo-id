<script setup>
import { ref, onMounted, onBeforeUnmount, computed } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import Toast from '../lib/toast'

const router = useRouter()

const credential = ref({
    email: '',
    password: ''
})

const deferredPrompt = ref(null)
const isInstallable = ref(false)

const user = computed(() => {
    return JSON.parse(localStorage.getItem('user'))
})

// HANDLER
const beforeInstallPromptHandler = (e) => {
    e.preventDefault()
    deferredPrompt.value = e
    isInstallable.value = true
    console.log('PWA installable')
}

onMounted(() => {
    window.addEventListener('beforeinstallprompt', beforeInstallPromptHandler)

    // FALLBACK: cek manual (Chrome Desktop)
    if (window.matchMedia('(display-mode: standalone)').matches === false) {
        setTimeout(() => {
            isInstallable.value = true
        }, 2000)
    }
})

onBeforeUnmount(() => {
    window.removeEventListener('beforeinstallprompt', beforeInstallPromptHandler)
})

const showInstallPrompt = async () => {
    if (!deferredPrompt.value) {
        Toast.fire({
            icon: 'info',
            title: 'Gunakan menu browser untuk install aplikasi'
        })
        return
    }

    deferredPrompt.value.prompt()
    const { outcome } = await deferredPrompt.value.userChoice

    if (outcome === 'accepted') {
        Toast.fire({
            icon: 'success',
            title: 'Aplikasi berhasil diinstall 🎉'
        })
    } else {
        Toast.fire({
            icon: 'info',
            title: 'Install dibatalkan'
        })
    }

    deferredPrompt.value = null
    isInstallable.value = false
}

const SignIn = async () => {
    try {
        const response = await axios.post('/api/signin', credential.value)

        if (response.status === 200) {
            localStorage.setItem('user', JSON.stringify(response.data.user))
            localStorage.setItem('token', response.data.access_token)
            router.push(response.data.redirect)
        }
    } catch (error) {
        Toast.fire({
            icon: 'error',
            title: error.response?.data?.message || 'Terjadi kesalahan saat login',
        })
    }
}
</script>

<template>
    <div class="d-flex flex-column align-items-center">
        <!-- CARD -->
        <div class="container mx-3 vh-50 bg-white p-3 rounded w-125">
            <div class="text-center">
                <img src="../assets/icon.webp" width="75" height="75"
                     class="rounded shadow-sm mb-3">
                <h5 class="fw-bold m-0">Sign In</h5>
                <span class="text-muted fs-21">
                    Silahkan masuk dengan akun anda
                </span>
            </div>

            <div class="form-group mt-3">
                <label class="fs-21">Email atau nomor telepon</label>
                <input type="text" class="form-control"
                       v-model="credential.email">
            </div>

            <div class="form-group mt-1">
                <label class="fs-21">Password</label>
                <input type="password" class="form-control"
                       v-model="credential.password">
            </div>

            <div class="form-group mt-3">
                <button class="btn btn-dark w-100" @click="SignIn">
                    Sign In
                </button>
            </div>

            <!-- INSTALL BUTTON -->
            <div
                v-if="!user && isInstallable"
                class="form-group mt-2"
            >
                <button
                    class="btn btn-sm btn-outline-dark w-100"
                    @click="showInstallPrompt"
                >
                    <span class="bi bi-cloud-arrow-down"></span>
                    Install App
                </button>
            </div>
        </div>

        <!-- FORGOT PASSWORD -->
        <div class="mt-3 text-center">
            <router-link
                to="/forgot-password"
                class="text-decoration-none text-muted fs-21"
            >
                Lupa password?
            </router-link>
        </div>
    </div>
</template>


<style scoped> 
.fs-21{
    font-size: 12px; 
}
.w-125{ 
    width: 300px; 
}
</style>