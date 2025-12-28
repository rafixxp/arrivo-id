<script setup>
import { useRouter } from 'vue-router';
import Topbar from '../../components/Topbar.vue';

const router = useRouter();

const go = (component) => {
    router.push(component)
}
</script>

<template>
    <!-- Top Bar -->
    <Topbar title="Penggajian"/>
    <div class="container">
        <div class="bg-white col-12 p-3 rounded" @click="go('/payslip/component')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-cash-stack mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Komponen Gaji</h6>
                    <span class="fs-21 text-muted">Buat komponen gaji</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded" @click="go('/attendance/schedule')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-receipt mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Set Penggajian</h6>
                    <span class="fs-21 text-muted">Buat setting penggajian</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded mt-2" @click="go('/attendance/daily')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-wallet mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Generate Penggajian</h6>
                    <span class="fs-21 text-muted">Generate penggajian massal</span>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.fs-21{
    font-size: 12px;
}
h6{
    font-size: 14px;
}

/* Tablet styles */
@media (min-width: 768px) {
    .container {
        max-width: 750px;
        margin: 0 auto;
    }
    
    .fs-21 {
        font-size: 13px;
    }
    
    h6 {
        font-size: 15px;
    }
    
    .bg-white.p-3 {
        padding: 1.5rem !important;
    }
    
    h1 {
        font-size: 2rem;
    }
}

/* Desktop styles */
@media (min-width: 1024px) {
    .container {
        max-width: 1000px;
    }
    
    .fs-21 {
        font-size: 14px;
    }
    
    h6 {
        font-size: 16px;
    }
    
    .bg-white.p-3 {
        padding: 2rem !important;
    }
    
    h1 {
        font-size: 2.5rem;
    }
    
    .bg-white.col-12 {
        max-width: 600px;
        margin: 0 auto 1rem auto;
    }
}

/* Large desktop styles */
@media (min-width: 1200px) {
    .container {
        max-width: 1140px;
    }
    
    h1 {
        font-size: 3rem;
    }
}

/* Card hover effects */
.bg-white.p-3 {
    transition: transform 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    cursor: pointer;
}

.bg-white.p-3:hover {
    transform: translateY(-2px);
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
}
</style>