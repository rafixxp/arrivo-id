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

onBeforeMount(async () => {
    const response = await axios.get('/api/attendance/recap', {
        headers:{
            'Authorization' : `Bearer ${localStorage.getItem('token')}`
        }
    })

    datas.value = response.data
})
</script>

<template>
    <Topbar title="Rekap Kehadiran"/>
    <div class="container mb-2 pb-5 px-3">
        <div class="bg-white rounded p-2">
            <table class="table table-sm table-bordered fs-14">
                <thead>
                    <tr>
                        <th width="200">Nama</th>
                        <th>Sakit</th>
                        <th>Izin</th>
                        <th>Cuti</th>
                        <th>Tidak Presensi</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="data in datas" :key="data.id">
                        <td>{{ data.name }}</td>
                        <td>{{ data.present_count }}</td>
                        <td>{{ data.on_time_count }}</td>
                        <td>{{ data.late_count }}</td>
                        <td>{{ data.early_count }}</td>
                    </tr>
                </tbody>
            </table>
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
table td{
    padding: 8px;
}
table th{
    padding: 8px;
}
.table-scroll{
    overflow-y: auto;
    max-height: 70vh;
    padding: 6px;
}
.table-scroll::-webkit-scrollbar{
    height: 8px;
    width: 8px;
}
.table-scroll table{
    min-width: 1400px;
}

/* Tablet styles */
@media (min-width: 768px) {
    .container {
        max-width: 750px;
        margin: 0 auto;
    }
    
    .fs-21 {
        font-size: 12px;
    }
    
    .fs-14 {
        font-size: 14px;
    }
    
    .bg-white.rounded.p-2 {
        padding: 1rem !important;
    }
    
    table td, table th {
        padding: 12px;
    }
}

/* Desktop styles */
@media (min-width: 1024px) {
    .container {
        max-width: 1000px;
    }
    
    .fs-21 {
        font-size: 13px;
    }
    
    .fs-14 {
        font-size: 15px;
    }
    
    .bg-white.rounded.p-2 {
        padding: 1.5rem !important;
    }
    
    table td, table th {
        padding: 15px;
    }
    
    .table-sm {
        font-size: 14px;
    }
}

/* Large desktop styles */
@media (min-width: 1200px) {
    .container {
        max-width: 1140px;
    }
    
    .fs-21 {
        font-size: 14px;
    }
    
    .fs-14 {
        font-size: 16px;
    }
    
    table td, table th {
        padding: 18px;
    }
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
