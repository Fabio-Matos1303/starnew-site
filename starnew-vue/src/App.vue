<script setup lang="ts">
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'
import CookieBanner from './components/CookieBanner.vue'
</script>

<template>
  <div class="min-h-dvh flex flex-col bg-white text-slate-800 dark:bg-slate-900 dark:text-slate-100">
    <Header />
    <main class="flex-1">
      <RouterView />
    </main>
    <Footer />
    <CookieBanner />
  </div>
</template>

<style scoped>
</style>
