#!/usr/bin/env bash
set -e

mkdir -p src/data src/screens

cat << 'EOF' > src/data/quests.js
export const quests = {
  ueno: {
    icon: '🏛️',
    title: { ja: '上野ミュージアムの謎', en: 'Ueno Museum Mystery' },
    description: { ja: '消えたコレクションの行方を追いましょう。', en: 'Track down the missing collection.' },
    spot: { ja: '上野公園の入口に到着しました。', en: 'You arrived at the entrance to Ueno Park.' },
    puzzle: { ja: '展示品を守る動物はどれ？', en: 'Which animal guards the collection?' },
    answers: { ja: ['パンダ', 'キツネ', 'フクロウ'], en: ['Panda', 'Fox', 'Owl'] },
    reward: { ja: 'パンダ探偵バッジ', en: 'Panda Detective Badge' }
  },
  yanaka: {
    icon: '🏮',
    title: { ja: '谷中レトロ探偵団', en: 'Yanaka Retro Detectives' },
    description: { ja: '路地裏に残された暗号を解きましょう。', en: 'Solve the code left in the alley.' },
    spot: { ja: '谷中銀座に到着しました。', en: 'You arrived at Yanaka Ginza.' },
    puzzle: { ja: '谷中の有名な階段は？', en: 'What is the famous staircase called?' },
    answers: { ja: ['夕焼けだんだん', '雷門', '仲見世'], en: ['Yuyake Dandan', 'Kaminarimon', 'Nakamise'] },
    reward: { ja: '谷中探偵バッジ', en: 'Yanaka Detective Badge' }
  },
  kappabashi: {
    icon: '🍳',
    title: { ja: 'かっぱ橋道具街ミステリー', en: 'Kappabashi Tool Street Mystery' },
    description: { ja: '幻の料理人レシピを探しましょう。', en: "Find the lost chef's recipe." },
    spot: { ja: 'かっぱ橋道具街に到着しました。', en: 'You arrived at Kappabashi Tool Street.' },
    puzzle: { ja: '街の目印になっているものは？', en: 'What is a landmark of the street?' },
    answers: { ja: ['巨大なシェフ像', '東京タワー', '鳥居'], en: ['A giant chef statue', 'Tokyo Tower', 'Torii'] },
    reward: { ja: '料理人のレシピ', en: "Chef's Recipe" }
  },
  sumida: {
    icon: '🌸',
    title: { ja: '隅田川桜伝説', en: 'Sumida River Cherry Blossom Legend' },
    description: { ja: '桜に隠された江戸の記録を探しましょう。', en: 'Find the Edo record hidden in the cherry blossoms.' },
    spot: { ja: '隅田公園に到着しました。', en: 'You arrived at Sumida Park.' },
    puzzle: { ja: '春を代表する花は？', en: 'Which flower represents spring?' },
    answers: { ja: ['桜', 'ひまわり', '紅葉'], en: ['Cherry blossom', 'Sunflower', 'Maple leaf'] },
    reward: { ja: '桜の記録', en: 'Cherry Blossom Record' }
  },
  night: {
    icon: '👻',
    title: { ja: '夜浅草 百鬼夜行', en: 'Night Asakusa Spirit Parade' },
    description: { ja: '夜の浅草で妖怪の謎を解きましょう。', en: 'Solve a yokai mystery in nighttime Asakusa.' },
    spot: { ja: '夜の浅草寺に到着しました。', en: 'You arrived at nighttime Sensoji Temple.' },
    puzzle: { ja: '夜行に現れた妖怪は？', en: 'Which spirit appeared in the parade?' },
    answers: { ja: ['河童', 'パンダ', 'ロボット'], en: ['Kappa', 'Panda', 'Robot'] },
    reward: { ja: '百鬼夜行の記憶', en: 'Spirit Parade Memory' }
  }
}
EOF

cat << 'EOF' > src/screens/QuestDetailScreen.jsx
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
EOF

cat << 'EOF' > src/screens/QuestStartScreen.jsx
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
EOF

