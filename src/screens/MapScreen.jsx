import { BackButton, ScreenLayout } from './ScreenLayout'
export function MapScreen({ t, go }) {
  return <ScreenLayout><BackButton t={t} go={go}/><h2>{t.screens[5][0]}</h2><div className="map"><span className="pin a">Puzzle</span><span className="pin b">NFT</span><span className="pin c">QR</span></div></ScreenLayout>
}
