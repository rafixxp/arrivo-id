<template>
    <div class="container d-flex align-items-center justify-content-center vh-100">
        <div class="text-center">
            <div class="mb-3">
                <i class="bi bi-exclamation-triangle-fill text-warning display-1 mb-3"></i>
                <h1 class="display-1 text-danger">403</h1>
                <h5 class="text-muted">Oops, Akses ditolak</h5>
                <p class="fs-21">Maaf, Anda tidak memiliki akses ke halaman ini</p>
            </div>
            <div class="mb-3">
                <a class="btn btn-primary" href="javascript:history.back()">Kembali</a>
            </div>
            <div class="d-flex justify-content-center gap-2">
                <a class="btn btn-primary" href="/">Kembali ke halaman utama</a>
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    mounted() {
        const spinner = document.querySelector('.spinner-border')
        spinner.classList.add('spinner-border-sm')
        setTimeout(() => {
            spinner.classList.add('d-none')
        }, 3000)
    },
}
</script>

<style scoped>
.vh-100 {
    height: 100vh;
}
</style>
