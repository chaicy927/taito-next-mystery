import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function PuzzleCorrectScreen({ t, go }) {
  return <ScreenLayout><h2 className="center">{t.screens[12][0]}</h2><p className="exp center">+50 EXP</p><p className="center">You obtained Kaminarimon history info!</p><Button onClick={() => go(13)}>{t.common.next}</Button></ScreenLayout>
}
