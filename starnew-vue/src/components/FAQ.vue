<script setup lang="ts">
import { ref } from 'vue'
const open = ref<number | null>(null)
</script>

<template>
  <section aria-labelledby="faq-title" class="py-16 bg-slate-50 dark:bg-slate-800/40">
    <div class="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
      <h2 id="faq-title" class="text-2xl font-semibold mb-8">Perguntas Frequentes</h2>
      <div class="space-y-3">
        <div class="rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-900">
          <button class="w-full text-left p-4 font-medium flex justify-between items-center" @click="open = open===1 ? null : 1" :aria-expanded="open===1">
            Assistência autorizada em quais marcas?
            <span aria-hidden="true">{{ open===1 ? '−' : '+' }}</span>
          </button>
          <div v-show="open===1" class="px-4 pb-4 text-slate-600 dark:text-slate-300">SMS, NHS e Ragtech.</div>
        </div>
        <div class="rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-900">
          <button class="w-full text-left p-4 font-medium flex justify-between items-center" @click="open = open===2 ? null : 2" :aria-expanded="open===2">Vocês atendem empresas?
            <span aria-hidden="true">{{ open===2 ? '−' : '+' }}</span>
          </button>
          <div v-show="open===2" class="px-4 pb-4 text-slate-600 dark:text-slate-300">Sim, com contratos corporativos e SLA.</div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
</style>
