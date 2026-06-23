import { InfoScreen } from './InfoScreen'
export function HotelCheckScreen({ t, go }) {
  return <InfoScreen title={t.screens[23][0]} text="Checked In. Night missions have been unlocked." nextLabel="Start Spirit Parade" nextScreen={24} go={go}/>
}
