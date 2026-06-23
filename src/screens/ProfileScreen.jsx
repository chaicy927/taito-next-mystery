import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function ProfileScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[25][0]}</h2><Card className="center"><IconPanel>🧭</IconPanel><h3>Guest Explorer</h3><p>Level: 4</p><p>Exploration Rate: 100%</p><p>NFTs: 25</p></Card><Button onClick={() => go(20)}>Collection</Button><Button variant="secondary" onClick={() => go(4)}>{t.common.home}</Button></ScreenLayout>
}
