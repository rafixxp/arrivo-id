<script setup>
import { ref,onMounted, onBeforeUnmount, onBeforeMount, computed } from 'vue'
import { Modal } from 'bootstrap'
import axios from 'axios'
import Toast from '../../lib/toast'
import Topbar from '../../components/Topbar.vue'

const branches = ref([])
const hours = ref([])
const employees = ref([])
const data = ref({ data: [] })

const add = ref({
    hour_id: '',
    employee_id: '',
    start_date: '',
    end_date: '',
})

const schedules = ref({
    branch_id: '',
    hour_id: '',
    employee_id: '',
    start_date: '',
    end_date: '',
})

const edit = ref({
    hour_id: '',
    date: '',
    employee_id: '',
    is_active: '1'
})

const addCustomSchedule = (date, employee) => {
    add.value.start_date = date
    add.value.employee_id = employee
}

const editSchedule = (employee, hour_id, date, is_active) => {
    edit.value.hour_id = hour_id
    edit.value.date = date
    edit.value.employee_id = employee
    edit.value.is_active = is_active
}

const customSchedule = async () => {
    const res = await axios.post('/api/schedules/custom', add.value, {
        headers:{
            'Authorization' : `Bearer ${localStorage.getItem('token')}`
        }
    })

    if(res.status == 201){
        Toast.fire({
            icon: 'success',
            title: 'Jadwal berhasil di tambahkan'
        })

        setTimeout(() => {
            window.location.reload();
        }, 2000)
    }
}

const update = async () => {
    const res = await axios.post('/api/schedules/update', edit.value, {
        headers:{
            'Authorization' : `Bearer ${localStorage.getItem('token')}`
        }
    })

    if(res.status == 200){
        Toast.fire({
            icon: 'success',
            title: res.data.message
        })

        setTimeout(() => {
            window.location.reload();
        }, 2000)
    }
    else{
        Toast.fire({
            icon: 'error',
            title: res.data.message
        })

        setTimeout(() => {
            window.location.reload();
        }, 2000)
    }
}

const normalizedData = computed(() => {
    if (!data.value || !Array.isArray(data.value.data)) return [];
    return data.value.data.map(user => {
        const schedulesByDate = {}
        // ubah array → object by date
        if (Array.isArray(user.schedules)) {
            user.schedules.forEach(s => {
                schedulesByDate[s.date] = s
            })
        }
        return {
            ...user,
            schedulesByDate
        }
    })
})

