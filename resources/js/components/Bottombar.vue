<template>
    <footer class="bottom-nav fixed-bottom bg-white">
        <div class="container-fluid">
            <div class="row text-center">

                <div class="col">
                    <router-link to="/" class="nav-item active">
                        <i class="bi bi-house-door"></i>
                        <span class="fs-14">Home</span>
                    </router-link>
                </div>
                
                <div class="col">
                    <router-link to="/employee" href="#" class="nav-item">
                        <i class="bi bi-people"></i>
                        <span class="fs-14">Karyawan</span>
                    </router-link>
                </div>

                <div class="col">
                    <router-link to="/attendance" class="nav-item">
                        <i class="bi bi-journal-check"></i>
                        <span class="fs-14">Kehadiran</span>
                    </router-link>
                </div>

                <div class="col">
                    <a href="#" class="nav-item">
                        <i class="bi bi-wallet"></i>
                        <span class="fs-14">Gaji</span>
                    </a>
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