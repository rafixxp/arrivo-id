<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import { useRouter } from 'vue-router';
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';

const datas = ref([])
const loading = ref(true)
const dataFilter = ref('today')

const router = useRouter();

const go = (route) => {
    router.push(route);
}

const filterReq = async (data) => {
    const response = await axios.post('/api/attendance/daily', {
        filter: data
    },
    {
        headers: {
            'Authorization' : `Bearer ${localStorage.getItem('token')}`
        }
    })

    datas.value = response.data;
}

const filter = () => {
    if(dataFilter.value === 'today'){
        filterReq('today');
    }
    else if (dataFilter.value === 'week'){
        filterReq('week');
    }
    else if (dataFilter.value === 'month'){
        filterReq('month');
    }
    else if (dataFilter.value === 'custom'){
        filterReq('custom');
    }

}
onBeforeMount(async () => {
    try{
        loading.value = true;
        const response = await axios.get('/api/approval/list', {
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
    <Topbar title="Approval"/>

    <div class="container px-2 pt-0 pb-2 position-fixed bg-white z-index-99">
        <div class="row px-3">
            <div class="col p-1">
                <label class="fs-21 px-1">Filter Tanggal</label>
                <select class="form-select fs-21 border-1" v-model="dataFilter" @change="filter">
                    <option value="today">Hari Ini</option>
                    <option value="week">Minggu Ini</option>
                    <option value="month">Bulan Ini</option>
                    <option value="custom">Sesuaikan Tanggal</option>
                </select>
            </div>
            <div class="col p-1 px-1">
                <label class="fs-21">Filter Cabang</label>
                <select class="form-select fs-21 border-1">
                    <option value="">Pilih Cabang</option>
                </select>
            </div>
        </div>
    </div>

    <div class="container mb-5 mt-5 pt-3">
        <!-- Skeleton Loading -->
        <div v-if="loading">
            <div class="bg-white col-12 p-3 rounded my-2" v-for="i in 5" :key="i">
                <div class="row align-items-center">
                    <div class="col-10">
                        <div class="d-flex align-items-center">
                            <div class="skeleton skeleton-avatar me-3"></div>
                            <div class="flex-grow-1">
                                <div class="skeleton skeleton-name mb-2"></div>
                                <div class="skeleton skeleton-time"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Actual Data -->
        <div v-else>
            <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer" v-for="data in datas" :key="data.id" @click="go('/attendance/approval/' + data.id)">
                <div class="row align-items-center">
                    <div class="col-10">
                        <div class="d-flex align-items-center">
                            <img :src="data.clockin_photo ?? `https://ui-avatars.com/api/?name=${data.name}&background=0d6efd&color=fff&size=40&bold=true`" 
                                 class="rounded me-3 object-fit-cover rounded-circle" width="60" height="60" alt="profile">
                            <div>
                                <h6 class="my-1 fw-semibold">{{ data.name }}</h6>
                                <p class="fs-21 text-muted mb-1">{{ data.date }}</p>
                                <span class="fs-21 bg-primary text-white px-1 rounded me-1">{{ data.type }}</span>
                                <span class="fs-21 bg-warning text-white px-1 rounded" v-if="data.status == 'pending'"><span class="bi bi-clock pe-1"></span>Pending</span>
                                <span class="fs-21 bg-danger text-white px-1 rounded" v-if="data.status == 'rejected'"><span class="bi bi-x-circle pe-1"></span>Ditolak</span>
                                <span class="fs-21 bg-success text-white px-1 rounded" v-if="data.status == 'approved'"><span class="bi bi-check-circle pe-1"></span>Diterima</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-2 p-2">
                        <button class="btn" type="button" data-bs-toggle="dropdown">
                            <strong class="bi bi-chevron-right"></strong>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <router-link to="/employee/add" class="btn btn-dark btn-add rounded-circle"><span class="bi bi-plus"></span></router-link>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 11px;
}
.fs-22{
    font-size: 14px;
}
h6{
    font-size: 15px;
}
.pt-0{
    margin-top: -16px !important;
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
.dropdown-menu {
    z-index: 1055;
}

/* Skeleton Loading Styles */
.skeleton {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: loading 1.5s infinite;
    border-radius: 4px;
}

.skeleton-avatar {
    width: 53px;
    height: 53px;
    border-radius: 8px;
    flex-shrink: 0;
}

.skeleton-name {
    height: 18px;
    width: 150px;
}

.skeleton-time {
    height: 14px;
    width: 200px;
}

.skeleton-chevron {
    width: 24px;
    height: 24px;
    border-radius: 4px;
}

@keyframes loading {
    0% {
        background-position: 200% 0;
    }
    100% {
        background-position: -200% 0;
    }
}

/* Tablet styles */
@media (min-width: 768px) {
    .container {
        max-width: 750px;
        margin: 0 auto;
    }
    
    .fs-21 {
        font-size: 13px;
    }
    
    .fs-22 {
        font-size: 15px;
    }
    
    h6 {
        font-size: 16px;
    }
    
    .bg-white.p-3 {
        padding: 1.5rem !important;
    }
    
    .form-select {
        font-size: 14px;
        padding: 0.75rem;
    }
    
    img[width="65"] {
        width: 75px;
        height: 75px;
    }
    
    .btn-add {
        width: 70px;
        height: 70px;
        bottom: 3vh;
        right: 3vw;
    }
    
    .skeleton-avatar {
        width: 65px;
        height: 65px;
    }
}

/* Desktop styles */
@media (min-width: 1024px) {
    .container {
        max-width: 1000px;
    }
    
    .fs-21 {
        font-size: 14px;
    }
    
    .fs-22 {
        font-size: 16px;
    }
    
    h6 {
        font-size: 17px;
    }
    
    .bg-white.p-3 {
        padding: 2rem !important;
    }
    
    .form-select {
        font-size: 15px;
        padding: 0.875rem;
    }
    
    img[width="65"] {
        width: 85px;
        height: 85px;
    }
    
    .btn-add {
        width: 75px;
        height: 75px;
        bottom: 2vh;
        right: 2vw;
    }
    
    .skeleton-avatar {
        width: 70px;
        height: 70px;
    }
}

/* Large desktop styles */
@media (min-width: 1200px) {
    .container {
        max-width: 1140px;
    }
    
    .btn-add {
        bottom: 2vh;
        right: 1vw;
    }
}
</style>