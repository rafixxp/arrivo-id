<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import Topbar from '../../components/Topbar.vue'
import axios from 'axios'
import Toast from '../../lib/toast.js'
import Swal from 'sweetalert2'
import { useRoute } from 'vue-router'

const route = useRoute()
const times = ref([])
const datas = ref([])
const users = ref({})

const edit = ref()

const save = async () => {
    try{
        const response = await axios.post(`/api/payslip/setting/${edit.value.id}`, edit.value,
            {
                headers:{
                    "Authorization":`Bearer ${localStorage.getItem('token')}`,
                    "Content-Type":"application/json",
                }
            }
        );

        if(response.status === 200){
            Toast.fire({
                icon: 'success',
                title: 'Detail payslip berhasil diperbarui'
            })
            
            setTimeout(() => {
                window.location.reload(true);
            }, 2000)
        }
    }
    catch(error){
        Toast.fire({
            icon: 'error',
            title: 'Gagal menyimpan data'
        });
    }
}

const editData = (branch) => {
    edit.value = branch
}

const format = (value) => {
    return new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR', minimumFractionDigits: 0 }).format(value);
}

onBeforeMount(async () => {
    try{
        const response = await axios.get(`/api/payslip/setting/${route.params.id}`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        
        if(response.status === 200){
            datas.value = response.data.details;
            users.value = response.data.user;
        }

        const time = await axios.get(`/api/payslip/times`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        
        if(response.status === 200){
            times.value = time.data;
        }
    }
    catch(error){
        Toast.fire({
            icon: 'error',
            title: 'Gagal memuat detail gaji'
        });
    }
})
</script>

<template>
    <!-- Top Bar -->
    <Topbar title="Detail Penggajian"/>

    <div class="modal fade" id="settingModal" tabindex="-1" aria-labelledby="settingModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content mx-2">
                <div class="modal-header border-0">
                    <h1 class="modal-title fs-5" id="settingModalLabel">Rincian Komponen Gaji</h1>
                </div>
                <div v-if="edit" class="modal-body my-0">
                    <div class="form-group">
                        <label for="" class="fs-21">Nama Komponen</label>
                        <input type="text" name="" class="form-control fs-22" v-model="edit.name">
                    </div>
                    <div class="form-group mt-1">
                        <label for="" class="fs-21">Waktu</label>
                        <select name="" id="" class="form-select fs-22" v-model="edit.time_id">
                            <option value="">Pilih Waktu</option>
                            <option v-for="time in times" :value="time.id">{{ time.name }}</option>
                        </select>
                    </div>
                    <div class="form-group mt-1">
                        <label for="" class="fs-21">Nominal</label>
                        <input type="text" name="" class="form-control fs-22" v-model="edit .value">
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    <button type="button" class="btn btn-dark" @click="save">Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <!-- <div class="container px-2 pt-0 pb-2 position-fixed bg-white z-index-99">
        <div class="row px-3">
            <div class="col-8 py-1 ps-0 pe-0">
                <div class="bg-white px-2 rounded border border-muted d-flex align-items-center">
                    <span class="bi bi-search me-2 fs-21 text-muted"></span>
                    <input type="search" name="" class="form-control fs-22 border-0" placeholder="Cari karyawan...">
                </div>
            </div>
            <div class="col-4 py-1 ps-0 pe-0 text-end">
                <button class="btn btn-dark fs-22" @click="generate"><span class="bi bi-arrow-repeat me-1"></span>Generate</button>
            </div>
        </div>
    </div> -->

    <div class="container">
        <div class="bg-white p-3 rounded text-center">
            <img :src="`https://ui-avatars.com/api/?name=${users.name}&background=0d6efd&color=fff&size=40&bold=true`" class="rounded-circle mb-2" width="65" height="65" alt="profile">
            <h6 class="m-0 fw-semibold">{{ users.name }}</h6>
            <span class="fs-21 text-muted">{{ users.email }}</span>
        </div>

        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer" v-for="data in datas" :key="data.id" data-bs-toggle="modal" data-bs-target="#settingModal" @click="editData(data)">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">{{ data.name }}</h6>
                <span class="text-muted fs-21">{{ format(data.value) }} - {{ data.time_name }}</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-chevron-right"></strong>
                </button>
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
.pt-0{
    margin-top: -17px !important;
}
</style>