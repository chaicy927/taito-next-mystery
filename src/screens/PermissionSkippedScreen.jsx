import { InfoScreen } from './InfoScreen'
export function PermissionSkippedScreen({ t, go }) {
  return <InfoScreen title={t.screens[38][0]} text="Some features may not work. You can change this later in Settings." nextLabel="Go Home" nextScreen={4} secondaryLabel="Settings" secondaryScreen={35} go={go}/>
}
