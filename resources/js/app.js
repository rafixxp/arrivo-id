import { createApp } from 'vue';
import App from './App.vue';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import router from './router';

const app = createApp(App);
app.use(router)
app.mount('#app');

if ('serviceWorker' in navigator) {
   window.addEventListener('load', () => {
        navigator.serviceWorker.register('/sw.js')
        .then(()=>{
            console.log('ServiceWorker berhasil teregistrasi !')
        })
        .catch((e) => {
            console.log(e)
        })
   })
}