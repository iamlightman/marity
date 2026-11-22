<?php
/**
 * MARITY TRADE — LUXURY FRAGRANCE MOBILE APPLICATION
 * Production PHP Entry Point for Apple iOS / WKWebView & Web Platforms
 */
require_once __DIR__ . '/config.php';

// Security Headers
header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: SAMEORIGIN');
header('X-XSS-Protection: 1; mode=block');
header('Referrer-Policy: strict-origin-when-cross-origin');
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
  <title>Marity Trade — Luxury Fragrances</title>
  <meta name="description" content="Realistic liquid metal glass mobile e-commerce application for Marity Trade.">
  <meta name="theme-color" content="#11151F">

  <!-- Luxury Typography: Playfair Display, Cinzel, Plus Jakarta Sans -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@500;700;800&family=Playfair+Display:ital,wght@0,500;0,600;0,700;1,500&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

  <!-- Apple iOS & Web App Icons (Authentic Marity Logo) -->
  <link rel="icon" type="image/png" href="assets/marity_logo_icon.png">
  <link rel="apple-touch-icon" href="assets/marity_logo_icon.png">
  <link rel="apple-touch-icon" sizes="152x152" href="assets/marity_logo_icon.png">
  <link rel="apple-touch-icon" sizes="180x180" href="assets/marity_logo_icon.png">
  <link rel="apple-touch-icon" sizes="167x167" href="assets/marity_logo_icon.png">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
  <meta name="apple-mobile-web-app-title" content="Marity Trade">

  <!-- Material & Application Stylesheets -->
  <link rel="stylesheet" href="css/liquid-metal.css">
  <link rel="stylesheet" href="css/app.css">
  <link rel="stylesheet" href="css/modals.css">
