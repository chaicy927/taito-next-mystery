import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function QRScanScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[10][0]}</h2><p>Scan the on-site QR code to launch AR.</p><div className="qr">▦</div><Button onClick={() => go(28)}>QR Code Scanned</Button><Button variant="secondary" onClick={() => go(31)}>Scan Failed Demo</Button></ScreenLayout>
}
