#!/usr/bin/env bash
set -e

mkdir -p src/api src/components src/data src/i18n src/screens

cat << 'EOF' > src/main.jsx
import React, { useEffect, useState } from 'react'
import { createRoot } from 'react-dom/client'
import { Header } from './components/Header'
import { DrawerMenu } from './components/DrawerMenu'
import { ScreenRouter } from './screens'
import { getMessages } from './i18n'
import { eventApi } from './api/eventApi'
import './styles.css'

function App() {
  const [screen, setScreen] = useState(1)
  const [locale, setLocale] = useState('ja')
  const [drawerOpen, setDrawerOpen] = useState(false)
  const [events, setEvents] = useState([])
  const t = getMessages(locale)

  useEffect(() => {
    eventApi.list(locale).then(setEvents)
  }, [locale])

  const go = (number) => {
    setScreen(number)
    setDrawerOpen(false)
  }

  return (
    <div className="phone">
      <DrawerMenu
        open={drawerOpen}
        t={t}
        onGo={go}
        onClose={() => setDrawerOpen(false)}
        onLanguage={() => go(2)}
      />
      {drawerOpen && <button className="overlay" onClick={() => setDrawerOpen(false)} />}
      {screen !== 1 && (
        <Header
          languageLabel={t.common.switchLanguage}
          onMenu={() => setDrawerOpen(true)}
          onLanguage={() => setLocale(locale === 'ja' ? 'en' : 'ja')}
        />
      )}
      <ScreenRouter
        screen={screen}
        t={t}
        events={events}
        go={go}
        setLocale={setLocale}
        toggleLocale={() => setLocale(locale === 'ja' ? 'en' : 'ja')}
      />
    </div>
  )
}

createRoot(document.getElementById('root')).render(<App />)
EOF

