import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function BeaconWaitingScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[33][0]}</h2><IconPanel>📡</IconPanel><Card><p>Searching for a beacon near Nakamise Street.</p><p>In mock mode, use the success button.</p></Card><Button onClick={() => go(15)}>Beacon Detected</Button><Button variant="secondary" onClick={() => go(34)}>Not Detected</Button></ScreenLayout>
}
