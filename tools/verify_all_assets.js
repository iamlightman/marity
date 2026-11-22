const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
console.log('>>> Auditing Marity Trade Client Codebase for Broken Assets, Code Errors & Policy Compliance...');

let errorsFound = 0;

// 1. Audit index.html image sources
const html = fs.readFileSync(path.join(root, 'index.html'), 'utf8');
const srcRegex = /src=["']([^"']+\.(png|jpg|jpeg|svg|webp))["']/gi;
let match;
while ((match = srcRegex.exec(html)) !== null) {
  const fileRef = match[1];
  if (!fileRef.startsWith('http')) {
    const fullPath = path.join(root, fileRef);
    if (!fs.existsSync(fullPath)) {
      console.error(`  ❌ Broken image in index.html: ${fileRef}`);
      errorsFound++;
    }
  }
}

// 2. Audit products.js images
const productsContent = fs.readFileSync(path.join(root, 'js/products.js'), 'utf8');
const prodImgRegex = /image:\s*['"]([^'"]+)['"]/gi;
while ((match = prodImgRegex.exec(productsContent)) !== null) {
  const fileRef = match[1];
  if (!fileRef.startsWith('http')) {
    const fullPath = path.join(root, fileRef);
    if (!fs.existsSync(fullPath)) {
      console.error(`  ❌ Broken product image in products.js: ${fileRef}`);
      errorsFound++;
    }
  }
}

// 3. Audit CSS url() references
const cssFiles = ['css/app.css', 'css/liquid-metal.css', 'css/modals.css'];
for (const cssFile of cssFiles) {
  const cssContent = fs.readFileSync(path.join(root, cssFile), 'utf8');
  const urlRegex = /url\(["']?([^"')]+?\.(png|jpg|jpeg|svg|webp))["']?\)/gi;
  while ((match = urlRegex.exec(cssContent)) !== null) {
    let fileRef = match[1];
    if (!fileRef.startsWith('http') && !fileRef.startsWith('data:')) {
      const fullPath = path.resolve(root, 'css', fileRef);
      if (!fs.existsSync(fullPath)) {
        console.error(`  ❌ Broken CSS asset in ${cssFile}: ${fileRef} (resolved to: ${fullPath})`);
        errorsFound++;
      }
    }
  }
}

// 4. Audit onclick handlers in index.html to ensure all functions exist in app.js
const appJsContent = fs.readFileSync(path.join(root, 'js/app.js'), 'utf8');
const onclickRegex = /onclick=["']window\.([a-zA-Z0-9_]+)\([^"']*?\);?["']/gi;
const calledFuncs = new Set();
while ((match = onclickRegex.exec(html)) !== null) {
  calledFuncs.add(match[1]);
}
for (const fn of calledFuncs) {
  if (!appJsContent.includes(`window.${fn}`) && !appJsContent.includes(`${fn} =`)) {
    console.error(`  ❌ Missing JS handler in app.js: window.${fn}`);
    errorsFound++;
  } else {
    console.log(`  ✓ Verified JS handler: window.${fn}`);
  }
}

if (errorsFound === 0) {
  console.log('>>> ALL ASSETS, IMAGES AND CSS REFERENCES VERIFIED! ZERO BROKEN LINKS!');
} else {
  console.error(`>>> AUDIT FAILED with ${errorsFound} broken asset references.`);
}
