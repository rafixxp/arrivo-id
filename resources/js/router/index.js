import { createRouter,createWebHistory } from "vue-router";
import Login from "../views/login.vue";
import MainLayout from "../layouts/MainLayout.vue";
import AuthLayout from "../layouts/AuthLayout.vue";
import Setting from "../views/admin/Setting.vue";
import Company from "../views/admin/Company.vue";
import Branches from "../views/admin/Branches.vue";
import Position from "../views/admin/Position.vue";
import Hours from "../views/admin/Hours.vue";
import AttendancesMenu from "../views/admin/AttendancesMenu.vue";
import Home from "../views/admin/Home.vue";
import Employee from "../views/admin/Employee.vue";
import AddEmployee from "../views/admin/AddEmployee.vue";
import EditEmployee from "../views/admin/EditEmployee.vue";
import DetailEmployee from "../views/admin/DetailEmployee.vue";
import Schedule from "../views/admin/Schedule.vue";
import Profile from "../views/admin/Profile.vue";
import HomeUser from "../views/user/HomeUser.vue";
import ScheduleUser from "../views/user/ScheduleUser.vue";
import Leave from "../views/user/Leave.vue";
import Payslip from "../views/user/Payslip.vue";
import NotFound from "../views/NotFound.vue";
import Forbidden from "../views/Forbidden.vue";
import DailyAttendance from "../views/admin/DailyAttendance.vue";

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

    // route butuh login
    if (to.meta.role) {
        if (!token) {
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