import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function SocialShareScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[18][0]}</h2><Card><h3>External Social Media API</h3><p>This assumes sharing through external social media APIs.</p></Card>{['Share on X', 'Instagram', 'Facebook', 'LINE'].map(x => <Button key={x} variant="secondary">{x}</Button>)}<Button onClick={() => go(19)}>Not Now</Button></ScreenLayout>
}
