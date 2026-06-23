import { Button } from './Button'

export function DrawerMenu({ open, t, onGo, onClose, onLanguage }) {
  return (
    <aside className={`drawer ${open ? 'open' : ''}`}>
      <h3>{t.menu.title}</h3>
      <Button onClick={() => onGo(4)}>{t.menu.home}</Button>
      <Button onClick={() => onGo(30)}>{t.menu.progress}</Button>
      <Button onClick={() => onGo(25)}>{t.menu.profile}</Button>
      <Button onClick={() => onGo(35)}>{t.menu.settings}</Button>
      <Button variant="secondary" onClick={onLanguage}>{t.menu.language}</Button>
      <Button variant="secondary" onClick={onClose}>{t.menu.close}</Button>
    </aside>
  )
}
