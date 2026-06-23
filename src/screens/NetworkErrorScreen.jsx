import { InfoScreen } from './InfoScreen'
export function NetworkErrorScreen({ t, go }) {
  return <InfoScreen title={t.screens[39][0]} text="Failed to fetch data. Please check your connection." icon="📡" nextLabel="Reload" nextScreen={4} secondaryLabel={t.common.home} secondaryScreen={4} go={go}/>
}
