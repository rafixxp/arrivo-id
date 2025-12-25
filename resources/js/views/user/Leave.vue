<script setup>
import { ref, onBeforeMount } from 'vue'
import axios from 'axios'
import Toast from '../../lib/toast'
import Topbar from '../../components/Topbar.vue'
import { useRoute,useRouter } from 'vue-router'
import Swal from 'sweetalert2'

const route = useRoute()
const router = useRouter()

const data = ref(JSON.parse(localStorage.getItem('user')))

const logout = () => {
    Swal.fire({
        icon: 'question',
        title: 'Logout',
        text: 'Apakah Anda yakin ingin keluar?',
        showCancelButton: true,
        confirmButtonText: 'Ya',
        cancelButtonText: 'Batal'
    }).then((result) => {
        if (result.isConfirmed) {
            localStorage.removeItem('user');
            localStorage.removeItem('token');
            router.push('/auth/login');
        }
    });
}
</script>

<template>
    <Topbar title="Pengajuan"/>
    <div class="container mb-2 pb-5 px-3">
        <div class="bg-white rounded p-3">
            <div class="row">
                <div class="col-6 mb-2">
                    <span class="fs-21 text-muted">Nama</span>
                    <h6>Rafi Ahfa Fauzan</h6>
                </div>
                <div class="col-6 mb-2">
                    <span class="fs-21 text-muted">ID Karyawan</span>
                    <h6>2515567894</h6>   
                </div>
                <div class="col-6 mt-1">
                    <span class="fs-21 text-muted">Jabatan</span>
                    <h6>Web Developer</h6>
                </div>
                <div class="col-6 mt-1">
                    <span class="fs-21 text-muted">Status</span>
                    <h6>Paruh Waktu</h6>
                </div>
            </div>
        </div>
        <div class="bg-white rounded p-2 mt-2">
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
        </div>
        <button class="btn btn-dark rounded-circle btn-left" @click="createLeave"><span class="bi bi-plus fs-4"></span></button>
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
.btn-left{
    position: fixed;
    bottom: 14vh;
    right: 7vw;
    width: 53px;
    height: 53px;
    font-size: 100px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
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
        font-size: 12px !important;
    }
    
    .btn {
        font-size: 12px !important;
        padding: 0.75rem !important;
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