cat << 'EOF' > src/screens/QuestSpotScreen.jsx
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
EOF

cat << 'EOF' > src/screens/QuestPuzzleScreen.jsx
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
EOF

cat << 'EOF' > src/screens/QuestRewardScreen.jsx
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
EOF

cat << 'EOF' > src/screens/QuestCompleteScreen.jsx
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
EOF

cat << 'EOF' > src/screens/EventListScreen.jsx
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
EOF

cat << 'EOF' > src/screens/CollectionScreen.jsx
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
EOF

cat << 'EOF' > src/App.jsx
import { useEffect, useState } from 'react'
import { Header } from './components/Header'
import { DrawerMenu } from './components/DrawerMenu'
import { eventApi } from './api/eventApi'
import { getMessages } from './i18n'
import { quests } from './data/quests'
import * as Screens from './screens'

const screenComponents = {
  1: Screens.SplashScreen,
  2: Screens.LanguageScreen,
  3: Screens.LoginScreen,
  4: Screens.HomeScreen,
  5: Screens.MapScreen,
  6: Screens.EventListScreen,
  7: Screens.EventDetailScreen,
  20: Screens.CollectionScreen,
  25: Screens.ProfileScreen,
  26: Screens.TermsScreen,
  27: Screens.HowToUseScreen,
  29: Screens.QuestCompleteScreen,
  30: Screens.ProgressScreen,
  35: Screens.SettingsScreen,
  39: Screens.NetworkErrorScreen
}

export default function App() {
  const [screenId, setScreenId] = useState(1)
  const [locale, setLocale] = useState('ja')
  const [drawerOpen, setDrawerOpen] = useState(false)
  const [events, setEvents] = useState([])
  const [selectedQuestId, setSelectedQuestId] = useState(null)

  const t = getMessages(locale)
  const selectedQuest = quests[selectedQuestId]

  useEffect(() => {
    eventApi.list(locale).then(setEvents)
  }, [locale])

  const go = (nextScreenId) => {
    setScreenId(nextScreenId)
    setDrawerOpen(false)
  }

  const toggleLocale = () => setLocale(locale === 'ja' ? 'en' : 'ja')

  let Screen = screenComponents[screenId] || Screens.HomeScreen

  if (screenId === 42 && selectedQuest) Screen = Screens.QuestDetailScreen
  if (screenId === 43 && selectedQuest) Screen = Screens.QuestStartScreen
  if (screenId === 44 && selectedQuest) Screen = Screens.QuestSpotScreen
  if (screenId === 45 && selectedQuest) Screen = Screens.QuestPuzzleScreen
  if (screenId === 46 && selectedQuest) Screen = Screens.QuestRewardScreen
  if (screenId === 47 && selectedQuest) Screen = Screens.QuestCompleteScreen

  return (
    <div className="phone">
      <DrawerMenu
        open={drawerOpen}
        t={t}
        onGo={go}
        onClose={() => setDrawerOpen(false)}
        onLanguage={() => go(2)}
      />
      {drawerOpen && <button className="overlay" onClick={() => setDrawerOpen(false)} />}

      {screenId !== 1 && (
        <Header
          languageLabel={t.common.switchLanguage}
          onMenu={() => setDrawerOpen(true)}
          onLanguage={toggleLocale}
        />
      )}

      <Screen
        t={t}
        locale={locale}
        events={events}
        quest={selectedQuest}
        go={go}
        setLocale={setLocale}
        setSelectedQuestId={setSelectedQuestId}
        toggleLocale={toggleLocale}
      />
    </div>
  )
}
EOF

cat << 'EOF' >> src/screens/index.js
export { QuestDetailScreen } from './QuestDetailScreen'
export { QuestStartScreen } from './QuestStartScreen'
export { QuestSpotScreen } from './QuestSpotScreen'
export { QuestPuzzleScreen } from './QuestPuzzleScreen'
export { QuestRewardScreen } from './QuestRewardScreen'
export { QuestCompleteScreen } from './QuestCompleteScreen'
EOF

echo "Common quest flow files were added."
echo "Verify with: npm run build"