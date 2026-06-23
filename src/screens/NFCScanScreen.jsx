import { Button } from '../components/Button'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function NFCScanScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[13][0]}</h2><IconPanel>📳</IconPanel><p>Hold your phone near the NFC tag.</p><Button onClick={() => go(14)}>Scan Complete</Button><Button variant="secondary" onClick={() => go(32)}>Scan Failed Demo</Button></ScreenLayout>
}
