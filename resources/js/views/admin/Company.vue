<script setup>
import { ref, onBeforeMount } from 'vue';
import axios from 'axios';
import Topbar from '../../components/Topbar.vue';

const company = ref ({
    name: '',
    address: '',
    npwp: '',
    email: '',
    domain: ''
})

const save = async () => {
    try{
        const profile = await axios.post('/api/company', company.value);
        if(profile.status === 200){
            alert('Data berhasil disimpan');
        }
    }
    catch(error){
        console.error(error);
    }
}

onBeforeMount( async () => {
    try{
        const profile = await axios.get('/api/company', {
            headers:{
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        });
        if(profile.status === 200){
            company.value = profile.data;
        }
    }
    catch(error){
        console.error(error);
    }
})
</script>

<template>
    <!-- Top Bar -->
    <Topbar title="Profil Perusahaan"/>
    <div class="container">
        <div class="bg-white rounded p-3">
            <div class="form-group">
                <label for="companyName" class="fs-21">Nama Perusahaan</label>
                <input type="text" id="companyName" class="form-control fs-14" v-model="company.name">
            </div>
            <div class="form-group mt-2">
                <label for="companyName" class="fs-21">Alamat</label>
                <textarea name="address" id="address" class="form-control fs-14" rows="3" v-model="company.address"></textarea>
            </div>
            <div class="form-group mt-2">
                <label for="companyName" class="fs-21">NPWP</label>
                <input type="text" id="companyName" class="form-control fs-14" v-model="company.npwp">
            </div>
            <div class="row">
                <div class="col">
                    <div class="form-group mt-2">
                        <label for="companyName" class="fs-21">Email</label>
                        <input type="text" id="companyName" class="form-control fs-14" v-model="company.email">
                    </div>
                </div>
                <div class="col">
                    <div class="form-group mt-2">
                        <label for="companyName" class="fs-21">Domain</label>
                        <input type="text" id="companyName" class="form-control fs-14" v-model="company.domain">
                    </div>
                </div>
            </div>
            <button class="btn btn-dark mt-3 w-100" @click="save">Simpan</button>
        </div>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 12px;
}
.fs-14{
    font-size: 14px;
}
</style>