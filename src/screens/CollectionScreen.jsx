import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function CollectionScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[20][0]}</h2><p>Collected 25/100</p>{['🏆 Memory of Raijin SSR', '🌀 Memory of Fujin SR', '👻 Spirit Parade Memory UR'].map(x => <Card key={x}>{x}</Card>)}<Button onClick={() => go(21)}>Check Completion</Button></ScreenLayout>
}
