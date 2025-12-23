<script setup>
import { useRouter } from 'vue-router';
import Topbar from '../../components/Topbar.vue';

const router = useRouter();

const go = (component) => {
    router.push(component)
}

// Sample data - in real app, this would come from API
const stats = {
    present: 45,
    sick: 3,
    leave: 2,
    total: 50
}
</script>

<template>
    <!-- Top Bar -->
    <div class="container mt-10">
        <div class="row">
            <div class="col">
                <span class="fs-21 text-muted">Selamat datang</span>
                <h6 class="fw-bold">Rafi Ahfa Fauzan</h6>
            </div>
            <div class="col text-end">
                <img src="https://ui-avatars.com/api/?name=Rafi+Ahfa&background=0d6efd&color=fff&size=45&bold=true" class="rounded-circle object-fit-cover" width="45" height="45" alt="profile">
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="row mt-2 g-3">
            <!-- Total Karyawan Card -->
            <div class="col-6 col-md-6 col-lg-3">
                <div class="card border-0 shadow-sm h-100 bg-white">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-primary bg-opacity-10 rounded-circle p-3">
                                    <i class="bi bi-people-fill text-primary fs-4"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="text-muted mb-1 fs-21">Karyawan</h6>
                                <h4 class="fw-bold mb-0 text-dark">{{ stats.total }}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hadir Card -->
            <div class="col-6 col-md-6 col-lg-3">
                <div class="card border-0 shadow-sm h-100 bg-white">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-success bg-opacity-10 rounded-circle p-3">
                                    <i class="bi bi-check-circle-fill text-success fs-4"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="text-muted mb-1 fs-21">Hadir</h6>
                                <h4 class="fw-bold mb-0 text-dark">{{ stats.present }}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sakit Card -->
            <div class="col-6 col-md-6 col-lg-3">
                <div class="card border-0 shadow-sm h-100 bg-white">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-warning bg-opacity-10 rounded-circle p-3">
                                    <i class="bi bi-thermometer-half text-warning fs-4"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="text-muted mb-1 fs-21">Sakit</h6>
                                <h4 class="fw-bold mb-0 text-dark">{{ stats.sick }}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Izin Card -->
            <div class="col-6 col-md-6 col-lg-3">
                <div class="card border-0 shadow-sm h-100 bg-white">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="flex-shrink-0">
                                <div class="bg-info bg-opacity-10 rounded-circle p-3">
                                    <i class="bi bi-calendar-x-fill text-info fs-4"></i>
                                </div>
                            </div>
                            <div class="flex-grow-1 ms-3">
                                <h6 class="text-muted mb-1 fs-21">Izin</h6>
                                <h4 class="fw-bold mb-0 text-dark">{{ stats.leave }}</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        
    </div>
</template>

<style scoped>
.mt-10{
    margin-top: -6vh;
}
.fs-21{
    font-size: 12px;
}
h6{
    font-size: 14px;
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
</style>