<script setup lang="ts">
import { ref } from 'vue'
import ThemeToggle from './ThemeToggle.vue'

const mobileOpen = ref(false)
function toggleMobile() { mobileOpen.value = !mobileOpen.value }
function closeMobile() { mobileOpen.value = false }
</script>

<template>
  <header class="sticky top-0 z-50 border-b border-slate-200/60 bg-white/80 dark:bg-slate-900/80 backdrop-blur supports-[backdrop-filter]:bg-white/60 supports-[backdrop-filter]:dark:bg-slate-900/60">
    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
      <RouterLink to="/" class="font-semibold text-slate-800 dark:text-slate-100">Starnew</RouterLink>
      <nav class="hidden md:flex items-center gap-6 text-sm">
        <a href="#quemsomos" class="hover:text-teal-600">Quem Somos</a>
        <a href="#servicos" class="hover:text-teal-600">Serviços</a>
        <a href="#contato" class="hover:text-teal-600">Contato</a>
      </nav>
      <div class="flex items-center gap-2">
        <button @click="toggleMobile" class="md:hidden inline-flex items-center justify-center rounded p-2 border border-slate-300 dark:border-slate-700" aria-label="Abrir menu">
          <svg v-if="!mobileOpen" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-5"><path d="M3.75 6.75h16.5v1.5H3.75zM3.75 11.25h16.5v1.5H3.75zM3.75 15.75h16.5v1.5H3.75z"/></svg>
          <svg v-else xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-5"><path d="M6.4 17.6 5 16.2 10.2 11 5 5.8 6.4 4.4 11.6 9.6 16.8 4.4 18.2 5.8 13 11l5.2 5.2-1.4 1.4-5.2-5.2z"/></svg>
        </button>
        <ThemeToggle />
      </div>
    </div>
    <div v-if="mobileOpen" class="md:hidden border-t border-slate-200/60 dark:border-slate-700">
      <nav class="px-4 py-3 space-y-2">
        <a @click="closeMobile" href="#quemsomos" class="block py-2">Quem Somos</a>
        <a @click="closeMobile" href="#servicos" class="block py-2">Serviços</a>
        <a @click="closeMobile" href="#contato" class="block py-2">Contato</a>
      </nav>
    </div>
  </header>
</template>

<style scoped>
</style>
