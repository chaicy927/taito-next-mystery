#!/usr/bin/env bash
set -e

mkdir -p src/screens

rm -f src/screens/index.jsx

cat <<'EOF' > src/main.jsx
import React from 'react'
import { createRoot } from 'react-dom/client'
import App from './App'
import './styles.css'

createRoot(document.getElementById('root')).render(<App />)
EOF

cat <<'EOF' > src/App.jsx
import { useEffect, useState } from 'react'
import { Header } from './components/Header'
import { DrawerMenu } from './components/DrawerMenu'
import { eventApi } from './api/eventApi'
import { getMessages } from './i18n'
import * as Screens from './screens'

const screenComponents = {
  1: Screens.SplashScreen, 2: Screens.LanguageScreen, 3: Screens.LoginScreen,
  4: Screens.HomeScreen, 5: Screens.MapScreen, 6: Screens.EventListScreen,
  7: Screens.EventDetailScreen, 8: Screens.EntryConfirmScreen, 9: Screens.EventStartScreen,
  10: Screens.QRScanScreen, 11: Screens.PuzzleScreen, 12: Screens.PuzzleCorrectScreen,
  13: Screens.NFCScanScreen, 14: Screens.NFCCompleteScreen, 15: Screens.BeaconDetectedScreen,
  16: Screens.FoodMissionScreen, 17: Screens.StoreCheckinScreen, 18: Screens.SocialShareScreen,
  19: Screens.NFTRewardScreen, 20: Screens.CollectionScreen, 21: Screens.AreaProgressScreen,
  22: Screens.StayQuestScreen, 23: Screens.HotelCheckScreen, 24: Screens.NightARScreen,
  25: Screens.ProfileScreen, 26: Screens.TermsScreen, 27: Screens.HowToUseScreen,
  28: Screens.ARLaunchScreen, 29: Screens.QuestCompleteScreen, 30: Screens.ProgressScreen,
  31: Screens.QRScanFailedScreen, 32: Screens.NFCFailedScreen, 33: Screens.BeaconWaitingScreen,
  34: Screens.BeaconFailedScreen, 35: Screens.SettingsScreen, 36: Screens.PermissionLocationScreen,
  37: Screens.PermissionCameraScreen, 38: Screens.PermissionSkippedScreen,
  39: Screens.NetworkErrorScreen, 40: Screens.StoreDetailScreen, 41: Screens.CouponScreen
}

export default function App() {
  const [screenId, setScreenId] = useState(1)
  const [locale, setLocale] = useState('ja')
  const [drawerOpen, setDrawerOpen] = useState(false)
  const [events, setEvents] = useState([])
  const t = getMessages(locale)

  useEffect(() => {
    eventApi.list(locale).then(setEvents)
  }, [locale])

  const go = (id) => {
    setScreenId(id)
    setDrawerOpen(false)
  }
  const toggleLocale = () => setLocale(locale === 'ja' ? 'en' : 'ja')
  const Screen = screenComponents[screenId] || Screens.HomeScreen

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
      {screenId !== 1 && (
        <Header
          languageLabel={t.common.switchLanguage}
          onMenu={() => setDrawerOpen(true)}
          onLanguage={toggleLocale}
        />
      )}
      <Screen
        t={t}
        go={go}
        events={events}
        setLocale={setLocale}
        toggleLocale={toggleLocale}
      />
    </div>
  )
}
EOF

cat <<'EOF' > src/screens/ScreenLayout.jsx
export function ScreenLayout({ children, hero = false, complete = false }) {
  return <main className={`screen ${hero ? 'hero' : ''} ${complete ? 'complete' : ''}`}>{children}</main>
}

export function BackButton({ t, go, to = 4 }) {
  return <button className="back" onClick={() => go(to)}>{t.common.back}</button>
}

export function IconPanel({ children = '✨' }) {
  return <div className="image">{children}</div>
}
EOF

cat <<'EOF' > src/screens/InfoScreen.jsx
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
EOF

