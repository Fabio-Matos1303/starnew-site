<script setup lang="ts">
const posts = [
  { title: 'Como escolher o nobreak ideal', href: '/blog/como-escolher-nobreak-ideal.html' },
  { title: 'Manutenção preventiva', href: '/blog/manutenção-preventiva-Nobreaks-Estabilizadores.html' },
  { title: 'Senoidais vs aproximados', href: '/blog/nobreaks-senoidais-vs-aproximados.html' },
]
</script>

<template>
  <section aria-labelledby="blog-title" class="py-16">
    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <h2 id="blog-title" class="text-2xl font-semibold mb-8">Do nosso Blog</h2>
      <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <article v-for="p in posts" :key="p.href" class="rounded-lg border border-slate-200 dark:border-slate-700 p-5 bg-white dark:bg-slate-900">
          <h3 class="font-semibold mb-1">
            <a :href="p.href" class="hover:underline">{{ p.title }}</a>
          </h3>
          <p class="text-sm text-slate-600 dark:text-slate-300">Leia no site atual (estático).</p>
        </article>
      </div>
    </div>
  </section>
</template>

<style scoped>
</style>
