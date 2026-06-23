import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { IconPanel, ScreenLayout } from './ScreenLayout'

export function InfoScreen({ title, text, icon, nextLabel, nextScreen, secondaryLabel, secondaryScreen, go }) {
  return (
    <ScreenLayout>
      <h2>{title}</h2>
      {icon && <IconPanel>{icon}</IconPanel>}
      <Card><p>{text}</p></Card>
      {nextScreen && <Button onClick={() => go(nextScreen)}>{nextLabel || 'Next'}</Button>}
      {secondaryScreen && <Button variant="secondary" onClick={() => go(secondaryScreen)}>{secondaryLabel || 'Back'}</Button>}
    </ScreenLayout>
  )
}
