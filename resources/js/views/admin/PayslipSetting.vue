<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';
import Swal from 'sweetalert2';
import { useRouter } from 'vue-router';

const router = useRouter()
const datas = ref([])
const criterias = ref([])

const adds = ref ({
    name : '',
    criteria_id: '',
    type: '',
    time_id: '',
    quantity: '0'
})

const edit = ref({
    id: '',
    name: '',
    criteria_id: '',
    type: '',
    time_id: '',
    quantity: '0'
})

const go = (comp) => {
    router.push(comp)
}

const save = async () => {
    try{
        const response = await axios.post('/api/payslip/component', adds.value,
            {
                headers:{
                    "Authorization":`Bearer ${localStorage.getItem('token')}`,
                    "Content-Type":"application/json",
                }
            }
        );

        if(response.status === 201){
            Toast.fire({
                icon: 'success',
                title: 'Komponen Gaji berhasil ditambahkan'
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

const editBranch = (branch) => {
    edit.value = branch
}

const update = async () => {
    try{
        const update = await axios.put(`/api/hours/${edit.value.id}`, edit.value, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })

        if(update.status === 200){
            Toast.fire({
                icon: 'success',
                title: 'Data jabatan berhasil diedit !'
            })
        }
    }
    catch(error){
        Toast.fire({
            icon: 'error',
            title: 'Gagal mengedit data jabatan'
        });
    }
}

const destroy = (id) => {
    Swal.fire({
        icon: 'question',
        title: 'Hapus cabang ?',
        showCancelButton: true,
        cancelButtonText: 'Tidak',
        confirmButtonText: 'Ya'
    }).then(async(result) => {
        if (result.isConfirmed) {
            try{
                const destroy = await axios.delete(`/api/hours/${id}`, {
                    headers: {
                        'Authorization': `Bearer ${localStorage.getItem('token')}`
                    }
                });

                if(destroy.status === 200){
                    Toast.fire({
                        icon: 'success',
                        title: 'Data jabatan berhasil dihapus !'
                    });
                    datas.value = datas.value.filter(adds => adds.id !== id);
                }
            }
            catch(error){
                Toast.fire({
                    icon: 'error',
                    title: 'Gagal menghapus data jabatan'
                });
            }
        }
    })
}

const generate = () => {
    Swal.fire({
        icon: 'question',
        text: 'Generate komponen untuk semua karyawan ?',
        showCancelButton: true,
        cancelButtonText: 'Batal',
        confirmButtonText: 'Ya, Generate',
    }).then(async (result) => {
        if (result.isConfirmed) {
            const exec = await axios.post('/api/payslip/component/generate', {}, {
                headers:{
                    'Authorization' : `Bearer ${localStorage.getItem('token')}`
                }
            })

            if(exec.status == 201){
                Toast.fire({
                    icon: 'success',
                    title: 'Komponen berhasil ditambahkan ke semua karyawan'
                });
            }
            else{
                Toast.fire({
                    icon: 'info',
                    title: 'Komponen gagal ditambahkan ke semua karyawan'
                });
            }
        }
    });
}

onBeforeMount(async () => {
    try{
        const response = await axios.get('/api/payslip/setting', {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        
        if(response.status === 200){
            datas.value = response.data;
        }

        const crit = await axios.get('/api/payslip/component/criteria', {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        
        if(crit.status === 200){
            criterias.value = crit.data;
        }
    }
    catch(error){
        Toast.fire({
            icon: 'error',
            title: 'Gagal memuat data komponen gaji'
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
                    <h1 class="modal-title fs-5" id="branchModalLabel">Tambah Komponen Gaji</h1>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="" class="fs-21">Nama Komponen</label>
                        <input type="text" name="" class="form-control fs-22" v-model="adds.name">
                    </div>
                    <div class="form-group mt-1">
                        <label for="" class="fs-21">Jenis</label>
                        <select name="" id="" class="form-select fs-22" v-model="adds.type">
                            <option value="">Pilih Jenis</option>
                            <option value="1">Pendapatan</option>
                            <option value="2">Potongan</option>
                        </select>
                    </div>
                    <div class="row">
                        <div class="col-6 pe-2">
                            <div class="form-group mt-1">
                                <label for="" class="fs-21">Kriteria</label>
                                <select name="" id="" class="form-select fs-22" v-model="adds.criteria_id">
                                    <option value="">Pilih Kriteria</option>
                                    <option v-for="criteria in criterias" :value="criteria.id">{{ criteria.name }}</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-6 ps-1">
                            <div class="form-group mt-1">
                                <label for="" class="fs-21">Kuantitas</label>
                                <input type="number" name="" class="form-control fs-22" v-model="adds.quantity" min="0">
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
    
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="branchModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content mx-2">
                <div class="modal-header border-0">
                    <h1 class="modal-title fs-5" id="branchModalLabel">Edit Jam Kerja</h1>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="branchName" class="form-label fs-22">Nama Jam Kerja</label>
                        <input type="text" class="form-control" id="branchName" placeholder="Masukkan nama jam kerja" v-model="edit.name">
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <label for="branchName" class="form-label fs-22">Jam Masuk</label>
                            <input type="time" class="form-control" id="branchName" placeholder="Masukkan nama jam kerja" v-model="edit.clock_in">
                        </div>
                        <div class="col-4">
                            <label for="branchName" class="form-label fs-22">Terlambat</label>
                            <input type="time" class="form-control" id="branchName" placeholder="Masukkan nama jam kerja" v-model="edit.late_time">
                        </div>
                        <div class="col-4">
                            <label for="branchName" class="form-label fs-22">Jam Pulang</label>
                            <input type="time" class="form-control" id="branchName" placeholder="Masukkan nama jam kerja" v-model="edit.clock_out">
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    <button type="button" class="btn btn-dark" @click="update">Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Top Bar -->
    <Topbar title="Set Penggajian"/>

        <div class="container px-2 pt-0 pb-2 position-fixed bg-white z-index-99">
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
    </div>

    <div class="container mt-5">
        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer" v-for="data in datas" :key="data.id" @click="go(`/payslip/setting/${data.id}`)">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">{{ data.nama }}</h6>
                <span class="text-muted fs-21">{{ data.branch_name }}</span>
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