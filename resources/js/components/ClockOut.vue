<script setup>
import { ref,onMounted } from 'vue'
import axios from 'axios'
import imageProcessor from '../lib/imageprocessor'
import Toast from '../lib/toast'

const props = defineProps({
    preview: String,
    image: String,
    size: Number
})

const input = () => {
    cameraIn.value.click();
}

const submit = async () => {
    try {
        const response = await axios.post('/api/attendance/clockout', {
            image: props.image,
        }, {
            headers:{
                'Authorization': `Bearer ${localStorage.getItem('token')}`,
                'Content-Type': 'application/json'
            }
        })
    
        if(response.status == 200){
            Toast.fire({
                icon: 'success',
                title: 'Clock Out berhasil'
            })

            setTimeout(() => {
                window.location.reload();
            }, 2000);
        }
        else if (response.status == 500){
            Toast.fire({
                icon: 'error',
                title: response.data.message
            })
        }
    } catch (error) {
        Toast.fire({
            icon: 'error',
            title: error
        })

        console.log(error)

        // setTimeout(() => {
        //     window.location.reload();
        // }, 2000);
    }
}
</script>

<template>
    <div class="modal fade" id="clockOut" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" ref="clockInModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content mx-3">
                <!-- Header -->
                <div class="mt-3 mb-2 border-0">
                </div>
                <!-- Body -->
                <div class="modal-body border-0 text-center px-4">
                    <!-- <span class="fs-21 text-success"><span class="bi bi-check-circle-fill text-success"></span> Wajah Terverifikasi !</span><br> -->
                    <!-- <span class="fs-21 text-danger"><span class="bi bi-x-circle-fill text-danger"></span> Wajah Tidak Terverifikasi !</span><br> -->
                    <!-- <input type="file" accept="image/*" capture="user" ref="cameraIn" @change="previewIn" hidden> -->
                    <img :src="preview" alt="clock-in" class="rounded my-2 object-fit-cover" width="150" height="150" v-if="preview"><br>
                    <div v-if="!preview" class="p-2 bg-white rounded border-1 border-dashed border-muted w-75 mx-auto button" @click="input">
                        <div class="button-cell">
                            <h5 class="bi bi-camera-fill text-muted"></h5>
                            <span class="fs-21 text-muted">Ambil foto Clock Out</span>
                        </div>
                    </div>
                    <span class="fs-22 text-muted" v-if="size">Ukuran gambar : {{ size }} kb</span><br>
                    <!-- <span class="fs-21"><span class="bi bi-geo-alt-fill me-2"></span><span class="text-success fw-semibold">(3m, anda didalam radius)</span></span><br> -->
                    <!-- <button class="btn btn-sm btn-primary mt-2"><span class="bi bi-camera me-2"></span>Ambil foto Clock Out</button> -->
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-dark w-100 fw-semibold" @click="submit"><span class="bi bi-arrow-up-right-circle-fill me-2"></span>Clock Out</button>
                </div>
            </div>
        </div>
    </div>
</template>

<style>
.fs-21{
    font-size: 12px;
}
.fs-22{
    font-size: 10px;
}
.border-dashed{
    border-style: dashed !important;
}
.button {
    display: table;
    width: 100%;
    height: 100px;
}
.button-cell {
    display: table-cell;
    vertical-align: middle;
    text-align: center;
}
</style>