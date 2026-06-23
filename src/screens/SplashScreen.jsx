import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function SplashScreen({ t, go }) {
  const s = t.screens[1]
  return <ScreenLayout hero><h1>{s[0]}</h1><p>{s[1]}</p><Button onClick={() => go(2)}>{s[2]}</Button></ScreenLayout>
}
