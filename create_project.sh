#!/usr/bin/env bash
set -e

mkdir -p public src/{api,components,data,i18n,screens}

cat <<'EOF' > package.json
{
  "name": "taito-mystery-walk",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^19.1.0",
    "react-dom": "^19.1.0"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^5.0.2",
    "vite": "^7.1.7"
  }
}
EOF

cat <<'EOF' > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()]
})
EOF

cat <<'EOF' > index.html
<!doctype html>
<html lang="ja">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>台東区 次世代謎解き街歩き</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

cat <<'EOF' > public/.gitkeep
EOF

cat <<'EOF' > README.md
# Taito Mystery Walk

React + Viteで作成した、台東区の謎解き街歩きモックSPAです。

## 起動

```bash
npm install
npm run dev -- --host 0.0.0.0
EOF