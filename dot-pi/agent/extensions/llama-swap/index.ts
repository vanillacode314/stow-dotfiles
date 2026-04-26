import type { ExtensionAPI } from '@earendil-works/pi-coding-agent'

export default async function (pi: ExtensionAPI) {
  const response = await fetch('https://llama-swap.homelab.lan/v1/models')
  const payload = (await response.json()) as {
    data: Array<{
      id: string
      name?: string
      context_window?: number
      max_tokens?: number
    }>
  }

  pi.registerProvider('llama-swap', {
    baseUrl: 'https://llama-swap.homelab.lan/v1',
    apiKey: 'LOCAL_OPENAI_API_KEY',
    api: 'openai-completions',
    models: payload.data.map((model) => ({
      id: model.id,
      name: model.name ?? model.id,
      reasoning: false,
      input: ['text'],
      cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
      contextWindow: model.context_window ?? 128000,
      maxTokens: model.max_tokens ?? 4096,
    })),
  })
}
