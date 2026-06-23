import { InfoScreen } from './InfoScreen'
export function PermissionLocationScreen({ t, go }) {
  return <InfoScreen title={t.screens[36][0]} text="Used for nearby spots and arrival checks." icon="📍" nextLabel="Allow" nextScreen={37} secondaryLabel="Set Later" secondaryScreen={38} go={go}/>
}
