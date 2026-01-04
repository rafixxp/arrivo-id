<script setup>
import { ref, onBeforeMount } from 'vue'
import axios from 'axios'
import Toast from '../../lib/toast'
import Topbar from '../../components/Topbar.vue'
import { useRoute,useRouter } from 'vue-router'
import Swal from 'sweetalert2'

const route = useRoute()
const router = useRouter()

const data = ref()

const destroy = async (id) => {
    Swal.fire({
        icon: 'question',
        title: 'Hapus karyawan ini ?',
        showCancelButton: true,
        cancelButtonText: 'Tidak',
        confirmButtonText: 'Ya'
    }).then(async(result) => {
        if(result.isConfirmed){
            const deletes = await axios.delete(`/api/employees/${id}`, {
                headers: {
                    'Authorization' : `Bearer ${localStorage.getItem('token')}`
                }
            })

            if(deletes.status === 200){
                Toast.fire({
                    icon: 'success',
                    title: 'Karyawan berhasil dihapus !'
                })

                setTimeout(() => {
                    router.push('/employee')
                }, 3000)
            }
        }
    })
}

onBeforeMount(async () => {
    const res = await axios.get(`/api/employees/${route.params.id}`, {
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })

    if(res.status === 200){
        data.value = res.data
    }
})
</script>

<template>
    <Topbar title="Detail Karyawan"/>
    <div class="container mb-2 pb-5 px-3">
        <!-- Profile Section -->
        <div class="bg-white border-white border-0 p-3 rounded text-center mb-2">
            <img :src="`/img/nopic.jpg`" alt="" class="img-fluid object-fit-cover rounded-circle mb-3" width="70px" height="70px">
            <h5 class="fw-bold mb-1">{{ data.name }}</h5>
            <span class="fs-21 text-muted d-block mb-2">{{ data.position_id }}</span>
            <div class="d-flex justify-content-center gap-1 mb-2">
                <span class="badge bg-success">Aktif</span>
                <span class="badge bg-primary">{{ data.role }}</span>
            </div>
        </div>

        <!-- Action Button -->
        <div class="row mb-2">
            <div class="col me-1">
                <router-link :to="`/employee/edit/${data.id}`" class="btn btn-dark btn-sm w-100"><span class="bi bi-pencil me-2"></span>Edit</router-link>
            </div>
            <!-- <div class="col">
                <button class="btn btn-success tn-sm w-100"><span class="bi bi-gear-wide me-2"></span>Izin</button>
            </div> -->
            <div class="col ms-1">
                <button class="btn btn-danger btn-sm w-100" @click="destroy(data.id)"><span class="bi bi-trash me-2"></span>Delete</button>
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
        width: 70px !important;
        height: 70px !important;
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
