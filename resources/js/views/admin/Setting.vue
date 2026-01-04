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
    <Topbar title="Pengaturan"/>
    <div class="container">
        <div class="bg-white col-12 p-3 rounded" @click="go('/settings/company')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-building mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Profil Perusahaan</h6>
                    <span class="fs-21 text-muted">Atur profil perusahaan</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded mt-2" @click="go('/settings/branches')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-share mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Cabang Perusahaan</h6>
                    <span class="fs-21 text-muted">Kelola Cabang perusahaan</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded mt-2" @click="go('/settings/position')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-person-gear mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Jabatan</h6>
                    <span class="fs-21 text-muted">Kelola Jabatan perusahaan</span>
                </div>
            </div>
        </div>
        <div class="bg-white col-12 p-3 rounded mt-2" @click="go('/settings/hours')">
            <div class="row align-items-center">
                <div class="col-2">
                    <h1 class="bi bi-clock mt-1"></h1>
                </div>
                <div class="col-8">
                    <h6 class="m-0">Jam Kerja</h6>
                    <span class="fs-21 text-muted">Kelola Jam Kerja perusahaan</span>
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