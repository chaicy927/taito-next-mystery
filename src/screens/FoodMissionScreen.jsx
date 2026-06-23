import { Button } from '../components/Button'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function FoodMissionScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[16][0]}</h2><IconPanel>🥮</IconPanel><h3>Find Ningyo-yaki!</h3><p>Target Stores: 3</p><Button variant="gold" onClick={() => go(40)}>View Stores</Button></ScreenLayout>
}
