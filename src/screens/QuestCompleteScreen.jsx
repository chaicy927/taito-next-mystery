import { Button } from '../components/Button'
import { Card } from '../components/Card'

export function QuestCompleteScreen({ quest, locale, go }) {
  const ja = locale === 'ja'

  return (
    <main className="screen complete">
      <div className="trophy">🏆</div>
      <h2 className="center">
        {quest.title[locale]}<br />
        {ja ? '達成！' : 'Completed!'}
      </h2>
      <Card className="center">
        <h3>{ja ? 'クエストクリア' : 'Quest CLEAR'}</h3>
        <p>{ja ? '報酬をコレクションに追加しました。' : 'Your reward was added to the collection.'}</p>
      </Card>
      <Button onClick={() => go(6)}>
        {ja ? 'イベント一覧へ戻る' : 'Back to Events'}
      </Button>
      <Button variant="secondary" onClick={() => go(4)}>
        {ja ? 'ホームへ' : 'Home'}
      </Button>
    </main>
  )
}
