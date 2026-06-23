import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function LanguageScreen({ t, go, setLocale }) {
  const s = t.screens[2]
  return <ScreenLayout><h2>{s[0]}</h2><Button onClick={() => { setLocale('ja'); go(3) }}>{s[1]}</Button><Button variant="secondary" onClick={() => { setLocale('en'); go(3) }}>{s[2]}</Button></ScreenLayout>
}
