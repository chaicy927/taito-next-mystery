import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function HomeScreen({ t, go }) {
  const s = t.screens[4]
  return <ScreenLayout><h2>{s[0]}</h2><Card><p>{s[1]}</p><p>{s[2]}</p><p>{s[3]}</p></Card><Button onClick={() => go(6)}>Choose Event</Button><Button variant="secondary" onClick={() => go(30)}>Progress</Button><Button variant="secondary" onClick={() => go(5)}>Map</Button><Button variant="secondary" onClick={() => go(20)}>Collection</Button><Button variant="secondary" onClick={() => go(39)}>Error Screen Test</Button></ScreenLayout>
}
