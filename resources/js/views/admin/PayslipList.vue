<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';
import Swal from 'sweetalert2';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();

const datas = ref([])

const adds = ref ({
    name: '',
    start_from: '',
    end_at: ''
})

const edit = ref({
    id: '',
    name: '',
    clock_in: '',
    late_time: '',
    clock_out: ''
})

const go = (page) => {
    router.push(page)
}
onBeforeMount(async () => {
    try{
        const response = await axios.get(`/api/payslip/lists/${route.params.id}`, {
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
            title: 'Gagal memuat data jabatan'
        });
    }
})
</script>

<template>
    <!-- modal -->
    <div class="modal fade" id="branchModal" tabindex="-1" aria-labelledby="branchModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content mx-2">
                <div class="modal-header border-0">
                    <h1 class="modal-title fs-5" id="branchModalLabel">Generate Penggajian</h1>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="" class="fs-21">Nama Periode</label>
                        <input type="text" name="" class="form-control fs-22" v-model="adds.name">
                    </div>
                    <div class="row">
                        <div class="col-6 pe-2">
                            <div class="form-group mt-1">
                                <label for="" class="fs-21">Dari Tanggal</label>
                                <input type="date" name="" class="form-control fs-22" v-model="adds.start_from">
                            </div>
                        </div>
                        <div class="col-6 ps-0">
                            <div class="form-group mt-1">
                                <label for="" class="fs-21">Sampai Tanggal</label>
                                <input type="date" name="" class="form-control fs-22" v-model="adds.end_at ">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    <button type="button" class="btn btn-dark" @click="save">Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Top Bar -->
    <Topbar title="List Penggajian"/>

    <div class="container px-2 pt-0 pb-2 position-fixed bg-white z-index-99">
        <div class="row px-3">
            <div class="col py-1 ps-0 pe-0">
                <div class="bg-white px-2 rounded border border-muted d-flex align-items-center">
                    <span class="bi bi-search me-2 fs-21 text-muted"></span>
                    <input type="search" name="" class="form-control fs-22 border-0" placeholder="Cari karyawan...">
                </div>
            </div>
            <div class="col-3 py-1 ps-0 pe-1 text-end">
                <button class="btn btn-dark fs-22" @click="generate"><span class="bi bi-arrow-repeat me-1"></span>Rilis</button>
            </div>
        </div>
    </div>

    <div class="container mt-5">
        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer" v-for="data in datas" :key="data.id" @click="go(`/payslip/details/${data.id}`)">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="fs-22 m-0">{{ data.name }}</h6>
                <span class="fs-21 text-success"><span class="bi bi-check-circle me-2"></span>{{ data.present }}x hadir</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-chevron-right"></strong>
                </button>
                <ul class="dropdown-menu py-1" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item fs-22" href="#" data-bs-toggle="modal" data-bs-target="#editModal" @click="editBranch()"><span class="fs-22 bi bi-pencil"></span> Edit</a></li>
                    <li><a class="dropdown-item fs-22" href="#" @click="destroy()"><span class="bi bi-trash"></span> Delete</a></li>
                </ul>
            </div>
            </div>
        </div>

        <button class="btn btn-dark btn-add rounded-circle" data-bs-toggle="modal" data-bs-target="#branchModal"><span class="bi bi-plus"></span></button>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 12px;
}
.fs-22{
    font-size: 14px;
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