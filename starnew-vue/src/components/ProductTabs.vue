<script setup lang="ts">
import { ref } from 'vue'

type TabKey = 'compra' | 'locacao'
const active = ref<TabKey>('compra')

const productsCompra = [
  { name: 'Nobreak SMS', desc: 'Linha corporativa', cta: '#contato' },
  { name: 'Nobreak NHS', desc: 'Mini III 700–2200VA', cta: '#contato' },
  { name: 'Nobreak Ragtech', desc: 'Modelos senoidais', cta: '#contato' },
]

const productsLocacao = [
  { name: 'Locação 1kVA', desc: 'Eventos e contingência', cta: '#contato' },
  { name: 'Locação 3kVA', desc: 'Ambiente crítico', cta: '#contato' },
  { name: 'Locação 6–10kVA', desc: 'Projetos especiais', cta: '#contato' },
]
</script>

<template>
  <div class="space-y-6">
    <div class="inline-flex rounded border border-slate-200 dark:border-slate-700 overflow-hidden">
      <button @click="active='compra'" :class="['px-4 py-2 text-sm', active==='compra' ? 'bg-[--color-brand] text-white' : '']">Compra</button>
      <button @click="active='locacao'" :class="['px-4 py-2 text-sm', active==='locacao' ? 'bg-[--color-brand] text-white' : '']">Locação</button>
    </div>

    <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
      <div v-for="p in (active==='compra'?productsCompra:productsLocacao)" :key="p.name" class="rounded-lg border border-slate-200 dark:border-slate-700 p-4 bg-white dark:bg-slate-900">
        <h3 class="font-semibold mb-1">{{ p.name }}</h3>
        <p class="text-sm text-slate-600 dark:text-slate-300 mb-3">{{ p.desc }}</p>
        <a :href="p.cta" class="inline-block px-3 py-1.5 rounded bg-[--color-accent] text-white text-sm">Solicitar cotação</a>
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>
