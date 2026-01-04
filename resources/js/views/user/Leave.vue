<script setup>
import { ref, onBeforeMount } from 'vue'
import axios from 'axios'
import Toast from '../../lib/toast'
import Topbar from '../../components/Topbar.vue'
import { useRoute,useRouter } from 'vue-router'
import Swal from 'sweetalert2'

const route = useRoute()
const router = useRouter()

const datas = ref([])

const detail = async (id) => {
    router.push(`/leave/${id}`)
}

onBeforeMount(async () => {
    try {
        const response = await axios.get('/api/leave', {
            headers:{
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })
    
        if(response.status == 200){
            datas.value = response.data
        }
    } catch (error) {
        Toast.fire({
            icon: 'error',
            title: error.response
        })   
    }
})
</script>

<template>
    <Topbar title="Pengajuan"/>
    <div class="container mb-2 pb-5 px-3">

        <!-- <div class="bg-white rounded p-2">
            <div class="row text-center">
                <div class="col-6">
                    <h5 class="mb-1">12</h5>
                    <span class="fs-21 text-muted">Izin Tersedia</span>
                </div>
                <div class="col-6">
                    <h5 class="mb-1">0</h5>   
                    <span class="fs-21 text-muted">Izin Digunakan</span>
                </div>
            </div>
        </div> -->

        <div class="bg-white rounded p-3 border-0 mt-2" v-for="data in datas" :key="data.id" @click="detail(data.id)">
            <h6 class="mb-1 fw-semibold">{{ data.date }}</h6>
            <p class="fs-21 mb-1 text-muted">{{ data.notes }}</p>
            <span class="fs-21 bg-primary text-white rounded px-1 me-2">{{ data.type }}</span>
            <span class="fs-21 bg-warning text-white rounded px-1" v-if="data.status === 'pending'"><span class="bi bi-clock pe-1"></span>Pending</span>
            <span class="fs-21 bg-success text-white rounded px-1" v-else-if="data.status === 'approved'"><span class="bi bi-check-circle pe-1"></span>Diterima</span>
            <span class="fs-21 bg-danger text-white rounded px-1" v-else-if="data.status === 'rejected'"><span class="bi bi-x-circle pe-1"></span>Ditolak</span>
        </div>

        <router-link to="/leave/create" class="btn btn-dark btn-block" @click="createLeave"><span class="bi bi-plus fs-14 me-2"></span>Buat Pengajuan</router-link>
    </div>
</template>

<style scoped>
.fs-14{
    font-size: 13px;
}
.border-none{
    border: none;
}
.fs-21{
    font-size: 12px;
}
.btn-block{
    width: 50%;
    position: fixed;
    bottom: 12vh;
    left: 25%;
    right: 25%;
}
/* Mobile Responsive Styles */
@media (max-width: 767px) {
    .container {
        padding: 0 1rem;
    }
    
    .bg-white.p-3 {
        padding: 1rem !important;
        margin-bottom: 1rem;
    }
    
    .fs-21 {
        font-size: 11px !important;
    }
    
    h5 {
        font-size: 16px !important;
    }
    
    h6 {
        font-size: 13.5px !important;
    }
    
    .btn {
        font-size: 12px !important;
    }
    
    .badge {
        font-size: 9px !important;
        padding: 0.25rem 0.5rem !important;
    }
    
    /* Profile picture mobile */
    .img-fluid.rounded-circle {
        width: 80px !important;
        height: 80px !important;
    }
}

/* Desktop Responsive Styles */
@media (min-width: 992px) {
    .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 0 2rem;
    }
    
    .fs-21 {
        font-size: 12px !important;
    }
    
    h5 {
        font-size: 20px !important;
    }
    
    h6 {
        font-size: 16px !important;
    }
    
    .btn {
        font-size: 14px !important;
        padding: 1rem !important;
    }
    
    .badge {
        font-size: 11px !important;
        padding: 0.35rem 0.65rem !important;
    }
    
    /* Profile picture desktop */
    .img-fluid.rounded-circle {
        width: 120px !important;
        height: 120px !important;
    }
}

/* Large Desktop Styles */
@media (min-width: 1200px) {
    .container {
        max-width: 700px;
    }
    
    .fs-21 {
        font-size: 13px !important;
    }
}

/* Common improvements */
.btn:hover {
    transform: translateY(-1px);
}

.badge {
    border-radius: 0.375rem;
}

.row {
    margin: 0;
}

.row .col,
.row .col-4,
.row .col-8 {
    padding: 0.25rem 0;
}


/* Info cards styling */
.bg-white.p-3:not(:first-child) {
    border: 1px solid #e9ecef;
}

/* Action buttons styling */
.d-flex.gap-2 {
    margin-top: 1rem;
}
</style>
