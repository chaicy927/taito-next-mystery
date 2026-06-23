import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function CouponScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[41][0]}</h2><Card className="center"><h3>¥50 Off Ningyo-yaki</h3><p>Valid: Today only</p></Card><Button onClick={() => go(17)}>Use at Store</Button></ScreenLayout>
}