cat <<'EOF' > src/screens/SplashScreen.jsx
import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function SplashScreen({ t, go }) {
  const s = t.screens[1]
  return <ScreenLayout hero><h1>{s[0]}</h1><p>{s[1]}</p><Button onClick={() => go(2)}>{s[2]}</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/LanguageScreen.jsx
import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function LanguageScreen({ t, go, setLocale }) {
  const s = t.screens[2]
  return <ScreenLayout><h2>{s[0]}</h2><Button onClick={() => { setLocale('ja'); go(3) }}>{s[1]}</Button><Button variant="secondary" onClick={() => { setLocale('en'); go(3) }}>{s[2]}</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/LoginScreen.jsx
import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function LoginScreen({ t, go }) {
  const s = t.screens[3]
  return <ScreenLayout><h2>{s[0]}</h2>{s.slice(1, 4).map(x => <Button key={x} variant="secondary">{x}</Button>)}<Button onClick={() => go(26)}>{s[4]}</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/TermsScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function TermsScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[26][0]}</h2><Card><p>This app may use location data, QR codes, NFC, Bluetooth beacons, and AR features.</p><p>Please avoid using your phone while walking.</p></Card><label><input type="checkbox" defaultChecked /> I agree</label><Button onClick={() => go(27)}>{t.common.next}</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/HowToUseScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function HowToUseScreen({ t, go }) {
  const steps = [['1. Choose an Event', 'Select a mystery walking event.'], ['2. Explore', 'Use GPS, QR, NFC, and beacons.'], ['3. Launch AR', 'Scan an on-site QR code.'], ['4. Collect Rewards', 'Earn NFTs and titles.']]
  return <ScreenLayout><h2>{t.screens[27][0]}</h2>{steps.map(([a, b]) => <Card key={a}><h3>{a}</h3><p>{b}</p></Card>)}<Button onClick={() => go(36)}>Permission Settings</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/HomeScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function HomeScreen({ t, go }) {
  const s = t.screens[4]
  return <ScreenLayout><h2>{s[0]}</h2><Card><p>{s[1]}</p><p>{s[2]}</p><p>{s[3]}</p></Card><Button onClick={() => go(6)}>Choose Event</Button><Button variant="secondary" onClick={() => go(30)}>Progress</Button><Button variant="secondary" onClick={() => go(5)}>Map</Button><Button variant="secondary" onClick={() => go(20)}>Collection</Button><Button variant="secondary" onClick={() => go(39)}>Error Screen Test</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/MapScreen.jsx
import { BackButton, ScreenLayout } from './ScreenLayout'
export function MapScreen({ t, go }) {
  return <ScreenLayout><BackButton t={t} go={go}/><h2>{t.screens[5][0]}</h2><div className="map"><span className="pin a">Puzzle</span><span className="pin b">NFT</span><span className="pin c">QR</span></div></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/EventListScreen.jsx
import { EventCard } from '../components/EventCard'
import { BackButton, ScreenLayout } from './ScreenLayout'
export function EventListScreen({ t, go, events }) {
  return <ScreenLayout><BackButton t={t} go={go}/><h2>{t.screens[6][0]}</h2>{events.map(event => <EventCard key={event.id} event={event} onClick={event.available ? () => go(7) : undefined}/>)}</ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/EventDetailScreen.jsx
import { Button } from '../components/Button'
import { BackButton, IconPanel, ScreenLayout } from './ScreenLayout'
export function EventDetailScreen({ t, go }) {
  return <ScreenLayout><BackButton t={t} go={go} to={6}/><h2>{t.screens[7][0]}</h2><IconPanel>⛩️</IconPanel><h3>Asakusa: Edo Phantom Record</h3><p>An interactive mystery tour through Edo-period memories and Taito history.</p><Button onClick={() => go(8)}>Join This Event</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/EntryConfirmScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function EntryConfirmScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[8][0]}</h2><Card><p>Do you want to join this event?</p><h3>Asakusa: Edo Phantom Record</h3></Card><Button onClick={() => go(9)}>Join</Button><Button variant="secondary" onClick={() => go(6)}>Cancel</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/EventStartScreen.jsx
import { Button } from '../components/Button'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function EventStartScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[9][0]}</h2><IconPanel>⛩️</IconPanel><h3>You arrived at Sensoji Temple!</h3><p>The first mission has been unlocked.</p><Button onClick={() => go(10)}>Launch QR Scanner</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/QRScanScreen.jsx
import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function QRScanScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[10][0]}</h2><p>Scan the on-site QR code to launch AR.</p><div className="qr">▦</div><Button onClick={() => go(28)}>QR Code Scanned</Button><Button variant="secondary" onClick={() => go(31)}>Scan Failed Demo</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/QRScanFailedScreen.jsx
import { InfoScreen } from './InfoScreen'
export function QRScanFailedScreen({ t, go }) {
  return <InfoScreen title={t.screens[31][0]} text="Could not scan the QR code. Try again in a brighter place." icon="⚠️" nextLabel="Try Again" nextScreen={10} secondaryLabel={t.common.back} secondaryScreen={9} go={go}/>
}
EOF

cat <<'EOF' > src/screens/ARLaunchScreen.jsx
import { InfoScreen } from './InfoScreen'
export function ARLaunchScreen({ t, go }) {
  return <InfoScreen title={t.screens[28][0]} text="QR authentication complete. AR content has launched." icon="🥽" nextLabel="Go to Puzzle" nextScreen={11} go={go}/>
}
EOF

cat <<'EOF' > src/screens/PuzzleScreen.jsx
import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function PuzzleScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[11][0]}</h2><p>What is the name of the huge red gate here?</p>{['Fujin Gate', 'Kaminarimon', 'Asakusa Gate'].map(x => <Button key={x} variant="secondary" onClick={() => go(12)}>{x}</Button>)}</ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/PuzzleCorrectScreen.jsx
import { Button } from '../components/Button'
import { ScreenLayout } from './ScreenLayout'
export function PuzzleCorrectScreen({ t, go }) {
  return <ScreenLayout><h2 className="center">{t.screens[12][0]}</h2><p className="exp center">+50 EXP</p><p className="center">You obtained Kaminarimon history info!</p><Button onClick={() => go(13)}>{t.common.next}</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/NFCScanScreen.jsx
import { Button } from '../components/Button'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function NFCScanScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[13][0]}</h2><IconPanel>📳</IconPanel><p>Hold your phone near the NFC tag.</p><Button onClick={() => go(14)}>Scan Complete</Button><Button variant="secondary" onClick={() => go(32)}>Scan Failed Demo</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/NFCFailedScreen.jsx
import { InfoScreen } from './InfoScreen'
export function NFCFailedScreen({ t, go }) {
  return <InfoScreen title={t.screens[32][0]} text="Could not read the NFC tag. Check NFC settings and tag position." icon="⚠️" nextLabel="Try Again" nextScreen={13} go={go}/>
}
EOF

cat <<'EOF' > src/screens/NFCCompleteScreen.jsx
import { InfoScreen } from './InfoScreen'
export function NFCCompleteScreen({ t, go }) {
  return <InfoScreen title={t.screens[14][0]} text="Secret information about Sensoji has been unlocked. +50 EXP" icon="🔓" nextLabel="Beacon Detection" nextScreen={33} go={go}/>
}
EOF

cat <<'EOF' > src/screens/BeaconWaitingScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function BeaconWaitingScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[33][0]}</h2><IconPanel>📡</IconPanel><Card><p>Searching for a beacon near Nakamise Street.</p><p>In mock mode, use the success button.</p></Card><Button onClick={() => go(15)}>Beacon Detected</Button><Button variant="secondary" onClick={() => go(34)}>Not Detected</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/BeaconFailedScreen.jsx
import { InfoScreen } from './InfoScreen'
export function BeaconFailedScreen({ t, go }) {
  return <InfoScreen title={t.screens[34][0]} text="Move closer to the target area and check Bluetooth settings." nextLabel="Retry" nextScreen={33} go={go}/>
}
EOF

cat <<'EOF' > src/screens/BeaconDetectedScreen.jsx
import { InfoScreen } from './InfoScreen'
export function BeaconDetectedScreen({ t, go }) {
  return <InfoScreen title={t.screens[15][0]} text="You arrived at Nakamise Street. A store check-in mission has been unlocked." nextLabel="View Mission" nextScreen={16} go={go}/>
}
EOF

cat <<'EOF' > src/screens/FoodMissionScreen.jsx
import { Button } from '../components/Button'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function FoodMissionScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[16][0]}</h2><IconPanel>🥮</IconPanel><h3>Find Ningyo-yaki!</h3><p>Target Stores: 3</p><Button variant="gold" onClick={() => go(40)}>View Stores</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/StoreDetailScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function StoreDetailScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[40][0]}</h2><IconPanel>🏪</IconPanel><h3>Kimuraya Main Store</h3><Card><p>A Ningyo-yaki shop on Nakamise Street. Check in to earn a coupon and EXP.</p></Card><Button onClick={() => go(17)}>Check In</Button><Button variant="secondary" onClick={() => go(41)}>View Coupon</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/CouponScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function CouponScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[41][0]}</h2><Card className="center"><h3>¥50 Off Ningyo-yaki</h3><p>Valid: Today only</p></Card><Button onClick={() => go(17)}>Use at Store</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/StoreCheckinScreen.jsx
import { InfoScreen } from './InfoScreen'
export function StoreCheckinScreen({ t, go }) {
  return <InfoScreen title={t.screens[17][0]} text="Kimuraya Main Store: Check-in Complete! +100 EXP" nextLabel="Social Share" nextScreen={18} go={go}/>
}
EOF

