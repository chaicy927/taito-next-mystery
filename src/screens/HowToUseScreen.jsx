import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function HowToUseScreen({ t, go }) {
  const steps = [['1. Choose an Event', 'Select a mystery walking event.'], ['2. Explore', 'Use GPS, QR, NFC, and beacons.'], ['3. Launch AR', 'Scan an on-site QR code.'], ['4. Collect Rewards', 'Earn NFTs and titles.']]
  return <ScreenLayout><h2>{t.screens[27][0]}</h2>{steps.map(([a, b]) => <Card key={a}><h3>{a}</h3><p>{b}</p></Card>)}<Button onClick={() => go(36)}>Permission Settings</Button></ScreenLayout>
}
