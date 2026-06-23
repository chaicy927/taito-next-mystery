import { InfoScreen } from './InfoScreen'
export function ARLaunchScreen({ t, go }) {
  return <InfoScreen title={t.screens[28][0]} text="QR authentication complete. AR content has launched." icon="🥽" nextLabel="Go to Puzzle" nextScreen={11} go={go}/>
}
