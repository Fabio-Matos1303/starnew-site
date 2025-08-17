<script setup lang="ts">
import { useHead } from '@vueuse/head'

useHead({
  title: 'Starnew Informática — Assistência técnica de nobreaks e estabilizadores',
  meta: [
    { name: 'description', content: 'Assistência técnica autorizada SMS, NHS e Ragtech em Salvador. Venda, locação e contratos de manutenção.' },
  ]
})
</script>

<template>
  <main class="min-h-dvh flex items-center justify-center p-8">
    <div class="max-w-2xl text-center space-y-4">
      <h1 class="text-3xl font-bold tracking-tight">Starnew Informática</h1>
      <p class="text-slate-600">Base do projeto Vue 3 criada. Próximas sprints: layout, seções e conteúdo.</p>
      <div class="flex items-center justify-center gap-3">
        <a href="#contato" class="px-4 py-2 rounded bg-blue-600 text-white">Contato</a>
        <a href="#servicos" class="px-4 py-2 rounded bg-teal-600 text-white">Serviços</a>
      </div>
    </div>
  </main>
  
</template>

<style scoped>
</style>