</head>
<body>

  <!-- ==========================================================================
       APP SPLASH LOADER (AUTHENTIC LOGO & FLUID WATER PROGRESS)
       ========================================================================== -->
  <div id="appSplashLoader" class="app-splash-loader">
    <div class="splash-content">
      <img src="assets/marity_logo.png" alt="Marity Trade Logo" class="splash-logo-img" />
      <div class="splash-water-progress-track">
        <div class="splash-water-progress-bar"></div>
      </div>
      <div class="splash-water-pour-tag">MARITY TRADE</div>
    </div>
  </div>

  <!-- Main Application Container -->
  <main class="app-container liquid-metal-canvas">

    <!-- Seamless Floating Luxury Header -->
    <header class="app-header">
      <div class="brand-block" onclick="window.appSwitchTab('home')" style="cursor: pointer;">
        <h1 class="brand-wordmark">Marity</h1>
        <span class="brand-submark">TRADE</span>
      </div>

      <div class="header-actions">
        <!-- Search Circular Frosted Lens Button -->
        <button class="glass-icon-btn" id="headerSearchBtn" onclick="window.appOpenSearch()" aria-label="Search Fragrances">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="7.5"></circle>
            <line x1="21" y1="21" x2="16.5" y2="16.5"></line>
          </svg>
        </button>

        <!-- Shopping Bag Circular Frosted Lens Button with Champagne Badge -->
        <button class="glass-icon-btn" id="headerBagBtn" onclick="window.appOpenBag()" aria-label="Shopping Bag">
          <svg width="19" height="19" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
            <line x1="3" y1="6" x2="21" y2="6"></line>
            <path d="M16 10a4 4 0 0 1-8 0"></path>
          </svg>
          <span class="bag-badge" id="bagCountBadge">2</span>
        </button>
      </div>
    </header>

        <!-- Scrollable Inner View Container -->
        <div class="screen-scroll-view">

          <!-- ================================================================
               TAB 1: HOMEPAGE VIEW
               ================================================================ -->
          <div class="view-container active" id="view-home">

            <!-- Hero Editorial Carousel -->
            <section class="hero-editorial-section" id="heroCarousel">
              
              <!-- Slide 1: The Art of Fragrance (Original Mockup) -->
              <div class="hero-slide hero-slide-art active" data-slide="0">
                <div class="hero-copy">
                  <div class="hero-pretitle">The Art of</div>
                  <h2 class="hero-title">FRAGRANCE</h2>
                  <p class="hero-tagline">Timeless elegance.<br>Unforgettable presence.</p>
                  <button class="btn-metallic-pill" onclick="window.appOpenProductDetail('art-of-fragrance-grand-cru')">
                    Explore Collection
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                  </button>
                </div>
                <div class="hero-flacon-stage" onclick="window.appOpenProductDetail('art-of-fragrance-grand-cru')">
                  <img src="assets/hero_bottle.png" alt="The Art of Fragrance Luxury Flacon" />
                </div>
              </div>

              <!-- Slide 2: Golden Hour Elixir -->
              <div class="hero-slide hero-slide-soleil" data-slide="1">
                <div class="hero-copy">
                  <div class="hero-pretitle">Solar Extrait</div>
                  <h2 class="hero-title">SOLEIL D'OR</h2>
                  <p class="hero-tagline">Mediterranean neroli.<br>Liquid golden amber.</p>
                  <button class="btn-metallic-pill" onclick="window.appOpenProductDetail('soleil-dor')">
                    Discover Extrait
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                  </button>
                </div>
                <div class="hero-flacon-stage" onclick="window.appOpenProductDetail('soleil-dor')">
                  <img src="assets/bottle_soleil_dor.png" alt="Soleil d'Or Luxury Flacon" />
                </div>
              </div>

              <!-- Slide 3: Nocturnal Oud (Restyled Obsidian Noir) -->
              <div class="hero-slide hero-slide-obsidian" data-slide="2">
                <div class="hero-copy">
                  <div class="hero-pretitle">Nocturnal Mastery</div>
                  <h2 class="hero-title">OBSIDIAN NOIR</h2>
                  <p class="hero-tagline">Smoked agarwood.<br>Supple glove leather.</p>
                  <button class="btn-metallic-pill btn-obsidian-cta" onclick="window.appOpenProductDetail('obsidian-noir')">
                    Shop Limited
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                  </button>
                </div>
                <div class="hero-flacon-stage" onclick="window.appOpenProductDetail('obsidian-noir')">
                  <img src="assets/bottle_obsidian_noir.png" alt="Obsidian Noir Luxury Flacon" />
                </div>
              </div>

              <!-- Carousel Indicators -->
              <div class="carousel-indicators">
                <div class="indicator-dot active" data-index="0"></div>
                <div class="indicator-dot" data-index="1"></div>
                <div class="indicator-dot" data-index="2"></div>
              </div>
            </section>

            <!-- Category Pods Glass Dock -->
            <section class="section-categories">
              <div class="glass-category-bar">
                
                <button class="cat-pod-item" data-category="mens">
                  <div class="cat-pod-circle">
                    <img src="assets/cat_mens.png" alt="Men's Fragrances" />
                  </div>
                  <span class="cat-pod-label">Men's</span>
                </button>

                <button class="cat-pod-item" data-category="womens">
                  <div class="cat-pod-circle">
                    <img src="assets/cat_womens.png" alt="Women's Fragrances" />
                  </div>
                  <span class="cat-pod-label">Women's</span>
                </button>

                <button class="cat-pod-item" data-category="unisex">
                  <div class="cat-pod-circle">
                    <img src="assets/cat_unisex.png" alt="Unisex Fragrances" />
                  </div>
                  <span class="cat-pod-label">Unisex</span>
                </button>

                <button class="cat-pod-item" data-category="gifts">
                  <div class="cat-pod-circle">
                    <img src="assets/cat_gifts.png" alt="Luxury Gifts" />
                  </div>
                  <span class="cat-pod-label">Gifts</span>
                </button>

              </div>
            </section>

            <!-- Best Sellers Section -->
            <section class="section-bestsellers">
              <div class="section-header-row">
                <h3 class="section-heading">Best Sellers</h3>
                <a class="section-action-link" onclick="window.appSwitchTab('shop')">
                  View All
                  <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="9 18 15 12 9 6"></polyline></svg>
                </a>
              </div>

              <!-- Dynamic 2-Column Product Grid -->
              <div class="products-grid-2col" id="bestsellersGrid">
                <!-- Rendered dynamically via JavaScript -->
              </div>
            </section>

            <!-- Promotional Luxury Campaign: "Luxury in Every Detail" -->
            <section class="section-promo">
              <div class="promo-luxury-card" style="cursor: pointer;" title="Tap to experience fine fragrance mist">
                <div class="promo-copy">
                  <h3 class="promo-title">Luxury in<br>Every Detail</h3>
                  <p class="promo-subtitle">Discover a world of premium fragrances handcrafted in Grasse, France.</p>
                  <button class="btn-pearl-pill" onclick="event.stopPropagation(); window.appSwitchTab('shop');">
                    Shop the Collection
                    <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                  </button>
                </div>
                <div class="promo-image-box">
                  <img src="assets/promo_atomizer.png" alt="Fine Fragrance Atomizer Mist" />
                  <img src="assets/promo_atomizer.png" alt="Marity Trade Perfume Mist" />
                </div>
              </div>
            </section>

            <!-- Trust Pillars: Product, Quality, Delivery (Clear & Understandable) -->
            <section class="section-features">
              <div class="features-slider">
                <!-- 1. PRODUCT PILLAR -->
                <div class="feature-glass-box">
                  <div class="feature-icon-badge">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                      <path d="M12 2.69l5.66 5.66a8 8 0 1 1-11.31 0z"></path>
                    </svg>
                  </div>
                  <div class="feature-title">All-Day Scent</div>
                  <div class="feature-desc">Lasts 14+ hours on skin</div>
                </div>

                <!-- 2. QUALITY PILLAR -->
                <div class="feature-glass-box">
                  <div class="feature-icon-badge">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                      <circle cx="12" cy="8" r="7"></circle>
                      <polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline>
                    </svg>
                  </div>
                  <div class="feature-title">Premium Quality</div>
                  <div class="feature-desc">Handcrafted in France</div>
                </div>

                <!-- 3. DELIVERY PILLAR -->
                <div class="feature-glass-box">
                  <div class="feature-icon-badge">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                      <rect x="1" y="3" width="15" height="13"></rect>
                      <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                      <circle cx="5.5" cy="18.5" r="2.5"></circle>
                      <circle cx="18.5" cy="18.5" r="2.5"></circle>
                    </svg>
                  </div>
                  <div class="feature-title">Express Delivery</div>
                  <div class="feature-desc">Delivery within 12 to 24 hours</div>
                </div>
              </div>
            </section>

          </div>

          <!-- ================================================================
               TAB 2: SHOP / CATALOG VIEW
               ================================================================ -->
          <div class="view-container" id="view-shop">
            <div class="view-title-block">
              <span class="view-kicker">CURATED SELECTION</span>
              <h2 class="view-main-title">Marity Trade Collection</h2>
              <p class="view-subtitle">Hand-blended extrait and eau de parfum collection.</p>
            </div>

            <!-- Filter Chips -->
            <div class="filter-pills-row">
              <button class="filter-pill active" data-filter="all">All Flacons</button>
              <button class="filter-pill" data-filter="mens">Men's</button>
              <button class="filter-pill" data-filter="womens">Women's</button>
              <button class="filter-pill" data-filter="unisex">Unisex</button>
              <button class="filter-pill" data-filter="gifts">Coffrets & Gifts</button>
            </div>

            <!-- Interactive Fragrance Finder Quiz Callout -->
            <div class="fragrance-finder-card" style="background: linear-gradient(135deg, rgba(255,255,255,0.88) 0%, rgba(240,245,252,0.72) 100%); border: 1px solid rgba(255,255,255,0.9); border-radius: 20px; padding: 14px 16px; margin-bottom: 18px; display:flex; align-items:center; justify-content:space-between; box-shadow: var(--glass-bevel-top);">
              <div>
                <div style="font-family: var(--font-serif); font-size: 15px; font-weight: 700; color: #11151F;">Fragrance Finder</div>
                <div style="font-size: 11px; color: #64748B;">Find your tailored signature fragrance in 30 seconds.</div>
              </div>
              <button class="btn-pearl-pill" onclick="window.appOpenScentQuiz()">Take Scent Quiz →</button>
            </div>

            <!-- Full Shop Grid -->
            <div class="products-grid-2col" id="shopGrid"></div>
          </div>

          <!-- ================================================================
               TAB 3: WISHLIST VIEW
               ================================================================ -->
          <div class="view-container" id="view-wishlist">
            <div class="view-title-block" style="display:flex; justify-content:space-between; align-items:flex-end;">
              <div>
                <h2 class="view-main-title">Private Wishlist</h2>
                <p class="view-subtitle">Your curated selection of signature flacons.</p>
              </div>
              <button class="btn-pearl-pill" onclick="fragranceStore.moveAllWishlistToCart(); window.appShowToast('All wishlist items moved to Bag');">Add All to Bag</button>
            </div>

            <div class="products-grid-2col" id="wishlistGrid"></div>
          </div>

          <!-- ================================================================
               TAB 3: ORDERS & CONCIERGE TRACKING VIEW (WITH VERIFICATION GATE)
               ================================================================ -->
          <div class="view-container" id="view-orders">
            <div class="view-title-block">
              <h2 class="view-main-title">Delivery Concierge</h2>
              <p class="view-subtitle">Real-time status of your hand-poured flacons and atelier shipments.</p>
            </div>

            <!-- Verification Gate Container (Shown when client has not yet entered code) -->
            <div id="orderVerifyGateCard" class="order-card-luxury" style="padding: 22px 18px; margin-bottom: 20px;">
              <div style="width: 48px; height: 48px; border-radius: 50%; background: linear-gradient(135deg, rgba(255,255,255,0.98), rgba(240,245,252,0.92)); border: 1.5px solid #FFF; display: flex; align-items: center; justify-content: center; margin: 0 auto 12px auto; box-shadow: 0 4px 14px rgba(15,23,42,0.08);">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#9A7B35" stroke-width="1.8">
                  <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                  <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                </svg>
              </div>
              <h3 style="font-family: var(--font-serif); font-size: 18px; font-weight: 700; text-align: center; margin-bottom: 4px; color: #11151F;">Client Order Lookup</h3>
              <p style="font-size: 11.5px; color: #64748B; text-align: center; margin-bottom: 18px; line-height: 1.45;">Enter your phone number or email address to receive an instant verification code and access your order history & tracking.</p>

              <!-- Step 1: Input Phone or Email -->
              <div id="orderStepInputBox">
                <div class="form-group" style="margin-bottom: 14px;">
                  <label class="form-label">Email or Phone Number</label>
                  <input type="text" id="orderLookupContactInput" class="form-input" placeholder="e.g. alexandre.laurent@parfum.fr or +33 6 12 34 56 78" value="alexandre.laurent@parfum.fr" />
                </div>
                <button class="btn-metallic-pill" style="width: 100%; padding: 13px;" onclick="window.appSendOrderVerificationCode()">
                  Send Verification Code
                  <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </button>
              </div>

              <!-- Step 2: Input 4-Digit Code -->
              <div id="orderStepCodeBox" style="display: none;">
                <div style="background: rgba(245, 230, 190, 0.25); border: 1px solid rgba(212, 175, 55, 0.4); border-radius: 12px; padding: 10px; margin-bottom: 14px; font-size: 11.5px; color: #785A18; text-align: center;">
                  ✦ Code sent to <strong id="orderLookupTargetDisplay">alexandre.laurent@parfum.fr</strong><br>
                  <span style="font-size: 10px; color: #8A6D3B;">(Demo security code: <strong>8492</strong>)</span>
                </div>
                <div class="form-group" style="margin-bottom: 14px;">
                  <label class="form-label" style="text-align: center;">Enter 4-Digit Code</label>
                  <input type="text" id="orderVerificationCodeInput" class="form-input" placeholder="8492" maxlength="6" style="text-align: center; font-size: 18px; font-weight: 700; letter-spacing: 0.25em;" value="8492" />
                </div>
                <div style="display: flex; gap: 8px;">
                  <button class="btn-pearl-pill" style="flex: 1; padding: 11px;" onclick="window.appBackToOrderContactInput()">Back</button>
                  <button class="btn-metallic-pill" style="flex: 2; padding: 11px;" onclick="window.appVerifyOrderCodeAndReveal()">
                    Verify & Reveal Orders
                  </button>
                </div>
              </div>
            </div>

            <!-- Verified Order Histories Container (Revealed after code verification) -->
            <div id="orderVerifiedContainer" style="display: none;">
              <div style="display: flex; justify-content: space-between; align-items: center; background: rgba(255, 255, 255, 0.9); border: 1.5px solid rgba(255, 255, 255, 0.95); border-radius: 16px; padding: 10px 14px; margin-bottom: 16px; box-shadow: 0 4px 12px rgba(15,23,42,0.04);">
                <div>
                  <div style="font-size: 10px; color: #2E7D32; font-weight: 700; display: flex; align-items: center; gap: 4px;">
                    <span>●</span> VERIFIED CLIENT ACCESS
                  </div>
                  <div style="font-size: 12px; font-weight: 700; color: #11151F;" id="orderVerifiedClientLabel">alexandre.laurent@parfum.fr</div>
                </div>
                <button class="btn-pearl-pill" style="padding: 5px 10px; font-size: 10.5px;" onclick="window.appLogoutOrderLookup()">Sign Out</button>
              </div>

              <!-- List of active and past orders -->
              <div id="ordersList"></div>
            </div>
          </div>

          <!-- ================================================================
               TAB 4: WHOLESALE B2B LOGIN & TRADE PORTAL
               ================================================================ -->
          <div class="view-container" id="view-wholesale">
            <div class="view-title-block">
              <h2 class="view-main-title">Wholesale Trade Portal</h2>
              <p class="view-subtitle">Certified atelier case pack allocations for authorized boutiques & salons.</p>
            </div>

            <!-- Wholesale Trade Login Card (Default View) -->
            <div id="wsLoginCard" class="order-card-luxury" style="padding: 22px 18px; margin-bottom: 20px;">
              <div style="width: 48px; height: 48px; border-radius: 50%; background: linear-gradient(135deg, rgba(255,255,255,0.98), rgba(240,245,252,0.92)); border: 1.5px solid #FFF; display: flex; align-items: center; justify-content: center; margin: 0 auto 12px auto; box-shadow: 0 4px 14px rgba(15,23,42,0.08);">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#9A7B35" stroke-width="1.8">
                  <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                  <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                  <line x1="12" y1="22.08" x2="12" y2="12"></line>
                </svg>
              </div>
              <h3 style="font-family: var(--font-serif); font-size: 18px; font-weight: 700; text-align: center; margin-bottom: 4px; color: #11151F;">Trade Partner Sign In</h3>
              <p style="font-size: 11.5px; color: #64748B; text-align: center; margin-bottom: 18px; line-height: 1.45;">Access certified wholesale case pricing, trade terms, and expedited dispatch allocations.</p>

              <!-- Trade Perks Grid -->
              <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 6px; margin-bottom: 18px;">
                <div style="background: rgba(255,255,255,0.85); border: 1px solid #E2E8F0; border-radius: 12px; padding: 10px 4px; text-align: center;">
                  <div style="font-size: 8.5px; color: #64748B; text-transform: uppercase;">Trade Margin</div>
                  <strong style="font-size: 12.5px; color: #2E7D32;">40% Off MSRP</strong>
                </div>
                <div style="background: rgba(255,255,255,0.85); border: 1px solid #E2E8F0; border-radius: 12px; padding: 10px 4px; text-align: center;">
                  <div style="font-size: 8.5px; color: #64748B; text-transform: uppercase;">Min. Order</div>
                  <strong style="font-size: 12.5px; color: #11151F;">1 Case (6 Btls)</strong>
                </div>
                <div style="background: rgba(255,255,255,0.85); border: 1px solid #E2E8F0; border-radius: 12px; padding: 10px 4px; text-align: center;">
                  <div style="font-size: 8.5px; color: #64748B; text-transform: uppercase;">Express Delivery</div>
                  <strong style="font-size: 12.5px; color: #11151F;">12 to 24 Hours</strong>
                </div>
              </div>

              <!-- Form Fields -->
              <div class="form-group" style="margin-bottom: 12px;">
                <label class="form-label">Wholesale Partner ID</label>
                <input type="text" id="wsPartnerIdInput" class="form-input" placeholder="e.g. MT-WS-8492" value="MT-WS-8492" />
              </div>

              <div class="form-group" style="margin-bottom: 16px;">
                <label class="form-label">Authorized Business Email</label>
                <input type="email" id="wsPartnerEmailInput" class="form-input" placeholder="e.g. buyer@boutique-parfum.fr" value="buyer@boutique-parfum.fr" />
              </div>

              <button class="btn-metallic-pill" style="width: 100%; padding: 13px;" onclick="window.appWholesaleLogin()">
                Access Wholesale Catalog
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
              </button>

              <div style="text-align: center; margin: 14px 0 10px 0; font-size: 11px; color: #94A3B8;">— NEW TRADE PARTNERS —</div>

              <button class="btn-pearl-pill" style="width: 100%; padding: 11px; font-weight: 700;" onclick="window.appToggleWholesaleApply()">
                Become a Wholesale Buyer
              </button>
            </div>

            <!-- Become a Wholesale Buyer Application Card (Toggleable) -->
            <div id="wsApplyCard" class="order-card-luxury" style="display: none; padding: 20px 18px; margin-bottom: 20px;">
              <h3 style="font-family: var(--font-serif); font-size: 17px; font-weight: 700; margin-bottom: 4px;">Trade Buyer Application</h3>
              <p style="font-size: 11.5px; color: #64748B; margin-bottom: 16px;">Join Marity Trade's authorized network of luxury retailers, salons & spas.</p>

              <div class="form-group" style="margin-bottom: 10px;">
                <label class="form-label">Business / Boutique Name</label>
                <input type="text" id="wsApplyBoutique" class="form-input" placeholder="e.g. Le Palais des Senteurs" value="Le Palais des Senteurs" />
              </div>
              <div class="form-group" style="margin-bottom: 10px;">
                <label class="form-label">City / Country</label>
                <input type="text" id="wsApplyCity" class="form-input" placeholder="e.g. Lyon, France" value="Lyon, France" />
              </div>
              <div class="form-group" style="margin-bottom: 10px;">
                <label class="form-label">VAT / Resale Tax ID</label>
                <input type="text" id="wsApplyTaxId" class="form-input" placeholder="e.g. FR-829104821" value="FR-829104821" />
              </div>
              <div class="form-group" style="margin-bottom: 14px;">
                <label class="form-label">Estimated Monthly Volume</label>
                <select id="wsApplyVolume" class="form-input" style="background:#FFF;">
                  <option value="1-5">1 - 5 Cases (6-30 Flacons)</option>
                  <option value="6-20" selected>6 - 20 Cases (36-120 Flacons)</option>
                  <option value="20+">20+ Cases (Master Allocation)</option>
                </select>
              </div>

              <div style="display: flex; gap: 8px;">
                <button class="btn-pearl-pill" style="flex: 1; padding: 11px;" onclick="window.appToggleWholesaleApply()">Cancel</button>
                <button class="btn-metallic-pill" style="flex: 2; padding: 11px;" onclick="window.appSubmitWholesaleApplication()">
                  Submit Application
                </button>
              </div>
            </div>

            <!-- Verified Wholesale Catalog (Unlocked after login) -->
            <div id="wsVerifiedCatalog" style="display: none;">
              <!-- Partner status bar -->
              <div style="display: flex; justify-content: space-between; align-items: center; background: rgba(255, 255, 255, 0.9); border: 1.5px solid rgba(255, 255, 255, 0.95); border-radius: 16px; padding: 10px 14px; margin-bottom: 16px; box-shadow: 0 4px 12px rgba(15,23,42,0.04);">
                <div>
                  <div style="font-size: 10px; color: #2E7D32; font-weight: 700; display: flex; align-items: center; gap: 4px;">
                    <span>●</span> VERIFIED TRADE BUYER
                  </div>
                  <div style="font-size: 12px; font-weight: 700; color: #11151F;" id="wsVerifiedClientLabel">MT-WS-8492 (40% Margin Active)</div>
                </div>
                <button class="btn-pearl-pill" style="padding: 5px 10px; font-size: 10.5px;" onclick="window.appWholesaleLogout()">Sign Out</button>
              </div>

              <!-- Wholesale Products Section -->
              <div class="section-header-row" style="margin-bottom: 12px;">
                <h3 class="section-heading" style="font-size:17px;">Wholesale Case Packs (6 x 100ml)</h3>
                <span class="badge-pearl" style="font-size:10px;">Trade Pricing</span>
              </div>

              <!-- Dynamic Wholesale Products 2-Col Grid -->
              <div class="products-grid-2col" id="wholesaleGrid">
                <!-- Rendered dynamically via js/app.js -->
              </div>

              <!-- B2B Order Summary Box -->
              <div class="order-card-luxury" id="wholesaleCartSummaryCard" style="margin-top: 16px;">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:8px;">
                  <div>
                    <h4 style="font-family:var(--font-serif); font-size:15px; margin-bottom:2px;">Trade Order Summary</h4>
                    <div style="font-size:11px; color:#64748B;" id="wsCartStatus">Tap "Add Case" on any fragrance above.</div>
                  </div>
                  <div style="text-align:right;">
                    <div style="font-size:10px; color:#64748B;">Wholesale Total</div>
                    <strong style="font-size:16px; color:#11151F;" id="wsTotalDisplay">GH₵0.00</strong>
                  </div>
                </div>
                <button class="btn-metallic-pill" id="btnSubmitWholesaleOrder" style="width:100%; padding:13px; font-size:13px;" onclick="window.appSubmitWholesaleOrder()">
                  Submit Wholesale Purchase Order
                </button>
              </div>
            </div>

          </div>

          <!-- ================================================================
               TAB 5: ACCOUNT & VIP LOUNGE VIEW
               ================================================================ -->
          <div class="view-container" id="view-account">
            <div class="view-title-block">
              <h2 class="view-main-title">Client Privilège</h2>
              <p class="view-subtitle">Alexandre Laurent • Member since 2024</p>
            </div>

            <!-- Metallic VIP Platinum Member Card -->
            <div class="vip-card-metal">
              <div style="display:flex; justify-content:space-between; align-items:center;">
                <span class="vip-tier-name">PLATINUM CONNOISSEUR</span>
                <span style="font-family:var(--font-serif); font-size:14px; color:var(--c-champagne-gold);">MARITY</span>
              </div>
              <div class="vip-points-val">1,450 <span style="font-size:15px; font-weight:400; color:#A0AEC0;">PTS</span></div>
              <div class="vip-points-lbl">Equivalent to GH₵75 Privilège Voucher</div>
              
              <div style="width:100%; height:4px; background:rgba(255,255,255,0.15); border-radius:9999px; margin:16px 0 8px 0; overflow:hidden;">
                <div style="width:72%; height:100%; background:linear-gradient(90deg, #F9E7B3, #CFA348); border-radius:9999px;"></div>
              </div>
              <div style="font-size:10px; color:#A0AEC0; display:flex; justify-content:space-between;">
                <span>Tier Milestone: 1,450 / 2,000 pts</span>
                <span>Next Gift: Bespoke Flacon</span>
              </div>
            </div>

            <!-- Active Orders & Concierge Tracking Shortcut -->
            <div class="order-card-luxury" style="display:flex; justify-content:space-between; align-items:center; cursor:pointer;" onclick="window.appSwitchTab('orders')">
              <div>
                <h4 style="font-family:var(--font-serif); font-size:15px; margin-bottom:4px;">Delivery Concierge & Orders</h4>
                <p style="font-size:11.5px; color:#64748B;">Track real-time shipment status & past flacons</p>
              </div>
              <button class="btn-pearl-pill" style="padding:6px 12px; font-size:11px;">View Orders →</button>
            </div>

            <!-- Scent Profile -->
            <div class="order-card-luxury">
              <h4 style="font-family:var(--font-serif); font-size:15px; margin-bottom:8px;">Your Signature Scent Profile</h4>
              <p style="font-size:11.5px; color:#64748B; margin-bottom:12px;">Based on your curated acquisitions and sensory preferences:</p>
              <div style="display:flex; flex-wrap:wrap; gap:6px; margin-bottom:14px;">
                <span class="note-chip">Warm Golden Amber</span>
                <span class="note-chip">Mineral Sea Salt</span>
                <span class="note-chip">Smoked Oud</span>
                <span class="note-chip">Grasse Rose</span>
              </div>
              <button class="btn-pearl-pill" style="width:100%;" onclick="window.appOpenScentQuiz()">Retake Scent Quiz</button>
            </div>

            <!-- Client Services / Concierge -->
            <div class="order-card-luxury">
              <h4 style="font-family:var(--font-serif); font-size:15px; margin-bottom:8px;">Boutique Concierge</h4>
              <p style="font-size:11.5px; color:#64748B; margin-bottom:12px;">Need personalized guidance from our master perfume advisors?</p>
              <div style="display:flex; gap:10px;">
                <button class="btn-metallic-pill" style="flex:1;" onclick="alert('Connecting to Marity Paris Concierge via Private Line: +33 1 42 68 55 00');">Call Concierge</button>
                <button class="btn-pearl-pill" style="flex:1;" onclick="window.appOpenAiChat();">Live Chat</button>
              </div>
            </div>

            <!-- Apple App Store Compliance: Privacy, Terms & Account Deletion (Guideline 5.1.1) -->
            <div class="order-card-luxury">
              <h4 style="font-family:var(--font-serif); font-size:15px; margin-bottom:6px;">Privacy & Customer Rights</h4>
              <p style="font-size:11.5px; color:#64748B; margin-bottom:12px;">Review our data protection commitments, terms of service, or initiate account deletion.</p>
              <div style="display:flex; flex-direction:column; gap:8px;">
                <a href="policy.html" class="btn-pearl-pill" style="text-align:center; padding:10px; text-decoration:none; color:inherit; font-size:11.5px; display:block;">View Privacy Policy & Data Terms</a>
                <button class="btn-pearl-pill" style="padding:10px; font-size:11.5px; color:#DC2626; border-color:rgba(220,38,38,0.3); font-weight:600;" onclick="window.appConfirmAccountDeletion()">Request Account & Data Deletion</button>
              </div>
            </div>

          </div>

        </div> <!-- /screen-scroll-view -->

    <!-- Liquid Metal Floating Capsule Navigation Bar (Exact Mockup Match) -->
    <nav class="liquid-capsule-dock" id="bottomCapsuleDock">
      
      <!-- Home Tab (Active Pill by Default) -->
      <button class="capsule-tab-item active" data-tab="home" aria-label="Home">
        <svg class="tab-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
          <polyline points="9 22 9 12 15 12 15 22"></polyline>
        </svg>
        <span class="tab-label-text">Home</span>
      </button>

      <!-- Shop Tab -->
      <button class="capsule-tab-item" data-tab="shop" aria-label="Shop">
        <svg class="tab-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
          <line x1="3" y1="6" x2="21" y2="6"></line>
          <path d="M16 10a4 4 0 0 1-8 0"></path>
        </svg>
        <span class="tab-label-text">Shop</span>
      </button>

      <!-- Hairline Vertical Divider -->
      <div class="capsule-divider"></div>

      <!-- Orders Tab (Delivery Concierge & Real-time Orders) -->
      <button class="capsule-tab-item" data-tab="orders" aria-label="Orders">
        <svg class="tab-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
          <polyline points="14 2 14 8 20 8"></polyline>
          <line x1="16" y1="13" x2="8" y2="13"></line>
          <line x1="16" y1="17" x2="8" y2="17"></line>
          <polyline points="10 9 9 9 8 9"></polyline>
        </svg>
        <span class="tab-label-text">Orders</span>
      </button>

      <!-- Hairline Vertical Divider -->
      <div class="capsule-divider"></div>

      <!-- Wholesale Tab (B2B Boutique & Commercial Partner Lounge) -->
      <button class="capsule-tab-item" data-tab="wholesale" aria-label="Wholesale">
        <svg class="tab-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
          <path d="M3 3h18v4H3z"></path>
          <path d="M3 7v14h18V7"></path>
          <path d="M9 21v-8h6v8"></path>
        </svg>
        <span class="tab-label-text">Wholesale</span>
      </button>

    </nav>

  </main> <!-- /app-container -->

  <!-- ==========================================================================
       MODAL 1: PRODUCT DETAILS BOTTOM SHEET
       ========================================================================== -->
  <div class="glass-sheet-backdrop" id="productSheetBackdrop" onclick="if(event.target === this) this.classList.remove('active');">
    <div class="glass-sheet-panel">
      <!-- Drag handle -->
      <div class="sheet-handle-pill" id="productSheetClose" style="cursor:pointer;" title="Drag down or tap to close"></div>

      <!-- Dedicated Modal Header Bar with Title & High-Contrast Cancel X Button -->
      <div class="modal-header-bar">
        <div class="modal-header-title-box">
          <div style="font-size:10px; font-weight:700; text-transform:uppercase; letter-spacing:0.08em; color:#9A7B35;">Marity Trade</div>
          <h3 class="modal-header-title" id="modalTopHeaderTitle">Ocean Breeze</h3>
        </div>
        <button class="modal-close-cancel-btn" onclick="document.getElementById('productSheetBackdrop').classList.remove('active')" aria-label="Close Product Details" title="Cancel & Close">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
      </div>

      <div class="product-detail-content">
        <!-- Gallery Stage -->
        <div class="gallery-stage">
          <img class="gallery-main-img" id="modalDetailMainImg" src="assets/product_ocean_breeze.png" alt="Detail View" />
          <!-- Live Cap Engraving Preview Overlay -->
          <div class="engraving-cap-preview" id="capEngravingPreview"></div>
        </div>

        <!-- Thumbnail Row -->
        <div class="gallery-thumbs-row" id="modalDetailThumbs"></div>

        <!-- Meta Header -->
        <div class="detail-header-meta">
          <div>
            <div class="detail-brand" id="modalDetailBrand">Marity Trade</div>
            <h2 class="detail-title" id="modalDetailTitle">Ocean Breeze</h2>
            <div style="font-size:12px; color:#64748B; font-style:italic;" id="modalDetailSubtitle">L'Onde Azurée</div>
          </div>
          <div class="detail-stock-badge">
            <span class="stock-dot-pulse"></span>
            In Stock
          </div>
        </div>

        <div class="detail-rating-row">
          <span class="rating-stars-gold">★★★★★</span>
          <span id="modalDetailRating">4.9 ★ (342 verified reviews)</span>
        </div>

        <!-- Price in Ghana Cedi -->
        <div class="detail-price-row">
          <div class="detail-price" id="modalDetailPrice">GH₵129.00</div>
          <div style="font-size:11px; color:#64748B;">Delivery within 12 to 24 hours • Gift Box Included</div>
        </div>

        <!-- Bottle Size Selector -->
        <div class="size-selector-block">
          <div class="selector-label">
            <span>Select Flacon Volume</span>
            <span style="font-weight:400; color:#64748B; text-transform:none;">Pure Extrait Dilution</span>
          </div>
          <div class="size-chips-grid" id="modalDetailSizes"></div>
        </div>

        <!-- Description -->
        <div style="margin-bottom:20px;">
          <div class="selector-label">Olfactory Vision</div>
          <p style="font-size:12.5px; line-height:1.55; color:#4A5568;" id="modalDetailDesc"></p>
        </div>

        <!-- Olfactory Pyramid -->
        <div class="pyramid-block">
          <div class="pyramid-title">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2L2 22h20L12 2z"></path></svg>
            Olfactory Pyramid
          </div>
          <div class="note-tier">
            <div class="note-tier-label">Head / Top Notes</div>
            <div style="font-size:12px; color:#11151F;" id="modalNotesTop">Calabrian Bergamot • Sea Salt</div>
          </div>
          <div class="note-tier">
            <div class="note-tier-label">Heart / Core Notes</div>
            <div style="font-size:12px; color:#11151F;" id="modalNotesHeart">French Clary Sage • Maritime Accord</div>
          </div>
          <div class="note-tier">
            <div class="note-tier-label">Soul / Base Notes</div>
            <div style="font-size:12px; color:#11151F;" id="modalNotesBase">Gray Ambergris • White Cedar</div>
          </div>
        </div>

        <!-- Scent Longevity & Sillage Meters -->
        <div style="background:rgba(255,255,255,0.6); border-radius:18px; padding:14px; margin-bottom:20px; font-size:12px;">
          <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
            <span style="color:#64748B;">Longevity on Skin:</span>
            <strong id="modalDetailLongevity">12+ Hours</strong>
          </div>
          <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
            <span style="color:#64748B;">Sillage & Projection:</span>
            <strong id="modalDetailSillage">Strong & Radiating</strong>
          </div>
          <div style="display:flex; justify-content:space-between;">
            <span style="color:#64748B;">Ideal Season:</span>
            <strong id="modalDetailSeason">All Year Signature</strong>
          </div>
        </div>

        <!-- Custom Flacon Engraving -->
        <div class="engraving-box">
          <div style="display:flex; justify-content:space-between; align-items:center;">
            <span style="font-size:12px; font-weight:700; color:#11151F;">Custom Flacon Engraving</span>
            <span class="badge-champagne" style="font-size:9px;">Optional</span>
          </div>
          <p style="font-size:11px; color:#64748B; margin-top:4px;">Diamond-tool custom initials engraved on the 24k gold cap:</p>
          <div class="engraving-input-row">
            <input type="text" id="engravingTextInput" class="engraving-input" placeholder="e.g. J.L." maxlength="4" oninput="window.appHandleEngravingInput(this.value)" />
          </div>
        </div>

        <!-- CTA Action Bar -->
        <div class="detail-cta-bar">
          <div class="qty-counter">
            <button class="qty-btn" onclick="window.appAdjustDetailQty(-1)">-</button>
            <span class="qty-num" id="detailQtyDisplay">1</span>
            <button class="qty-btn" onclick="window.appAdjustDetailQty(1)">+</button>
          </div>

          <button class="btn-metallic-pill detail-add-bag-btn" onclick="window.appDetailAddToBag()">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path><line x1="3" y1="6" x2="21" y2="6"></line><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
            <span id="modalAddBagBtnText">Add to Bag • GH₵129.00</span>
          </button>
        </div>

        <!-- AI Consultation Link -->
        <div style="text-align:center; margin-top:12px;">
          <button type="button" onclick="window.appOpenAiChat('product')" style="background:none; border:none; color:#9A7B35; font-size:11.5px; font-weight:600; cursor:pointer; display:inline-flex; align-items:center; gap:5px;">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
            Ask AI Fragrance Advisor about this scent
          </button>
        </div>

      </div>
    </div>
  </div>

  <!-- ==========================================================================
       MODAL 2: SHOPPING BAG / CART SLIDE-OVER DRAWER
       ========================================================================== -->
  <div class="glass-sheet-backdrop" id="cartDrawerBackdrop" onclick="if(event.target === this) this.classList.remove('active');">
    <div class="glass-sheet-panel">
      <!-- Drag handle -->
      <div class="sheet-handle-pill" id="cartDrawerClose" style="cursor:pointer;" title="Tap to close"></div>

      <!-- Dedicated Modal Header Bar with Title & High-Contrast Cancel X Button -->
      <div class="modal-header-bar">
        <div class="modal-header-title-box">
          <h3 class="modal-header-title">Shopping Bag</h3>
          <span class="modal-header-subtitle">Curated Luxury Selection</span>
        </div>
        <button class="modal-close-cancel-btn" onclick="document.getElementById('cartDrawerBackdrop').classList.remove('active')" aria-label="Close Shopping Bag" title="Cancel & Close">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
      </div>

      <div class="cart-drawer-content">

        <!-- Free Delivery Progress Bar -->
        <div class="free-shipping-bar-box">
          <div style="font-size:11.5px; color:#334155;" id="freeShippingBarMsg">
            Add <strong>GH₵21.00</strong> more for Free Delivery within 12 to 24 hours.
          </div>
          <div class="shipping-bar-track">
            <div class="shipping-bar-fill" id="freeShippingBarFill" style="width: 86%;"></div>
          </div>
        </div>

        <!-- Cart Items List Container -->
        <div id="cartItemsList"></div>

        <!-- Restyled Compact Luxury Promo Capsule -->
        <div class="promo-capsule-box">
          <div class="promo-input-capsule">
            <svg class="promo-icon-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path>
              <line x1="7" y1="7" x2="7.01" y2="7"></line>
            </svg>
            <input type="text" id="cartPromoInput" class="promo-input" placeholder="Promo code" maxlength="15" autocomplete="off" autocapitalize="characters" />
            <button class="btn-promo-apply" onclick="window.appApplyPromo()" aria-label="Apply Promo Code">Apply</button>
          </div>
          <div id="cartPromoStatus" class="promo-status-badge"></div>
        </div>

        <!-- Restyled Luxury Cart Summary Receipt in Ghana Cedi -->
        <div class="cart-summary-block">
          <div class="summary-row">
            <span class="summary-label">Subtotal</span>
            <span class="summary-val" id="cartSubtotalDisplay">GH₵268.00</span>
          </div>
          <div class="summary-row" id="cartDiscountRow">
            <span class="summary-label">Privilège Discount</span>
            <span class="summary-val discount-val" id="cartDiscountDisplay">GH₵0.00</span>
          </div>
          <div class="summary-row">
            <span class="summary-label">
              Express Delivery
              <span class="delivery-time-pill">12–24h</span>
            </span>
            <span class="summary-val" id="cartShippingDisplay"><span class="badge-free-delivery">Free</span></span>
          </div>
          <div class="summary-row">
            <span class="summary-label">VAT / Tax (8%)</span>
            <span class="summary-val" id="cartTaxDisplay">GH₵21.44</span>
          </div>
          <div class="summary-divider"></div>
          <div class="summary-row total-row">
            <div class="total-label-box">
              <span class="total-title">Estimated Total</span>
              <span class="total-sub">All taxes & white-glove dispatch included</span>
            </div>
            <span class="total-amount" id="cartTotalDisplay">GH₵289.44</span>
          </div>
        </div>

        <!-- Checkout Trigger Button -->
        <button class="btn-metallic-pill" id="cartCheckoutBtn" style="width:100%; padding:14px; font-size:14px; font-weight:600;" onclick="window.appOpenCheckout()">
          Proceed to Checkout
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
        </button>

      </div>
    </div>
  </div>

  <!-- ==========================================================================
       MODAL 3: MULTI-STEP LUXURY CHECKOUT MODAL
       ========================================================================== -->
  <div class="glass-sheet-backdrop" id="checkoutModalBackdrop" onclick="if(event.target === this) this.classList.remove('active');">
    <div class="glass-sheet-panel">
      <!-- Drag handle -->
      <div class="sheet-handle-pill" id="checkoutModalClose" style="cursor:pointer;" title="Tap to close"></div>

      <!-- Dedicated Modal Header Bar with Title & High-Contrast Cancel X Button -->
      <div class="modal-header-bar">
        <div class="modal-header-title-box">
          <h3 class="modal-header-title">Checkout</h3>
          <span class="modal-header-subtitle">White Glove Settlement</span>
        </div>
        <button class="modal-close-cancel-btn" onclick="document.getElementById('checkoutModalBackdrop').classList.remove('active')" aria-label="Close Checkout" title="Cancel & Close">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
      </div>

      <div style="padding: 10px 20px 24px 20px; overflow-y:auto; max-height:75vh;">
        
        <!-- Step Indicators -->
        <div class="checkout-steps-nav">
          <span class="step-indicator active">1. Address</span>
          <span class="step-indicator">2. Delivery</span>
          <span class="step-indicator">3. Payment</span>
          <span class="step-indicator">4. Receipt</span>
        </div>

        <!-- Step 1: Shipping Address Form -->
        <div class="checkout-step-body active" id="checkoutStep1">
          <h4 style="font-family:var(--font-serif); font-size:18px; margin-bottom:14px;">Delivery Destination</h4>
          
          <div class="form-group">
            <label class="form-label">Full Name</label>
            <input type="text" id="checkoutName" class="form-input" value="Alexandre Laurent" />
          </div>

          <div class="form-group">
            <label class="form-label">Street Address</label>
            <input type="text" id="checkoutStreet" class="form-input" value="14 Place Vendôme" />
          </div>

          <div class="form-row-2col">
            <div class="form-group">
              <label class="form-label">City</label>
              <input type="text" id="checkoutCity" class="form-input" value="Accra" />
            </div>
            <div class="form-group">
              <label class="form-label">Postal Code / Region</label>
              <input type="text" id="checkoutZip" class="form-input" value="GA-182" />
            </div>
          </div>

          <div class="form-group">
            <label class="form-label">Country / Territory</label>
            <input type="text" id="checkoutCountry" class="form-input" value="Ghana" />
          </div>

          <button class="btn-metallic-pill" style="width:100%; margin-top:10px; padding:12px;" onclick="window.appNextCheckoutStep(1)">
            Continue to Delivery Method
          </button>
        </div>

        <!-- Step 2: Shipping Method -->
        <div class="checkout-step-body" id="checkoutStep2">
          <h4 style="font-family:var(--font-serif); font-size:18px; margin-bottom:14px;">Select Courier Experience</h4>

          <label style="display:block; background:rgba(255,255,255,0.85); border:1px solid rgba(226,232,240,0.8); border-radius:16px; padding:14px; margin-bottom:10px; cursor:pointer;">
            <input type="radio" name="shippingTier" value="express" checked />
            <strong style="margin-left:6px; font-size:13px;">White Glove Express Dispatch</strong>
            <div style="font-size:11px; color:#64748B; margin-left:24px;">Delivery within 12 to 24 hours • Insurance & Tracking Included</div>
          </label>

          <label style="display:block; background:rgba(255,255,255,0.85); border:1px solid rgba(226,232,240,0.8); border-radius:16px; padding:14px; margin-bottom:18px; cursor:pointer;">
            <input type="radio" name="shippingTier" value="white-glove" />
            <strong style="margin-left:6px; font-size:13px;">VIP Concierge Delivery</strong>
            <div style="font-size:11px; color:#64748B; margin-left:24px;">Hand-delivered in velvet casing with climate-controlled courier</div>
          </label>

          <button class="btn-metallic-pill" style="width:100%; padding:12px;" onclick="window.appNextCheckoutStep(2)">
            Continue to Payment
          </button>
        </div>

        <!-- Step 3: Payment Options -->
        <div class="checkout-step-body" id="checkoutStep3">
          <h4 style="font-family:var(--font-serif); font-size:18px; margin-bottom:14px;">Secure Settlement</h4>

          <!-- One-Tap Simulated Apple Pay / Mobile Money -->
          <div class="apple-pay-box" onclick="window.appCompletePayment('apple-pay')">
            <div style="font-size:18px; font-weight:700;">Pay • Mobile Money</div>
            <div style="font-size:10.5px; color:#A0AEC0; margin-top:3px;">One-tap instant settlement</div>
          </div>

          <div style="text-align:center; font-size:11px; color:#64748B; margin:10px 0;">— OR PAY WITH CLIENT CARD —</div>

          <div style="background:rgba(255,255,255,0.85); border:1px solid rgba(226,232,240,0.8); border-radius:16px; padding:14px; margin-bottom:16px;">
            <div class="form-group">
              <label class="form-label">Cardholder Name</label>
              <input type="text" class="form-input" value="Alexandre Laurent" />
            </div>
            <div class="form-group">
              <label class="form-label">Card Number</label>
              <input type="text" class="form-input" value="•••• •••• •••• 8492" />
            </div>
            <div class="form-row-2col">
              <div class="form-group">
                <label class="form-label">Expiry</label>
                <input type="text" class="form-input" value="11/28" />
              </div>
              <div class="form-group">
                <label class="form-label">CVC</label>
                <input type="text" class="form-input" value="•••" />
              </div>
            </div>
          </div>

          <button class="btn-metallic-pill" id="paySubmitBtn" style="width:100%; padding:13px;" onclick="window.appCompletePayment('card')">
            Authorize Payment • <span id="checkoutSummaryTotal">GH₵289.44</span>
          </button>
        </div>

        <!-- Step 4: Order Confirmed Receipt -->
        <div class="checkout-step-body" id="checkoutStep4">
          <div style="text-align:center; padding:10px 0 20px 0;">
            <div style="width:54px; height:54px; border-radius:50%; background:var(--c-champagne-gold); color:#11151F; font-size:24px; font-weight:700; display:flex; align-items:center; justify-content:center; margin:0 auto 12px auto; box-shadow:0 6px 20px rgba(212,175,55,0.4);">✓</div>
            <h3 style="font-family:var(--font-serif); font-size:22px; margin-bottom:4px;">Grand Flacon Confirmed</h3>
            <p style="font-size:12px; color:#64748B;">Your bespoke order has been registered at our atelier.</p>
          </div>

          <div style="background:rgba(255,255,255,0.85); border:1px solid rgba(226,232,240,0.8); border-radius:18px; padding:16px; margin-bottom:18px; font-size:12.5px;">
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span style="color:#64748B;">Order Reference:</span>
              <strong id="confirmOrderRef">#MR-2026-9482</strong>
            </div>
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span style="color:#64748B;">Estimated Delivery:</span>
              <strong id="confirmEta">Delivery within 12 to 24 hours</strong>
            </div>
            <div style="display:flex; justify-content:space-between;">
              <span style="color:#64748B;">Settlement Amount:</span>
              <strong id="confirmTotal">GH₵289.44</strong>
            </div>
          </div>

          <button class="btn-metallic-pill" style="width:100%; padding:13px;" onclick="window.appFinishAndTrack()">
            Track Dispatch in Delivery Concierge
          </button>
        </div>

      </div>
    </div>
  </div>

  <!-- ==========================================================================
       MODAL 4: SCENT FINDER QUIZ MODAL
       ========================================================================== -->
  <div class="glass-sheet-backdrop" id="scentQuizBackdrop" onclick="if(event.target === this) this.classList.remove('active');">
    <div class="glass-sheet-panel">
      <!-- Drag handle -->
      <div class="sheet-handle-pill" id="scentQuizClose" style="cursor:pointer;" title="Tap to close"></div>

      <!-- Dedicated Modal Header Bar with Title & High-Contrast Cancel X Button -->
      <div class="modal-header-bar">
        <div class="modal-header-title-box">
          <h3 class="modal-header-title">Fragrance Finder</h3>
          <span class="modal-header-subtitle">Find Your Signature Scent</span>
        </div>
        <button class="modal-close-cancel-btn" onclick="document.getElementById('scentQuizBackdrop').classList.remove('active')" aria-label="Close Quiz" title="Cancel & Close">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
      </div>

      <div style="padding:14px 20px 24px 20px;">
        <p style="font-size:11.5px; color:#64748B; margin-bottom:16px;">Answer 3 brief questions to determine your signature fragrance chord.</p>

        <div style="margin-bottom:14px;">
          <div style="font-size:11.5px; font-weight:700; text-transform:uppercase; color:#4A5568; margin-bottom:8px;">1. Desired Atmosphere</div>
          <div style="display:grid; grid-template-columns:1fr 1fr; gap:8px;">
            <label style="padding:10px; background:#FFF; border:1px solid #E2E8F0; border-radius:12px; font-size:11.5px; cursor:pointer;">
              <input type="radio" name="quizMood" value="daily" checked /> Oceanic Crispness
            </label>
            <label style="padding:10px; background:#FFF; border:1px solid #E2E8F0; border-radius:12px; font-size:11.5px; cursor:pointer;">
              <input type="radio" name="quizMood" value="sensual" /> Velvety Rose Petals
            </label>
            <label style="padding:10px; background:#FFF; border:1px solid #E2E8F0; border-radius:12px; font-size:11.5px; cursor:pointer;">
              <input type="radio" name="quizMood" value="evening" /> Smoked Nighttime Oud
            </label>
            <label style="padding:10px; background:#FFF; border:1px solid #E2E8F0; border-radius:12px; font-size:11.5px; cursor:pointer;">
              <input type="radio" name="quizMood" value="regal" /> Aged Amber Royal Cru
            </label>
          </div>
        </div>

        <button class="btn-metallic-pill" style="width:100%; margin-top:10px; padding:12px;" onclick="window.appSubmitScentQuiz()">
          Reveal My Signature Flacon
        </button>
      </div>
    </div>
  </div>

  <!-- ==========================================================================
       MODAL 5: INSTANT LIVE SEARCH OVERLAY
       ========================================================================== -->
  <div class="glass-sheet-backdrop" id="searchOverlayBackdrop" onclick="if(event.target === this) this.classList.remove('active');">
    <div class="glass-sheet-panel" style="max-height:85vh;">
      <div class="sheet-handle-pill" id="searchOverlayClose" style="cursor:pointer;" title="Tap to close"></div>

      <div class="search-overlay-header">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#9A7B35" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
        <input type="text" id="searchQueryInput" class="search-input-field" placeholder="Search by name, note, or concentration..." autofocus />
        <button class="modal-close-cancel-btn" onclick="document.getElementById('searchOverlayBackdrop').classList.remove('active')" aria-label="Close Search" title="Cancel & Close" style="width:34px; height:34px; min-width:34px; min-height:34px;">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
      </div>

      <!-- Quick Search Chips -->
      <div class="search-quick-tags">
        <span class="search-quick-tag" onclick="window.appSearchTag('Ocean Breeze')">Ocean Breeze</span>
        <span class="search-quick-tag" onclick="window.appSearchTag('Velvet Bloom')">Velvet Bloom</span>
        <span class="search-quick-tag" onclick="window.appSearchTag('Amber')">Amber</span>
        <span class="search-quick-tag" onclick="window.appSearchTag('Oud')">Oud</span>
        <span class="search-quick-tag" onclick="window.appSearchTag('Rose')">Rose</span>
        <span class="search-quick-tag" onclick="window.appSearchTag('Extrait')">Extrait</span>
      </div>

      <div class="search-results-list" id="searchResultsContainer"></div>
    </div>
  </div>

  <!-- ==========================================================================
       FLOATING LUXURY AI CONCIERGE FAB (VISIBLE ON ALL SCREENS)
       ========================================================================== -->
  <button class="floating-ai-concierge-fab" id="floatingAiFab" onclick="window.appOpenAiChat()" aria-label="Marity Concierge" title="Customer Support & Orders">
    <div class="fab-icon-box">
      <svg class="fab-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
        <circle cx="9" cy="10" r="1" fill="currentColor"></circle>
        <circle cx="12" cy="10" r="1" fill="currentColor"></circle>
        <circle cx="15" cy="10" r="1" fill="currentColor"></circle>
      </svg>
      <span class="fab-pulse-dot"></span>
    </div>
  </button>

  <!-- ==========================================================================
       MODAL 6: MARITY CUSTOMER & ORDER ASSISTANT
       ========================================================================== -->
  <div class="glass-sheet-backdrop" id="aiChatModalBackdrop" onclick="if(event.target === this) window.appCloseAiChat();">
    <div class="glass-sheet-panel ai-chat-panel">
      <!-- Drag handle -->
      <div class="sheet-handle-pill" onclick="window.appCloseAiChat()" style="cursor:pointer;" title="Tap to close"></div>

      <!-- Dedicated Modal Header Bar with Title & High-Contrast Cancel X Button -->
      <div class="modal-header-bar ai-chat-header-bar">
        <div class="ai-header-profile">
          <div class="ai-avatar-badge">
            <span class="ai-avatar-monogram">M</span>
            <span class="ai-status-indicator"></span>
          </div>
          <div class="modal-header-title-box">
            <h3 class="modal-top-headline" style="margin:0; font-size:16px; font-weight:700; color:#11151F;">Marity Assistant</h3>
            <p class="modal-top-subheadline" style="margin:2px 0 0 0; font-size:12px; color:#64748B; display:flex; align-items:center; gap:5px;">
              <span style="width:6px; height:6px; border-radius:50%; background:#22C55E; display:inline-block;"></span>
              Customer Support & Orders • Online
            </p>
          </div>
        </div>
        <button class="modal-close-cancel-btn" onclick="window.appCloseAiChat()" aria-label="Close Chat" title="Close">✕</button>
      </div>

      <!-- Quick Action Prompt Chips (Horizontally Scrollable) -->
      <div class="ai-quick-chips-row">
        <button class="ai-chip-btn" onclick="window.appAiSendPreset('Find best seller fragrances')">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
          Find Fragrance
        </button>
        <button class="ai-chip-btn" onclick="window.appAiSendPreset('Show fragrances under GH₵150')">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
          Under GH₵150
        </button>
        <button class="ai-chip-btn" onclick="window.appAiSendPreset('Track my order #MR-2026-9482')">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="3" width="15" height="13"></rect><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon><circle cx="5.5" cy="18.5" r="2.5"></circle><circle cx="18.5" cy="18.5" r="2.5"></circle></svg>
          Track Order
        </button>
        <button class="ai-chip-btn" onclick="window.appAiSendPreset('Contact boutique admin')">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
          Contact Admin
        </button>
      </div>

      <!-- Chat Messages Scroll Container -->
      <div class="ai-chat-messages-container" id="aiChatMessages">
        <!-- Rendered dynamically via JavaScript -->
      </div>

      <!-- Chat Input Bar -->
      <div class="ai-chat-input-bar">
        <form class="ai-input-form" onsubmit="event.preventDefault(); window.appAiSubmit();">
          <input type="text" id="aiChatInput" class="ai-chat-input" placeholder="Ask about scents, orders, or admin..." autocomplete="off" />
          <button type="submit" class="ai-chat-send-btn" aria-label="Send message">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
              <line x1="22" y1="2" x2="11" y2="13"></line>
              <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
            </svg>
          </button>
        </form>
      </div>
    </div>
  </div>

  <!-- ==========================================================================
       TOAST FEEDBACK PILL
       ========================================================================== -->
  <div class="toast-container">
    <div class="toast-pill" id="toastPill">
      <span class="toast-gold-check">✦</span>
      <span id="toastMessage">Added to your luxury bag</span>
    </div>
  </div>

  <!-- Global Application Scripts -->
  <script src="js/products.js"></script>
  <script src="js/store.js"></script>
  <script src="js/app.js"></script>

</body>
</html>

