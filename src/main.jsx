import React, { useEffect, useState } from 'react'
import { createRoot } from 'react-dom/client'
import { Header } from './components/Header'
import { DrawerMenu } from './components/DrawerMenu'
import { ScreenRouter } from './screens'
import { getMessages } from './i18n'
import { eventApi } from './api/eventApi'
import './styles.css'

function App() {
  const [screen, setScreen] = useState(1)
  const [locale, setLocale] = useState('ja')
  const [drawerOpen, setDrawerOpen] = useState(false)
  const [events, setEvents] = useState([])
  const t = getMessages(locale)

  useEffect(() => {
    eventApi.list(locale).then(setEvents)
  }, [locale])

  const go = (number) => {
    setScreen(number)
    setDrawerOpen(false)
  }

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
      {screen !== 1 && (
        <Header
          languageLabel={t.common.switchLanguage}
          onMenu={() => setDrawerOpen(true)}
          onLanguage={() => setLocale(locale === 'ja' ? 'en' : 'ja')}
        />
      )}
      <ScreenRouter
        screen={screen}
        t={t}
        events={events}
        go={go}
        setLocale={setLocale}
        toggleLocale={() => setLocale(locale === 'ja' ? 'en' : 'ja')}
      />
    </div>
  )
}

createRoot(document.getElementById('root')).render(<App />)
