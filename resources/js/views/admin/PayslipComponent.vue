<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';
import Swal from 'sweetalert2';

const datas = ref([])

const adds = ref ({
    name: '',
    clock_in: '',
    late_time: '',
    clock_out: ''
})

const edit = ref({
    id: '',
    name: '',
    clock_in: '',
    late_time: '',
    clock_out: ''
})

const save = async () => {
    try{
        const response = await axios.post('/api/hours', adds.value,
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
                title: 'Data jabatan berhasil disimpan'
            })
            datas.value.push(adds.value);
        }
        else{
            alert('Gagal menyimpan data');
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

onBeforeMount(async () => {
    try{
        const response = await axios.get('/api/hours', {
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
                    <h1 class="modal-title fs-5" id="branchModalLabel">Tambah Jam Kerja Baru</h1>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="branchName" class="form-label fs-22">Nama Jam Kerja</label>
                        <input type="text" class="form-control" id="branchName" placeholder="Masukkan nama jam kerja" v-model="adds.name">
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <label for="branchName" class="form-label fs-22">Jam Masuk</label>
                            <input type="time" class="form-control" id="branchName" placeholder="Masukkan nama jam kerja" v-model="adds.clock_in">
                        </div>
                        <div class="col-4">
                            <label for="branchName" class="form-label fs-22">Terlambat</label>
                            <input type="time" class="form-control" id="branchName" placeholder="Masukkan nama jam kerja" v-model="adds.late_time">
                        </div>
                        <div class="col-4">
                            <label for="branchName" class="form-label fs-22">Jam Pulang</label>
                            <input type="time" class="form-control" id="branchName" placeholder="Masukkan nama jam kerja" v-model="adds.clock_out">
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
    <Topbar title="Komponen Gaji"/>
    <div class="container">
        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">Gaji Pokok</h6>
                <span class="fs-21 text-success">Pendapatan</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-three-dots-vertical"></strong>
                </button>
                <ul class="dropdown-menu py-1" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item fs-22" href="#" data-bs-toggle="modal" data-bs-target="#editModal" @click="editBranch()"><span class="fs-22 bi bi-pencil"></span> Edit</a></li>
                    <li><a class="dropdown-item fs-22" href="#" @click="destroy()"><span class="bi bi-trash"></span> Delete</a></li>
                </ul>
            </div>
            </div>
        </div>

        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">Tidak Hadir</h6>
                <span class="fs-21 text-danger">Potongan</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-three-dots-vertical"></strong>
                </button>
                <ul class="dropdown-menu py-1" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item fs-22" href="#" data-bs-toggle="modal" data-bs-target="#editModal" @click="editBranch()"><span class="fs-22 bi bi-pencil"></span> Edit</a></li>
                    <li><a class="dropdown-item fs-22" href="#" @click="destroy()"><span class="bi bi-trash"></span> Delete</a></li>
                </ul>
            </div>
            </div>
        </div>

        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">Jaminan hari tua</h6>
                <span class="fs-21 text-danger">Potongan</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-three-dots-vertical"></strong>
                </button>
                <ul class="dropdown-menu py-1" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item fs-22" href="#" data-bs-toggle="modal" data-bs-target="#editModal" @click="editBranch()"><span class="fs-22 bi bi-pencil"></span> Edit</a></li>
                    <li><a class="dropdown-item fs-22" href="#" @click="destroy()"><span class="bi bi-trash"></span> Delete</a></li>
                </ul>
            </div>
            </div>
        </div>

        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">Iuran BPJS</h6>
                <span class="fs-21 text-danger">Potongan</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-three-dots-vertical"></strong>
                </button>
                <ul class="dropdown-menu py-1" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item fs-22" href="#" data-bs-toggle="modal" data-bs-target="#editModal" @click="editBranch()"><span class="fs-22 bi bi-pencil"></span> Edit</a></li>
                    <li><a class="dropdown-item fs-22" href="#" @click="destroy()"><span class="bi bi-trash"></span> Delete</a></li>
                </ul>
            </div>
            </div>
        </div>

        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">Uang Makan dan Transport</h6>
                <span class="fs-21 text-success">Pendapatan</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-three-dots-vertical"></strong>
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
</style>