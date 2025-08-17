import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'

const HomeView = () => import('../views/HomeView.vue')
const PrivacidadeView = () => import('../views/PrivacidadeView.vue')
const TermosView = () => import('../views/TermosView.vue')

const routes: RouteRecordRaw[] = [
  { path: '/', name: 'home', component: HomeView },
  { path: '/privacidade', name: 'privacidade', component: PrivacidadeView },
  { path: '/termos', name: 'termos', component: TermosView },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() {
    return { top: 0 }
  },
})

export default router
