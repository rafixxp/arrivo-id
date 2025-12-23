<script setup>
import Topbar from '../../components/Topbar.vue';
</script>

<template>
    <Topbar title="Tambah Karyawan"/>
    <div class="container mb-2 pb-5 px-3">
        <div class="bg-white p-3 rounded text-center mb-2">
            <img src="https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-1.jpg" alt="" class="img-fluid object-fit-cover rounded-circle" width="70px" height="70px"><br>
            <span class="fs-21 text-muted">Tap untuk mengubah foto profil</span>
        </div>
        <div class="bg-white p-3 rounded text-center">
            <div class="mb-2 text-start">
                <label for="nama" class="form-label fs-14">Nama Lengkap</label>
                <input type="text" class="form-control fs-14" id="nama" placeholder="Masukkan nama lengkap">
            </div>
            <div class="row">
                <div class="col">
                    <div class="mb-2 text-start">
                        <label for="tempatLahir" class="form-label fs-14">Tempat Lahir</label>
                        <input type="text" class="form-control fs-14" id="tempatLahir" placeholder="Masukkan tempat lahir">
                    </div>
                </div>
                <div class="col">
                    <div class="mb-2 text-start">
                        <label for="tanggalLahir" class="form-label fs-14">Tanggal Lahir</label>
                        <input type="date" class="form-control fs-14" id="tanggalLahir">
                    </div>
                </div>
            </div>
            <div class="mb-2 text-start">
                <label for="alamat" class="form-label fs-14">Alamat</label>
                <textarea name="" class="form-control" rows="3"></textarea>
            </div>
            <div class="mb-2 text-start">
                <label for="position" class="form-label fs-14">Jabatan</label>
                <select class="form-select fs-14" aria-label="Default select example">
                    <option selected>Pilih jabatan</option>
                </select>
            </div>
            <div class="row p-0">
                <div class="col-6">
                    <div class="mb-2 text-start">
                        <label for="diterima" class="form-label fs-14">Diterima</label>
                        <input type="date" class="form-control fs-14" id="diterima">
                    </div>
                </div>
                <div class="col-6">
                    <div class="mb-2 text-start">
                        <label for="habisKontrak" class="form-label fs-14">Habis Kontrak</label>
                        <input type="date" class="form-control fs-14" id="habisKontrak">
                    </div>
                </div>
            </div>
            <div class="mb-2 text-start">
                <label for="phone" class="form-label fs-14">Nomor Telepon</label>
                <input type="number" class="form-control fs-14" id="phone" placeholder="Masukkan nomor telepon">
            </div>
            <div class="mb-2 text-start">
                <label for="email" class="form-label fs-14">Email</label>
                <input type="email" class="form-control fs-14" id="email" placeholder="Masukkan email">
            </div>
            <div class="mb-2 text-start">
                <label for="password" class="form-label fs-14">Password</label>
                <input type="text" class="form-control fs-14" id="password" placeholder="Kosongkan untuk password default">
            </div>
            <button class="btn btn-dark w-100 mt-2">Simpan</button>
        </div>
    </div>
</template>

<style scoped>
h6{
    font-size: 14px;
}
.fs-21{
    font-size: 11px;
}
.fs-14{
    font-size: 13px;
}
.border-none{
    border: none;
}
</style>