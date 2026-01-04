<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';
import Swal from 'sweetalert2';
import { Dropdown } from 'bootstrap'

onMounted(() => {
    document.querySelectorAll('[data-bs-toggle="dropdown"]')
        .forEach(el => {
            new Dropdown(el)
        })
})

const positions = ref([])

const position = ref ({
    name: '',
})

const positionEdit = ref({
    id: '',
    name: '',
})

const save = async () => {
    try{
        const response = await axios.post('/api/position', position.value,
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
            positions.value.push(position.value);
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
    positionEdit.value = branch
}

const update = async () => {
    try{
        const update = await axios.put(`/api/position/${positionEdit.value.id}`, positionEdit.value, {
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
                const destroy = await axios.delete(`/api/position/${id}`, {
                    headers: {
                        'Authorization': `Bearer ${localStorage.getItem('token')}`
                    }
                });

                if(destroy.status === 200){
                    Toast.fire({
                        icon: 'success',
                        title: 'Data jabatan berhasil dihapus !'
                    });
                    positions.value = positions.value.filter(position => position.id !== id);
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
        const response = await axios.get('/api/position', {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        
        if(response.status === 200){
            positions.value = response.data;
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
                    <h1 class="modal-title fs-5" id="branchModalLabel">Tambah Jabatan Baru</h1>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="branchName" class="form-label">Nama Jabatan</label>
                        <input type="text" class="form-control" id="branchName" placeholder="Masukkan nama jabatan" v-model="position.name">
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
                    <h1 class="modal-title fs-5" id="branchModalLabel">Edit Jabatan</h1>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="branchName" class="form-label">Nama Jabatan</label>
                        <input type="text" class="form-control" id="branchName" placeholder="Masukkan nama jabatan" v-model="positionEdit.name">
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
    <Topbar title="Jabatan Perusahaan"/>
    <div class="container">
        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer" v-for="pos in positions" :key="pos.id">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">{{ pos.name }}</h6>
                <span class="fs-21 text-muted">0 orang</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn border-0" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-three-dots-vertical"></strong>
                </button>
                <ul class="dropdown-menu py-1" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item fs-22" href="#" data-bs-toggle="modal" data-bs-target="#editModal" @click="editBranch(pos)"><span class="fs-22 bi bi-pencil"></span> Edit</a></li>
                    <li><a class="dropdown-item fs-22" href="#" @click="destroy(pos.id)"><span class="bi bi-trash"></span> Delete</a></li>
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