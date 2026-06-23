import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function QuestCompleteScreen({ t, go }) {
  return <ScreenLayout complete><div className="trophy">🏆</div><h2 className="center">{t.screens[29][0]}</h2><Card className="center"><h3>Spirit Parade Quest CLEAR</h3><p>You solved the final mystery of nighttime Asakusa.</p></Card><p className="exp center">+500 EXP</p><Button variant="gold" onClick={() => go(20)}>View Collection</Button><Button onClick={() => go(25)}>Profile</Button><Button variant="secondary" onClick={() => go(4)}>{t.common.home}</Button></ScreenLayout>
}
