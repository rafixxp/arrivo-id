<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';
import Swal from 'sweetalert2';

const branches = ref([])

const branch = ref ({
    name: '',
    address: ''
})

const branchEdit = ref({
    id: '',
    name: '',
    address: ''
})

const save = async () => {
    try{
        const response = await axios.post('/api/branches', branch.value,
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
                title: 'Data cabang berhasil disimpan'
            })
            branches.value.push(branch.value);
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
    branchEdit.value = branch
}

const update = async () => {
    try{
        const update = await axios.put(`/api/branches/${branchEdit.value.id}`, branchEdit.value, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })

        if(update.status === 200){
            Toast.fire({
                icon: 'success',
                title: 'Data cabang berhasil diedit !'
            })
        }
    }
    catch(error){
        Toast.fire({
            icon: 'error',
            title: 'Gagal mengedit data cabang'
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
                const destroy = await axios.delete(`/api/branches/${id}`, {
                    headers: {
                        'Authorization': `Bearer ${localStorage.getItem('token')}`
                    }
                });

                if(destroy.status === 200){
                    Toast.fire({
                        icon: 'success',
                        title: 'Data cabang berhasil dihapus !'
                    });
                    branches.value = branches.value.filter(branch => branch.id !== id);
                }
            }
            catch(error){
                Toast.fire({
                    icon: 'error',
                    title: 'Gagal menghapus data cabang'
                });
            }
        }
    })
}

onBeforeMount(async () => {
    try{
        const response = await axios.get('/api/branches', {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        
        if(response.status === 200){
            branches.value = response.data;
        }
    }
    catch(error){
        Toast.fire({
            icon: 'error',
            title: 'Gagal memuat data cabang'
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
                    <h1 class="modal-title fs-5" id="branchModalLabel">Tambah Cabang Baru</h1>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="branchName" class="form-label">Nama Cabang</label>
                            <input type="text" class="form-control" id="branchName" placeholder="Masukkan nama cabang" v-model="branch.name">
                        </div>
                        <div class="mb-3">
                            <label for="branchAddress" class="form-label">Alamat</label>
                           <textarea name="branchAddress" id="branchAddress" class="form-control" rows="3" v-model="branch.address"></textarea>
                        </div>
                    </form>
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
                    <h1 class="modal-title fs-5" id="branchModalLabel">Edit Cabang</h1>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="branchName" class="form-label">Nama Cabang</label>
                            <input type="text" class="form-control" id="branchName" placeholder="Masukkan nama cabang" v-model="branchEdit.name">
                        </div>
                        <div class="mb-3">
                            <label for="branchAddress" class="form-label">Alamat</label>
                           <textarea name="branchAddress" id="branchAddress" class="form-control" rows="3" v-model="branchEdit.address"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    <button type="button" class="btn btn-dark" @click="update">Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Top Bar -->
    <Topbar title="Cabang Perusahaan"/>
    <div class="container">
        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer" v-for="branch in branches" :key="branch.id">
            <div class="row align-items-center">
            <div class="col-10">
                <h6 class="m-0">{{ branch.name }}</h6>
                <span class="fs-21 text-muted">{{ branch.address }}</span>
            </div>
            <div class="col-2 p-2">
                <button class="btn" type="button" data-bs-toggle="dropdown">
                   <strong class="bi bi-three-dots-vertical"></strong>
                </button>
                <ul class="dropdown-menu py-1" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item fs-22" href="#" data-bs-toggle="modal" data-bs-target="#editModal" @click="editBranch(branch)"><span class="fs-22 bi bi-pencil"></span> Edit</a></li>
                    <li><a class="dropdown-item fs-22" href="#" @click="destroy(branch.id)"><span class="bi bi-trash"></span> Delete</a></li>
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