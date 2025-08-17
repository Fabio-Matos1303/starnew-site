import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'
import { createHead } from '@vueuse/head'
import { VueQueryPlugin } from '@tanstack/vue-query'

const app = createApp(App)

app.use(router)
app.use(createHead())
app.use(VueQueryPlugin)

app.mount('#app')
