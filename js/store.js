/**
 * MARITY FRAGRANCES — STATE STORE
 * Manages Cart, Wishlist, Orders, Search, and User Preferences with persistence.
 */

class FragranceStore {
  constructor() {
    this.STORAGE_KEY = 'marity_fragrance_store_v1';
    this.listeners = [];
    this.state = this.loadState();
  }

  getDefaultState() {
    return {
      cart: [
        {
          id: 'cart-1',
          productId: 'ocean-breeze',
          size: '100ml',
          price: 129.00,
          quantity: 1,
          engraving: 'J.F.',
          addedAt: Date.now() - 3600000
        },
        {
          id: 'cart-2',
          productId: 'velvet-bloom',
          size: '100ml',
          price: 139.00,
          quantity: 1,
          engraving: '',
          addedAt: Date.now() - 1800000
        }
      ],
      wishlist: ['art-of-fragrance-grand-cru', 'obsidian-noir'],
      selectedSamples: ['sample-1', 'sample-3'],
      giftWrapping: {
        enabled: true,
        note: 'With heartfelt admiration and timeless elegance.'
      },
      appliedPromo: null,
      orders: [
        {
          id: 'MR-2026-9482',
          date: 'Nov 20, 2026',
          status: 'In Transit',
          statusStep: 4, // 1: Confirmed, 2: Engraved, 3: Quality Passed, 4: Dispatched, 5: Delivered
          carrier: 'DHL Express Worldwide',
          trackingNumber: 'DHL-EXP-840291932',
          eta: 'Tomorrow, by 12:00 PM',
          items: [
            {
              productId: 'art-of-fragrance-grand-cru',
              name: 'The Art of Fragrance',
              size: '100ml',
              price: 165.00,
              quantity: 1,
              engraving: 'C.L.'
            }
          ],
          subtotal: 165.00,
          shipping: 0.00,
          tax: 13.20,
          total: 178.20,
          deliveryAddress: {
            name: 'Alexandre Laurent',
            street: '14 Place Vendôme',
            city: 'Paris',
            postalCode: '75001',
            country: 'France'
          }
        }
      ],
      user: {
        name: 'Alexandre Laurent',
        tier: 'Platinum Connoisseur',
        memberSince: '2024',
        loyaltyPoints: 1450,
        email: 'a.laurent@haute-parfumerie.com',
        phone: '+33 1 42 68 55 00',
        savedAddresses: [
          {
            id: 'addr-1',
            title: 'Hôtel Particulier',
            address: '14 Place Vendôme, 75001 Paris, France',
            isDefault: true
          }
        ],
        scentPreferences: ['Warm Amber', 'Mineral Sea Salt', 'Smoked Oud', 'Grasse Rose']
      },
      currentTab: 'home',
      activeCategory: 'all'
    };
  }

  loadState() {
    try {
      const saved = localStorage.getItem(this.STORAGE_KEY);
      if (saved) {
        const parsed = JSON.parse(saved);
        return { ...this.getDefaultState(), ...parsed };
      }
    } catch (e) {
      console.warn('LocalStorage unavailable, using default state', e);
    }
    return this.getDefaultState();
  }

  saveState() {
    try {
      localStorage.setItem(this.STORAGE_KEY, JSON.stringify(this.state));
    } catch (e) {
      console.warn('Could not persist to LocalStorage', e);
    }
    this.notify();
  }

  subscribe(listener) {
    this.listeners.push(listener);
    return () => {
      this.listeners = this.listeners.filter(l => l !== listener);
    };
  }

  notify() {
    this.listeners.forEach(cb => cb(this.state));
  }

  // --- CART ACTIONS ---

  addToCart(productId, size = '100ml', quantity = 1, engraving = '') {
    const product = PRODUCTS.find(p => p.id === productId);
    if (!product) return;

    const sizeObj = product.sizes.find(s => s.size === size) || product.sizes[0];
    const unitPrice = sizeObj ? sizeObj.price : product.basePrice;

    // Check if duplicate exists with same size & engraving
    const existingIndex = this.state.cart.findIndex(
      item => item.productId === productId && item.size === size && item.engraving === engraving
    );

    if (existingIndex > -1) {
      this.state.cart[existingIndex].quantity += quantity;
    } else {
      this.state.cart.push({
        id: 'cart-' + Date.now() + '-' + Math.random().toString(36).substr(2, 4),
        productId,
        size,
        price: unitPrice,
        quantity,
        engraving,
        addedAt: Date.now()
      });
    }
    this.saveState();
  }

  updateQuantity(cartItemId, newQty) {
    if (newQty <= 0) {
      this.removeFromCart(cartItemId);
      return;
    }
    const item = this.state.cart.find(i => i.id === cartItemId);
    if (item) {
      item.quantity = newQty;
      this.saveState();
    }
  }

  removeFromCart(cartItemId) {
    this.state.cart = this.state.cart.filter(i => i.id !== cartItemId);
    this.saveState();
  }

  clearCart() {
    this.state.cart = [];
    this.saveState();
  }

  toggleSample(sampleId) {
    const idx = this.state.selectedSamples.indexOf(sampleId);
    if (idx > -1) {
      this.state.selectedSamples.splice(idx, 1);
    } else {
      if (this.state.selectedSamples.length >= 2) {
        this.state.selectedSamples.shift(); // keep maximum 2 samples
      }
      this.state.selectedSamples.push(sampleId);
    }
    this.saveState();
  }

