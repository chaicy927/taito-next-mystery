import { InfoScreen } from './InfoScreen'
export function StoreCheckinScreen({ t, go }) {
  return <InfoScreen title={t.screens[17][0]} text="Kimuraya Main Store: Check-in Complete! +100 EXP" nextLabel="Social Share" nextScreen={18} go={go}/>
}
