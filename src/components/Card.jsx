export function Card({ children, onClick, className = '' }) {
  return <section className={`card ${onClick ? 'clickable' : ''} ${className}`} onClick={onClick}>{children}</section>
}
