import { InfoScreen } from './InfoScreen'
export function PermissionCameraScreen({ t, go }) {
  return <InfoScreen title={t.screens[37][0]} text="Used for QR scanning and AR display." icon="📷" nextLabel="Allow" nextScreen={4} secondaryLabel="Set Later" secondaryScreen={4} go={go}/>
}
