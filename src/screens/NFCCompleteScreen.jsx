import { InfoScreen } from './InfoScreen'
export function NFCCompleteScreen({ t, go }) {
  return <InfoScreen title={t.screens[14][0]} text="Secret information about Sensoji has been unlocked. +50 EXP" icon="🔓" nextLabel="Beacon Detection" nextScreen={33} go={go}/>
}
