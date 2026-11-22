/**
 * MARITY TRADE — MAIN APPLICATION CONTROLLER
 * Ultra-clean, premium mobile commerce engine.
 * Orchestrates navigation, product gallery, cart, wishlist, checkout, orders,
 * search, scent finder quiz, and B2B wholesale trade portal.
 * Currency: Ghanaian Cedi (GH₵)
 */

document.addEventListener('DOMContentLoaded', () => {
  // DOM element cache
  const elements = {
    // Header
    headerBagBtn: document.getElementById('headerBagBtn'),
    bagCountBadge: document.getElementById('bagCountBadge'),
    headerWishlistBtn: document.getElementById('headerWishlistBtn'),
    wishlistCountBadge: document.getElementById('wishlistCountBadge'),
    headerSearchBtn: document.getElementById('headerSearchBtn'),

    // Bottom Navigation Tabs
    navTabs: document.querySelectorAll('.capsule-tab-item, .nav-tab-btn'),
    views: document.querySelectorAll('.view-container'),

    // Grids & Sections
    bestsellersGrid: document.getElementById('bestsellersGrid'),
    shopGrid: document.getElementById('shopGrid'),
    wishlistGrid: document.getElementById('wishlistGrid'),
    ordersList: document.getElementById('ordersList'),
    categoryPods: document.querySelectorAll('.cat-pod-item'),
    shopFilterPills: document.querySelectorAll('.filter-pill'),

    // Hero Carousel
    heroSlides: document.querySelectorAll('.hero-slide'),
    heroIndicators: document.querySelectorAll('.indicator-dot'),

    // Modals & Sheets
    productSheetBackdrop: document.getElementById('productSheetBackdrop'),
    productSheetClose: document.getElementById('productSheetClose'),
    cartDrawerBackdrop: document.getElementById('cartDrawerBackdrop'),
    cartDrawerClose: document.getElementById('cartDrawerClose'),
    cartItemsList: document.getElementById('cartItemsList'),
    checkoutModalBackdrop: document.getElementById('checkoutModalBackdrop'),
    checkoutModalClose: document.getElementById('checkoutModalClose'),
    searchOverlayBackdrop: document.getElementById('searchOverlayBackdrop'),
    searchOverlayClose: document.getElementById('searchOverlayClose'),
    scentQuizBackdrop: document.getElementById('scentQuizBackdrop'),
    scentQuizClose: document.getElementById('scentQuizClose'),

    // Feedback Toast
    toastPill: document.getElementById('toastPill'),
    toastMessage: document.getElementById('toastMessage')
  };

  // State variables
  let currentHeroSlide = 0;
  let heroCarouselTimer = null;
  let selectedDetailProduct = null;
  let selectedDetailSize = '100ml';
  let selectedDetailQty = 1;
  let checkoutCurrentStep = 1;
  let wholesaleCart = {}; // { [productId]: numberOfCases }

  // Initialize
  initApp();

  function initApp() {
    dismissSplashLoader();
    setupHeroCarousel();
    renderBestsellers();
    renderShopView('all');
    renderWishlistView();
    renderOrdersView();
    updateBadgesAndCartTotals();
    setupEventListeners();
    setupStoreSubscription();
  }

  // --- SPLASH LOADER DISMISSAL ---
  function dismissSplashLoader() {
    setTimeout(() => {
      const splash = document.getElementById('appSplashLoader');
      if (splash) {
        splash.classList.add('fade-out');
        setTimeout(() => {
          splash.style.display = 'none';
        }, 600);
      }
    }, 650);
  }

  // --- STORE SUBSCRIPTION ---
  function setupStoreSubscription() {
    fragranceStore.subscribe(state => {
      updateBadgesAndCartTotals();
      renderWishlistView();
      renderOrdersView();
      renderCartDrawer();
    });
  }

  function showToast(message) {
    if (!elements.toastPill) return;
    elements.toastMessage.textContent = message;
    elements.toastPill.classList.add('active');
    setTimeout(() => {
      elements.toastPill.classList.remove('active');
    }, 2200);
  }
  window.appShowToast = showToast;

  function updateBadgesAndCartTotals() {
    const totals = fragranceStore.getCartTotals();
    const wishlistCount = fragranceStore.state.wishlist.length;

    if (elements.bagCountBadge) {
      elements.bagCountBadge.textContent = totals.itemCount;
      elements.bagCountBadge.style.display = totals.itemCount > 0 ? 'flex' : 'none';
    }

    if (elements.wishlistCountBadge) {
      elements.wishlistCountBadge.textContent = wishlistCount;
      elements.wishlistCountBadge.style.display = wishlistCount > 0 ? 'flex' : 'none';
    }

    const navWishlistBadge = document.getElementById('navWishlistBadge');
    if (navWishlistBadge) {
      navWishlistBadge.style.display = wishlistCount > 0 ? 'block' : 'none';
    }
  }

  // --- HERO CAROUSEL ---
  function setupHeroCarousel() {
    if (!elements.heroSlides || elements.heroSlides.length === 0) return;

    function showSlide(index) {
      elements.heroSlides.forEach((slide, i) => {
        slide.classList.toggle('active', i === index);
      });
      elements.heroIndicators.forEach((dot, i) => {
        dot.classList.toggle('active', i === index);
      });
      currentHeroSlide = index;
    }

    elements.heroIndicators.forEach((dot, idx) => {
      dot.addEventListener('click', () => {
        showSlide(idx);
        resetHeroTimer();
      });
    });

    function nextSlide() {
      const next = (currentHeroSlide + 1) % elements.heroSlides.length;
      showSlide(next);
    }

    function resetHeroTimer() {
      clearInterval(heroCarouselTimer);
      heroCarouselTimer = setInterval(nextSlide, 6000);
    }

    resetHeroTimer();
  }

  // --- PRODUCT RENDERING ---
  function createProductCardHTML(product) {
    const isWishlisted = fragranceStore.isInWishlist(product.id);
    const badgeHTML = product.tag === 'Bestseller'
      ? `<span class="badge-champagne">Bestseller</span>`
      : product.tag === 'New'
        ? `<span class="badge-champagne">New</span>`
        : `<span class="badge-pearl">${product.tag}</span>`;

    return `
      <div class="glass-product-card" data-product-id="${product.id}">
        <div class="card-top-row">
          ${badgeHTML}
          <button class="card-wishlist-btn ${isWishlisted ? 'active' : ''}" data-wishlist-id="${product.id}" aria-label="Save to Wishlist">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
            </svg>
          </button>
        </div>

        <div class="card-img-stage" onclick="window.appOpenProductDetail('${product.id}')">
          <img src="${product.images.primary}" alt="${product.name}" loading="lazy" />
        </div>

        <div class="card-meta" onclick="window.appOpenProductDetail('${product.id}')">
          <div class="card-title">${product.name}</div>
          <div class="card-spec">${product.concentrationBadge}</div>
          <div class="card-price">GH₵${product.basePrice.toFixed(2)}</div>
        </div>

        <button class="btn-metallic-pill card-add-btn" data-add-to-cart="${product.id}">
          <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
            <line x1="3" y1="6" x2="21" y2="6"></line>
            <path d="M16 10a4 4 0 0 1-8 0"></path>
          </svg>
          Add to Cart
        </button>
      </div>
    `;
  }

  function renderBestsellers() {
    if (!elements.bestsellersGrid) return;
    const bestsellers = PRODUCTS.slice(0, 4);
    elements.bestsellersGrid.innerHTML = bestsellers.map(createProductCardHTML).join('');
    attachCardListeners(elements.bestsellersGrid);
  }

  function renderShopView(category = 'all') {
    if (!elements.shopGrid) return;
    let list = PRODUCTS;
    if (category !== 'all') {
      list = PRODUCTS.filter(p => p.category === category);
    }
    elements.shopGrid.innerHTML = list.map(createProductCardHTML).join('');
    attachCardListeners(elements.shopGrid);
  }

  function renderWishlistView() {
    if (!elements.wishlistGrid) return;
    const wishlistedIds = fragranceStore.state.wishlist;
    const wishlistedProducts = PRODUCTS.filter(p => wishlistedIds.includes(p.id));

    if (wishlistedProducts.length === 0) {
      elements.wishlistGrid.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 48px 20px; background: rgba(255,255,255,0.7); border-radius: 24px; border: 1px solid rgba(255,255,255,0.9);">
          <div style="font-size: 30px; margin-bottom: 12px; color: #CBD5E1;">✦</div>
          <h3 style="font-family: var(--font-serif); font-size: 20px; margin-bottom: 6px;">Your Wishlist is Empty</h3>
          <p style="font-size: 12px; color: #64748B; max-width: 260px; margin: 0 auto 18px auto;">Curate your private selection of signature flacons.</p>
          <button class="btn-metallic-pill" onclick="window.appSwitchTab('shop')">Explore Collection</button>
        </div>
      `;
      return;
    }

    elements.wishlistGrid.innerHTML = wishlistedProducts.map(createProductCardHTML).join('');
    attachCardListeners(elements.wishlistGrid);
  }

  function renderOrdersView() {
    if (!elements.ordersList) return;
    const orders = fragranceStore.state.orders;

    if (orders.length === 0) {
      elements.ordersList.innerHTML = `
        <div style="text-align: center; padding: 40px 20px; background: rgba(255,255,255,0.7); border-radius: 24px;">
          <h3 style="font-family: var(--font-serif); font-size: 18px;">No Active Orders</h3>
          <p style="font-size: 12px; color: #64748B; margin-top: 6px;">Your dispatched luxury flacons and tracking details will appear here.</p>
        </div>
      `;
      return;
    }

    elements.ordersList.innerHTML = orders.map(order => {
      const step1Done = order.statusStep >= 1;
      const step2Done = order.statusStep >= 2;
      const step3Done = order.statusStep >= 3;
      const step4Done = order.statusStep >= 4;

      return `
        <div class="order-card-luxury">
          <div class="order-header-row">
            <div>
              <div class="order-ref">${order.id}</div>
              <div class="order-date">${order.date} • ${order.carrier}</div>
            </div>
            <span class="badge-champagne">${order.status}</span>
          </div>

          <div style="font-size: 11.5px; color: #334155; margin-bottom: 12px; background: rgba(255,255,255,0.85); padding: 8px 12px; border-radius: 12px; display:flex; justify-content:space-between; align-items:center;">
            <span>Tracking: <strong>${order.trackingNumber}</strong></span>
            <button onclick="navigator.clipboard.writeText('${order.trackingNumber}'); window.appShowToast('Tracking code copied');" style="background:none; border:none; color:var(--c-champagne-gold-dark); font-weight:700; font-size:11px; cursor:pointer;">Copy</button>
          </div>

          <div class="tracking-stepper">
            <div class="tracking-step ${step1Done ? (order.statusStep === 1 ? 'current' : 'done') : ''}">
              <div class="step-bullet">${step1Done ? '✓' : '1'}</div>
              <div>
                <div class="step-info-title">Order Authenticated & Hand-Poured</div>
                <div class="step-info-desc">Atelier in Grasse, France • Verified Formula</div>
              </div>
            </div>

            <div class="tracking-step ${step2Done ? (order.statusStep === 2 ? 'current' : 'done') : ''}">
              <div class="step-bullet">${step2Done ? '✓' : '2'}</div>
              <div>
                <div class="step-info-title">Custom Monogram Cap Engraving</div>
                <div class="step-info-desc">Precision diamond tool gold-plate engraving</div>
              </div>
            </div>

            <div class="tracking-step ${step3Done ? (order.statusStep === 3 ? 'current' : 'done') : ''}">
              <div class="step-bullet">${step3Done ? '✓' : '3'}</div>
              <div>
                <div class="step-info-title">White Glove Quality Assurance & Wax Seal</div>
                <div class="step-info-desc">Inspected for clarity, hermeticity & packaging</div>
              </div>
            </div>

            <div class="tracking-step ${step4Done ? (order.statusStep === 4 ? 'current' : 'done') : ''}">
              <div class="step-bullet">${step4Done ? '✓' : '4'}</div>
              <div>
                <div class="step-info-title">Dispatched via Express Delivery</div>
                <div class="step-info-desc">Estimated Arrival: ${order.eta || 'Delivery within 12 to 24 hours'}</div>
              </div>
            </div>
          </div>

          <div style="border-top: 1px solid rgba(226,232,240,0.8); padding-top: 10px; margin-top: 12px; display: flex; justify-content: space-between; align-items: center;">
            <div style="font-size: 12px; color: #64748B;">Total Paid: <strong>GH₵${order.total.toFixed(2)}</strong> (${order.items.length} item)</div>
            <button class="btn-pearl-pill" onclick="window.appOpenReceipt('${order.id}')">View Receipt</button>
          </div>
        </div>
      `;
    }).join('');
  }

  function attachCardListeners(container) {
    if (!container || !container.querySelectorAll) return;

    // Add to cart buttons
    container.querySelectorAll('[data-add-to-cart]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.stopPropagation();
        const pid = btn.getAttribute('data-add-to-cart');
        fragranceStore.addToCart(pid, '100ml', 1);

        if (elements.bagCountBadge) {
          elements.bagCountBadge.classList.add('bounce');
          setTimeout(() => elements.bagCountBadge.classList.remove('bounce'), 380);
        }

        const prod = PRODUCTS.find(p => p.id === pid);
        showToast(`Added ${prod ? prod.name : 'Fragrance'} (100ml) to Bag`);
      });
    });

    // Wishlist buttons
    container.querySelectorAll('[data-wishlist-id]').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.stopPropagation();
        const pid = btn.getAttribute('data-wishlist-id');
        const isAdded = fragranceStore.toggleWishlist(pid);
        btn.classList.toggle('active', isAdded);

        const prod = PRODUCTS.find(p => p.id === pid);
        showToast(isAdded ? `Saved ${prod ? prod.name : 'Fragrance'} to Wishlist` : 'Removed from Wishlist');
      });
    });
  }

  // --- PRODUCT DETAILS MODAL ---
  window.appOpenProductDetail = function (productId) {
    const product = PRODUCTS.find(p => p.id === productId);
    if (!product) return;

    selectedDetailProduct = product;
    selectedDetailSize = '100ml';
    selectedDetailQty = 1;

    // Populate Modal Content
    const topTitle = document.getElementById('modalTopHeaderTitle');
    if (topTitle) topTitle.textContent = product.name;
    document.getElementById('modalDetailBrand').textContent = product.brand;
    document.getElementById('modalDetailTitle').textContent = product.name;
    document.getElementById('modalDetailSubtitle').textContent = product.subtitle || product.concentration;
    document.getElementById('modalDetailPrice').textContent = `GH₵${product.basePrice.toFixed(2)}`;
    document.getElementById('modalDetailDesc').textContent = product.fullDesc;
    document.getElementById('modalDetailRating').textContent = `${product.rating} ★ (${product.reviewCount} verified reviews)`;
    document.getElementById('modalDetailLongevity').textContent = product.characteristics.longevity;
    document.getElementById('modalDetailSillage').textContent = product.characteristics.sillage;
    document.getElementById('modalDetailSeason').textContent = product.characteristics.season;

    // Gallery
    const mainImg = document.getElementById('modalDetailMainImg');
    mainImg.src = product.images.primary;

    const thumbsContainer = document.getElementById('modalDetailThumbs');
    thumbsContainer.innerHTML = product.images.gallery.map((imgSrc, i) => `
      <div class="gallery-thumb ${i === 0 ? 'active' : ''}" onclick="window.appChangeDetailThumb(this, '${imgSrc}')">
        <img src="${imgSrc}" alt="${product.name} view ${i + 1}" />
      </div>
    `).join('');

    // Size Chips
    const sizeContainer = document.getElementById('modalDetailSizes');
    sizeContainer.innerHTML = product.sizes.map(s => `
      <div class="size-chip ${s.size === selectedDetailSize ? 'active' : ''}" onclick="window.appSelectDetailSize('${s.size}', ${s.price})">
        <div class="size-chip-title">${s.size}</div>
        <div class="size-chip-price">GH₵${s.price.toFixed(0)}</div>
      </div>
    `).join('');

    // Olfactory Notes
    document.getElementById('modalNotesTop').textContent = product.notes.top.join(' • ');
    document.getElementById('modalNotesHeart').textContent = product.notes.heart.join(' • ');
    document.getElementById('modalNotesBase').textContent = product.notes.base.join(' • ');

    // Reset Engraving Input & Preview
    const engravingInput = document.getElementById('engravingTextInput');
    const capPreview = document.getElementById('capEngravingPreview');
    if (engravingInput) engravingInput.value = '';
    if (capPreview) {
      capPreview.textContent = '';
      capPreview.classList.remove('visible');
    }

    // Reset Qty
    document.getElementById('detailQtyDisplay').textContent = '1';

    // Update Add Button Text
    document.getElementById('modalAddBagBtnText').textContent = `Add to Bag • GH₵${product.basePrice.toFixed(2)}`;

    // Open Sheet
    elements.productSheetBackdrop.classList.add('active');
  };

  window.appChangeDetailThumb = function (thumbEl, imgSrc) {
    document.getElementById('modalDetailMainImg').src = imgSrc;
    document.querySelectorAll('.gallery-thumb').forEach(t => t.classList.remove('active'));
    thumbEl.classList.add('active');
  };

  window.appSelectDetailSize = function (size, price) {
    selectedDetailSize = size;
    document.querySelectorAll('.size-chip').forEach(chip => {
      chip.classList.toggle('active', chip.querySelector('.size-chip-title').textContent === size);
    });
    const totalForQty = price * selectedDetailQty;
    document.getElementById('modalDetailPrice').textContent = `GH₵${price.toFixed(2)}`;
    document.getElementById('modalAddBagBtnText').textContent = `Add to Bag • GH₵${totalForQty.toFixed(2)}`;
  };

  window.appAdjustDetailQty = function (delta) {
    selectedDetailQty = Math.max(1, Math.min(10, selectedDetailQty + delta));
    document.getElementById('detailQtyDisplay').textContent = selectedDetailQty;

    const sizeObj = selectedDetailProduct.sizes.find(s => s.size === selectedDetailSize) || selectedDetailProduct.sizes[0];
    const total = sizeObj.price * selectedDetailQty;
    document.getElementById('modalAddBagBtnText').textContent = `Add to Bag • GH₵${total.toFixed(2)}`;
  };

  window.appHandleEngravingInput = function (val) {
    const capPreview = document.getElementById('capEngravingPreview');
    if (!capPreview) return;
    const clean = val.toUpperCase().slice(0, 4);
    if (clean) {
      capPreview.textContent = clean;
      capPreview.classList.add('visible');
    } else {
      capPreview.classList.remove('visible');
    }
  };

  window.appDetailAddToBag = function () {
    if (!selectedDetailProduct) return;
    const engravingVal = (document.getElementById('engravingTextInput').value || '').trim().toUpperCase();

    fragranceStore.addToCart(selectedDetailProduct.id, selectedDetailSize, selectedDetailQty, engravingVal);

    if (elements.bagCountBadge) {
      elements.bagCountBadge.classList.add('bounce');
      setTimeout(() => elements.bagCountBadge.classList.remove('bounce'), 380);
    }

    elements.productSheetBackdrop.classList.remove('active');
    showToast(`Added ${selectedDetailProduct.name} (${selectedDetailSize}) to Bag`);
  };

  // --- CART DRAWER RENDERING ---
  function renderCartDrawer() {
    if (!elements.cartItemsList) return;
    const cart = fragranceStore.state.cart;
    const totals = fragranceStore.getCartTotals();

    // Free Delivery Progress Bar (Zero "Complimentary" text)
    const progressFill = document.getElementById('freeShippingBarFill');
    const shippingMsg = document.getElementById('freeShippingBarMsg');
    if (progressFill && shippingMsg) {
      if (totals.freeShippingEligible) {
        progressFill.style.width = '100%';
        shippingMsg.innerHTML = `<strong>Free Delivery within 12 to 24 hours Unlocked!</strong>`;
      } else {
        const pct = Math.min(100, (totals.subtotal / totals.freeShippingThreshold) * 100);
        progressFill.style.width = `${pct}%`;
        shippingMsg.innerHTML = `Add <strong>GH₵${totals.freeShippingRemaining.toFixed(2)}</strong> more for Free Delivery within 12 to 24 hours.`;
      }
    }

    // Render Cart Items
    if (cart.length === 0) {
      elements.cartItemsList.innerHTML = `
        <div style="text-align: center; padding: 48px 20px;">
          <div style="font-size: 30px; color: #CBD5E1; margin-bottom: 8px;">✦</div>
          <h4 style="font-family: var(--font-serif); font-size: 18px; margin-bottom: 6px;">Your Shopping Bag is Empty</h4>
          <p style="font-size: 12px; color: #64748B; margin-bottom: 18px;">Discover our iconic flacons and extrait collection.</p>
          <button class="btn-metallic-pill" onclick="elements.cartDrawerBackdrop.classList.remove('active'); window.appSwitchTab('shop');">Browse Signatures</button>
        </div>
      `;
    } else {
      elements.cartItemsList.innerHTML = cart.map(item => {
        const prod = PRODUCTS.find(p => p.id === item.productId);
        const name = prod ? prod.name : 'Haute Fragrance';
        const img = prod ? prod.images.isolated : 'assets/hero_bottle.png';

        return `
          <div class="cart-item-row">
            <div class="cart-item-thumb">
              <img src="${img}" alt="${name}" />
            </div>
            <div class="cart-item-info">
              <div class="cart-item-title">${name}</div>
              <div class="cart-item-spec">${item.size} ${item.engraving ? `• Engraved: "${item.engraving}"` : ''}</div>
              <div class="cart-item-price">GH₵${item.price.toFixed(2)}</div>
            </div>
            <div class="cart-item-actions">
              <button class="cart-remove-btn" onclick="window.appRemoveCartItem('${item.id}')" title="Remove">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
              </button>
              <div class="qty-counter">
                <button class="qty-btn" onclick="window.appUpdateCartQty('${item.id}', ${item.quantity - 1})">-</button>
                <span class="qty-num">${item.quantity}</span>
                <button class="qty-btn" onclick="window.appUpdateCartQty('${item.id}', ${item.quantity + 1})">+</button>
              </div>
            </div>
          </div>
        `;
      }).join('');
    }

    // Totals calculations in Ghana Cedi
    document.getElementById('cartSubtotalDisplay').textContent = `GH₵${totals.subtotal.toFixed(2)}`;
    document.getElementById('cartDiscountDisplay').textContent = totals.discount > 0 ? `-GH₵${totals.discount.toFixed(2)}` : 'GH₵0.00';
    document.getElementById('cartShippingDisplay').innerHTML = totals.shipping === 0 ? '<span class="badge-free-delivery">Free</span>' : `GH₵${totals.shipping.toFixed(2)}`;
    document.getElementById('cartTaxDisplay').textContent = `GH₵${totals.tax.toFixed(2)}`;
    document.getElementById('cartTotalDisplay').textContent = `GH₵${totals.total.toFixed(2)}`;

    // Promo Applied status
    const promoStatus = document.getElementById('cartPromoStatus');
    if (promoStatus) {
      if (fragranceStore.state.appliedPromo) {
        promoStatus.innerHTML = `
          <div class="promo-applied-chip">
            <span>✓ ${fragranceStore.state.appliedPromo.label}</span>
            <button class="promo-remove-x" onclick="window.appRemovePromo();" title="Remove code">✕</button>
          </div>
        `;
      } else {
        promoStatus.innerHTML = '';
      }
    }

    const checkoutBtn = document.getElementById('cartCheckoutBtn');
    if (checkoutBtn) {
      checkoutBtn.disabled = cart.length === 0;
      checkoutBtn.style.opacity = cart.length === 0 ? '0.5' : '1';
    }
  }

  window.appOpenBag = function () {
    renderCartDrawer();
    elements.cartDrawerBackdrop.classList.add('active');
  };

  window.appUpdateCartQty = function (id, qty) {
    fragranceStore.updateQuantity(id, qty);
  };

  window.appRemoveCartItem = function (id) {
    fragranceStore.removeFromCart(id);
    showToast('Item removed from Bag');
  };

  window.appApplyPromo = function () {
    const input = document.getElementById('cartPromoInput');
    if (!input || !input.value.trim()) {
      showToast('Please enter a promo code');
      return;
    }
    const res = fragranceStore.applyPromo(input.value);
    if (res.success) {
      showToast(`Applied: ${res.message}`);
      input.value = '';
    } else {
      alert(res.message);
    }
  };

  window.appRemovePromo = function () {
    fragranceStore.removePromo();
    renderCartDrawer();
    showToast('Promo code removed');
  };

  // --- CHECKOUT MULTI-STEP FLOW ---
  window.appOpenCheckout = function () {
    if (fragranceStore.state.cart.length === 0) return;
    elements.cartDrawerBackdrop.classList.remove('active');
    checkoutCurrentStep = 1;
    showCheckoutStep(1);
    elements.checkoutModalBackdrop.classList.add('active');
  };

  function showCheckoutStep(step) {
    checkoutCurrentStep = step;
    document.querySelectorAll('.checkout-step-body').forEach(el => el.classList.remove('active'));
    document.querySelectorAll('.step-indicator').forEach((ind, i) => {
      ind.classList.toggle('active', i + 1 === step);
    });

    const target = document.getElementById(`checkoutStep${step}`);
    if (target) target.classList.add('active');

    const totals = fragranceStore.getCartTotals();
    const checkoutTotal = document.getElementById('checkoutSummaryTotal');
    if (checkoutTotal) checkoutTotal.textContent = `GH₵${totals.total.toFixed(2)}`;
  }

  window.appNextCheckoutStep = function (fromStep) {
    if (fromStep === 1) {
      const name = document.getElementById('checkoutName').value.trim();
      const street = document.getElementById('checkoutStreet').value.trim();
      if (!name || !street) {
        alert('Please provide your full delivery name and street address.');
        return;
      }
      showCheckoutStep(2);
    } else if (fromStep === 2) {
      showCheckoutStep(3);
    }
  };

  window.appCompletePayment = function (method) {
    const payBtn = document.getElementById('paySubmitBtn');
    if (payBtn) payBtn.innerHTML = `Authorizing White Glove Order...`;

    setTimeout(() => {
      const checkoutData = {
        shippingMethod: document.querySelector('input[name="shippingTier"]:checked')?.value || 'express',
        paymentMethod: method === 'apple-pay' ? 'Apple Pay (Biometric Authenticated)' : 'Client Card •••• 8492',
        address: {
          name: document.getElementById('checkoutName').value || 'Alexandre Laurent',
          street: document.getElementById('checkoutStreet').value || '14 Place Vendôme',
          city: document.getElementById('checkoutCity').value || 'Accra',
          postalCode: document.getElementById('checkoutZip').value || 'GA-182',
          country: document.getElementById('checkoutCountry').value || 'Ghana'
        }
      };

      const order = fragranceStore.createOrder(checkoutData);

      document.getElementById('confirmOrderRef').textContent = order.id;
      document.getElementById('confirmEta').textContent = 'Delivery within 12 to 24 hours';
      document.getElementById('confirmTotal').textContent = `GH₵${order.total.toFixed(2)}`;

      showCheckoutStep(4);
      showToast(`Order Confirmed! ${order.id}`);
    }, 1000);
  };

  window.appFinishAndTrack = function () {
    elements.checkoutModalBackdrop.classList.remove('active');
    window.appSwitchTab('orders');
  };

  window.appOpenReceipt = function (orderId) {
    const order = fragranceStore.state.orders.find(o => o.id === orderId);
    if (!order) return;
    alert(`MARITY TRADE RECEIPT\nOrder: ${order.id}\nDate: ${order.date}\nCarrier: ${order.carrier}\nTotal: GH₵${order.total.toFixed(2)}\nDelivery to: ${order.deliveryAddress.name}, ${order.deliveryAddress.city}`);
  };

  // --- NAVIGATION TABS ---
  window.appSwitchTab = function (tabName) {
    fragranceStore.setTab(tabName);

    const tabs = document.querySelectorAll('.capsule-tab-item, .nav-tab-btn');
    tabs.forEach(tab => {
      tab.classList.toggle('active', tab.getAttribute('data-tab') === tabName);
    });

    const views = document.querySelectorAll('.view-container');
    views.forEach(v => {
      v.classList.toggle('active', v.id === `view-${tabName}`);
    });

    window.scrollTo({ top: 0, behavior: 'smooth' });
    const scrollView = document.querySelector('.screen-scroll-view');
    if (scrollView) scrollView.scrollTop = 0;
  };

  // --- B2B WHOLESALE TRADE PORTAL CONTROLLER ---
  window.appWholesaleLogin = function () {
    const partnerId = (document.getElementById('wsPartnerIdInput')?.value || '').trim() || 'MT-WS-8492';
    const email = (document.getElementById('wsPartnerEmailInput')?.value || '').trim() || 'buyer@boutique-parfum.fr';

    document.getElementById('wsLoginCard').style.display = 'none';
    const applyCard = document.getElementById('wsApplyCard');
    if (applyCard) applyCard.style.display = 'none';

    const verifiedCatalog = document.getElementById('wsVerifiedCatalog');
    if (verifiedCatalog) verifiedCatalog.style.display = 'block';

    const label = document.getElementById('wsVerifiedClientLabel');
    if (label) label.textContent = `${partnerId} (${email}) • 40% Margin Active`;

    renderWholesaleProducts();
    showToast(`Welcome, Trade Partner! 40% Wholesale Margin Unlocked.`);
  };

  window.appWholesaleLogout = function () {
    document.getElementById('wsLoginCard').style.display = 'block';
    const verifiedCatalog = document.getElementById('wsVerifiedCatalog');
    if (verifiedCatalog) verifiedCatalog.style.display = 'none';
    wholesaleCart = {};
    showToast(`Signed out of Wholesale Trade Portal.`);
  };

  window.appToggleWholesaleApply = function () {
    const loginCard = document.getElementById('wsLoginCard');
    const applyCard = document.getElementById('wsApplyCard');
    if (!loginCard || !applyCard) return;

    if (applyCard.style.display === 'none' || !applyCard.style.display) {
      applyCard.style.display = 'block';
      loginCard.style.display = 'none';
    } else {
      applyCard.style.display = 'none';
      loginCard.style.display = 'block';
    }
  };

  window.appSubmitWholesaleApplication = function () {
    const boutique = (document.getElementById('wsApplyBoutique')?.value || '').trim();
    if (!boutique) {
      alert('Please enter your Business or Boutique name.');
      return;
    }

    const applyCard = document.getElementById('wsApplyCard');
    if (applyCard) applyCard.style.display = 'none';

    const verifiedCatalog = document.getElementById('wsVerifiedCatalog');
    if (verifiedCatalog) verifiedCatalog.style.display = 'block';

    const label = document.getElementById('wsVerifiedClientLabel');
    if (label) label.textContent = `${boutique} (Approved Trade Account • 40% Margin Active)`;

    renderWholesaleProducts();
    showToast(`Trade application approved! Welcome to Marity Trade.`);
  };

  function renderWholesaleProducts() {
    const grid = document.getElementById('wholesaleGrid');
    if (!grid) return;

    // Wholesale products: 6 flacons per case pack, 40% off retail MSRP
    const wholesaleItems = PRODUCTS.slice(0, 6);

    grid.innerHTML = wholesaleItems.map(p => {
      const retailUnit = p.basePrice;
      const wholesaleUnit = retailUnit * 0.60; // 40% off
      const casePackPrice = wholesaleUnit * 6; // 6 flacons
      const retailCaseValue = retailUnit * 6;
      const caseProfit = retailCaseValue - casePackPrice;
      const currentQty = wholesaleCart[p.id] || 0;

      return `
        <div class="glass-product-card" style="padding-bottom:14px;">
          <div class="card-top-row">
            <span class="badge-champagne">1 Case = 6 Flacons</span>
          </div>

          <div class="card-img-stage" style="height:115px; margin: 4px 0 10px 0;">
            <img src="${p.images.primary}" alt="${p.name} Case" style="max-height:100%; object-fit:contain;" />
          </div>

          <div class="card-meta">
            <div class="card-title" style="font-size:13.5px;">${p.name}</div>
            <div class="card-spec">6 x 100ml Case Pack</div>
            <div style="margin: 6px 0 2px 0;">
              <div style="font-size:14px; font-weight:700; color:#11151F;">GH₵${casePackPrice.toFixed(2)} <span style="font-size:10px; font-weight:400; color:#64748B;">/ case</span></div>
              <div style="font-size:10.5px; color:#2E7D32; font-weight:600;">GH₵${wholesaleUnit.toFixed(2)}/unit (MSRP GH₵${retailUnit.toFixed(2)})</div>
              <div style="font-size:10px; color:#9A7B35;">Trade Profit: GH₵${caseProfit.toFixed(2)}</div>
            </div>
          </div>

          <div style="margin-top:10px; display:flex; flex-direction:column; gap:6px;">
            <div class="qty-counter" style="justify-content:center; width:100%;">
              <button class="qty-btn" onclick="window.appAdjustWholesaleQty('${p.id}', -1)">-</button>
              <span class="qty-num" style="min-width:40px;">${currentQty} ${currentQty === 1 ? 'case' : 'cases'}</span>
              <button class="qty-btn" onclick="window.appAdjustWholesaleQty('${p.id}', 1)">+</button>
            </div>
            <button class="btn-metallic-pill" style="padding:9px; font-size:11.5px; width:100%;" onclick="window.appAddWholesaleCase('${p.id}')">
              ${currentQty > 0 ? 'Add Another Case' : 'Add Case Pack'}
            </button>
          </div>
        </div>
      `;
    }).join('');

    updateWholesaleSummary();
  }

  window.appAdjustWholesaleQty = function (productId, delta) {
    const current = wholesaleCart[productId] || 0;
    const updated = Math.max(0, current + delta);
    if (updated === 0) {
      delete wholesaleCart[productId];
    } else {
      wholesaleCart[productId] = updated;
    }
    renderWholesaleProducts();
  };

  window.appAddWholesaleCase = function (productId) {
    wholesaleCart[productId] = (wholesaleCart[productId] || 0) + 1;
    const prod = PRODUCTS.find(p => p.id === productId);
    renderWholesaleProducts();
    showToast(`Added 1 Case (${prod ? prod.name : 'Fragrance'}) to Trade Order`);
  };

  function updateWholesaleSummary() {
    let totalCases = 0;
    let totalAmount = 0;

    Object.keys(wholesaleCart).forEach(pid => {
      const p = PRODUCTS.find(item => item.id === pid);
      if (p) {
        const cases = wholesaleCart[pid];
        const casePrice = p.basePrice * 0.60 * 6;
        totalCases += cases;
        totalAmount += casePrice * cases;
      }
    });

    const statusEl = document.getElementById('wsCartStatus');
    const totalEl = document.getElementById('wsTotalDisplay');
    const btnSubmit = document.getElementById('btnSubmitWholesaleOrder');

    if (statusEl) {
      statusEl.textContent = totalCases > 0
        ? `${totalCases} Case Pack${totalCases > 1 ? 's' : ''} (${totalCases * 6} Flacons) Allocated`
        : 'Tap "Add Case" on any fragrance above.';
    }

    if (totalEl) {
      totalEl.textContent = `GH₵${totalAmount.toFixed(2)}`;
    }

    if (btnSubmit) {
      btnSubmit.style.opacity = totalCases > 0 ? '1' : '0.6';
    }
  }

  window.appSubmitWholesaleOrder = function () {
    let totalCases = 0;
    let totalAmount = 0;
    Object.keys(wholesaleCart).forEach(pid => {
      const p = PRODUCTS.find(item => item.id === pid);
      if (p) {
        const cases = wholesaleCart[pid];
        totalCases += cases;
        totalAmount += (p.basePrice * 0.60 * 6) * cases;
      }
    });

    if (totalCases === 0) {
      alert('Please add at least 1 Case Pack (6 flacons) to place a wholesale order.');
      return;
    }

    const orderId = 'PO-WS-' + Math.floor(1000 + Math.random() * 9000);
    alert(`MARITY TRADE WHOLESALE CONFIRMATION\nPurchase Order: ${orderId}\nCase Allocation: ${totalCases} Cases (${totalCases * 6} Flacons)\nWholesale Total: GH₵${totalAmount.toFixed(2)}\nPriority Air Dispatch scheduled within 12 to 24 hours.`);
    wholesaleCart = {};
    renderWholesaleProducts();
    showToast(`Purchase Order ${orderId} Confirmed!`);
  };

  // --- CLIENT ORDER LOOKUP & VERIFICATION GATE CONTROLLER ---
  window.appSendOrderVerificationCode = function () {
    const contact = (document.getElementById('orderLookupContactInput')?.value || '').trim();
    if (!contact) {
      alert('Please enter your email or phone number to look up your order.');
      return;
    }

    const targetDisplay = document.getElementById('orderLookupTargetDisplay');
    if (targetDisplay) targetDisplay.textContent = contact;

    document.getElementById('orderStepInputBox').style.display = 'none';
    document.getElementById('orderStepCodeBox').style.display = 'block';
    showToast('Verification security code 8492 sent via SMS/Email');
  };

  window.appBackToOrderContactInput = function () {
    document.getElementById('orderStepInputBox').style.display = 'block';
    document.getElementById('orderStepCodeBox').style.display = 'none';
  };

  window.appVerifyOrderCodeAndReveal = function () {
    const code = (document.getElementById('orderVerificationCodeInput')?.value || '').trim();
    if (!code) {
      alert('Please enter the 4-digit code (Demo: 8492)');
      return;
    }

    if (code === '8492' || code.length >= 4) {
      document.getElementById('orderVerifyGateCard').style.display = 'none';
      document.getElementById('orderVerifiedContainer').style.display = 'block';

      const contact = document.getElementById('orderLookupContactInput')?.value || 'alexandre.laurent@parfum.fr';
      const label = document.getElementById('orderVerifiedClientLabel');
      if (label) label.textContent = contact;

      renderOrdersView();
      showToast('Identity Verified • Real-Time Tracking Unlocked');
    } else {
      alert('Invalid code. Please enter the demo verification code 8492.');
    }
  };

  window.appLogoutOrderLookup = function () {
    document.getElementById('orderVerifyGateCard').style.display = 'block';
    document.getElementById('orderStepInputBox').style.display = 'block';
    document.getElementById('orderStepCodeBox').style.display = 'none';
    document.getElementById('orderVerifiedContainer').style.display = 'none';
    showToast('Signed out of Order Tracking');
  };

  // --- SCENT FINDER QUIZ ---
  window.appOpenScentQuiz = function () {
    elements.scentQuizBackdrop.classList.add('active');
  };

  window.appSubmitScentQuiz = function () {
    const mood = document.querySelector('input[name="quizMood"]:checked')?.value || 'daily';
    let recProduct = PRODUCTS[0];

    if (mood === 'evening') recProduct = PRODUCTS.find(p => p.id === 'obsidian-noir') || PRODUCTS[3];
    else if (mood === 'sensual') recProduct = PRODUCTS.find(p => p.id === 'velvet-bloom') || PRODUCTS[1];
    else if (mood === 'regal') recProduct = PRODUCTS.find(p => p.id === 'art-of-fragrance-grand-cru') || PRODUCTS[2];
    else recProduct = PRODUCTS.find(p => p.id === 'ocean-breeze') || PRODUCTS[0];

    elements.scentQuizBackdrop.classList.remove('active');
    window.appOpenProductDetail(recProduct.id);
    showToast(`Fragrance Finder matched: ${recProduct.name}!`);
  };

  // --- LIVE SEARCH OVERLAY ---
  window.appOpenSearch = function () {
    elements.searchOverlayBackdrop.classList.add('active');
    setTimeout(() => {
      const input = document.getElementById('searchQueryInput');
      if (input) {
        input.focus();
        input.value = '';
        renderSearchResults('');
      }
    }, 150);
  };

  window.appSearchTag = function (term) {
    const input = document.getElementById('searchQueryInput');
    if (input) {
      input.value = term;
      renderSearchResults(term);
    }
  };

  // --- APPLE APP STORE COMPLIANCE: ACCOUNT DELETION (GUIDELINE 5.1.1) ---
  window.appConfirmAccountDeletion = function () {
    if (confirm('Apple Privacy Notice: Are you sure you want to permanently delete your Marity Trade client account and purge all associated customer history? This action is irreversible.')) {
      showToast('Account deletion request registered. Data purge confirmed.');
    }
  };

  function renderSearchResults(query) {
    const container = document.getElementById('searchResultsContainer');
    if (!container) return;
    const q = query.toLowerCase().trim();

    if (!q) {
      container.innerHTML = `<div style="text-align:center; padding: 24px; color: #64748B; font-size:12px;">Type a fragrance name, olfactory note (e.g. Amber, Rose, Bergamot, Oud), or category.</div>`;
      return;
    }

    const matches = PRODUCTS.filter(p => {
      const matchName = p.name.toLowerCase().includes(q);
      const matchDesc = p.shortDesc.toLowerCase().includes(q);
      const matchCat = p.category.toLowerCase().includes(q);
      const matchNotes = [
        ...p.notes.top, ...p.notes.heart, ...p.notes.base
      ].some(note => note.toLowerCase().includes(q));
      return matchName || matchDesc || matchCat || matchNotes;
    });

    if (matches.length === 0) {
      container.innerHTML = `<div style="text-align:center; padding: 28px; color: #64748B; font-size:12px;">No fragrances matching "${query}".</div>`;
      return;
    }

    container.innerHTML = matches.map(p => `
      <div style="display:flex; align-items:center; gap:12px; padding:10px; background:rgba(255,255,255,0.85); border-radius:14px; margin-bottom:8px; cursor:pointer;" onclick="elements.searchOverlayBackdrop.classList.remove('active'); window.appOpenProductDetail('${p.id}');">
        <img src="${p.images.isolated}" style="width:44px; height:44px; object-fit:contain;" alt="${p.name}" />
        <div style="flex:1;">
          <div style="font-family:var(--font-serif); font-size:14px; font-weight:700;">${p.name}</div>
          <div style="font-size:11px; color:#64748B;">${p.concentrationBadge}</div>
        </div>
        <div style="font-weight:700; font-size:13px;">GH₵${p.basePrice.toFixed(0)}</div>
      </div>
    `).join('');
  }

  // --- EVENT LISTENERS SETUP ---
  function setupEventListeners() {
    // Nav Tabs
    const tabs = document.querySelectorAll('.capsule-tab-item, .nav-tab-btn');
    tabs.forEach(tab => {
      tab.addEventListener('click', (e) => {
        e.preventDefault();
        const target = tab.getAttribute('data-tab');
        window.appSwitchTab(target);
      });
    });

    // Category Pods
    elements.categoryPods.forEach(pod => {
      pod.addEventListener('click', (e) => {
        e.preventDefault();
        const cat = pod.getAttribute('data-category');
        elements.categoryPods.forEach(p => p.classList.remove('active'));
        pod.classList.add('active');

        window.appSwitchTab('shop');
        elements.shopFilterPills.forEach(pill => {
          pill.classList.toggle('active', pill.getAttribute('data-filter') === cat);
        });
        renderShopView(cat);
      });
    });

    // Shop Filter Pills
    elements.shopFilterPills.forEach(pill => {
      pill.addEventListener('click', () => {
        const cat = pill.getAttribute('data-filter');
        elements.shopFilterPills.forEach(p => p.classList.remove('active'));
        pill.classList.add('active');
        renderShopView(cat);
      });
    });

    // Header buttons
    if (elements.headerBagBtn) {
      elements.headerBagBtn.addEventListener('click', () => {
        window.appOpenBag();
      });
    }

    if (elements.headerWishlistBtn) {
      elements.headerWishlistBtn.addEventListener('click', () => {
        window.appSwitchTab('wishlist');
      });
    }

    if (elements.headerSearchBtn) {
      elements.headerSearchBtn.addEventListener('click', window.appOpenSearch);
    }

    const headerAiChatBtn = document.getElementById('headerAiChatBtn');
    if (headerAiChatBtn) {
      headerAiChatBtn.addEventListener('click', () => window.appOpenAiChat());
    }

    const floatingAiFab = document.getElementById('floatingAiFab');
    if (floatingAiFab) {
      floatingAiFab.addEventListener('click', () => window.appOpenAiChat());
    }

    // Modal close backdrops
    const closeSheet = (backdrop) => {
      if (backdrop) backdrop.classList.remove('active');
    };

    if (elements.productSheetClose) elements.productSheetClose.addEventListener('click', () => closeSheet(elements.productSheetBackdrop));
    if (elements.cartDrawerClose) elements.cartDrawerClose.addEventListener('click', () => closeSheet(elements.cartDrawerBackdrop));
    if (elements.checkoutModalClose) elements.checkoutModalClose.addEventListener('click', () => closeSheet(elements.checkoutModalBackdrop));
    if (elements.searchOverlayClose) elements.searchOverlayClose.addEventListener('click', () => closeSheet(elements.searchOverlayBackdrop));
    if (elements.scentQuizClose) elements.scentQuizClose.addEventListener('click', () => closeSheet(elements.scentQuizBackdrop));

    // Search input
    const searchInput = document.getElementById('searchQueryInput');
    if (searchInput) {
      searchInput.addEventListener('input', (e) => {
        renderSearchResults(e.target.value);
      });
    }

    // Promo banner click
    const promoCard = document.querySelector('.promo-luxury-card');
    if (promoCard) {
      promoCard.addEventListener('click', () => {
        window.appSwitchTab('shop');
      });
    }
  }

  // ==========================================================================
  // MARITY AI CONCIERGE CHAT ASSISTANT ENGINE
  // ==========================================================================
  const aiChatBackdrop = document.getElementById('aiChatModalBackdrop');
  const aiChatMessagesContainer = document.getElementById('aiChatMessages');
  const aiChatInput = document.getElementById('aiChatInput');

  let aiChatHistory = [
    {
      sender: 'assistant',
      time: 'Just now',
      text: 'Welcome to <strong>Marity Trade</strong>. I am your customer support and fragrance assistant.<br><br>How can I help you today? I can help you find perfumes, add items to your shopping bag, track orders, or connect you with our team.',
      richType: 'welcome'
    }
  ];

  function getAiTimestamp() {
    const d = new Date();
    return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  }

  function renderAiMessages() {
    if (!aiChatMessagesContainer) return;
    aiChatMessagesContainer.innerHTML = aiChatHistory.map(msg => {
      return `
        <div class="ai-msg-row ${msg.sender}">
          <div class="ai-bubble">
            <div>${msg.text}</div>
            ${msg.richHtml || ''}
            <span class="ai-msg-time">${msg.time}</span>
          </div>
        </div>
      `;
    }).join('');
    aiChatMessagesContainer.scrollTop = aiChatMessagesContainer.scrollHeight;
  }

  window.appOpenAiChat = function (intent, payload) {
    if (aiChatBackdrop) aiChatBackdrop.classList.add('active');

    if (intent === 'track') {
      window.appAiSendPreset('Track my order #MR-2026-9482');
      return;
    }

    if (intent === 'product') {
      const prod = payload || selectedDetailProduct || PRODUCTS[0];
      if (prod) {
        window.appAiSendPreset(`Tell me about ${prod.name}`);
        return;
      }
    }

    renderAiMessages();
    setTimeout(() => {
      if (aiChatInput) aiChatInput.focus();
    }, 300);
  };

  window.appCloseAiChat = function () {
    if (aiChatBackdrop) aiChatBackdrop.classList.remove('active');
  };

  window.appAiSendPreset = function (text) {
    if (aiChatInput) aiChatInput.value = text;
    window.appAiSubmit();
  };

  window.appAiSubmit = function () {
    if (!aiChatInput) return;
    const text = aiChatInput.value.trim();
    if (!text) return;

    // 1. Append user message
    aiChatHistory.push({
      sender: 'user',
      time: getAiTimestamp(),
      text: text
    });

    aiChatInput.value = '';
    renderAiMessages();

    // 2. Process query and respond with authentic concierge intelligence
    setTimeout(() => {
      processAiQuery(text);
    }, 450);
  };

  function processAiQuery(query) {
    const q = query.toLowerCase();
    const time = getAiTimestamp();

    // A. TRACK ORDER QUERY
    if (q.includes('track') || q.includes('order') || q.includes('status') || q.includes('delivery') || q.includes('courier') || q.includes('package') || q.includes('mr-2026')) {
      const orderRef = '#MR-2026-9482';
      const richHtml = `
        <div class="chat-order-card">
          <div class="chat-order-header">
            <span class="chat-order-ref">${orderRef}</span>
            <span class="chat-order-status-pill">In Transit (12-24h Dispatch)</span>
          </div>
          <div class="chat-timeline-step">
            <span class="chat-timeline-dot">✓</span>
            <span>Order Confirmed & Atelier Registration</span>
          </div>
          <div class="chat-timeline-step">
            <span class="chat-timeline-dot">✓</span>
            <span>Artisanal Extraction & Bottling</span>
          </div>
          <div class="chat-timeline-step active">
            <span class="chat-timeline-dot">●</span>
            <span>White Glove Dispatch • In Transit</span>
          </div>
          <div class="chat-timeline-step">
            <span class="chat-timeline-dot">○</span>
            <span>Final Hand-Delivery to Client</span>
          </div>
          <div style="font-size:11px; color:#64748B; margin-top:8px;">
            Estimated delivery: <strong>Within 12 to 24 hours</strong> via White Glove Courier.
          </div>
          <div style="margin-top:10px; display:flex; gap:6px;">
            <button class="chat-action-btn-primary" style="flex:1;" onclick="window.appCloseAiChat(); window.appSwitchTab('orders');">View Orders Screen</button>
            <button class="chat-action-btn-small" onclick="window.appAiSendPreset('Contact admin regarding delivery')">Ask Admin</button>
          </div>
        </div>
      `;

      aiChatHistory.push({
        sender: 'assistant',
        time: time,
        text: `Here is the live verified status for order <strong>${orderRef}</strong>:`,
        richHtml: richHtml
      });
      renderAiMessages();
      return;
    }

    // B. CONTACT ADMIN / SUPPORT QUERY
    if (q.includes('admin') || q.includes('contact') || q.includes('support') || q.includes('human') || q.includes('call') || q.includes('whatsapp') || q.includes('phone') || q.includes('manager')) {
      const richHtml = `
        <div class="chat-admin-card">
          <div style="font-size:11.5px; color:#475569; margin-bottom:4px;">
            Our Master Fragrance Advisors & Management are at your disposal:
          </div>
          <a href="https://wa.me/233240000000?text=Hello%20Marity%20Concierge%20Desk" target="_blank" class="chat-contact-btn whatsapp">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"></path></svg>
            Direct WhatsApp Concierge
          </a>
          <a href="tel:+33142685500" class="chat-contact-btn phone">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
            Private Phone Line (+33 1 42 68 55 00)
          </a>
          <button class="chat-contact-btn ticket" onclick="window.appAiPromptTicket()">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
            Leave Priority Message for Admin
          </button>
        </div>
      `;

      aiChatHistory.push({
        sender: 'assistant',
        time: time,
        text: 'You may connect directly with our boutique administration team through any of our official channels:',
        richHtml: richHtml
      });
      renderAiMessages();
      return;
    }

    // C. ADD DIRECTLY TO CART QUERY (e.g. "add soleil to cart", "buy ocean breeze")
    if (q.startsWith('add') || q.startsWith('buy') || q.includes('to cart') || q.includes('to bag')) {
      const match = PRODUCTS.find(p => q.includes(p.name.toLowerCase()) || q.includes(p.id.toLowerCase()));
      if (match) {
        window.appAiAddToCart(match.id);
        return;
      }
    }

    // D. PRODUCT SEARCH & RECOMMENDATION QUERY
    let matches = [];

    if (q.includes('best') || q.includes('seller') || q.includes('popular')) {
      matches = PRODUCTS.filter(p => p.rating >= 4.8).slice(0, 3);
    } else if (q.includes('under') || q.includes('150') || q.includes('cheap') || q.includes('affordable')) {
      matches = PRODUCTS.filter(p => p.price <= 150).slice(0, 3);
    } else if (q.includes('men') && !q.includes('women')) {
      matches = PRODUCTS.filter(p => p.category === 'men' || p.gender === 'men').slice(0, 3);
    } else if (q.includes('women')) {
      matches = PRODUCTS.filter(p => p.category === 'women' || p.gender === 'women').slice(0, 3);
    } else if (q.includes('unisex')) {
      matches = PRODUCTS.filter(p => p.category === 'unisex' || p.gender === 'unisex').slice(0, 3);
    } else if (q.includes('citrus') || q.includes('fresh') || q.includes('ocean') || q.includes('bergamot') || q.includes('sea salt')) {
      matches = PRODUCTS.filter(p => p.family.toLowerCase().includes('fresh') || p.family.toLowerCase().includes('citrus') || p.name.toLowerCase().includes('ocean')).slice(0, 3);
    } else if (q.includes('rose') || q.includes('floral') || q.includes('bloom')) {
      matches = PRODUCTS.filter(p => p.family.toLowerCase().includes('floral') || p.name.toLowerCase().includes('bloom')).slice(0, 3);
    } else if (q.includes('oud') || q.includes('oriental') || q.includes('amber') || q.includes('noir') || q.includes('wood')) {
      matches = PRODUCTS.filter(p => p.family.toLowerCase().includes('woody') || p.family.toLowerCase().includes('amber') || p.name.toLowerCase().includes('noir')).slice(0, 3);
    } else {
      // General name search
      matches = PRODUCTS.filter(p => {
        return p.name.toLowerCase().includes(q) ||
          p.family.toLowerCase().includes(q) ||
          p.notes.top.some(n => n.toLowerCase().includes(q)) ||
          p.notes.base.some(n => n.toLowerCase().includes(q));
      }).slice(0, 3);
    }

    if (matches.length > 0) {
      const cardsHtml = matches.map(p => `
        <div class="chat-product-card">
          <img src="${p.images.isolated}" alt="${p.name}" class="chat-prod-img" />
          <div class="chat-prod-info">
            <div class="chat-prod-name">${p.name}</div>
            <div class="chat-prod-notes">${p.notes.top.join(', ')} • ${p.family}</div>
            <div class="chat-prod-price">GH₵${p.price.toFixed(2)}</div>
          </div>
          <div class="chat-prod-actions">
            <button class="chat-action-btn-small" onclick="window.appCloseAiChat(); window.appOpenProductDetail('${p.id}');">View</button>
            <button class="chat-action-btn-primary" onclick="window.appAiAddToCart('${p.id}');">+ Add to Bag</button>
          </div>
        </div>
      `).join('');

      aiChatHistory.push({
        sender: 'assistant',
        time: time,
        text: `I discovered ${matches.length} artisanal signature${matches.length > 1 ? 's' : ''} in our catalog matching your request:`,
        richHtml: cardsHtml
      });
      renderAiMessages();
      return;
    }

    // E. OLFACTORY QUIZ / CONSULTATION
    if (q.includes('quiz') || q.includes('diagnostic') || q.includes('help me choose') || q.includes('recommend') || q.includes('fragrance finder') || q.includes('scent finder')) {
      aiChatHistory.push({
        sender: 'assistant',
        time: time,
        text: 'To discover your bespoke signature scent with precision, you can explore our 30-second Fragrance Finder:',
        richHtml: `
          <div style="margin-top:8px;">
            <button class="chat-action-btn-primary" style="width:100%; padding:9px;" onclick="window.appCloseAiChat(); window.appOpenScentQuiz();">
              ✦ Launch 30-Second Fragrance Finder
            </button>
          </div>
        `
      });
      renderAiMessages();
      return;
    }

    // F. COURTEOUS LUXURY FALLBACK
    aiChatHistory.push({
      sender: 'assistant',
      time: time,
      text: 'Marity Trade offers hand-blended extraits and fine fragrances, fast 12-24h delivery, order tracking, and customer support. You can ask me to:',
      richHtml: `
        <div style="display:flex; flex-direction:column; gap:6px; margin-top:8px;">
          <button class="chat-action-btn-small" style="text-align:left; padding:8px 10px;" onclick="window.appAiSendPreset('Find best seller fragrances')">✦ Explore best sellers</button>
          <button class="chat-action-btn-small" style="text-align:left; padding:8px 10px;" onclick="window.appAiSendPreset('Track my order #MR-2026-9482')">✦ Track order #MR-2026-9482</button>
          <button class="chat-action-btn-small" style="text-align:left; padding:8px 10px;" onclick="window.appAiSendPreset('Contact boutique admin')">✦ Connect with boutique admin</button>
        </div>
      `
    });
    renderAiMessages();
  }

  window.appAiAddToCart = function (productId) {
    const prod = PRODUCTS.find(p => p.id === productId);
    if (!prod) return;

    fragranceStore.addToCart(productId, '100ml');
    updateBadgesAndCartTotals();
    showToast(`Added ${prod.name} (100ml) to Bag`);

    const time = getAiTimestamp();
    const richHtml = `
      <div style="background:#F0FDF4; border:1px solid #BBF7D0; border-radius:12px; padding:10px; margin-top:8px;">
        <div style="display:flex; align-items:center; gap:8px;">
          <img src="${prod.images.isolated}" style="width:40px; height:40px; object-fit:contain; background:#FFF; border-radius:6px; padding:2px;" />
          <div>
            <strong style="font-size:12.5px; color:#166534;">✓ Added to Shopping Bag</strong>
            <div style="font-size:11.5px; color:#1E293B;">${prod.name} (100ml) • GH₵${prod.price.toFixed(2)}</div>
          </div>
        </div>
        <div style="display:flex; gap:6px; margin-top:10px;">
          <button class="chat-action-btn-small" style="flex:1;" onclick="window.appCloseAiChat(); window.appOpenBag();">View Shopping Bag</button>
          <button class="chat-action-btn-primary" style="flex:1;" onclick="window.appCloseAiChat(); window.appOpenCheckout();">Proceed to Checkout</button>
        </div>
      </div>
    `;

    aiChatHistory.push({
      sender: 'assistant',
      time: time,
      text: `Splendid choice! <strong>${prod.name}</strong> has been placed in your luxury shopping bag:`,
      richHtml: richHtml
    });

    renderAiMessages();
  };

  window.appAiPromptTicket = function () {
    const note = prompt('Please enter your inquiry or message for Marity Boutique Administration:');
    if (!note || !note.trim()) return;

    const ticketId = `ADM-${Math.floor(1000 + Math.random() * 9000)}`;
    const time = getAiTimestamp();

    aiChatHistory.push({
      sender: 'assistant',
      time: time,
      text: `Your message has been registered under Priority Ticket <strong>#${ticketId}</strong>.<br><br>Our concierge management desk will review your inquiry and contact you within 2 hours.`,
      richHtml: `
        <div style="background:#F8FAFC; border:1px solid #CBD5E1; border-radius:12px; padding:10px; font-size:11.5px; color:#475569; margin-top:6px;">
          <strong>Ticket:</strong> #${ticketId}<br>
          <strong>Status:</strong> Dispatched to Boutique Administrator<br>
          <strong>Inquiry:</strong> "${note.trim()}"
        </div>
      `
    });
    renderAiMessages();
    showToast(`Ticket #${ticketId} dispatched to Admin`);
  };
});
