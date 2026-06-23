import { Card } from './Card'

export function EventCard({ event, onClick }) {
  return (
    <Card onClick={onClick}>
      <div className="image">{event.icon}</div>
      <h3>{event.title}</h3>
      <p>{event.subtitle}</p>
      <p>{event.status}</p>
    </Card>
  )
}
