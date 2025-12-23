<script setup>
import Sidebar from '../components/Sidebar.vue';
import Bottombar from '../components/Bottombar.vue';

const token = localStorage.getItem('token')
const user = localStorage.getItem('user')
</script>

<template>
    <!-- Layout Wrapper -->
    <div class="container-fluid" style="padding-top:56px; padding-bottom:56px;">
        <div class="row">

            <!-- Sidebar (Hidden on Mobile) -->
            <Sidebar/>
            <!-- Main Section -->
            <main class="col-12 col-md-9 col-lg-10 p-1 mt-3">
                <router-view></router-view>
            </main>

        </div>
    </div>

    <!-- Bottom Bar -->
    <Bottombar />
</template>