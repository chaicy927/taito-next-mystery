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
