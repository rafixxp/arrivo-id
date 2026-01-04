<script setup>
import { ref, onMounted, computed, onBeforeMount } from 'vue'
import axios from 'axios'
import { Modal } from 'bootstrap'
import ClockIn from '../../components/ClockIn.vue'
import ClockOut from '../../components/ClockOut.vue'
import BlankBar from '../../components/BlankBar.vue'
import imageProcessor from '../../lib/imageprocessor'
import Map from '../../components/Map.vue'


const data = ref({})
const preview = ref('')
const image = ref('')
const size = ref(0)

const user = JSON.parse(localStorage.getItem('user'));

const openModalIn = () => {
    const modal = new Modal(document.getElementById('clockIn'));
    modal.show();
}

const openModalOut = () => {
    const modal = new Modal(document.getElementById('clockOut'));
    modal.show();
}

const previewFun = async (e) => {
    const file = e.target.files[0];
    if(file) {
        preview.value = URL.createObjectURL(file);
    }

    const compress = await imageProcessor(file, 400, 0.65)
    image.value = compress

    // cek size hasil (KB)
    const sizeKB = Math.round((compress.length * 3) / 4 / 1024)
    size.value = sizeKB
}

onBeforeMount(async () => {
    await getData();
})

const getData = async () => {
    const response = await axios.get('/api/attendance/getschedule', {
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })
    data.value = response.data;
}
</script>

