<script setup>
import { ref } from 'vue'

const user = ref(localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : null)
</script>

<template>
    <footer class="bottom-nav fixed-bottom bg-white">
        <div class="container-fluid">
            <div class="row text-center" v-if="user && user.role === 'super admin'">
                <div class="col">
                    <router-link to="/" class="nav-item" :class="{ 'active': $route.fullPath === '/' }">
                        <i class="bi bi-house-door"></i>
                        <span class="fs-14">Home</span>
                    </router-link>
                </div>
                
                <div class="col">
                    <router-link to="/employee" class="nav-item" :class="{ 'active': $route.fullPath === '/employee' }">
                        <i class="bi bi-people"></i>
                        <span class="fs-14">Karyawan</span>
                    </router-link>
                </div>

                <div class="col">
                    <router-link to="/attendance" class="nav-item" :class="{ 'active': $route.fullPath === '/attendance' }">
                        <i class="bi bi-journal-check"></i>
                        <span class="fs-14">Kehadiran</span>
                    </router-link>
                </div>

                <div class="col">
                    <a href="#" class="nav-item" :class="{ 'active': $route.fullPath === '/salary' }">
                        <i class="bi bi-wallet"></i>
                        <span class="fs-14">Gaji</span>
                    </a>
                </div>
            </div>
            
            <div class="row text-center" v-else-if="user && user.role === 'employee'">
                <div class="col">
                    <router-link to="/home" class="nav-item" :class="{ 'active': $route.fullPath === '/home' }">
                        <i class="bi bi-house-door"></i>
                        <span class="fs-14">Home</span>
                    </router-link>
                </div>
                <div class="col">
                    <router-link to="/schedule" class="nav-item" :class="{ 'active': $route.fullPath === '/schedule' }">
                        <i class="bi bi-calendar-day"></i>
                        <span class="fs-14">Jadwal</span>
                    </router-link>
                </div>
                <div class="col">
                    <router-link to="/leave" class="nav-item" :class="{ 'active': $route.fullPath === '/leave' }">
                        <i class="bi bi-file-earmark-text"></i>
                        <span class="fs-14">Pengajuan</span>
                    </router-link>
                </div>
                <div class="col">
                    <router-link to="/payslip" class="nav-item" :class="{ 'active': $route.fullPath === '/salary' }">
                        <i class="bi bi-wallet"></i>
                        <span class="fs-14">Gaji</span>
                    </router-link>
                </div>

            </div>
        </div>
    </footer>
</template>

<style scoped>
.bottom-nav {
    height: 56px;
}

.bottom-nav .nav-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 6px 0;
    text-decoration: none;
    color: #6c757d;
    font-size: 12px;
}

.bottom-nav .nav-item i {
    font-size: 17.5px;
}

.bottom-nav .nav-item.active {
    color: #36383a;
    font-weight: bold;
}

.bottom-nav .nav-item.active i {
    transform: scale(1.1);
}
.fs-14{
    font-size: 11px;
}
</style>