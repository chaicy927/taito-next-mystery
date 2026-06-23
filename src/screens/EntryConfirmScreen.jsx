import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function EntryConfirmScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[8][0]}</h2><Card><p>Do you want to join this event?</p><h3>Asakusa: Edo Phantom Record</h3></Card><Button onClick={() => go(9)}>Join</Button><Button variant="secondary" onClick={() => go(6)}>Cancel</Button></ScreenLayout>
}
