export function ScreenLayout({ children, hero = false, complete = false }) {
  return <main className={`screen ${hero ? 'hero' : ''} ${complete ? 'complete' : ''}`}>{children}</main>
}

export function BackButton({ t, go, to = 4 }) {
  return <button className="back" onClick={() => go(to)}>{t.common.back}</button>
}

export function IconPanel({ children = '✨' }) {
  return <div className="image">{children}</div>
}
