import { events } from '../data/events'

export const mockApi = {
  async listEvents(locale) {
    await new Promise(resolve => setTimeout(resolve, 150))
    return events.map(({ title, subtitle, status, ...event }) => ({
      ...event,
      title: title[locale],
      subtitle: subtitle[locale],
      status: status[locale]
    }))
  }
}
