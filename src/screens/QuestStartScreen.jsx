import { Button } from '../components/Button'
import { Card } from '../components/Card'

export function QuestStartScreen({ quest, locale, go }) {
  const ja = locale === 'ja'

  return (
    <main className="screen">
      <h2>{ja ? 'クエスト開始' : 'Quest Start'}</h2>
      <div className="image">{quest.icon}</div>
      <Card>
        <h3>{quest.title[locale]}</h3>
        <p>{ja ? '最初のスポットへ向かいましょう。' : 'Head to the first spot.'}</p>
      </Card>
      <Button onClick={() => go(44)}>
        {ja ? 'スポットへ進む' : 'Go to Spot'}
      </Button>
    </main>
  )
}
