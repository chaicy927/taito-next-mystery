import { Button } from '../components/Button'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function NFTRewardScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[19][0]}</h2><IconPanel>🏆</IconPanel><h3>Memory of Raijin</h3><p className="exp">SSR</p><Button onClick={() => go(20)}>Collection</Button></ScreenLayout>
}
