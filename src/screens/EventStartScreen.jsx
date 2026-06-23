import { Button } from '../components/Button'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function EventStartScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[9][0]}</h2><IconPanel>⛩️</IconPanel><h3>You arrived at Sensoji Temple!</h3><p>The first mission has been unlocked.</p><Button onClick={() => go(10)}>Launch QR Scanner</Button></ScreenLayout>
}
