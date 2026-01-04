<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const user = JSON.parse(localStorage.getItem('user'))
const router = useRouter()

defineProps({
    title: {
        type: String,
        default: 'Title'
    }
});

const back = () => {
    window.history.length > 1 ? window.history.back() : window.location.href = '/';
}

const go = (component) => {
    router.push(component)
}
</script>

<template>
    <nav class="navbar navbar-light bg-white fixed-top">
        <div class="container-fluid px-2 py-1">
            <div class="d-flex align-items-center w-100">
                <div class="d-flex align-items-center justify-content-between w-100">
                    <!-- Back button -->
                    <button class="btn btn-white text-dark p-0 me-2" @click="back">
                        <i class="bi bi-chevron-left fs-3"></i>
                    </button>

                    <!-- Title -->
                    <div class="fw-semibold px-2" style="font-size: 1.05rem;">
                        {{ title }}
                    </div>

                    <!-- Right action placeholder -->
                    <div class="d-flex align-items-center pe-1 pt-1" style="min-width:45px; justify-content: flex-end;">
                        <img :src="`/img/nopic.jpg`" class="rounded-circle object-fit-cover" width="35" height="35" alt="profile" @click="go('/profile')">
                    </div>
                </div>
            </div>
        </div>
    </nav>
</template>
