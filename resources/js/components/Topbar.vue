<script setup>
import { ref } from 'vue';

defineProps({
    title: {
        type: String,
        default: 'Title'
    }
});

const back = () => {
    window.history.length > 1 ? window.history.back() : window.location.href = '/';
}
</script>

<template>
    <nav class="navbar navbar-light bg-white fixed-top">
        <div class="container-fluid px-2 py-1">
            <div class="d-flex align-items-center w-100">

                <!-- Back button -->
                <button class="btn btn-white text-dark p-0 me-2" @click="back">
                    <i class="bi bi-chevron-left fs-3"></i>
                </button>

                <!-- Title -->
                <div class="flex-grow-1 text-center fw-semibold">
                    {{ title }}
                </div>

                <!-- Right action placeholder -->
                <div style="width: 32px"></div>

            </div>
        </div>
    </nav>
</template>
