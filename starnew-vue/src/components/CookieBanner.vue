<script setup lang="ts">
import { onMounted, ref } from 'vue'

const visible = ref(false)

onMounted(() => {
  const consent = localStorage.getItem('cookieConsent')
  visible.value = !consent
})

function accept() {
  localStorage.setItem('cookieConsent', 'accepted')
  visible.value = false
}

function reject() {
  localStorage.setItem('cookieConsent', 'rejected')
  visible.value = false
}
</script>

<template>
  <div v-if="visible" class="fixed bottom-0 inset-x-0 z-50">
    <div class="mx-auto max-w-5xl m-4 rounded-lg bg-slate-800 text-white p-4 shadow-lg">
      <div class="flex flex-col sm:flex-row items-center justify-between gap-4">
        <p class="text-sm">Este site utiliza cookies para melhorar sua experiência. Consulte nossa <a href="/privacidade" class="underline text-blue-300">Política de Privacidade</a>.</p>
        <div class="flex gap-2">
          <button @click="accept" class="bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded text-sm font-medium">Aceitar</button>
          <button @click="reject" class="bg-gray-600 hover:bg-gray-700 px-4 py-2 rounded text-sm font-medium">Rejeitar</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
</style>
