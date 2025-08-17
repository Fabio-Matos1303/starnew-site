<script setup lang="ts">
import { reactive, ref } from 'vue'
import { z } from 'zod'

const formSchema = z.object({
  name: z.string().min(2, 'Informe seu nome'),
  email: z.string().email('E-mail inválido'),
  phone: z.string().min(8, 'Telefone inválido').optional().or(z.literal('')),
  subject: z.enum(['orcamento', 'assistencia', 'locacao', 'outros']),
  message: z.string().min(10, 'Mensagem muito curta'),
  privacy: z.literal(true, { message: 'É necessário aceitar a Política de Privacidade' }),
  website: z.string().max(0).optional(), // honeypot
})

type UiFormData = {
  name: string
  email: string
  phone?: string
  subject: 'orcamento' | 'assistencia' | 'locacao' | 'outros'
  message: string
  privacy: boolean
  website?: string
}

const data = reactive<UiFormData>({
  name: '',
  email: '',
  phone: '',
  subject: 'orcamento',
  message: '',
  privacy: false,
  website: '',
})

const errors = reactive<Record<string, string>>({})
const sending = ref(false)
const responseMsg = ref<{ type: 'success' | 'error'; text: string } | null>(null)
const startedAt = Date.now()

function validateField(key: keyof UiFormData) {
  if (key === 'privacy') {
    if (!data.privacy) errors.privacy = 'É necessário aceitar a Política de Privacidade'
    else delete errors.privacy
    return
  }
  const single = formSchema.pick({ [key]: true } as any)
  const res = single.safeParse({ [key]: (data as any)[key] })
  if (!res.success) errors[key as string] = res.error.issues[0]?.message ?? 'Campo inválido'
  else delete errors[key as string]
}

async function onSubmit(e: Event) {
  e.preventDefault()
  responseMsg.value = null

  // tempo mínimo para evitar bots
  if (Date.now() - startedAt < 1200) {
    responseMsg.value = { type: 'error', text: 'Envio muito rápido. Tente novamente.' }
    return
  }

  const res = formSchema.safeParse({ ...data, privacy: data.privacy === true })
  errorsClear()
  if (!res.success) {
    for (const issue of res.error.issues) {
      const path = issue.path[0] as string
      errors[path] = issue.message
    }
    return
  }

  sending.value = true
  try {
    const resp = await fetch('https://formspree.io/f/xqalqkqd', {
      method: 'POST',
      headers: { Accept: 'application/json' },
      body: new FormData(e.target as HTMLFormElement),
    })
    if (resp.ok) {
      responseMsg.value = { type: 'success', text: 'Mensagem enviada com sucesso!' }
      ;(e.target as HTMLFormElement).reset()
      Object.assign(data, { name: '', email: '', phone: '', subject: 'orcamento', message: '', privacy: false, website: '' })
    } else {
      throw new Error('Falha no envio')
    }
  } catch {
    responseMsg.value = { type: 'error', text: 'Erro ao enviar. Tente novamente.' }
  } finally {
    sending.value = false
  }
}

function errorsClear() {
  for (const k of Object.keys(errors)) delete errors[k]
}
</script>

<template>
  <form @submit="onSubmit" class="grid gap-4 max-w-2xl">
    <div class="grid sm:grid-cols-2 gap-4">
      <div>
        <label for="name" class="block text-sm font-medium">Nome</label>
        <input id="name" name="name" v-model="data.name" @blur="validateField('name')" class="mt-1 w-full rounded border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-900 px-3 py-2" required />
        <p v-if="errors.name" class="text-sm text-red-600 mt-1">{{ errors.name }}</p>
      </div>
      <div>
        <label for="email" class="block text-sm font-medium">E-mail</label>
        <input id="email" name="email" type="email" v-model="data.email" @blur="validateField('email')" class="mt-1 w-full rounded border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-900 px-3 py-2" required />
        <p v-if="errors.email" class="text-sm text-red-600 mt-1">{{ errors.email }}</p>
      </div>
    </div>
    <div class="grid sm:grid-cols-2 gap-4">
      <div>
        <label for="phone" class="block text-sm font-medium">Telefone</label>
        <input id="phone" name="phone" v-model="data.phone" @blur="validateField('phone')" class="mt-1 w-full rounded border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-900 px-3 py-2" />
        <p v-if="errors.phone" class="text-sm text-red-600 mt-1">{{ errors.phone }}</p>
      </div>
      <div>
        <label for="subject" class="block text-sm font-medium">Assunto</label>
        <select id="subject" name="subject" v-model="data.subject" class="mt-1 w-full rounded border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-900 px-3 py-2">
          <option value="orcamento">Orçamento</option>
          <option value="assistencia">Assistência técnica</option>
          <option value="locacao">Locação</option>
          <option value="outros">Outros</option>
        </select>
      </div>
    </div>
    <div>
      <label for="message" class="block text-sm font-medium">Mensagem</label>
      <textarea id="message" name="message" rows="5" v-model="data.message" @blur="validateField('message')" class="mt-1 w-full rounded border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-900 px-3 py-2" required />
      <p v-if="errors.message" class="text-sm text-red-600 mt-1">{{ errors.message }}</p>
    </div>

    <!-- Honeypot -->
    <input type="text" name="website" v-model="data.website" class="hidden" tabindex="-1" autocomplete="off" />

    <div class="flex items-start gap-3">
      <input id="privacy" name="privacy" type="checkbox" v-model="data.privacy" class="mt-1" />
      <label for="privacy" class="text-sm">Concordo com a <a href="/privacidade.html" class="underline text-[--color-brand]">Política de Privacidade</a> e autorizo o tratamento dos meus dados pessoais.</label>
    </div>
    <p v-if="errors.privacy" class="text-sm text-red-600 -mt-2">{{ errors.privacy }}</p>

    <div class="flex items-center gap-3">
      <button type="submit" :disabled="sending" class="px-5 py-2.5 rounded bg-[--color-brand] text-white disabled:opacity-60">{{ sending ? 'Enviando...' : 'Enviar' }}</button>
      <span v-if="responseMsg" :class="['text-sm', responseMsg.type==='success' ? 'text-green-600' : 'text-red-600']">{{ responseMsg.text }}</span>
    </div>
  </form>
</template>

<style scoped>
</style>
