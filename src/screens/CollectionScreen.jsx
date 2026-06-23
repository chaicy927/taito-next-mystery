import { Button } from '../components/Button'
import { Card } from '../components/Card'

export function CollectionScreen({ t, go }) {
  return (
    <main className="screen">
      <h2>{t.screens[20][0]}</h2>
      <p>{t.screens[20][1]}</p>
      <Card>🏆 Memory of Raijin SSR</Card>
      <Card>🌀 Memory of Fujin SR</Card>
      <Card>👻 Spirit Parade Memory UR</Card>
      <Button onClick={() => go(6)}>Back to Events</Button>
      <Button variant="secondary" onClick={() => go(4)}>
        {t.common.home}
      </Button>
    </main>
  )
}
