import { useEffect, useState } from 'react'
import { Header } from './components/Header'
import { DrawerMenu } from './components/DrawerMenu'
import { eventApi } from './api/eventApi'
import { getMessages } from './i18n'
import * as Screens from './screens'

const screenComponents = {
  1: Screens.SplashScreen, 2: Screens.LanguageScreen, 3: Screens.LoginScreen,
  4: Screens.HomeScreen, 5: Screens.MapScreen, 6: Screens.EventListScreen,
  7: Screens.EventDetailScreen, 8: Screens.EntryConfirmScreen, 9: Screens.EventStartScreen,
  10: Screens.QRScanScreen, 11: Screens.PuzzleScreen, 12: Screens.PuzzleCorrectScreen,
  13: Screens.NFCScanScreen, 14: Screens.NFCCompleteScreen, 15: Screens.BeaconDetectedScreen,
  16: Screens.FoodMissionScreen, 17: Screens.StoreCheckinScreen, 18: Screens.SocialShareScreen,
  19: Screens.NFTRewardScreen, 20: Screens.CollectionScreen, 21: Screens.AreaProgressScreen,
  22: Screens.StayQuestScreen, 23: Screens.HotelCheckScreen, 24: Screens.NightARScreen,
  25: Screens.ProfileScreen, 26: Screens.TermsScreen, 27: Screens.HowToUseScreen,
  28: Screens.ARLaunchScreen, 29: Screens.QuestCompleteScreen, 30: Screens.ProgressScreen,
  31: Screens.QRScanFailedScreen, 32: Screens.NFCFailedScreen, 33: Screens.BeaconWaitingScreen,
  34: Screens.BeaconFailedScreen, 35: Screens.SettingsScreen, 36: Screens.PermissionLocationScreen,
  37: Screens.PermissionCameraScreen, 38: Screens.PermissionSkippedScreen,
  39: Screens.NetworkErrorScreen, 40: Screens.StoreDetailScreen, 41: Screens.CouponScreen
}

export default function App() {
  const [screenId, setScreenId] = useState(1)
  const [locale, setLocale] = useState('ja')
  const [drawerOpen, setDrawerOpen] = useState(false)
  const [events, setEvents] = useState([])
  const t = getMessages(locale)

  useEffect(() => {
    eventApi.list(locale).then(setEvents)
  }, [locale])

  const go = (id) => {
    setScreenId(id)
    setDrawerOpen(false)
  }
  const toggleLocale = () => setLocale(locale === 'ja' ? 'en' : 'ja')
  const Screen = screenComponents[screenId] || Screens.HomeScreen

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
        go={go}
        events={events}
        setLocale={setLocale}
        toggleLocale={toggleLocale}
      />
    </div>
  )
}
