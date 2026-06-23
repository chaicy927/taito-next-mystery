import { Button } from '../components/Button'
import { Card } from '../components/Card'

export function QuestSpotScreen({ quest, locale, go }) {
  const ja = locale === 'ja'

  return (
    <main className="screen">
      <h2>{ja ? 'スポット到着' : 'Spot Reached'}</h2>
      <div className="image">📍</div>
      <Card><p>{quest.spot[locale]}</p></Card>
      <Button onClick={() => go(45)}>
        {ja ? '謎に挑戦する' : 'Solve the Puzzle'}
      </Button>
    </main>
  )
}
