/**
 * MARITY TRADE — iOS Web Bundle Preparation
 * Copies client assets (HTML, CSS, JS, Assets) into the `public/` directory
 * for Capacitor iOS bundling and Codemagic CI/CD.
 */

const fs = require('fs');
const path = require('path');

const rootDir = path.resolve(__dirname, '..');
const outDir = path.join(rootDir, 'public');

console.log('>>> Preparing Marity Trade iOS Web Bundle in:', outDir);

if (fs.existsSync(outDir)) {
  fs.rmSync(outDir, { recursive: true, force: true });
}
fs.mkdirSync(outDir, { recursive: true });

function copyRecursive(src, dest) {
  const stat = fs.statSync(src);
  if (stat.isDirectory()) {
    if (!fs.existsSync(dest)) {
      fs.mkdirSync(dest, { recursive: true });
    }
    const entries = fs.readdirSync(src);
    for (const entry of entries) {
      copyRecursive(path.join(src, entry), path.join(dest, entry));
    }
  } else {
    fs.copyFileSync(src, dest);
  }
}

// 1. Copy core files
const filesToCopy = ['index.html', 'manifest.json'];
for (const file of filesToCopy) {
  const src = path.join(rootDir, file);
  const dest = path.join(outDir, file);
  if (fs.existsSync(src)) {
    fs.copyFileSync(src, dest);
    console.log(`  ✓ Bundled file: ${file}`);
  }
}

// 2. Copy directories
const dirsToCopy = ['css', 'js', 'assets'];
for (const dir of dirsToCopy) {
  const src = path.join(rootDir, dir);
  const dest = path.join(outDir, dir);
  if (fs.existsSync(src)) {
    copyRecursive(src, dest);
    console.log(`  ✓ Bundled directory: ${dir}/`);
  }
}

console.log('>>> iOS Web Bundle prepared successfully for Capacitor & Codemagic!');
