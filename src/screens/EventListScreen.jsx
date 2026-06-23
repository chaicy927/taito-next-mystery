import { EventCard } from '../components/EventCard'
import { BackButton, ScreenLayout } from './ScreenLayout'
export function EventListScreen({ t, go, events }) {
  return <ScreenLayout><BackButton t={t} go={go}/><h2>{t.screens[6][0]}</h2>{events.map(event => <EventCard key={event.id} event={event} onClick={event.available ? () => go(7) : undefined}/>)}</ScreenLayout>
}
