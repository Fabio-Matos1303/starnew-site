<script setup lang="ts">
import { onMounted, ref } from 'vue'

const isDark = ref(false)

function applyTheme(dark: boolean) {
  const root = document.documentElement
  if (dark) {
    root.classList.add('dark')
    localStorage.setItem('theme', 'dark')
  } else {
    root.classList.remove('dark')
    localStorage.setItem('theme', 'light')
  }
  isDark.value = dark
}

function toggleTheme() {
  applyTheme(!isDark.value)
}

onMounted(() => {
  const saved = localStorage.getItem('theme')
  applyTheme(saved ? saved === 'dark' : false)
})
</script>

<template>
  <button @click="toggleTheme" class="inline-flex items-center gap-2 rounded px-3 py-1.5 text-sm border border-slate-300 dark:border-slate-700">
    <span v-if="isDark">🌙 Escuro</span>
    <span v-else>☀️ Claro</span>
  </button>
</template>

<style scoped>
</style>
