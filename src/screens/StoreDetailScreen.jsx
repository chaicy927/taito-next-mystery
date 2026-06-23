import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function StoreDetailScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[40][0]}</h2><IconPanel>🏪</IconPanel><h3>Kimuraya Main Store</h3><Card><p>A Ningyo-yaki shop on Nakamise Street. Check in to earn a coupon and EXP.</p></Card><Button onClick={() => go(17)}>Check In</Button><Button variant="secondary" onClick={() => go(41)}>View Coupon</Button></ScreenLayout>
}
