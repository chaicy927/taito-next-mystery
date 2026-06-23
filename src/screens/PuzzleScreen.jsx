import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function PuzzleScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[11][0]}</h2><p>What is the name of the huge red gate here?</p>{['Fujin Gate', 'Kaminarimon', 'Asakusa Gate'].map(x => <Button key={x} variant="secondary" onClick={() => go(12)}>{x}</Button>)}</ScreenLayout>
}
