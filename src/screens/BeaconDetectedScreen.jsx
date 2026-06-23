import { InfoScreen } from './InfoScreen'
export function BeaconDetectedScreen({ t, go }) {
  return <InfoScreen title={t.screens[15][0]} text="You arrived at Nakamise Street. A store check-in mission has been unlocked." nextLabel="View Mission" nextScreen={16} go={go}/>
}