cat <<'EOF' > src/screens/SocialShareScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function SocialShareScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[18][0]}</h2><Card><h3>External Social Media API</h3><p>This assumes sharing through external social media APIs.</p></Card>{['Share on X', 'Instagram', 'Facebook', 'LINE'].map(x => <Button key={x} variant="secondary">{x}</Button>)}<Button onClick={() => go(19)}>Not Now</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/NFTRewardScreen.jsx
import { Button } from '../components/Button'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function NFTRewardScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[19][0]}</h2><IconPanel>🏆</IconPanel><h3>Memory of Raijin</h3><p className="exp">SSR</p><Button onClick={() => go(20)}>Collection</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/CollectionScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function CollectionScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[20][0]}</h2><p>Collected 25/100</p>{['🏆 Memory of Raijin SSR', '🌀 Memory of Fujin SR', '👻 Spirit Parade Memory UR'].map(x => <Card key={x}>{x}</Card>)}<Button onClick={() => go(21)}>Check Completion</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/AreaProgressScreen.jsx
import { InfoScreen } from './InfoScreen'
export function AreaProgressScreen({ t, go }) {
  return <InfoScreen title={t.screens[21][0]} text="Night Asakusa Chapter Unlocked. Proceed to the final mission." nextLabel="Stay Quest" nextScreen={22} go={go}/>
}
EOF

