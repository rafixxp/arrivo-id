import { createRouter, createWebHistory } from "vue-router";

/* layouts */
const MainLayout = () => import("../layouts/MainLayout.vue");
const AuthLayout = () => import("../layouts/AuthLayout.vue");

/* auth */
const Login = () => import("../views/login.vue");

/* admin */
const Home = () => import("../views/admin/Home.vue");
const Employee = () => import("../views/admin/Employee.vue");
const AddEmployee = () => import("../views/admin/AddEmployee.vue");
const EditEmployee = () => import("../views/admin/EditEmployee.vue");
const DetailEmployee = () => import("../views/admin/DetailEmployee.vue");

const AttendancesMenu = () => import("../views/admin/AttendancesMenu.vue");
const Schedule = () => import("../views/admin/Schedule.vue");
const DailyAttendance = () => import("../views/admin/DailyAttendance.vue");
const AttendanceRecap = () => import("../views/admin/AttendanceRecap.vue");
const DetailAttendance = () => import("../views/admin/DetailAttendance.vue");

const Approval = () => import("../views/admin/Approval.vue");
const DetailApproval = () => import("../views/admin/DetailApproval.vue");

/* payslip admin */
const PayslipMenu = () => import("../views/admin/PayslipMenu.vue");
const PayslipComponent = () => import("../views/admin/PayslipComponent.vue");
const PayslipGenerate = () => import("../views/admin/PayslipGenerate.vue");
const PayslipSetting = () => import("../views/admin/PayslipSetting.vue");
const PayslipSetDetail = () => import("../views/admin/PayslipSetDetail.vue");
const PayslipList = () => import("../views/admin/PayslipList.vue");
const PayslipDetail = () => import("../views/admin/PayslipDetail.vue");

/* settings */
const Setting = () => import("../views/admin/Setting.vue");
const Company = () => import("../views/admin/Company.vue");
const Branches = () => import("../views/admin/Branches.vue");
const Position = () => import("../views/admin/Position.vue");
const Hours = () => import("../views/admin/Hours.vue");

/* user */
const HomeUser = () => import("../views/user/HomeUser.vue");
const ScheduleUser = () => import("../views/user/ScheduleUser.vue");
const Leave = () => import("../views/user/Leave.vue");
const CreateLeave = () => import("../views/user/CreateLeave.vue");
const DetailLeave = () => import("../views/user/DetailLeave.vue");
const Payslip = () => import("../views/user/Payslip.vue");

/* misc */
const Profile = () => import("../views/admin/Profile.vue");
const NotFound = () => import("../views/NotFound.vue");
const Forbidden = () => import("../views/Forbidden.vue");

const routes = [
    {
        path: '/',
        component: MainLayout,
        children:[
           {
               // path admin
                path: '',
                component: Home,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/employee',
                component: Employee,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/employee/add',
                component: AddEmployee,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/employee/edit/:id',
                component: EditEmployee,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/employee/detail/:id',
                component: DetailEmployee,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/attendance',
                component: AttendancesMenu,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/attendance/schedule',
                component: Schedule,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/attendance/daily',
                component: DailyAttendance,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/attendance/approval',
                component: Approval,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/attendance/approval/:id',
                component: DetailApproval,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/attendance/recap',
                component: AttendanceRecap,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/attendance/detail/:id',
                component: DetailAttendance,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/payslip/menu',
                component: PayslipMenu,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/payslip/component',
                component: PayslipComponent,
                meta: {
                    role: ['super admin']
                }
           },
           {    
                path: '/payslip/generate',
                component: PayslipGenerate,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/payslip/lists/:id',
                component: PayslipList,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/payslip/details/:id',
                component: PayslipDetail,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/payslip/setting',
                component: PayslipSetting,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/payslip/setting/:id',
                component: PayslipSetDetail,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/settings',
                component: Setting,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/settings/company',
                component: Company,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/settings/branches',
                component: Branches,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/settings/position',
                component: Position,
                meta: {
                    role: ['super admin']
                }
           },
           {
                path: '/settings/hours',
                component: Hours,
                meta: {
                    role: ['super admin']
                } 
           },
           {
                path: '/profile',
                component: Profile,
                meta: {
                    role: ['super admin','employee']
                }
           },
           {
               //  path user / employee
                path : '/home',
                component: HomeUser,
                meta: {
                    role: ['employee']
                }
           },
           {
                path: '/schedule',
                component: ScheduleUser,
                meta: {
                    role: ['employee']
                }
           },
           {
                path: '/leave',
                component: Leave,
                meta: {
                    role: ['employee']
                }
           },
           {
                path: '/leave/create',
                component: CreateLeave,
                meta: {
                    role: ['employee']
                }
           },
           {
                path: '/leave/:id',
                component: DetailLeave,
                meta: {
                    role: ['employee']
                }
           },
           {
                path: '/payslip',
                component: Payslip,
                meta: {
                    role: ['employee']
                }
           }
        ]
    },
    {
        path: '/auth/',
        component: AuthLayout,
        children:[
            {
                path: 'login',
                component: Login
            }
        ]
    },
    {
        path: '/:pathMatch(.*)*',
        component: NotFound
    },
    {
        path: '/forbidden',
        component: Forbidden
    }
];  

const router = createRouter({
    history: createWebHistory(),
    routes,
});

router.beforeEach((to, from, next) => {
    const token = localStorage.getItem('token')
    const user  = JSON.parse(localStorage.getItem('user'))

    if(to.path === '/auth/login' && token && user){
        return next(user.role === 'employee' ? '/home' : '/')
    }
    
    // route butuh login
    if (to.meta.role) {
        if (!token || !user) {
            return next('/auth/login')
        }

        // cek role
        if (!to.meta.role.includes(user.role)) {
            return next('/forbidden')
        }
    }

    next()
})

export default router;