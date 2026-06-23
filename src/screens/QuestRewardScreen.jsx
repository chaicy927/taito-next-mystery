import { Button } from '../components/Button'
import { Card } from '../components/Card'

export function QuestRewardScreen({ quest, locale, go }) {
  const ja = locale === 'ja'

  return (
    <main className="screen">
      <h2 className="center">{ja ? '正解！' : 'Correct!'}</h2>
      <p className="exp center">+100 EXP</p>
      <Card className="center">
        <h3>{ja ? '獲得報酬' : 'Reward'}</h3>
        <p>{quest.reward[locale]}</p>
      </Card>
      <Button onClick={() => go(47)}>
        {ja ? '達成画面へ' : 'View Completion'}
      </Button>
    </main>
  )
}
