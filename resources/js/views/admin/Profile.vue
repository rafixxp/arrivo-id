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
    }).then(async (result) => {
        if (result.isConfirmed) {
            const destroy = await axios.post('/api/logout', {}, {
                headers: {
                    'Authorization': `Bearer ${localStorage.getItem('token')}`
                }
            })

            if(destroy.status == 200){
                localStorage.removeItem('user');
                localStorage.removeItem('token');
                router.push('/auth/login');
            }
        }
    });
}

const go = (component) => {
    router.push(component)
}
</script>

<template>
    <Topbar title="Detail Akun"/>
    <div class="container mb-2 pb-5 px-3">
        <!-- Profile Section -->
        <div class="bg-white border-white border-0 p-3 rounded text-center mb-2">
            <img :src="`/img/nopic.jpg`" alt="" class="img-fluid object-fit-cover rounded-circle mb-3" width="100px" height="100px">
            <h5 class="fw-bold mb-1">{{ data.name }}</h5>
            <span class="fs-21 text-muted d-block mb-2">{{ data.position_id }}</span>
            <div class="d-flex justify-content-center gap-2 mb-2">
                <span class="badge bg-success">Aktif</span>
                <span class="badge bg-primary">{{ data.role }}</span>
            </div>
        </div>

        <div v-if="data.role == 'super admin' || data.role == 'admin'">
            <div @click="go('/settings')" class="bg-white px-3 py-2 border-0 rounded mb-2">
                <div class="row mt-2">
                    <div class="col-2 d-flex align-items-center">
                        <h4 class="mt-2 bi bi-gear"></h4>
                    </div>
                    <div class="col-10">
                        <h6 class="fw-bold m-0 mt-1">Pengaturan</h6>
                        <span class="fs-21 text-muted">Kelola pengaturan aplikasi</span>
                    </div>
                </div>
            </div>
    
            <div class="bg-white px-3 py-2 border-0 rounded mb-2">
                <div class="row mt-2">
                    <div class="col-2 d-flex align-items-center">
                        <h4 class="mt-2 bi bi-key"></h4>
                    </div>
                    <div class="col-10">
                        <h6 class="fw-bold m-0 mt-1">Keamanan</h6>
                        <span class="fs-21 text-muted">Kelola kata sandi akun</span>
                    </div>
                </div>
            </div>

            <div @click="go('/settings')" class="bg-white px-3 py-2 border-0 rounded mb-2">
                <div class="row mt-2">
                    <div class="col-2 d-flex align-items-center">
                        <h4 class="mt-2 bi bi-moon"></h4>
                    </div>
                    <div class="col-10">
                        <h6 class="fw-bold m-0 mt-1">Mode Gelap</h6>
                        <span class="fs-21 text-muted">Aktifkan mode gelap</span>
                    </div>
                </div>
            </div>
        </div>

        <div v-else>
            <div class="bg-white px-3 py-2 border-0 rounded mb-2">
                <div class="row mt-2">
                    <div class="col-2 d-flex align-items-center">
                        <h4 class="mt-2 bi bi-key"></h4>
                    </div>
                    <div class="col-10">
                        <h6 class="fw-bold m-0 mt-1">Keamanan</h6>
                        <span class="fs-21 text-muted">Kelola kata sandi akun</span>
                    </div>
                </div>
            </div>

            <div class="bg-white px-3 py-2 border-0 rounded mb-2">
                <div class="row mt-2">
                    <div class="col-2 d-flex align-items-center">
                        <h4 class="mt-2 bi bi-moon"></h4>
                    </div>
                    <div class="col-8 ps-2">
                        <h6 class="fw-bold m-0 mt-1">Mode Gelap</h6>
                        <span class="fs-21 text-muted">Aktifkan mode gelap</span>
                    </div>
                    <div class="col-1 d-flex align-items-center">
                        <div class="col-2 d-flex align-items-center">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="modeDark" v-model="$root.darkMode" @change="$root.setDarkMode()">
                                <label class="form-check-label" for="modeDark"></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    
        </div>

        <!-- Detail Section -->
        <div class="bg-white p-3 border-0 rounded">
            <div class="row mt-2">
                <div class="col-2 d-flex align-items-center">
                    <h4 class="mt-2 bi bi-whatsapp"></h4>
                </div>
                <div class="col-10">
                    <span class="fs-21 text-muted">Nomor HP / Whatsapp</span>
                    <h6 class="fw-bold">{{ data.phone ?? '-' }}</h6>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-2 d-flex align-items-center">
                    <h4 class="mt-2 bi bi-envelope"></h4>
                </div>
                <div class="col-10">
                    <span class="fs-21 text-muted">Email</span>
                    <h6 class="fw-bold">{{ data.email ?? '-' }}</h6>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-2 d-flex align-items-center">
                    <h4 class="mt-2 bi bi-cake"></h4>
                </div>
                <div class="col-10">
                    <span class="fs-21 text-muted">Tanggal Lahir</span>
                    <h6 class="fw-bold">{{ data.date_of_birth ?? '-' }}</h6>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-2 d-flex align-items-center">
                    <h4 class="mt-2 bi bi-geo-alt"></h4>
                </div>
                <div class="col-10">
                    <span class="fs-21 text-muted">Tempat Lahir</span>
                    <h6 class="fw-bold">{{ data.place_of_birth ?? '-' }}</h6>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-2 d-flex align-items-center">
                    <h4 class="mt-2 bi bi-map"></h4>
                </div>
                <div class="col-10">
                    <span class="fs-21 text-muted">Alamat</span>
                    <h6 class="fw-bold">{{ data.address ?? '-' }}</h6>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-2 d-flex align-items-center">
                    <h4 class="mt-2 bi bi-person-gear"></h4>
                </div>
                <div class="col-10">
                    <span class="fs-21 text-muted">Jabatan</span>
                    <h6 class="fw-bold">{{ data.position_id ?? '-' }}</h6>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-2 d-flex align-items-center">
                    <h4 class="mt-2 bi bi-calendar-day"></h4>
                </div>
                <div class="col-10">
                    <span class="fs-21 text-muted">Diterima</span>
                    <h6 class="fw-bold">{{ data.start_date ?? '-' }}</h6>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-2 d-flex align-items-center">
                    <h4 class="mt-2 bi bi-calendar-x"></h4>
                </div>
                <div class="col-10">
                    <span class="fs-21 text-muted">Habis Kontrak</span>
                    <h6 class="fw-bold">{{ data.end_date ?? '-' }}</h6>
                </div>
            </div>
        </div>

        <!-- logout btn -->
        <div class="row">
            <div class="col">
                <button class="btn btn-danger btn-sm w-100" @click="logout"><span class="bi bi-box-arrow-right me-2"></span>Logout</button>
            </div>
        </div>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 11px;
}
.fs-14{
    font-size: 13px;
}
.border-none{
    border: none;
}
.ps-2{
    padding-left: 12px !important;
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
