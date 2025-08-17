<script setup lang="ts">
import { useHead } from '@vueuse/head'
import ProductTabs from '@/components/ProductTabs.vue'

useHead({
  title: 'Starnew Informática — Assistência técnica de nobreaks e estabilizadores',
  meta: [
    { name: 'description', content: 'Assistência técnica autorizada SMS, NHS e Ragtech em Salvador. Venda, locação e contratos de manutenção.' },
  ]
})
</script>

<template>
  <main>
    <!-- Hero -->
    <section class="relative overflow-hidden py-16 sm:py-20 bg-slate-50 dark:bg-slate-800/40">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 grid md:grid-cols-2 gap-10 items-center">
        <div class="space-y-5">
          <h1 class="text-3xl sm:text-4xl font-bold tracking-tight">
            Especialistas em nobreaks e estabilizadores
          </h1>
          <p class="text-slate-600 dark:text-slate-300">
            Assistência autorizada SMS, NHS e Ragtech. Venda, locação e manutenção desde 1994.
          </p>
          <div class="flex flex-wrap gap-3">
            <a href="#contato" class="px-5 py-2.5 rounded bg-[--color-brand] text-white hover:opacity-90">Solicitar orçamento</a>
            <a href="#servicos" class="px-5 py-2.5 rounded bg-[--color-accent] text-white hover:opacity-90">Conhecer serviços</a>
          </div>
        </div>
        <div class="aspect-video rounded-xl bg-gradient-to-br from-blue-200/40 to-teal-200/40 dark:from-blue-900/30 dark:to-teal-900/30"></div>
      </div>
    </section>

    <!-- Âncoras principais -->
    <section id="quemsomos" class="py-16">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <h2 class="text-2xl font-semibold mb-4">Quem Somos</h2>
        <p class="text-slate-600 dark:text-slate-300">Conteúdo a migrar da versão atual.</p>
      </div>
    </section>
    <section id="servicos" class="py-16 bg-slate-50 dark:bg-slate-800/40">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <h2 class="text-2xl font-semibold mb-4">Serviços</h2>
        <p class="text-slate-600 dark:text-slate-300 mb-6">Conteúdo a migrar da versão atual.</p>
        <ProductTabs />
      </div>
    </section>
    <section id="contato" class="py-16">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <h2 class="text-2xl font-semibold mb-4">Contato</h2>
        <p class="text-slate-600 dark:text-slate-300">Formulário será implementado na Sprint 4.</p>
      </div>
    </section>
  </main>
</template>

<style scoped>
</style>
