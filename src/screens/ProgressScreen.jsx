import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function ProgressScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[30][0]}</h2><Card><h3>Asakusa: Edo Phantom Record</h3><p>Progress</p><div className="bar"><span /></div><p>90%</p></Card><Card><p>Done: QR / AR Puzzle / NFC / Food Mission</p><p>Remaining: Spirit Parade Quest</p></Card><Button onClick={() => go(22)}>Continue</Button></ScreenLayout>
}
