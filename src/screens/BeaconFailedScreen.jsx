import { InfoScreen } from './InfoScreen'
export function BeaconFailedScreen({ t, go }) {
  return <InfoScreen title={t.screens[34][0]} text="Move closer to the target area and check Bluetooth settings." nextLabel="Retry" nextScreen={33} go={go}/>
}
