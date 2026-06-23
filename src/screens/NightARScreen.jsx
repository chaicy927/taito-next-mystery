import { InfoScreen } from './InfoScreen'
export function NightARScreen({ t, go }) {
  return <InfoScreen title={t.screens[24][0]} text="Edo Spirit Parade: you solved the final puzzle." icon="👻" nextLabel="Complete Quest" nextScreen={29} go={go}/>
}
