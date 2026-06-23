export function Header({ onMenu, onLanguage, languageLabel }) {
  return (
    <header className="topbar">
      <button className="hamburger" onClick={onMenu}>☰</button>
      <button className="lang-btn" onClick={onLanguage}>{languageLabel}</button>
    </header>
  )
}