cat <<'EOF' > src/screens/ProgressScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function ProgressScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[30][0]}</h2><Card><h3>Asakusa: Edo Phantom Record</h3><p>Progress</p><div className="bar"><span /></div><p>90%</p></Card><Card><p>Done: QR / AR Puzzle / NFC / Food Mission</p><p>Remaining: Spirit Parade Quest</p></Card><Button onClick={() => go(22)}>Continue</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/StayQuestScreen.jsx
import { InfoScreen } from './InfoScreen'
export function StayQuestScreen({ t, go }) {
  return <InfoScreen title={t.screens[22][0]} text="Night Asakusa Chapter. Requirement: Hotel Check-in." icon="🌙" nextLabel="View Quest" nextScreen={23} go={go}/>
}
EOF

cat <<'EOF' > src/screens/HotelCheckScreen.jsx
import { InfoScreen } from './InfoScreen'
export function HotelCheckScreen({ t, go }) {
  return <InfoScreen title={t.screens[23][0]} text="Checked In. Night missions have been unlocked." nextLabel="Start Spirit Parade" nextScreen={24} go={go}/>
}
EOF

cat <<'EOF' > src/screens/NightARScreen.jsx
import { InfoScreen } from './InfoScreen'
export function NightARScreen({ t, go }) {
  return <InfoScreen title={t.screens[24][0]} text="Edo Spirit Parade: you solved the final puzzle." icon="👻" nextLabel="Complete Quest" nextScreen={29} go={go}/>
}
EOF

