<script setup>
import { ref, onMounted, onBeforeMount } from 'vue'
import { useRouter } from 'vue-router';
import Topbar from '../../components/Topbar.vue'
import axios from 'axios';
import Toast from '../../lib/toast.js';

const datas = ref([])

const router = useRouter();

const go = (route) => {
    router.push(route);
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
    <!-- Top Bar -->
    <Topbar title="Karyawan"/>
    <div class="container">
        <div class="bg-white col-12 p-3 rounded my-2 cursor-pointer" v-for="data in datas" :key="data.id" @click="go('/employee/detail')">
            <div class="row align-items-center">
                <div class="col-10">
                    <div class="d-flex align-items-center">
                        <img src="https://ui-avatars.com/api/?name=Rafi+Ahfa&background=0d6efd&color=fff&size=40&bold=true" 
                             class="rounded-circle me-3" width="45" height="45" alt="profile">
                        <div>
                            <h6 class="m-0 p-0 mt-1">Rafi Ahfa Fauzan</h6>
                            <span class="fs-21 text-muted">rafiahfa@gmail.com</span>
                        </div>
                    </div>
                </div>
                <div class="col-2 p-2">
                    <button class="btn" type="button" data-bs-toggle="dropdown">
                        <strong class="bi bi-chevron-right"></strong>
                    </button>
                </div>
            </div>
        </div>
        <router-link to="/employee/add" class="btn btn-dark btn-add rounded-circle"><span class="bi bi-plus"></span></router-link>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 11px;
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