<template>
    <!-- clock in - clock out -->
    <ClockIn :preview="preview" :image="image" :size="size"/>
    <ClockOut :preview="preview" :image="image" :size="size"/>
    <div class="container mt-10">
        <BlankBar :title="user.name"/>
        <!-- <div class="row">
            <div class="col-9">
                <span class="fs-21 text-muted">Selamat datang</span>
                <h6 class="fw-bold">{{ user.name }}</h6>
            </div>
            <div class="col-3 text-end">
                <img :src="`https://ui-avatars.com/api/?name=${user.name}&background=0d6efd&color=fff&size=45&bold=true`" class="rounded-circle object-fit-cover" width="45" height="45" alt="profile" @click="go('/profile')">
            </div>
        </div> -->
        
        <div v-if="data.schedule">
            <div class="row mx-0 mt-5">
                <div class="col-12 p-0">
                    <div class="card border-0" v-if="data.schedule">
                        <div class="card-header bg-white border-0 text-center pb-3">
                            <span class="fs-22 text-muted">{{ data.schedule.date }}</span><br>
                            <h6 class="mt-2 mb-2 fw-bold">{{ data.schedule.branch_name }}</h6>
                            <span class="fs-22">{{ data.schedule.hour_name }} - <span :class="data.schedule.status == 1 ? 'bg-success p-1 rounded text-white' : 'bg-danger p-1 rounded text-white'">{{ data.schedule.status == 1 ? 'Tercatat' : 'Belum tercatat' }}</span></span>
                        </div>
                        <div class="card-body rounded p-0 m-0">
                            <Map/>
                        </div>
                    </div>
                    
                    <!-- Skeleton for schedule info -->
                    <div class="card border-0 py-2" v-else>
                        <div class="card-header bg-white border-0 text-center">
                            <div class="skeleton-line skeleton-branch"></div>
                            <div class="skeleton-line skeleton-schedule"></div>
                        </div>
                        <div class="card-body bg-success rounded p-0 skeleton-body-small"></div>
                    </div>
                </div>
            </div>
            
            <div class="row mx-0 mt-2">
                <template v-if="data.schedule">
                    <div class="col bg-white rounded py-2 px-3 me-1 text-center">
                        <div class="d-flex align-items-center mb-2">
                            <span class="bi bi-arrow-down-left-circle fs-3"></span>
                            <span class="fs-21 mx-2">Jam Masuk</span>
                        </div>
                        <h5 class="fw-bold">{{ data.schedule.clock_in }}</h5>
                    </div>
                    <div class="col bg-white rounded py-2 px-3 ms-1 text-center">
                        <div class="d-flex align-items-center mb-2">
                            <span class="bi bi-arrow-up-right-circle fs-3"></span>
                            <span class="fs-21 mx-2">Jam Pulang</span>
                        </div>
                        <h5 class="fw-bold">{{ data.schedule.clock_out }}</h5>
                    </div>
                </template>
                <template v-else>
                    <!-- Skeleton for clock cards -->
                    <div class="col bg-white rounded py-2 px-3 me-1 text-center skeleton-clock-card">
                        <div class="d-flex align-items-center mb-2">
                            <div class="skeleton-icon skeleton-icon-in"></div>
                            <div class="skeleton-line skeleton-label ms-2"></div>
                        </div>
                        <div class="skeleton-line skeleton-time"></div>
                    </div>
                    <div class="col bg-white rounded py-2 px-3 ms-1 text-center skeleton-clock-card">
                        <div class="d-flex align-items-center mb-2">
                            <div class="skeleton-icon skeleton-icon-out"></div>
                            <div class="skeleton-line skeleton-label ms-2"></div>
                        </div>
                        <div class="skeleton-line skeleton-time"></div>
                    </div>
                </template>
            </div>
            
            <template v-if="data.schedule">
                <div class="row mt-1 mx-0 g-1 p-0">
                    <div class="col-6 pe-1" v-if="data.attendance[0]?.type === 'clockin'">
                        <div class="bg-white py-2 text-center rounded">
                            <img :src="data.attendance[0].path" class="object-fit-cover rounded" width="100" height="100" />
                            <h6 class="fw-semibold mt-2">{{ data.attendance[0].time }}</h6>
                            <span :class="data.attendance[0].attend == 'Tepat Waktu' ? 'fs-13 bg-success text-white p-1 rounded' : 'fs-13 bg-danger text-white p-1 rounded'">
                                {{ data.attendance[0].attend }}
                            </span>
                        </div>
                    </div>

                    <div class="col-6 ps-1" v-if="data.attendance[1]?.type === 'clockout'">
                        <div class="bg-white py-2 text-center rounded">
                            <img :src="data.attendance[1].path" class="object-fit-cover rounded" width="100" height="100" />
                            <h6 class="fw-semibold mt-2">{{ data.attendance[1].time }}</h6>
                            <span :class="data.attendance[1].attend == 'Tepat Waktu' ? 'fs-13 bg-success text-white p-1 rounded' : 'fs-13 bg-danger text-white p-1 rounded'">
                                {{ data.attendance[1].attend }}
                            </span>
                        </div>
                    </div>
                </div>
            </template>

            <template v-if="data.schedule">
                <div class="text-center attendance">
                    <!-- Show Clock In button only if there's no attendance data or no clock in yet -->
                    <label class="btn btn-dark py-2 px-3 fs-21" data-bs-toggle="modal" data-bs-target="#clockIn" v-if="!data.attendance || data.attendance.length === 0 || data.attendance[0]?.type !== 'clockin'" @click="openModalIn">
                        <span class="bi bi-arrow-down-left-circle me-1"></span> Klik untuk clock in
                        <input type="file" accept="image/*" capture="user" @change="previewFun" hidden>
                    </label>

                    <!-- Show Clock Out button only if there's a clock in but no clock out yet -->
                    <label class="btn btn-dark py-2 px-3 fs-21" data-bs-toggle="modal" data-bs-target="#clockOut" v-else-if="data.attendance && data.attendance.length > 0 && data.attendance[0]?.type === 'clockin' && (!data.attendance[1] || data.attendance[1]?.type !== 'clockout')
" @click="openModalOut">
                        <span class="bi bi-arrow-up-right-circle me-1"></span> Klik untuk clock out 
                        <input type="file" accept="image/*" capture="user" @change="previewFun" hidden>
                    </label>
                </div>
            </template>

        </div>

        <div v-else-if="data.status == 'error'" class="holiday-greeting-container">
           <div class="bg-white p-4 rounded-4 mt-5 text-center holiday-card">
                <div class="holiday-icon-wrapper mb-3">
                    <div class="holiday-icon">
                        <i class="bi bi-exclamation-circle fs-4"></i>
                    </div>
                </div>
                <h6 class="fw-bold p-0 mb-2 holiday-title">Uh Oh !</h6>
                <span class="fs-13 text-muted holiday-message">Jadwal belum di set, silahkan hubungi admin</span>
           </div>
        </div>
        
        <div v-else-if="data.status == 'libur'" class="holiday-greeting-container">
           <div class="bg-white p-4 rounded-4 mt-5 text-center holiday-card">
                <div class="holiday-icon-wrapper mb-3">
                    <div class="holiday-icon">
                        <i class="bi bi-emoji-smile"></i>
                    </div>
                </div>
                <h6 class="fw-bold p-0 mb-2 holiday-title">Selamat Hari Libur!</h6>
                <span class="fs-13 text-muted holiday-message">Hari ini adalah hari libur. Selamat beristirahat!</span>
           </div>
        </div>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 12px;
}
.fs-13{
    font-size: 11px;
}
.border-dashed{
    border-style: dashed !important;
}
.attendance{
    position: fixed;
    left: 0;
    right: 0;
    bottom: 12vh;
}
iframe{
    width: 100%;
    height: 200px;
}
.mt-10{
    margin-top: -6vh;
}
h6{
    font-size: 14px;
}