cat <<'EOF' > src/screens/QuestCompleteScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function QuestCompleteScreen({ t, go }) {
  return <ScreenLayout complete><div className="trophy">🏆</div><h2 className="center">{t.screens[29][0]}</h2><Card className="center"><h3>Spirit Parade Quest CLEAR</h3><p>You solved the final mystery of nighttime Asakusa.</p></Card><p className="exp center">+500 EXP</p><Button variant="gold" onClick={() => go(20)}>View Collection</Button><Button onClick={() => go(25)}>Profile</Button><Button variant="secondary" onClick={() => go(4)}>{t.common.home}</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/ProfileScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { IconPanel, ScreenLayout } from './ScreenLayout'
export function ProfileScreen({ t, go }) {
  return <ScreenLayout><h2>{t.screens[25][0]}</h2><Card className="center"><IconPanel>🧭</IconPanel><h3>Guest Explorer</h3><p>Level: 4</p><p>Exploration Rate: 100%</p><p>NFTs: 25</p></Card><Button onClick={() => go(20)}>Collection</Button><Button variant="secondary" onClick={() => go(4)}>{t.common.home}</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/SettingsScreen.jsx
import { Button } from '../components/Button'
import { Card } from '../components/Card'
import { ScreenLayout } from './ScreenLayout'
export function SettingsScreen({ t, go, toggleLocale }) {
  return <ScreenLayout><h2>{t.screens[35][0]}</h2><Card><h3>Language</h3><Button variant="secondary" onClick={toggleLocale}>Switch Language</Button></Card><Card><h3>Permissions</h3><p>Location: Allowed</p><p>Camera: Allowed</p><p>NFC: Pending</p><p>Bluetooth: Pending</p></Card><Button onClick={() => go(4)}>{t.common.home}</Button></ScreenLayout>
}
EOF

cat <<'EOF' > src/screens/PermissionLocationScreen.jsx
import { InfoScreen } from './InfoScreen'
export function PermissionLocationScreen({ t, go }) {
  return <InfoScreen title={t.screens[36][0]} text="Used for nearby spots and arrival checks." icon="📍" nextLabel="Allow" nextScreen={37} secondaryLabel="Set Later" secondaryScreen={38} go={go}/>
}
EOF

cat <<'EOF' > src/screens/PermissionCameraScreen.jsx
import { InfoScreen } from './InfoScreen'
export function PermissionCameraScreen({ t, go }) {
  return <InfoScreen title={t.screens[37][0]} text="Used for QR scanning and AR display." icon="📷" nextLabel="Allow" nextScreen={4} secondaryLabel="Set Later" secondaryScreen={4} go={go}/>
}
EOF

cat <<'EOF' > src/screens/PermissionSkippedScreen.jsx
import { InfoScreen } from './InfoScreen'
export function PermissionSkippedScreen({ t, go }) {
  return <InfoScreen title={t.screens[38][0]} text="Some features may not work. You can change this later in Settings." nextLabel="Go Home" nextScreen={4} secondaryLabel="Settings" secondaryScreen={35} go={go}/>
}
EOF

cat <<'EOF' > src/screens/NetworkErrorScreen.jsx
import { InfoScreen } from './InfoScreen'
export function NetworkErrorScreen({ t, go }) {
  return <InfoScreen title={t.screens[39][0]} text="Failed to fetch data. Please check your connection." icon="📡" nextLabel="Reload" nextScreen={4} secondaryLabel={t.common.home} secondaryScreen={4} go={go}/>
}
EOF

cat <<'EOF' > src/screens/index.js
export { SplashScreen } from './SplashScreen'
export { LanguageScreen } from './LanguageScreen'
export { LoginScreen } from './LoginScreen'
export { TermsScreen } from './TermsScreen'
export { HowToUseScreen } from './HowToUseScreen'
export { HomeScreen } from './HomeScreen'
export { MapScreen } from './MapScreen'
export { EventListScreen } from './EventListScreen'
export { EventDetailScreen } from './EventDetailScreen'
export { EntryConfirmScreen } from './EntryConfirmScreen'
export { EventStartScreen } from './EventStartScreen'
export { QRScanScreen } from './QRScanScreen'
export { QRScanFailedScreen } from './QRScanFailedScreen'
export { ARLaunchScreen } from './ARLaunchScreen'
export { PuzzleScreen } from './PuzzleScreen'
export { PuzzleCorrectScreen } from './PuzzleCorrectScreen'
export { NFCScanScreen } from './NFCScanScreen'
export { NFCFailedScreen } from './NFCFailedScreen'
export { NFCCompleteScreen } from './NFCCompleteScreen'
export { BeaconWaitingScreen } from './BeaconWaitingScreen'
export { BeaconFailedScreen } from './BeaconFailedScreen'
export { BeaconDetectedScreen } from './BeaconDetectedScreen'
export { FoodMissionScreen } from './FoodMissionScreen'
export { StoreDetailScreen } from './StoreDetailScreen'
export { CouponScreen } from './CouponScreen'
export { StoreCheckinScreen } from './StoreCheckinScreen'
export { SocialShareScreen } from './SocialShareScreen'
export { NFTRewardScreen } from './NFTRewardScreen'
export { CollectionScreen } from './CollectionScreen'
export { AreaProgressScreen } from './AreaProgressScreen'
export { ProgressScreen } from './ProgressScreen'
export { StayQuestScreen } from './StayQuestScreen'
export { HotelCheckScreen } from './HotelCheckScreen'
export { NightARScreen } from './NightARScreen'
export { QuestCompleteScreen } from './QuestCompleteScreen'
export { ProfileScreen } from './ProfileScreen'
export { SettingsScreen } from './SettingsScreen'
export { PermissionLocationScreen } from './PermissionLocationScreen'
export { PermissionCameraScreen } from './PermissionCameraScreen'
export { PermissionSkippedScreen } from './PermissionSkippedScreen'
export { NetworkErrorScreen } from './NetworkErrorScreen'
EOF

echo "Screen components have been split successfully."
echo "Run: npm run dev -- --host 0.0.0.0"