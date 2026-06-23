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