const fetchEmployee = async (id) => {
    const employee = await axios.get(`/api/employees/hours/${id}`, {
        headers:{
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
    })

    employees.value = employee.data.data
}

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

            setTimeout(() => {
                window.location.reload();
            }, 2000)
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
                        <select class="form-select" v-model="edit.hour_id">
                            <option v-for="hour in hours" :value="hour.id">{{ hour.name }} ({{ hour.clock_in }} - {{ hour.clock_out }})</option>
                        </select>
                    </div>
                    <div class="form-group mb-2">
                        <label class="form-label fs-13 text-muted">Apakah Libur ?</label>
                        <select class="form-select" v-model="edit.is_active">
                            <option value="0">Ya</option>
                            <option value="1">Tidak</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button class="btn" data-bs-dismiss="modal" @click="closeModal">Batal</button>
                    <button class="btn btn-dark" @click="update">Simpan</button>
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
                        <select class="form-select" v-model="add.hour_id">
                            <option v-for="hour in hours" :value="hour.id">{{ hour.name }} ({{ hour.clock_in }} - {{ hour.clock_out }})</option>
                        </select>
                    </div>
                    <div class="row g-3">
                        <div class="col-6">
                            <label class="form-label fs-13 text-muted">Dari Tanggal</label>
                            <input type="date" class="form-control" v-model="add.start_date">
                        </div>
                        <div class="col-6">
                            <label class="form-label fs-13 text-muted">Sampai Tanggal</label>
                            <input type="date" class="form-control" v-model="add.end_date">
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button class="btn" data-bs-dismiss="modal">Batal</button>
                    <button class="btn btn-dark" @click="customSchedule">Simpan</button>
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
                        <select class="form-select" v-model="schedules.hour_id" @change="fetchEmployee(schedules.hour_id)">
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
                    <button class="btn" data-bs-dismiss="modal">Batal</button>
                    <button class="btn btn-dark" @click="generateSchedule">Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container px-2 pt-0 pb-2 position-fixed bg-white z-index-99">
        <div class="row px-3">
            <div class="col-7 p-1">
                <label class="fs-21 px-1">Filter Tanggal</label>
                <select class="form-select fs-21 border-1">
                    <option value="">Pilih Rentang Tanggal</option>
                </select>
            </div>
            <!-- <div class="col p-1">
                <label class="fs-21 px-1">Filter Tanggal</label>
                <select class="form-select fs-21 border-1">
                    <option value="">Pilih Cabang</option>
                </select>
            </div> -->
            <div class="col p-1">
                <button class="btn btn-danger mt-4 w-100 fs-13"><span class="bi bi-calendar-x me-2"></span>Update Libur</button>
            </div>
        </div>
    </div>

    <div class="container mt-4 pt-5 mb-5 pb-5 px-3">
        <div class="bg-white rounded p-2">
            <div class="table-scroll">
                <table class="table table-bordered">
                    <thead class="fs-13">
                        <tr>
                            <th>Nama Karyawan</th>
                            <th v-for="date in data.dates" :key="date">
                                {{ date[1] }}
                            </th>
                        </tr>
                    </thead>

                    <tbody class="fs-14">
                        <tr
                            v-for="schedules in normalizedData"
                            :key="schedules.user_name"
                            @click="openModal"
                        >
                            <td>{{ schedules.user_name }}</td>

                            <td v-for="date in data.dates" :key="date[0]">
                                <div class="bg-white border-dashed rounded p-2" v-if="schedules.schedulesByDate[date[0]] && schedules.schedulesByDate[date[0]].status == '1'" data-bs-toggle="modal" data-bs-target="#editModal" @click="editSchedule(schedules.user_id, schedules.schedulesByDate[date[0]].hour_id, date[0], schedules.schedulesByDate[date[0]].status)">
                                    <h6 class="text-muted"> {{ schedules.schedulesByDate[date[0]].hour_name ?? '-' }}</h6>
                                    <span class="fs-21">{{schedules.schedulesByDate[date[0]].clock_in}} - {{ schedules.schedulesByDate[date[0]].clock_out }}</span>
                                </div>

                                <div class="bg-danger text-white border-white border-dashed rounded p-2" v-else-if="schedules.schedulesByDate[date[0]] && schedules.schedulesByDate[date[0]].status == '0'" data-bs-toggle="modal" data-bs-target="#editModal" @click="editSchedule(schedules.user_id, schedules.schedulesByDate[date[0]].hour_id, date[0], schedules.schedulesByDate[date[0]].status)">
                                    <h6 class="text-white">Libur</h6>
                                    <span class="fs-21">{{schedules.schedulesByDate[date[0]].clock_in}} - {{ schedules.schedulesByDate[date[0]].clock_out }}</span>
                                </div>

                                <div class="bg-white text-center text-align-center" data-bs-toggle="modal" data-bs-target="#newModal" @click="addCustomSchedule(date[0], schedules.user_id)" v-else>
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
    width: 63px;
    height: 63px;
    font-size: 19px;
}
.pt-0{
    margin-top: -16px !important;
}
.fs-21{
    font-size: 11px;
}
.fs-13{
    font-size: 12px;
}
.fs-14{
    font-size: 13px;
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
    min-width: 110px;
    padding: 6px;
    width: auto;
}

/* Table scroll wrapper to enable horizontal and vertical scrolling */
.table-scroll{
    overflow-y: auto;
    max-height: 80vh;
    padding: 6px;
}
.table-scroll::-webkit-scrollbar{
    height: 8px;
    width: 8px;
}
.table-scroll table{
    min-width: 800px;
}
.pt-6{
    padding-top: 9vh;
}
.z-index-99{
    z-index: 99;
}
</style>