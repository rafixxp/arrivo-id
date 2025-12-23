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

const routes = [
    {
        path: '/',
        component: MainLayout,
        children:[
           {
                path: '',
                component: Home
           },
           {
                path: '/attendance',
                component: AttendancesMenu
           },
           {
                path: '/employee',
                component: Employee
           },
           {
                path: '/employee/add',
                component: AddEmployee
           },
           {
                path: '/employee/edit',
                component: EditEmployee
           },
           {
                path: '/employee/detail',
                component: DetailEmployee
           },
           {
                path: '/settings/company',
                component: Company
           },
           {
                path: '/settings/branches',
                component: Branches
           },
           {
                path: '/settings/position',
                component: Position
           },
           {
                path: '/settings/hours',
                component: Hours 
           },
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
    }
];  

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;