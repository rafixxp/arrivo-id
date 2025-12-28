<script setup>
import { ref, onBeforeMount } from 'vue'
import axios from 'axios'
import Toast from '../../lib/toast'
import Topbar from '../../components/Topbar.vue'
import { useRoute,useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()

const data = ({
    type: '',
    // attachment: '',
    from_date: '',
    to_date: '',
    note: ''
})

const send = async () => {
    try {
        const response = await axios.post('/api/leave', data, {
            headers :{
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })

        if(response.status == 201){
            Toast.fire({
                icon: 'success',
                title: 'Pengajuan berhasil terkirim !'
            })

            setTimeout(() => {
                router.push('/leave')
            }, 2000);
        }
    } catch (error) {
        Toast.fire({
            icon: 'error',
            title: error.response
        })
    }
}
</script>

<template>
    <Topbar title="Buat Pengajuan"/>
    <div class="container mb-2 pb-5 px-3">
        <div class="bg-white p-3 rounded">
            <div class="form-group mt-1">
                <label for="" class="fs-21 px-1">Jenis Pengajuan</label>
                <select name="" id="" class="form-select fs-14 mt-1" v-model="data.type">
                    <option value="">Pilih Jenis Pengajuan</option>
                    <option value="sakit">Sakit</option>
                    <option value="izin">Izin</option>
                </select>
            </div>
            <div class="form-group mt-1">
                <label for="" class="fs-21 px-1">Attachment (opsional, hanya diizinkan gambar) *</label>
                <input type="file" name="" class="form-control fs-14 mt-1">
            </div>
            <div class="row">
                <div class="col-6 p-0 pe-1">
                    <div class="form-group mt-1">
                        <label for="" class="fs-21 px-1">Dari Tanggal</label>
                        <input type="date" name="" class="form-control fs-14 mt-1" v-model="data.from_date">
                    </div>
                </div>
                <div class="col-6 p-0 ps-1">
                    <div class="form-group mt-1">
                        <label for="" class="fs-21 px-1">Sampai Tanggal</label>
                        <input type="date" name="" class="form-control fs-14 mt-1" v-model="data.to_date">
                    </div>
                </div>
            </div>
            <div class="form-group mt-1">
                <label for="" class="fs-21 px-1">Catatan (opsional) *</label>
                <textarea class="form-control fs-14 mt-1" rows="5" placeholder="Tulis catatan anda" v-model="data.note"></textarea>
            </div>
            <button class="btn btn-dark w-100 mt-2" @click="send"><span class="bi bi-send fs-14 me-2"></span>Kirim Pengajuan</button>
        </div>
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
        font-size: 12px !important;
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