cat << 'EOF' > src/styles.css
:root {
  --bg:#f5f7fb; --surface:#fff; --soft:#f8fafc; --text:#111827;
  --muted:#6b7280; --line:#e5e7eb; --primary:#2563eb; --gold:#b7791f;
}
* { box-sizing:border-box; }
body {
  margin:0; padding:20px; display:flex; justify-content:center;
  font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;
  color:var(--text); background:linear-gradient(180deg,#eef2ff,#f8fafc);
}
.phone {
  position:relative; width:390px; min-height:760px; overflow:hidden;
  background:var(--surface); border:1px solid var(--line); border-radius:32px;
  box-shadow:0 18px 40px rgba(15,23,42,.12);
}
.topbar { display:flex; justify-content:space-between; padding:14px 18px; border-bottom:1px solid var(--line); }
.hamburger,.lang-btn { padding:8px 12px; border:1px solid var(--line); border-radius:12px; background:var(--soft); cursor:pointer; }
.hamburger { font-size:22px; }
.screen { min-height:700px; padding:20px; overflow:auto; background:var(--bg); }
.hero {
  min-height:760px; display:flex; flex-direction:column; justify-content:center;
  gap:22px; padding:32px; text-align:center;
  background:radial-gradient(circle at top,rgba(37,99,235,.16),transparent 42%),linear-gradient(#fff,#eff6ff);
}
.hero h1 { white-space:pre-line; font-size:32px; line-height:1.35; }
h2 { margin:0 0 16px; } h3 { margin:0 0 8px; }
p { margin:6px 0; color:var(--muted); line-height:1.7; }
.btn {
  width:100%; margin:8px 0; padding:14px; border:0; border-radius:14px;
  color:#fff; background:var(--primary); font-size:15px; font-weight:700; cursor:pointer;
}
.btn.secondary { color:var(--text); background:var(--surface); border:1px solid var(--line); }
.btn.gold { background:var(--gold); }
.card { margin:12px 0; padding:16px; border:1px solid var(--line); border-radius:16px; background:var(--surface); }
.clickable { cursor:pointer; }
.image { display:grid; place-items:center; height:150px; margin-bottom:12px; border:1px solid var(--line); border-radius:20px; background:linear-gradient(135deg,#fff,#eef2ff); font-size:46px; }
.back { padding:0; border:0; background:none; color:var(--primary); font-weight:700; cursor:pointer; }
.drawer { position:absolute; z-index:10; top:0; left:-270px; width:270px; height:100%; padding:24px; background:#fff; transition:.25s; box-shadow:20px 0 50px rgba(15,23,42,.12); }
.drawer.open { left:0; }
.overlay { position:absolute; z-index:9; inset:0; width:100%; height:100%; border:0; background:rgba(15,23,42,.22); }
.center { text-align:center; } .exp { color:var(--gold); font-size:28px; font-weight:800; }
.qr { display:grid; place-items:center; height:250px; margin:20px 0; border:2px dashed #94a3b8; border-radius:24px; background:#fff; font-size:56px; }
.map { position:relative; height:350px; border:1px solid var(--line); border-radius:20px; background:repeating-linear-gradient(0deg,transparent,transparent 59px,#dbeafe 60px),repeating-linear-gradient(90deg,transparent,transparent 59px,#dbeafe 60px),#fff; }
.pin { position:absolute; padding:8px; border-radius:999px; color:#fff; background:var(--primary); font-size:12px; }
.pin.a { top:80px; left:70px; }.pin.b { top:200px; left:190px; background:#059669; }.pin.c { top:300px; left:120px; background:#7c3aed; }
.bar { height:14px; overflow:hidden; border-radius:20px; background:#e5e7eb; }.bar span { display:block; width:90%; height:100%; background:linear-gradient(90deg,var(--primary),#60a5fa); }
.complete { background:linear-gradient(#fff,#fff7ed); }.trophy { font-size:76px; text-align:center; }
@media (max-width:430px) { body { padding:0; }.phone { width:100%; min-height:100vh; border:0; border-radius:0; } }
EOF

cat << 'EOF' > src/components/Button.jsx
export function Button({ children, variant = 'primary', onClick }) {
  return <button className={`btn ${variant}`} onClick={onClick}>{children}</button>
}
EOF

cat << 'EOF' > src/components/Card.jsx
export function Card({ children, onClick, className = '' }) {
  return <section className={`card ${onClick ? 'clickable' : ''} ${className}`} onClick={onClick}>{children}</section>
}
EOF

cat << 'EOF' > src/components/Header.jsx
export function Header({ onMenu, onLanguage, languageLabel }) {
  return (
    <header className="topbar">
      <button className="hamburger" onClick={onMenu}>☰</button>
      <button className="lang-btn" onClick={onLanguage}>{languageLabel}</button>
    </header>
  )
}
EOF

cat << 'EOF' > src/components/DrawerMenu.jsx
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
EOF

cat << 'EOF' > src/components/EventCard.jsx
import { Card } from './Card'

export function EventCard({ event, onClick }) {
  return (
    <Card onClick={onClick}>
      <div className="image">{event.icon}</div>
      <h3>{event.title}</h3>
      <p>{event.subtitle}</p>
      <p>{event.status}</p>
    </Card>
  )
}
EOF

cat << 'EOF' > src/data/events.js
export const events = [
  {
    id: 'asakusa', available: true, icon: '⛩️',
    title: { ja: '浅草：江戸幻影録', en: 'Asakusa: Edo Phantom Record' },
    subtitle: { ja: '失われた記憶と宝', en: 'The Lost Memory and Treasure' },
    status: { ja: '難易度 ★★★ / 進行度 90%', en: 'Difficulty ★★★ / Progress 90%' }
  },
  {
    id: 'ueno', icon: '🏛️',
    title: { ja: '上野ミュージアムの謎', en: 'Ueno Museum Mystery' },
    subtitle: { ja: '消えたコレクション', en: 'The Lost Collection' },
    status: { ja: '準備中', en: 'Coming Soon' }
  },
  {
    id: 'yanaka', icon: '🏮',
    title: { ja: '谷中レトロ探偵団', en: 'Yanaka Retro Detectives' },
    subtitle: { ja: '路地裏に残された暗号', en: 'The Code Left in the Alley' },
    status: { ja: '準備中', en: 'Coming Soon' }
  },
  {
    id: 'night', icon: '👻',
    title: { ja: '夜浅草 百鬼夜行', en: 'Night Asakusa Spirit Parade' },
    subtitle: { ja: '宿泊者限定ナイトクエスト', en: 'Hotel Guest Limited Night Quest' },
    status: { ja: '進行中', en: 'In Progress' }
  }
]
EOF

cat << 'EOF' > src/api/mockApi.js
import { events } from '../data/events'

export const mockApi = {
  async listEvents(locale) {
    await new Promise(resolve => setTimeout(resolve, 150))
    return events.map(({ title, subtitle, status, ...event }) => ({
      ...event,
      title: title[locale],
      subtitle: subtitle[locale],
      status: status[locale]
    }))
  }
}
EOF

cat << 'EOF' > src/api/realApi.js
// AWS API Gateway / Amplify接続時に実装します。
// mockApiと同じ listEvents(locale) 契約を保ってください。
export const realApi = {
  async listEvents() {
    throw new Error('Real API is not configured.')
  }
}
EOF

cat << 'EOF' > src/api/eventApi.js
import { mockApi } from './mockApi'
import { realApi } from './realApi'

const api = import.meta.env.VITE_API_MODE === 'real' ? realApi : mockApi

export const eventApi = {
  list: locale => api.listEvents(locale)
}
EOF

cat << 'EOF' > src/i18n/index.js
import ja from './ja'
import en from './en'

export const getMessages = locale => locale === 'en' ? en : ja
EOF

cat << 'EOF' > src/i18n/ja.js
export default {
  common: { switchLanguage: 'English', back: '← 戻る', next: '次へ', home: 'ホーム' },
  menu: { title: 'メニュー', home: 'ホーム', progress: '進行状況', profile: 'プロフィール', settings: '設定', language: '言語を選ぶ', close: '閉じる' },
  screens: {
    1: ['台東区\n次世代謎解き\n街歩き', '食・文化・歴史を楽しみながら探索しよう。', 'はじめる'],
    2: ['言語を選択', '日本語', 'English'],
    3: ['ログイン', 'Googleでログイン', 'Appleでサインイン', 'メールでログイン', 'ゲストで利用する'],
    4: ['ホーム', 'Lv.4 江戸探検家', '現在地：浅草エリア', 'EXP 780/1000'],
    5: ['マップ'], 6: ['イベントを選ぶ'], 7: ['イベント詳細'],
    8: ['参加確認'], 9: ['イベント開始'], 10: ['QRコード読み取り'],
    11: ['問題1'], 12: ['正解！'], 13: ['NFC読み取り'], 14: ['読み取り完了'],
    15: ['Beacon検知'], 16: ['フードミッション'], 17: ['店舗チェックイン'],
    18: ['SNS共有'], 19: ['NFT獲得'], 20: ['コレクション'],
    21: ['浅草エリア進捗'], 22: ['宿泊クエスト'], 23: ['ホテル連携確認'],
    24: ['夜間AR'], 25: ['ユーザープロフィール'], 26: ['利用規約'],
    27: ['アプリの使い方'], 28: ['AR起動'], 29: ['浅草：江戸幻影録\nクリア！'],
    30: ['イベント進行状況'], 31: ['QR読み取り失敗'], 32: ['NFC読み取り失敗'],
    33: ['Beacon検知待ち'], 34: ['Beacon未検知'], 35: ['設定'],
    36: ['位置情報の許可'], 37: ['カメラの許可'], 38: ['権限未設定'],
    39: ['通信エラー'], 40: ['店舗詳細'], 41: ['クーポン']
  }
}
EOF

cat << 'EOF' > src/i18n/en.js
export default {
  common: { switchLanguage: '日本語', back: '← Back', next: 'Next', home: 'Home' },
  menu: { title: 'Menu', home: 'Home', progress: 'Progress', profile: 'Profile', settings: 'Settings', language: 'Language', close: 'Close' },
  screens: {
    1: ['Taito City\nNext-Gen Mystery\nWalking Tour', 'Explore food, culture, and history.', 'Start'],
    2: ['Select Language', '日本語', 'English'],
    3: ['Login', 'Continue with Google', 'Continue with Apple', 'Login with Email', 'Continue as Guest'],
    4: ['Home', 'Lv.4 Edo Explorer', 'Current Area: Asakusa', 'EXP 780/1000'],
    5: ['Map'], 6: ['Choose Event'], 7: ['Event Details'], 8: ['Confirm Entry'],
    9: ['Event Start'], 10: ['QR Code Scan'], 11: ['Question 1'], 12: ['Correct!'],
    13: ['NFC Scan'], 14: ['Scan Complete'], 15: ['Beacon Detection'],
    16: ['Food Mission'], 17: ['Store Check-in'], 18: ['Social Share'],
    19: ['NFT Acquired'], 20: ['Collection'], 21: ['Asakusa Progress'],
    22: ['Stay Quest'], 23: ['Hotel Link Check'], 24: ['Night AR'],
    25: ['User Profile'], 26: ['Terms of Use'], 27: ['How to Use'],
    28: ['AR Launched'], 29: ['Asakusa: Edo Phantom Record\nCompleted!'],
    30: ['Event Progress'], 31: ['QR Scan Failed'], 32: ['NFC Scan Failed'],
    33: ['Waiting for Beacon'], 34: ['Beacon Not Detected'], 35: ['Settings'],
    36: ['Location Permission'], 37: ['Camera Permission'], 38: ['Permissions Not Set'],
    39: ['Network Error'], 40: ['Store Details'], 41: ['Coupon']
  }
}
EOF

cat << 'EOF' > src/screens/index.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { EventCard } from '../components/EventCard'

const Frame = ({ children, hero = false, complete = false }) =>
  <main className={`screen ${hero ? 'hero' : ''} ${complete ? 'complete' : ''}`}>{children}</main>

const Icon = ({ children = '✨' }) => <div className="image">{children}</div>
const Back = ({ go, to = 4, label }) => <button className="back" onClick={() => go(to)}>{label}</button>

function Screen({ n, t, events, go, setLocale, toggleLocale }) {
  const s = t.screens[n] || []

  if (n === 1) return <Frame hero><h1>{s[0]}</h1><p>{s[1]}</p><Button onClick={() => go(2)}>{s[2]}</Button></Frame>
  if (n === 2) return <Frame><h2>{s[0]}</h2><Button onClick={() => { setLocale('ja'); go(3) }}>{s[1]}</Button><Button variant="secondary" onClick={() => { setLocale('en'); go(3) }}>{s[2]}</Button></Frame>
  if (n === 3) return <Frame><h2>{s[0]}</h2>{s.slice(1, 4).map(x => <Button key={x} variant="secondary">{x}</Button>)}<Button onClick={() => go(26)}>{s[4]}</Button></Frame>
  if (n === 4) return <Frame><h2>{s[0]}</h2><Card><p>{s[1]}</p><p>{s[2]}</p><p>{s[3]}</p></Card><Button onClick={() => go(6)}>Choose Event</Button><Button variant="secondary" onClick={() => go(30)}>Progress</Button><Button variant="secondary" onClick={() => go(5)}>Map</Button><Button variant="secondary" onClick={() => go(20)}>Collection</Button></Frame>
  if (n === 5) return <Frame><Back go={go} label={t.common.back}/><h2>{s[0]}</h2><div className="map"><span className="pin a">Puzzle</span><span className="pin b">NFT</span><span className="pin c">QR</span></div></Frame>
  if (n === 6) return <Frame><Back go={go} label={t.common.back}/><h2>{s[0]}</h2>{events.map(e => <EventCard key={e.id} event={e} onClick={e.available ? () => go(7) : undefined}/>)}</Frame>
  if (n === 7) return <Frame><Back go={go} to={6} label={t.common.back}/><h2>{s[0]}</h2><Icon>⛩️</Icon><h3>Asakusa: Edo Phantom Record</h3><p>Interactive mystery walking tour.</p><Button onClick={() => go(8)}>Join This Event</Button></Frame>
  if (n === 8) return <Frame><h2>{s[0]}</h2><Card><p>Do you want to join this event?</p></Card><Button onClick={() => go(9)}>Join</Button><Button variant="secondary" onClick={() => go(6)}>Cancel</Button></Frame>
  if (n === 10) return <Frame><h2>{s[0]}</h2><p>Scan the on-site QR code to launch AR.</p><div className="qr">▦</div><Button onClick={() => go(28)}>QR Code Scanned</Button><Button variant="secondary" onClick={() => go(31)}>Scan Failed Demo</Button></Frame>
  if (n === 11) return <Frame><h2>{s[0]}</h2><p>What is the name of the huge red gate here?</p>{['Fujin Gate', 'Kaminarimon', 'Asakusa Gate'].map(x => <Button key={x} variant="secondary" onClick={() => go(12)}>{x}</Button>)}</Frame>
  if (n === 12) return <Frame><h2 className="center">{s[0]}</h2><p className="exp center">+50 EXP</p><Button onClick={() => go(13)}>{t.common.next}</Button></Frame>
  if (n === 20) return <Frame><h2>{s[0]}</h2>{['🏆 Memory of Raijin SSR', '🌀 Memory of Fujin SR', '👻 Spirit Parade Memory UR'].map(x => <Card key={x}>{x}</Card>)}<Button onClick={() => go(21)}>Check Completion</Button></Frame>
  if (n === 25) return <Frame><h2>{s[0]}</h2><Card className="center"><Icon>🧭</Icon><h3>Guest Explorer</h3><p>Level: 4</p><p>NFTs: 25</p></Card><Button onClick={() => go(20)}>Collection</Button></Frame>
  if (n === 29) return <Frame complete><div className="trophy">🏆</div><h2 className="center">{s[0]}</h2><Card className="center"><h3>Spirit Parade Quest CLEAR</h3></Card><p className="exp center">+500 EXP</p><Button variant="gold" onClick={() => go(20)}>View Collection</Button><Button onClick={() => go(25)}>Profile</Button><Button variant="secondary" onClick={() => go(4)}>{t.common.home}</Button></Frame>
  if (n === 30) return <Frame><h2>{s[0]}</h2><Card><h3>Asakusa: Edo Phantom Record</h3><div className="bar"><span /></div><p>90%</p></Card><Button onClick={() => go(22)}>Continue</Button></Frame>
  if (n === 35) return <Frame><h2>{s[0]}</h2><Card><h3>Language</h3><Button variant="secondary" onClick={toggleLocale}>Switch Language</Button></Card><Button onClick={() => go(4)}>{t.common.home}</Button></Frame>
  if (n === 36 || n === 37) return <Frame><h2>{s[0]}</h2><Icon>{n === 36 ? '📍' : '📷'}</Icon><Card><p>Permission is used for the walking experience.</p></Card><Button onClick={() => go(n === 36 ? 37 : 4)}>Allow</Button><Button variant="secondary" onClick={() => go(4)}>Set Later</Button></Frame>
  if (n === 39) return <Frame><h2>{s[0]}</h2><Icon>📡</Icon><Card><p>Failed to fetch data.</p></Card><Button onClick={() => go(4)}>Reload</Button></Frame>
  if (n === 40) return <Frame><h2>{s[0]}</h2><Icon>🏪</Icon><Card><h3>Kimuraya Main Store</h3><p>Check in to earn EXP.</p></Card><Button onClick={() => go(17)}>Check In</Button><Button variant="secondary" onClick={() => go(41)}>View Coupon</Button></Frame>
  if (n === 41) return <Frame><h2>{s[0]}</h2><Card className="center"><h3>¥50 Off Ningyo-yaki</h3></Card><Button onClick={() => go(17)}>Use at Store</Button></Frame>

  const next = { 9:10, 13:14, 14:33, 15:16, 16:40, 17:18, 18:19, 19:20, 21:22, 22:23, 23:24, 24:29, 26:27, 27:36, 28:11, 31:10, 32:13, 33:15, 34:33, 38:4 }[n] || 4
  return <Frame><h2>{s[0] || `Screen ${n}`}</h2><Icon>{n === 9 ? '⛩️' : n === 14 ? '🔓' : n === 15 ? '📡' : '✨'}</Icon><Card><p>This screen is part of the original numbered flow.</p></Card><Button onClick={() => go(next)}>{t.common.next}</Button><Button variant="secondary" onClick={() => go(4)}>{t.common.home}</Button></Frame>
}

export function ScreenRouter(props) {
  return <Screen {...props} n={props.screen} />
}
EOF

echo "src/ has been created successfully."