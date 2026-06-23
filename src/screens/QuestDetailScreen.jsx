import { Button } from '../components/Button'
import { Card } from '../components/Card'

export function QuestDetailScreen({ quest, locale, go }) {
  const ja = locale === 'ja'

  return (
    <main className="screen">
      <button className="back" onClick={() => go(6)}>← {ja ? '戻る' : 'Back'}</button>
      <h2>{quest.title[locale]}</h2>
      <div className="image">{quest.icon}</div>
      <Card><p>{quest.description[locale]}</p></Card>
      <Button onClick={() => go(43)}>
        {ja ? 'このクエストを始める' : 'Start This Quest'}
      </Button>
    </main>
  )
}
