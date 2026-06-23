import { mockApi } from './mockApi'
import { realApi } from './realApi'

const api = import.meta.env.VITE_API_MODE === 'real' ? realApi : mockApi

export const eventApi = {
  list: locale => api.listEvents(locale)
}
