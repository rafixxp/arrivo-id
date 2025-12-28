<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import { useRouter, useRoute } from 'vue-router';
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';

const datas = ref([])
const loading = ref(true)

const router = useRouter();
const route = useRoute();

const go = (route) => {
    router.push(route);
}

onBeforeMount(async () => {
    try{
        loading.value = true;
        const response = await axios.get(`/api/attendance/detail/${route.params.id}`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        
        if(response.status === 200){
            datas.value = response.data;
        }

    }
    catch(error){
        Toast.fire({
            icon: 'error',
            title: 'Gagal memuat data kehadiran'
        });
    }
    finally{
        loading.value = false;
    }
})
</script>

<template>
    <!-- Top Bar -->
    <Topbar title="Detail Kehadiran"/>
    <div class="container mb-5">
        <!-- Skeleton Loading -->
        <div v-if="loading">
            <div class="bg-white p-3 rounded mb-2" v-for="i in 2" :key="i">
                <div class="skeleton skeleton-title mb-3"></div>
                <div class="row">
                    <div class="col-5">
                        <div class="skeleton skeleton-image"></div>
                    </div>
                    <div class="col-7">
                        <div class="d-flex flex-column gap-2">
                            <div class="skeleton skeleton-text"></div>
                            <div class="skeleton skeleton-text"></div>
                            <div class="skeleton skeleton-text"></div>
                            <div class="skeleton skeleton-text"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Actual Data -->
        <div v-else>
            <div class="bg-white p-3 rounded mb-2" v-for="data in datas" :key="data.id">
                <h6 class="fw-semibold">{{ data.type == 'clockin' ? 'Kehadiran Masuk' : 'Kehadiran Pulang' }}</h6>
                <div class="row">
                    <div class="col-5">
                        <img :src="data.path" :alt="data.type" width="110" height="110" class="object-fit-cover rounded">
                    </div>
                    <div class="col-7 fs-22">
                        <div class="d-flex flex-column gap-1">
                            <span>Jam : {{ data.time }}</span>
                            <span>Status : <span :class="data.attend == 'Tepat Waktu' ? 'bg-success text-white rounded px-1 fs-21':'bg-danger text-white rounded px-1 fs-21'">{{ data.attend }}</span></span>
                            <span>IP Address : {{ data.ip_address }}</span>
                            <span>Perangkat : {{ data.device }}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 11px;
}
.fs-22{
    font-size: 13px;
}
h6{
font-size: 15px;
}
.btn-add{
    position: fixed;
    bottom: 14vh;
    right: 7vw;
    width: 63px;
    height: 63px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
}

/* Skeleton Loading Styles */
.skeleton {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: loading 1.5s infinite;
    border-radius: 4px;
}

.skeleton-title {
    height: 20px;
    width: 150px;
}

.skeleton-image {
    width: 110px;
    height: 110px;
    border-radius: 8px;
}

.skeleton-text {
    height: 16px;
    width: 100%;
    margin-bottom: 4px;
}

.skeleton-text:last-child {
    width: 80%;
}

@keyframes loading {
    0% {
        background-position: 200% 0;
    }
    100% {
        background-position: -200% 0;
    }
}
</style>