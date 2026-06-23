import { InfoScreen } from './InfoScreen'
export function QRScanFailedScreen({ t, go }) {
  return <InfoScreen title={t.screens[31][0]} text="Could not scan the QR code. Try again in a brighter place." icon="⚠️" nextLabel="Try Again" nextScreen={10} secondaryLabel={t.common.back} secondaryScreen={9} go={go}/>
}
