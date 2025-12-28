<script setup>
import { ref, onBeforeMount } from 'vue'
import axios from 'axios'
import Toast from '../../lib/toast'
import Topbar from '../../components/Topbar.vue'
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()

const data = ref({})

const form = ref({
    notes: '',
    status: '' // approved | rejected
})

const submit = async () => {
    if (!form.value.status) return

    try {
        const response = await axios.put(
            `/api/approval/${data.value.id}`,
            form.value,
            {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem('token')}`
                }
            }
        )

        Toast.fire({
            icon: 'success',
            title: 'Approval berhasil disimpan'
        })

        setTimeout(() => {
            router.go('/attendance/approval')
        }, 1500)

    } catch (error) {
        Toast.fire({
            icon: 'error',
            title: 'Gagal menyimpan approval'
        })
    }
}

onBeforeMount(async () => {
    try {
        const response = await axios.get(
            `/api/leave/${route.params.id}`,
            {
                headers: {
                    Authorization: `Bearer ${localStorage.getItem('token')}`
                }
            }
        )

        if (response.status === 200) {
            data.value = response.data
        }

    } catch (error) {
        Toast.fire({
            icon: 'error',
            title: 'Gagal mengambil data'
        })
    }
})
</script>


<template>
    <Topbar title="Detail Approval"/>

    <div class="container mb-2 pb-5 px-3">

        <!-- MODAL APPROVAL -->
        <div class="modal fade" id="approvalModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content mx-2">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">
                            Catatan
                        </h5>
                    </div>

                    <div class="modal-body">
                        <textarea
                            rows="6"
                            class="form-control fs-14"
                            placeholder="Tulis catatan approval anda disini.."
                            v-model="form.notes"
                        ></textarea>
                    </div>

                    <div class="modal-footer border-0">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">
                            Batal
                        </button>
                        <button
                            class="btn btn-dark"
                            :disabled="!form.notes"
                            @click="submit"
                        >
                            Simpan
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- DETAIL CARD -->
        <div class="bg-white p-3 rounded border-0">
            <table class="table table-sm table-borderless">
                <tbody class="fs-14">
                    <tr>
                        <td>Status Pengajuan</td>
                        <td>:</td>
                        <td>
                            <span class="fs-21 bg-danger text-white px-1 rounded" v-if="data.status === 'rejected'">
                                <i class="bi bi-x"></i> Ditolak
                            </span>
                            <span class="fs-21 bg-warning text-white px-1 rounded" v-if="data.status === 'pending'">
                                <i class="bi bi-clock"></i> Pending
                            </span>
                            <span class="fs-21 bg-success text-white px-1 rounded" v-if="data.status === 'approved'">
                                <i class="bi bi-check-circle"></i> Disetujui
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>Jenis Pengajuan</td>
                        <td>:</td>
                        <td>{{ data.type }}</td>
                    </tr>
                    <tr>
                        <td>Dari tanggal</td>
                        <td>:</td>
                        <td>{{ data.start_date }}</td>
                    </tr>
                    <tr>
                        <td>Sampai tanggal</td>
                        <td>:</td>
                        <td>{{ data.end_date }}</td>
                    </tr>
                    <tr>
                        <td>Lama Waktu</td>
                        <td>:</td>
                        <td>{{ data.duration }} hari</td>
                    </tr>
                    <tr>
                        <td>Keterangan</td>
                        <td>:</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <textarea
                                class="form-control fs-14"
                                rows="5"
                                readonly
                            >{{ data.notes }}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- ACTION BUTTON -->
            <div class="row mx-0" v-if="data.status === 'pending'">
                <div class="col-6 px-1">
                    <button
                        class="btn btn-danger w-100"
                        data-bs-toggle="modal"
                        data-bs-target="#approvalModal"
                        @click="form.status='rejected'; form.notes=''"
                    >
                        <i class="bi bi-x-circle me-2"></i>Reject
                    </button>
                </div>
                <div class="col-6 px-1">
                    <button
                        class="btn btn-success w-100"
                        data-bs-toggle="modal"
                        data-bs-target="#approvalModal"
                        @click="form.status='approved'; form.notes=''"
                    >
                        <i class="bi bi-check-circle me-2"></i>Approve
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
    .fs-14 {
        font-size: 13px;
    }
    .border-none {
        border: none;
    }
    .fs-21 {
        font-size: 12px;
    }
    .btn-block {
        width: 50%;
        position: fixed;
        bottom: 12vh;
        left: 25%;
        right: 25%;
    }
    .form-control:focus {
        box-shadow: none;
    }

    /* Mobile Responsive Styles */
    @media (max-width: 767px) {
        .container {
            padding: 0 1rem;
        }
        .bg-white.p-3 {
            padding: 1rem !important;
            margin-bottom: 1rem;
        }
        .fs-21 {
            font-size: 11px !important;
        }
        h5 {
            font-size: 16px !important;
        }
        h6 {
            font-size: 13.5px !important;
        }
        .btn {
            font-size: 12px !important;
        }
        .badge {
            font-size: 9px !important;
            padding: 0.25rem 0.5rem !important;
        }
        /* Profile picture mobile */
        .img-fluid.rounded-circle {
            width: 80px !important;
            height: 80px !important;
        }
    }

    /* Desktop Responsive Styles */
    @media (min-width: 992px) {
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        .fs-21 {
            font-size: 12px !important;
        }
        h5 {
            font-size: 20px !important;
        }
        h6 {
            font-size: 16px !important;
        }
        .btn {
            font-size: 14px !important;
            padding: 1rem !important;
        }
        .badge {
            font-size: 11px !important;
            padding: 0.35rem 0.65rem !important;
        }
        /* Profile picture desktop */
        .img-fluid.rounded-circle {
            width: 120px !important;
            height: 120px !important;
        }
    }

    /* Large Desktop Styles */
    @media (min-width: 1200px) {
        .container {
            max-width: 700px;
        }
        .fs-21 {
            font-size: 13px !important;
        }
    }

    /* Common improvements */
    .btn:hover {
        transform: translateY(-1px);
    }
    .badge {
        border-radius: 0.375rem;
    }
    .row {
        margin: 0;
    }
    .row .col,
    .row .col-4,
    .row .col-8 {
        padding: 0.25rem 0;
    }

    /* Info cards styling */
    .bg-white.p-3:not(:first-child) {
        border: 1px solid #e9ecef;
    }

    /* Action buttons styling */
    .d-flex.gap-2 {
        margin-top: 1rem;
    }
</style>