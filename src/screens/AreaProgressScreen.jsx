import { InfoScreen } from './InfoScreen'
export function AreaProgressScreen({ t, go }) {
  return <InfoScreen title={t.screens[21][0]} text="Night Asakusa Chapter Unlocked. Proceed to the final mission." nextLabel="Stay Quest" nextScreen={22} go={go}/>
}