  toggleGiftWrapping(enabled, note = '') {
    this.state.giftWrapping.enabled = enabled;
    if (note !== undefined) this.state.giftWrapping.note = note;
    this.saveState();
  }

  applyPromo(code) {
    const trimmed = (code || '').trim().toUpperCase();
    if (PROMO_CODES[trimmed]) {
      this.state.appliedPromo = {
        code: trimmed,
        ...PROMO_CODES[trimmed]
      };
      this.saveState();
      return { success: true, message: PROMO_CODES[trimmed].label };
    }
    return { success: false, message: 'Invalid or expired promotional code' };
  }

  removePromo() {
    this.state.appliedPromo = null;
    this.saveState();
  }

  getCartTotals() {
    let subtotal = 0;
    this.state.cart.forEach(item => {
      subtotal += item.price * item.quantity;
    });

    let discount = 0;
    if (this.state.appliedPromo) {
      if (this.state.appliedPromo.type === 'percent') {
        discount = subtotal * this.state.appliedPromo.discount;
      } else {
        discount = Math.min(subtotal, this.state.appliedPromo.discount);
      }
    }

    const freeShippingThreshold = 150.00;
    const shipping = subtotal >= freeShippingThreshold || subtotal === 0 ? 0.00 : 15.00;
    const taxableSubtotal = Math.max(0, subtotal - discount);
    const tax = taxableSubtotal * 0.08; // 8% luxury sales tax / VAT
    const total = taxableSubtotal + shipping + tax;
    const freeShippingRemaining = Math.max(0, freeShippingThreshold - subtotal);

    return {
      itemCount: this.state.cart.reduce((sum, item) => sum + item.quantity, 0),
      subtotal,
      discount,
      shipping,
      freeShippingThreshold,
      freeShippingRemaining,
      freeShippingEligible: subtotal >= freeShippingThreshold,
      tax,
      total
    };
  }

  // --- WISHLIST ACTIONS ---

  toggleWishlist(productId) {
    const idx = this.state.wishlist.indexOf(productId);
    const isAdded = idx === -1;
    if (isAdded) {
      this.state.wishlist.push(productId);
    } else {
      this.state.wishlist.splice(idx, 1);
    }
    this.saveState();
    return isAdded;
  }

  isInWishlist(productId) {
    return this.state.wishlist.includes(productId);
  }

  moveWishlistToCart(productId) {
    this.addToCart(productId, '100ml', 1);
    this.toggleWishlist(productId);
  }

  moveAllWishlistToCart() {
    this.state.wishlist.forEach(id => {
      this.addToCart(id, '100ml', 1);
    });
    this.state.wishlist = [];
    this.saveState();
  }

  clearWishlist() {
    this.state.wishlist = [];
    this.saveState();
  }

  // --- ORDER CREATION & CHECKOUT ---

  createOrder(checkoutData) {
    const totals = this.getCartTotals();
    const orderId = 'MR-2026-' + Math.floor(1000 + Math.random() * 9000);
    const now = new Date();
    const dateStr = now.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });

    const orderItems = this.state.cart.map(item => {
      const p = PRODUCTS.find(prod => prod.id === item.productId);
      return {
        productId: item.productId,
        name: p ? p.name : 'Haute Fragrance',
        size: item.size,
        price: item.price,
        quantity: item.quantity,
        engraving: item.engraving,
        image: p ? p.images.isolated : 'assets/hero_bottle.png'
      };
    });

    const newOrder = {
      id: orderId,
      date: dateStr,
      status: 'Order Placed',
      statusStep: 1, // 1: Confirmed, 2: Engraved, 3: Quality Passed, 4: Dispatched, 5: Delivered
      carrier: checkoutData.shippingMethod === 'express' ? 'DHL Express Priority' : 'White Glove Concierge Delivery',
      trackingNumber: 'DHL-EXP-' + Math.floor(100000000 + Math.random() * 900000000),
      eta: 'Delivery within 12 to 24 hours',
      items: orderItems,
      selectedSamples: [...this.state.selectedSamples],
      giftWrapping: { ...this.state.giftWrapping },
      subtotal: totals.subtotal,
      discount: totals.discount,
      shipping: totals.shipping,
      tax: totals.tax,
      total: totals.total,
      deliveryAddress: checkoutData.address,
      paymentMethod: checkoutData.paymentMethod
    };

    // Prepend to orders list
    this.state.orders.unshift(newOrder);

    // Add reward points (1 point per dollar spent)
    this.state.user.loyaltyPoints += Math.round(totals.total);

    // Clear cart and samples
    this.state.cart = [];
    this.state.appliedPromo = null;

    this.saveState();
    return newOrder;
  }

  // --- NAVIGATION & UI STATE ---

  setTab(tab) {
    this.state.currentTab = tab;
    this.saveState();
  }

  setCategory(category) {
    this.state.activeCategory = category;
    this.saveState();
  }

  resetDemoData() {
    this.state = this.getDefaultState();
    this.saveState();
  }
}

const fragranceStore = new FragranceStore();
