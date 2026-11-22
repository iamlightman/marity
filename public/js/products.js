/**
 * MARITY FRAGRANCES — CATALOGUE & OLFACTORY DATABASE
 * Authentic Haute Parfumerie specifications, olfactory pyramids, bottle sizes, and imagery.
 */

const PRODUCTS = [
  {
    id: 'ocean-breeze',
    name: 'Ocean Breeze',
    brand: 'Marity Trade',
    subtitle: 'L’Onde Azurée',
    concentration: 'Eau de Parfum',
    concentrationBadge: 'Eau de Parfum • 100ml',
    tag: 'Bestseller',
    category: 'mens',
    gender: 'Men’s',
    basePrice: 129.00,
    sizes: [
      { size: '50ml', price: 98.00, label: '50ml (1.7 FL. OZ.)' },
      { size: '100ml', price: 129.00, label: '100ml (3.4 FL. OZ.)', default: true },
      { size: '200ml', price: 189.00, label: '200ml (6.8 FL. OZ.)' }
    ],
    rating: 4.9,
    reviewCount: 342,
    images: {
      primary: 'assets/product_ocean_breeze.png',
      isolated: 'assets/bottle_ocean_breeze_isolated.png',
      detail: 'assets/atomizer_spray_head.png',
      gallery: [
        'assets/product_ocean_breeze.png',
        'assets/bottle_ocean_breeze_isolated.png',
        'assets/atomizer_spray_head.png',
        'assets/promo_card_full.png'
      ]
    },
    shortDesc: 'A tempestuous clash of mineral sea salt, Italian bergamot, and sun-warmed ambergris on ancient coastal cliffs.',
    fullDesc: 'Ocean Breeze opens with an invigorating burst of Calabrian bergamot and ozone mist, evoking the crisp Atlantic sea spray. The heart unfolds with French clary sage and salty maritime accords, before settling into an enduring base of gray ambergris, Indonesian patchouli, and weathered cedarwood. Handcrafted in Grasse, France.',
    notes: {
      top: ['Calabrian Bergamot', 'Mineral Sea Salt', 'Crisp Ozone Mist'],
      heart: ['French Clary Sage', 'Crushed Juniper Berry', 'Maritime Accord'],
      base: ['Rare Ambergris', 'Weathered White Cedar', 'Indonesian Patchouli']
    },
    characteristics: {
      sillage: 'Strong & Radiating (6ft trail)',
      longevity: '12+ Hours on Skin',
      season: 'Spring / Summer Signature',
      character: 'Aquatic, Woody, Noble'
    },
    inStock: true,
    engravable: true,
    accentColor: '#1e3a5f'
  },
  {
    id: 'velvet-bloom',
    name: 'Velvet Bloom',
    brand: 'Marity Trade',
    subtitle: 'Éclat de Soie',
    concentration: 'Eau de Parfum',
    concentrationBadge: 'Eau de Parfum • 100ml',
    tag: 'New',
    category: 'womens',
    gender: 'Women’s',
    basePrice: 139.00,
    sizes: [
      { size: '50ml', price: 105.00, label: '50ml (1.7 FL. OZ.)' },
      { size: '100ml', price: 139.00, label: '100ml (3.4 FL. OZ.)', default: true },
      { size: '200ml', price: 198.00, label: '200ml (6.8 FL. OZ.)' }
    ],
    rating: 4.95,
    reviewCount: 289,
    images: {
      primary: 'assets/product_velvet_bloom.png',
      isolated: 'assets/bottle_velvet_bloom_isolated.png',
      detail: 'assets/atomizer_spray_head.png',
      gallery: [
        'assets/product_velvet_bloom.png',
        'assets/bottle_velvet_bloom_isolated.png',
        'assets/atomizer_spray_head.png',
        'assets/promo_card_full.png'
      ]
    },
    shortDesc: 'A sublime tapestry of Centifolia Rose, sparkling pink pepper, and cashmere white musk wrapped in satin petals.',
    fullDesc: 'Harvested at dawn in the legendary fields of Grasse, the Centifolia Rose delivers an intoxicating velvet radiance. Accented by Madagascar pink peppercorn and crystalline lychee, Velvet Bloom transitions gracefully into a sensual drydown of Tuscan orris root and white cashmere musk.',
    notes: {
      top: ['Grasse Centifolia Rose', 'Madagascar Pink Pepper', 'Sparkling Lychee'],
      heart: ['Peony Petals', 'Egyptian Jasmine Sambac', 'Damascena Infusion'],
      base: ['Tuscan Orris Butter', 'Cashmere White Musk', 'Bourbon Vanilla Bean']
    },
    characteristics: {
      sillage: 'Moderate & Intoxicating',
      longevity: '10-14 Hours',
      season: 'All Seasons / Romantic Evening',
      character: 'Velvety Floral, Powdery, Luminous'
    },
    inStock: true,
    engravable: true,
    accentColor: '#8a4b65'
  },
  {
    id: 'art-of-fragrance-grand-cru',
    name: 'The Art of Fragrance',
    brand: 'Marity Trade',
    subtitle: 'Grand Cru Éternel',
    concentration: 'Extrait de Parfum',
    concentrationBadge: 'Extrait de Parfum • 100ml',
    tag: 'Iconic',
    category: 'unisex',
    gender: 'Unisex',
    basePrice: 165.00,
    sizes: [
      { size: '50ml', price: 125.00, label: '50ml (1.7 FL. OZ.)' },
      { size: '100ml', price: 165.00, label: '100ml (3.4 FL. OZ.)', default: true },
      { size: '200ml', price: 245.00, label: '200ml (6.8 FL. OZ.)' }
    ],
    rating: 5.0,
    reviewCount: 512,
    images: {
      primary: 'assets/hero_bottle.png',
      isolated: 'assets/bottle_hero_isolated.png',
      detail: 'assets/atomizer_spray_head.png',
      gallery: [
        'assets/hero_bottle.png',
        'assets/bottle_hero_isolated.png',
        'assets/atomizer_spray_head.png',
        'assets/hero_banner_full.png'
      ]
    },
    shortDesc: 'The crowning house masterpiece: rare aged golden amber, saffron threads, and royal royal resin in heavy crystal.',
    fullDesc: 'The pinnacle of Marity haute parfumerie. Bottled in hand-polished architectural crystal with a 24k gold-plated flacon cap. A symphony of Persian saffron, rare amber crystals aged for two decades in cognac barrels, and golden beeswax that leaves an unforgettable signature aura.',
    notes: {
      top: ['Persian Saffron Threads', 'Bitter Almond', 'Golden Mandarin'],
      heart: ['Amber Resin Nectar', 'Cedarwood Heart', 'Bulgarian Rose Absolute'],
      base: ['Laotian Oud Wood', 'Roasted Tonka Bean', 'Aged Oakmoss']
    },
    characteristics: {
      sillage: 'Majestic & Enveloping',
      longevity: '16+ Hours',
      season: 'Autumn / Winter / Black Tie',
      character: 'Warm Amber, Opulent, Regal'
    },
    inStock: true,
    engravable: true,
    accentColor: '#9e7328'
  },
  {
    id: 'obsidian-noir',
    name: 'Obsidian Noir',
    brand: 'Marity Trade',
    subtitle: 'Sillage Ténébreux',
    concentration: 'Extrait de Parfum',
    concentrationBadge: 'Extrait de Parfum • 100ml',
    tag: 'Bestseller',
    category: 'unisex',
    gender: 'Unisex',
    basePrice: 155.00,
    sizes: [
      { size: '50ml', price: 115.00, label: '50ml (1.7 FL. OZ.)' },
      { size: '100ml', price: 155.00, label: '100ml (3.4 FL. OZ.)', default: true },
      { size: '200ml', price: 230.00, label: '200ml (6.8 FL. OZ.)' }
    ],
    rating: 4.88,
    reviewCount: 194,
    images: {
      primary: 'assets/bottle_obsidian_noir.png',
      isolated: 'assets/bottle_obsidian_noir.png',
      detail: 'assets/atomizer_spray_head.png',
      gallery: [
        'assets/bottle_obsidian_noir.png',
        'assets/cat_unisex.png',
        'assets/atomizer_spray_head.png'
      ]
    },
    shortDesc: 'A hypnotic nightfall of smoked agarwood oud, black cardamom, and supple Tuscan glove leather.',
    fullDesc: 'Obsidian Noir is an enigmatic, nocturnal elixir designed for those who command the room without saying a word. Deep Cambodian oud melts into smoky incense and spiced black cardamom, grounded by dark vetiver and supple leather.',
    notes: {
      top: ['Black Cardamom', 'Smoked Birch', 'Bitter Cacao'],
      heart: ['Cambodian Oud Wood', 'Tuscan Leather', 'Somalian Frankincense'],
      base: ['Haitian Vetiver', 'Dark Amber Resin', 'Roasted Tonka Bean']
    },
    characteristics: {
      sillage: 'Dark, Lingering & Magnetic',
      longevity: '14+ Hours',
      season: 'Night / Formal / Cold Seasons',
      character: 'Smoky, Leather, Oud'
    },
    inStock: true,
    engravable: true,
    accentColor: '#2b2b36'
  },
  {
    id: 'soleil-dor',
    name: 'Soleil d’Or',
    brand: 'Marity Trade',
    subtitle: 'Nectar Solaire',
    concentration: 'Eau de Parfum',
    concentrationBadge: 'Eau de Parfum • 100ml',
    tag: 'Featured',
    category: 'womens',
    gender: 'Women’s',
    basePrice: 145.00,
    sizes: [
      { size: '50ml', price: 108.00, label: '50ml (1.7 FL. OZ.)' },
      { size: '100ml', price: 145.00, label: '100ml (3.4 FL. OZ.)', default: true },
      { size: '200ml', price: 210.00, label: '200ml (6.8 FL. OZ.)' }
    ],
    rating: 4.92,
    reviewCount: 176,
    images: {
      primary: 'assets/bottle_soleil_dor.png',
      isolated: 'assets/bottle_soleil_dor.png',
      detail: 'assets/atomizer_spray_head.png',
      gallery: [
        'assets/bottle_soleil_dor.png',
        'assets/hero_bottle.png',
        'assets/atomizer_spray_head.png'
      ]
    },
    shortDesc: 'Liquid Mediterranean sunshine: Sicilian neroli, orange blossom honey, and luminous solar amber.',
    fullDesc: 'Inspired by golden hour along the Côte d’Azur. Soleil d’Or bathes the senses in sparkling Mediterranean mandarin and neroli blossoms, enveloped in a radiant honeyed nectar and warm sandalwood base.',
    notes: {
      top: ['Sicilian Green Mandarin', 'Neroli Petals', 'Bergamot Zest'],
      heart: ['Orange Blossom Honey', 'Ylang-Ylang Comores', 'Heliotrope'],
      base: ['Solar Amber Accord', 'Mysore Sandalwood', 'Tahitian Vanilla']
    },
    characteristics: {
      sillage: 'Radiant & Uplifting',
      longevity: '10-12 Hours',
      season: 'Summer / Daytime Elegance',
      character: 'Citrus Floral, Solar, Golden'
    },
    inStock: true,
    engravable: true,
    accentColor: '#c59b27'
  },
  {
    id: 'santal-blanc',
    name: 'Santal Blanc',
    brand: 'Marity Trade',
    subtitle: 'Pur Velours',
    concentration: 'Eau de Parfum',
    concentrationBadge: 'Eau de Parfum • 100ml',
    tag: 'Refined',
    category: 'unisex',
    gender: 'Unisex',
    basePrice: 135.00,
    sizes: [
      { size: '50ml', price: 102.00, label: '50ml (1.7 FL. OZ.)' },
      { size: '100ml', price: 135.00, label: '100ml (3.4 FL. OZ.)', default: true },
      { size: '200ml', price: 195.00, label: '200ml (6.8 FL. OZ.)' }
    ],
    rating: 4.87,
    reviewCount: 122,
    images: {
      primary: 'assets/bottle_santal_blanc.png',
      isolated: 'assets/bottle_santal_blanc.png',
      detail: 'assets/atomizer_spray_head.png',
      gallery: [
        'assets/bottle_santal_blanc.png',
        'assets/bottle_velvet_bloom_isolated.png',
        'assets/atomizer_spray_head.png'
      ]
    },
    shortDesc: 'A minimalist sanctuary of Australian white sandalwood, green cardamom pods, and violet leaf.',
    fullDesc: 'Epitomizing modern architectural serenity. Santal Blanc cushions the crisp freshness of green cardamom and crushed violet leaves upon a cloud of creamy Australian sandalwood and delicate white musk.',
    notes: {
      top: ['Green Cardamom', 'Crisp Violet Leaf', 'Carrot Seed'],
      heart: ['Australian White Sandalwood', 'Papyrus Accord', 'Iris Pallida'],
      base: ['White Cedarwood', 'Clean Musks', 'Creamy Amber']
    },
    characteristics: {
      sillage: 'Subtle, Skin-Scent Luxury',
      longevity: '11 Hours',
      season: 'Year-Round Sophistication',
      character: 'Creamy Wood, Clean, Meditative'
    },
    inStock: true,
    engravable: true,
    accentColor: '#7b8794'
  },
  {
    id: 'fleur-sauvage',
    name: 'Fleur Sauvage',
    brand: 'Marity Trade',
    subtitle: 'Émeraude Botanique',
    concentration: 'Eau de Parfum',
    concentrationBadge: 'Eau de Parfum • 100ml',
    tag: 'New',
    category: 'womens',
    gender: 'Women’s',
    basePrice: 142.00,
    sizes: [
      { size: '50ml', price: 106.00, label: '50ml (1.7 FL. OZ.)' },
      { size: '100ml', price: 142.00, label: '100ml (3.4 FL. OZ.)', default: true },
      { size: '200ml', price: 205.00, label: '200ml (6.8 FL. OZ.)' }
    ],
    rating: 4.89,
    reviewCount: 96,
    images: {
      primary: 'assets/bottle_fleur_sauvage.png',
      isolated: 'assets/bottle_fleur_sauvage.png',
      detail: 'assets/atomizer_spray_head.png',
      gallery: [
        'assets/bottle_fleur_sauvage.png',
        'assets/product_ocean_breeze.png',
        'assets/atomizer_spray_head.png'
      ]
    },
    shortDesc: 'An untamed garden after rain: Indian tuberose, galbanum stems, and crisp green vetiver.',
    fullDesc: 'Daring and vividly green. Fleur Sauvage captures the intoxicating mystery of nocturnal blooms in a French botanical greenhouse. Heavy white tuberose petals are sharpened by wild galbanum and rooted in earthy vetiver.',
    notes: {
      top: ['Wild Galbanum', 'Dewy Ivy Leaf', 'Pink Grapefruit'],
      heart: ['Indian Tuberose Absolute', 'Jasmine Sambac', 'Green Fig Accord'],
      base: ['Haitian Vetiver Root', 'Oakmoss', 'Clean Ambergris']
    },
    characteristics: {
      sillage: 'Bold & Hypnotic',
      longevity: '12 Hours',
      season: 'Spring / Twilight',
      character: 'Green Floral, Earthy, Lush'
    },
    inStock: true,
    engravable: true,
    accentColor: '#2b533b'
  },
  {
    id: 'luxury-gift-coffret',
    name: 'Discovery Coffret Prestige',
    brand: 'Marity Trade',
    subtitle: 'Écrin Découverte 5x10ml',
    concentration: 'Collection Extrait',
    concentrationBadge: '5 Flacons • 10ml each',
    tag: 'Gift Set',
    category: 'gifts',
    gender: 'Gifts',
    basePrice: 110.00,
    sizes: [
      { size: '5x10ml', price: 110.00, label: 'Coffret 5 x 10ml Flacons', default: true },
      { size: '5x20ml', price: 185.00, label: 'Prestige Coffret 5 x 20ml' }
    ],
    rating: 4.98,
    reviewCount: 420,
    images: {
      primary: 'assets/bottle_gift_coffret.png',
      isolated: 'assets/cat_gifts.png',
      detail: 'assets/atomizer_spray_head.png',
      gallery: [
        'assets/bottle_gift_coffret.png',
        'assets/cat_gifts.png',
        'assets/promo_card_full.png'
      ]
    },
    shortDesc: 'Our five signature masterpieces presented in a handcrafted black lacquer box tied with champagne satin.',
    fullDesc: 'The ultimate olfactory voyage. Contains luxury miniature flacons of The Art of Fragrance, Ocean Breeze, Velvet Bloom, Obsidian Noir, and Santal Blanc. Includes an exclusive voucher redeemable against any full-size flacon.',
    notes: {
      top: ['Curated Discovery Set', '5 Distinct Masterpieces', 'Exclusive Luxury Packaging'],
      heart: ['Ocean Breeze', 'Velvet Bloom', 'The Art of Fragrance'],
      base: ['Obsidian Noir', 'Santal Blanc', 'GH₵50 Gift Voucher Included']
    },
    characteristics: {
      sillage: 'Varies by Fragrance',
      longevity: 'Full-Day Sampling',
      season: 'Ideal for Gifting',
      character: 'Exclusive, Curated, Luxury'
    },
    inStock: true,
    engravable: false,
    accentColor: '#33271e'
  }
];

// Valid Promo Codes
const PROMO_CODES = {
  'MARITY10': { discount: 0.10, type: 'percent', label: '10% Privilège Discount' },
  'GOLDEN': { discount: 20.00, type: 'fixed', label: 'GH₵20 Trade Voucher' },
  'VIPCONCIERGE': { discount: 0.15, type: 'percent', label: '15% VIP Connoisseur Benefit' }
};

const COMPLIMENTARY_SAMPLES = [];

if (typeof module !== 'undefined' && module.exports) {
  module.exports = { PRODUCTS, COMPLIMENTARY_SAMPLES, PROMO_CODES };
}
