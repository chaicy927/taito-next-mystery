import { InfoScreen } from './InfoScreen'
export function StayQuestScreen({ t, go }) {
  return <InfoScreen title={t.screens[22][0]} text="Night Asakusa Chapter. Requirement: Hotel Check-in." icon="🌙" nextLabel="View Quest" nextScreen={23} go={go}/>
}
