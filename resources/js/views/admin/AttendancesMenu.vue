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
    <Topbar title="Kehadiran"/>
    <div class="container">
        <div class="bg-white col-12 p-3 rounded" @click="go('/settings/company')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-calendar-day mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Penjadwalan</h6>
                    <span class="fs-21 text-muted">Buat penjadwalan kehadiran</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded mt-2" @click="go('/settings/branches')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-person-check mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Kehadiran Harian</h6>
                    <span class="fs-21 text-muted">Lihat kehadiran harian</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded mt-2" @click="go('/settings/branches')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-person-x mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Approval</h6>
                    <span class="fs-21 text-muted">Lihat approval kehadiran</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded mt-2" @click="go('/settings/position')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-journal mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Rekap Kehadiran</h6>
                    <span class="fs-21 text-muted">Lihat rekap kehadiran</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded mt-2" @click="go('/settings/hours')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-journal-text mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Laporan</h6>
                    <span class="fs-21 text-muted">Lihat laporan kehadiran</span>
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
</style>