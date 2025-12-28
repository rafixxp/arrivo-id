<script setup>
import { ref,onMounted, onBeforeUnmount, onBeforeMount, computed } from 'vue'
import { Modal } from 'bootstrap'
import axios from 'axios'
import Toast from '../../lib/toast'
import Topbar from '../../components/Topbar.vue'

const branches = ref([])
const hours = ref([])
const employees = ref([])
const data = ref([])

const schedules = ref({
    branch_id: '',
    hour_id: '',
    employee_id: '',
    start_date: '',
    end_date: '',
})

const normalizedData = computed(() => {
    return data.value.data.map(user => {
        const schedulesByDate = {}

        // ubah array → object by date
        user.schedules.forEach(s => {
            schedulesByDate[s.date] = s
        })

        return {
            ...user,
            schedulesByDate
        }
    })
})

const generateSchedule = async () => {
    try {
        const res = await axios.post('/api/schedules', schedules.value, {
            headers:{
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })

        if(res.status === 201){
            Toast.fire({
                icon: 'success',
                title: 'Jadwal berhasil di generate'
            })
        }
    } catch (error) {
        Toast.fire({
            icon: 'error',
            title: 'Gagal generate jadwal'
        })
    }
}

onBeforeMount(async () => {
    const scheduled = await axios.get('/api/schedules', {
        headers:{
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })
    data.value = scheduled.data

    const branch = await axios.get('/api/branches', {
        headers:{
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })

    branches.value = branch.data

    const hour = await axios.get('/api/hours', {
        headers:{
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })

    hours.value = hour.data

    const employee = await axios.get('/api/employees/all', {
        headers:{
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })

    employees.value = employee.data.data
})
</script>

<template>
        <Topbar title="Penjadwalan"/>
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content mx-2">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Edit Jadwal</h5>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-2">
                            <label class="form-label fs-13 text-muted">Jam Kerja</label>
                            <select class="form-select" v-model="schedules.hour_id">
                                <option value="all">Semua Jam Kerja</option>
                                <option v-for="hour in hours" :value="hour.id">{{ hour.name }} ({{ hour.clock_in }} - {{ hour.clock_out }})</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button class="btn btn-danger" @click="closeModal">Batal</button>
                        <button class="btn btn-primary">Simpan</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="newModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content mx-2">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Tambah Jadwal</h5>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-2">
                            <label class="form-label fs-13 text-muted">Jam Kerja</label>
                            <select class="form-select" v-model="schedules.hour_id">
                                <option v-for="hour in hours" :value="hour.id">{{ hour.name }} ({{ hour.clock_in }} - {{ hour.clock_out }})</option>
                            </select>
                        </div>
                        <div class="row g-3">
                            <div class="col-6">
                                <label class="form-label fs-13 text-muted">Dari Tanggal</label>
                                <input type="date" class="form-control" v-model="schedules.start_date">
                            </div>
                            <div class="col-6">
                                <label class="form-label fs-13 text-muted">Sampai Tanggal</label>
                                <input type="date" class="form-control" v-model="schedules.end_date">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button class="btn btn-danger" data-bs-dismiss="modal">Batal</button>
                        <button class="btn btn-dark" @click="generateSchedule">Simpan</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content mx-2">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">Generate Jadwal</h5>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-2">
                            <label class="form-label fs-13 text-muted">Cabang</label>
                            <select class="form-select" v-model="schedules.branch_id">
                                <option value="all">Semua Cabang</option>
                                <option v-for="branch in branches" :value="branch.id">{{ branch.name }}</option>
                            </select>
                        </div>
                        <div class="form-group mb-2">
                            <label class="form-label fs-13 text-muted">Jam Kerja</label>
                            <select class="form-select" v-model="schedules.hour_id">
                                <option value="all">Semua Jam Kerja</option>
                                <option v-for="hour in hours" :value="hour.id">{{ hour.name }} ({{ hour.clock_in }} - {{ hour.clock_out }})</option>
                            </select>
                        </div>
                        <div class="form-group mb-2">
                            <label class="form-label fs-13 text-muted">Karyawan</label>
                            <select class="form-select" v-model="schedules.employee_id">
                                <option value="all">Semua Karyawan</option>
                                <option v-for="employee in employees" :value="employee.id">{{ employee.name }}</option>
                            </select>
                        </div>
                        <div class="row g-3">
                            <div class="col-6">
                                <label class="form-label fs-13 text-muted">Dari Tanggal</label>
                                <input type="date" class="form-control" v-model="schedules.start_date">
                            </div>
                            <div class="col-6">
                                <label class="form-label fs-13 text-muted">Sampai Tanggal</label>
                                <input type="date" class="form-control" v-model="schedules.end_date">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer border-0">
                        <button class="btn btn-danger" data-bs-dismiss="modal">Batal</button>
                        <button class="btn btn-dark" @click="generateSchedule">Simpan</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="container px-2 pt-0 pb-2 position-fixed bg-white z-index-99">
            <div class="row px-3">
                <div class="col p-1">
                    <select class="form-select fs-21 border-0">
                        <option value="">Pilih Rentang Tanggal</option>
                    </select>
                </div>
                <div class="col p-1">
                    <select class="form-select fs-21 border-0">
                        <option value="">Pilih Cabang</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="container pt-5 mb-5 pb-5 px-3">
           <div class="bg-white rounded p-2">
                <div class="table-scroll">
                    <table class="table table-bordered fs-13">
                        <thead>
                            <tr>
                                <th>Nama Karyawan</th>
                                <th v-for="date in data.dates" :key="date">
                                    {{ date }}
                                </th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr
                                v-for="schedules in normalizedData"
                                :key="schedules.user_name"
                                @click="openModal"
                            >
                                <td>{{ schedules.user_name }}</td>

                                <!-- LOOP TANGGAL, BUKAN ARRAY JADWAL -->
                                <td v-for="date in data.dates" :key="date">
                                    <div class="bg-white border-dashed rounded p-2" v-if="schedules.schedulesByDate[date]" data-bs-toggle="modal" data-bs-target="#editModal">
                                        <h6 class="text-muted"> {{ schedules.schedulesByDate[date].hour_name ?? '-' }}</h6>
                                        <span class="fs-21">{{schedules.schedulesByDate[date].clock_in}} - {{ schedules.schedulesByDate[date].clock_out }}</span>
                                    </div>
                                    <div class="bg-white text-center text-align-center" data-bs-toggle="modal" data-bs-target="#newModal" v-else>
                                        <i class="bi bi-plus-lg fs-5 cursor-pointer d-block mt-2 fw-bold"></i>
                                        <span class="fs-21 text-muted">Tambah jadwal</span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <button class="btn btn-dark btn-fixed rounded-circle" data-bs-toggle="modal" data-bs-target="#addModal"><i class="bi bi-calendar-plus"></i></button>
</template>

<style scoped>
.btn-fixed{
    position: fixed;
    right: 7vw;
    bottom: 15vh;
    height: 56px;
    width: 56px;
    font-size: 19px;
}
.pt-0{
    margin-top: -16px !important;
}
.fs-21{
    font-size: 11px;
}
.fs-13{
    font-size: 14px;
}
.border-none{
    border: none;
}
h6{
    font-size: 15px;
}
.border-dashed{
    border:  1px dashed #000000;
}
table th, table td {
    min-width: 120px;
    padding: 6px;
    width: auto;
}

/* Table scroll wrapper to enable horizontal and vertical scrolling */
.table-scroll{
    overflow-y: auto;
    max-height: 70vh;
    padding: 6px;
}
.table-scroll::-webkit-scrollbar{
    height: 8px;
    width: 8px;
}
.table-scroll table{
    min-width: 1400px;
}
.pt-6{
    padding-top: 9vh;
}
.z-index-99{
    z-index: 99;
}
</style>