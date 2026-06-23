import { EventCard } from '../components/EventCard'

export function EventListScreen({ t, events, go, setSelectedQuestId }) {
  return (
    <main className="screen">
      <button className="back" onClick={() => go(4)}>{t.common.back}</button>
      <h2>{t.screens[6][0]}</h2>
      {events.map((event) => (
        <EventCard
          key={event.id}
          event={event}
          onClick={() => {
            setSelectedQuestId(event.id)
            go(event.id === 'asakusa' ? 7 : 42)
          }}
        />
      ))}
    </main>
  )
}
