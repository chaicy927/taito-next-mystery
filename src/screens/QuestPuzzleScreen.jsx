import { Button } from '../components/Button'

export function QuestPuzzleScreen({ quest, locale, go }) {
  const ja = locale === 'ja'

  return (
    <main className="screen">
      <h2>{ja ? 'クエスト問題' : 'Quest Puzzle'}</h2>
      <p>{quest.puzzle[locale]}</p>
      {quest.answers[locale].map((answer) => (
        <Button key={answer} variant="secondary" onClick={() => go(46)}>
          {answer}
        </Button>
      ))}
    </main>
  )
}
