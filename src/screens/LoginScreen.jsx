import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function LoginScreen({ t, go }) {
  const s = t.screens[3]
  return <ScreenLayout><h2>{s[0]}</h2>{s.slice(1, 4).map(x => <Button key={x} variant="secondary">{x}</Button>)}<Button onClick={() => go(26)}>{s[4]}</Button></ScreenLayout>
}
