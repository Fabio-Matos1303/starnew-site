<script setup lang="ts">
import ThemeToggle from './ThemeToggle.vue'
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
        <ThemeToggle />
      </div>
    </div>
  </header>
</template>

<style scoped>
</style>
