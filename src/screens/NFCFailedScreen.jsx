import { InfoScreen } from './InfoScreen'
export function NFCFailedScreen({ t, go }) {
  return <InfoScreen title={t.screens[32][0]} text="Could not read the NFC tag. Check NFC settings and tag position." icon="⚠️" nextLabel="Try Again" nextScreen={13} go={go}/>
}
