<script setup>
import { ref, onBeforeMount } from 'vue'
import axios from 'axios'
import { useRoute, useRouter } from 'vue-router'
import Toast from '../../lib/toast';
import Topbar from '../../components/Topbar.vue';

const router = useRouter()
const route = useRoute()

const positions = ref()
const branches = ref()
const data = ref({})

const fetchData = async () => {
    const res = await axios.get(`/api/employees/${route.params.id}/edit`, {
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })

    if(res.status === 200){
        data.value = res.data
    }
}

const fetchPositions = async () => {
    const res = await axios.get('/api/position', {
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })

    if(res.status === 200){
        positions.value = res.data
    }
}

const fetchBranches = async () => {
    const res = await axios.get('/api/branches', {
        headers:{
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        }
    })

    if(res.status === 200){
        branches.value = res.data
    }
}

const update = async() => {
    const res = await axios.put(`/api/employees/${route.params.id}`, data.value, {
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })

    if(res.status === 200){
        Toast.fire({
            icon: 'success',
            title: 'Karyawan berhasil diperbarui !'
        })

        setTimeout(() => {
            router.push('/employee')
        }, 2000)
    }
    else{
        Toast.fire({
            icon: 'error',
            title: 'Karyawan gagal diperbarui !'
        })
    }
}

onBeforeMount(async () => {
    await Promise.all([fetchData(), fetchPositions(), fetchBranches()])
})

</script>

<template>
    <Topbar title="Edit Karyawan"/>
    <div class="container mb-2 pb-5 px-3">
        <div class="bg-white p-3 rounded text-center mb-2">
            <img :src="data.photo_url || 'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-1.jpg'" alt="" class="img-fluid object-fit-cover rounded-circle" width="70px" height="70px"><br>
            <span class="fs-21 text-muted">Tap untuk mengubah foto profil</span>
        </div>
        <div class="bg-white p-3 rounded text-center">
            <div class="mb-2 text-start">
                <label for="nama" class="form-label fs-14">Nama Lengkap</label>
                <input type="text" class="form-control fs-14" id="nama" placeholder="Masukkan nama lengkap" v-model="data.name">
            </div>
            <div class="row">
                <div class="col">
                    <div class="mb-2 text-start">
                        <label for="tempatLahir" class="form-label fs-14">Tempat Lahir</label>
                        <input type="text" class="form-control fs-14" id="tempatLahir" placeholder="Masukkan tempat lahir" v-model="data.place_of_birth">
                    </div>
                </div>
                <div class="col">
                    <div class="mb-2 text-start">
                        <label for="tanggalLahir" class="form-label fs-14">Tanggal Lahir</label>
                        <input type="date" class="form-control fs-14" id="tanggalLahir" v-model="data.date_of_birth">
                    </div>
                </div>
            </div>
            <div class="mb-2 text-start">
                <label for="alamat" class="form-label fs-14">Alamat</label>
                <textarea name="" class="form-control fs-14" rows="5" v-model="data.address"></textarea>
            </div>
            <div class="mb-2 text-start">
                <label for="position" class="form-label fs-14">Cabang</label>
                <select class="form-select fs-14" aria-label="Default select example" v-model="data.branch_id">
                    <option v-for="branch in branches" :value="branch.id">{{ branch.name }}</option>
                </select>
            </div>
            <div class="mb-2 text-start">
                <label for="position" class="form-label fs-14">Jabatan</label>
                <select class="form-select fs-14" aria-label="Default select example" v-model="data.position_id">
                    <option selected>Pilih jabatan</option>
                    <option v-for="position in positions" :key="position.id" :value="position.id">{{ position.name }}</option>
                </select>
            </div>
            <div class="row p-0">
                <div class="col-6">
                    <div class="mb-2 text-start">
                        <label for="diterima" class="form-label fs-14">Diterima</label>
                        <input type="date" class="form-control fs-14" id="diterima" v-model="data.start_date">
                    </div>
                </div>
                <div class="col-6">
                    <div class="mb-2 text-start">
                        <label for="habisKontrak" class="form-label fs-14">Habis Kontrak</label>
                        <input type="date" class="form-control fs-14" id="habisKontrak" v-model="data.end_date">
                    </div>
                </div>
            </div>
            <div class="mb-2 text-start">
                <label for="phone" class="form-label fs-14">Nomor Telepon</label>
                <input type="number" class="form-control fs-14" id="phone" placeholder="Masukkan nomor telepon" v-model="data.phone">
            </div>
            <div class="mb-2 text-start">
                <label for="email" class="form-label fs-14">Email</label>
                <input type="email" class="form-control fs-14" id="email" placeholder="Masukkan email" v-model="data.email">
            </div>
            <div class="mb-2 text-start">
                <label for="password" class="form-label fs-14">Password</label>
                <input type="text" class="form-control fs-14" id="password" placeholder="Kosongkan jika tidak ingin diubah" v-model="data.passwords">
            </div>
            <button class="btn btn-dark w-100 mt-2" @click="update">Simpan</button>
        </div>
    </div>
</template>

<style scoped>
h6{
    font-size: 14px;
}
.fs-21{
    font-size: 11px;
}
.fs-14{
    font-size: 13px;
}
.border-none{
    border: none;
}
</style>