import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function SettingsScreen({ t, go, toggleLocale }) {
  return <ScreenLayout><h2>{t.screens[35][0]}</h2><Card><h3>Language</h3><Button variant="secondary" onClick={toggleLocale}>Switch Language</Button></Card><Card><h3>Permissions</h3><p>Location: Allowed</p><p>Camera: Allowed</p><p>NFC: Pending</p><p>Bluetooth: Pending</p></Card><Button onClick={() => go(4)}>{t.common.home}</Button></ScreenLayout>
}
