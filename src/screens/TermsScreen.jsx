import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function TermsScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[26][0]}</h2><Card><p>This app may use location data, QR codes, NFC, Bluetooth beacons, and AR features.</p><p>Please avoid using your phone while walking.</p></Card><label><input type="checkbox" defaultChecked /> I agree</label><Button onClick={() => go(27)}>{t.common.next}</Button></ScreenLayout>
}