/* Skeleton loader styles */
.skeleton-line {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: skeleton-shimmer 1.5s ease-in-out infinite;
    border-radius: 4px;
    margin: 0 auto;
}

/* Schedule skeleton */
.skeleton-branch {
    width: 40%;
    height: 20px;
    margin-bottom: 0.5rem;
}

.skeleton-schedule {
    width: 70%;
    height: 16px;
}

.skeleton-body-small {
    height: 40px;
    background: linear-gradient(90deg, #e8f5e8 25%, #d4edd4 50%, #e8f5e8 75%);
    background-size: 200% 100%;
    animation: skeleton-shimmer 1.5s ease-in-out infinite;
}

/* Clock cards skeleton */
.skeleton-clock-card {
    animation: skeleton-pulse 2s ease-in-out infinite;
}

.skeleton-icon {
    width: 24px;
    height: 24px;
    border-radius: 50%;
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: skeleton-shimmer 1.5s ease-in-out infinite;
}

.skeleton-label {
    width: 60px;
    height: 12px;
}

.skeleton-time {
    width: 80px;
    height: 24px;
}

/* Clock buttons skeleton */
.skeleton-button {
    animation: skeleton-pulse 2s ease-in-out infinite;
}

.skeleton-icon-button {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: skeleton-shimmer 1.5s ease-in-out infinite;
    margin: 4px auto 8px;
}

.skeleton-button-text {
    width: 50px;
    height: 11px;
}

@keyframes skeleton-pulse {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.8;
    }
}

@keyframes skeleton-shimmer {
    0% {
        background-position: -200% 0;
    }
    100% {
        background-position: 200% 0;
    }
}

/* Card hover effects */
.card {
    transition: transform 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    border-radius: 10px;
}

.card:hover {
    transform: translateY(-2px);
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
}

/* Icon circle styling */
.rounded-circle.p-3 {
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Mobile responsive adjustments */
@media (max-width: 768px) {
    .card-body {
        padding: 1rem;
    }
    
    .rounded-circle.p-3 {
        width: 40px;
        height: 40px;
        padding: 0.75rem !important;
    }
    
    .fs-4 {
        font-size: 1rem !important;
    }
}

/* Error message animations */
.error-container {
    animation: fadeInUp 0.6s ease-out;
}

.error-card {
    background: #ffffff;
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
}

.error-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1) !important;
}

.error-icon-wrapper {
    position: relative;
    display: inline-block;
}

.error-icon {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: rgb(42, 42, 42);
    font-size: 24px;
    animation: bounceIn 0.8s ease-out, pulse 2s ease-in-out infinite;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.error-title {
    color: #000000;
    font-size: 18px;
    animation: slideInLeft 0.5s ease-out 0.3s both;
}

.error-message {
    display: block;
    animation: slideInLeft 0.5s ease-out 0.4s both;
    line-height: 1.5;
}

.error-dots {
    display: flex;
    justify-content: center;
    gap: 8px;
    animation: slideInUp 0.5s ease-out 0.5s both;
}

.dot {
    width: 8px;
    height: 8px;
    background: #000000;
    border-radius: 50%;
    animation: dotPulse 1.4s ease-in-out infinite;
}

.dot:nth-child(2) {
    animation-delay: 0.2s;
}

.dot:nth-child(3) {
    animation-delay: 0.4s;
}

/* Error animations */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes bounceIn {
    0% {
        opacity: 0;
        transform: scale(0.3);
    }
    50% {
        opacity: 1;
        transform: scale(1.05);
    }
    70% {
        transform: scale(0.9);
    }
    100% {
        opacity: 1;
        transform: scale(1);
    }
}

@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.05);
    }
}

@keyframes slideInLeft {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes slideInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes dotPulse {
    0%, 60%, 100% {
        transform: scale(1);
        opacity: 0.7;
    }
    30% {
        transform: scale(1.3);
        opacity: 1;
    }
}
</style>