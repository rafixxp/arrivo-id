<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import Swal from 'sweetalert2';
import axios from 'axios';

const router = useRouter();

const credential = ref({
    email: '',
    password: ''
})

const user = localStorage.getItem('user');

const SignIn = async () => {
    try{
        const response = await axios.post('/api/signin', credential.value);
        if(response.status === 200){
            localStorage.setItem('user', JSON.stringify(response.data.user));
            localStorage.setItem('token', response.data.access_token);
            router.push('/');
        }
        else{
           Swal.fire({
                icon: 'error',
                title: 'Sign In Gagal !',
                text: response.data.message || 'Periksa kembali email dan password anda',
           })
        }
    }
    catch(error){
        Swal.fire({
            icon: 'error',
            title: 'Sign In Gagal !',
            text: 'Silahkan isi email dan password',
        })
    }
}
</script>

<template>
    <div class="container mx-4 vh-50 bg-white p-3 rounded w-125">
        <h5 class="fw-bold m-0">Sign In</h5>
        <span class="text-muted fs-21">Silahkan Sign In dengan akun anda</span>
        <div class="form-group mt-3">
            <label for="email" class="fs-21">Email atau nomor telepon</label>
            <input type="text" name="email" class="form-control" id="email" v-model="credential.email">
        </div>
        <div class="form-group mt-1">
            <label for="password" class="fs-21">Password</label>
            <input type="password" name="password" class="form-control" id="password" v-model="credential.password">
        </div>
        <div class="form-group mt-3">
           <button class="btn btn-dark w-100" @click="SignIn">Sign In</button>
        </div>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 12px;
}
.w-125{
    width: 400px;
}
</style>