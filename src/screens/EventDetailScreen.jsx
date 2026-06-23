import { Button } from '../components/Button'
import { BackButton, IconPanel, ScreenLayout } from './ScreenLayout'
export function EventDetailScreen({ t, go }) {
  return <ScreenLayout><BackButton t={t} go={go} to={6}/><h2>{t.screens[7][0]}</h2><IconPanel>⛩️</IconPanel><h3>Asakusa: Edo Phantom Record</h3><p>An interactive mystery tour through Edo-period memories and Taito history.</p><Button onClick={() => go(8)}>Join This Event</Button></ScreenLayout>
}
