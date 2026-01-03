<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import { useRouter } from 'vue-router';
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';

const datas = ref([])
const loading = ref(true)

const router = useRouter();

const go = (route) => {
    router.push(route);
}

onBeforeMount(async () => {
    try{
        loading.value = true;
        const response = await axios.get('/api/employees', {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        
        if(response.status === 200){
            datas.value = response.data.data;
        }

        console.log(response);
    }
    catch(error){
        Toast.fire({
            icon: 'error',
            title: 'Gagal memuat data jabatan'
        });
    }
    finally{
        loading.value = false;
    }
})
</script>

<template>
    <!-- Top Bar -->
    <Topbar title="Karyawan"/>
    <div class="container px-2 pt-0 pb-2 position-fixed bg-white z-index-99">
        <div class="row px-3">
            <div class="col-12 py-1 ps-0 pe-2">
                <div class="bg-white px-2 rounded border border-muted d-flex align-items-center">
                    <span class="bi bi-search me-2 fs-21 text-muted"></span>
                    <input type="search" name="" class="form-control fs-22 border-0" placeholder="Cari karyawan..">
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-5 mt-5">
        <div v-if="loading">
            <div class="bg-white col-12 p-3 rounded my-2" v-for="i in 5" :key="i">
                <div class="row align-items-center">
                    <div class="col-10">
                        <div class="d-flex align-items-center">
                            <div class="skeleton skeleton-avatar me-3"></div>
                            <div class="flex-grow-1">
                                <div class="skeleton skeleton-name mb-2"></div>
                                <div class="skeleton skeleton-email"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-2 p-2">
                        <div class="skeleton skeleton-chevron"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Actual Data -->
        <div v-else>
        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer" v-for="data in datas" :key="data.id" @click="go('/employee/detail/' + data.id)">
            <div class="row align-items-center">
                <div class="col-10">
                    <div class="d-flex align-items-center">
                        <img :src="`/img/nopic.jpg`" 
                             class="rounded-circle me-3" width="48" height="48" alt="profile">
                        <div>
                            <h6 class="m-0 mt-2 fw-semibold">{{ data.name }}</h6>
                            <span class="fs-21 text-muted">{{ data.email }}</span>
                        </div>
                    </div>
                </div>
                <div class="col-2 p-2">
                    <button class="btn" type="button" data-bs-toggle="dropdown">
                        <span class="bi bi-chevron-right fs-22"></span>
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
font-size: 14px;
}
.form-control{
    border: none;
    font-size: 13px;
}
.form-control:focus{
    box-shadow: none;
}
.pt-0{
    margin-top: -17px !important;
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
    
    .form-control {
        font-size: 14px;
        padding: 0.75rem;
    }
    
    img[width="45"] {
        width: 55px;
        height: 55px;
    }
    
    .btn-add {
        width: 70px;
        height: 70px;
        bottom: 3vh;
        right: 3vw;
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
    
    .form-control {
        font-size: 15px;
        padding: 0.875rem;
    }
    
    img[width="45"] {
        width: 65px;
        height: 65px;
    }
    
    .btn-add {
        width: 75px;
        height: 75px;
        bottom: 2vh;
        right: 2vw;
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

/* Skeleton Loading Styles */
.skeleton {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: loading 1.5s infinite;
    border-radius: 4px;
}

.skeleton-avatar {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    flex-shrink: 0;
}

.skeleton-name {
    height: 18px;
    width: 150px;
}

.skeleton-email {
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
</style>