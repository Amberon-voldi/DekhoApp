# Dekho Product Specification

## What is Dekho?
Dekho is a premium product discovery and price-comparison application designed specifically for the Indian market. It aggregates product listings across major e-commerce retailers, allowing users to find the best deals, track price changes, and seamlessly compare options in a single unified interface.

## Target Audience
- **Demographics:** Indian consumers aged 18-45
- **Behavior:** Frequent online shoppers who prioritize finding the best deals and rely on comparisons before making purchase decisions.
- **Geography:** Tier 1, Tier 2, and expanding into Tier 3 cities in India.

## The Core Problem
Price fragmentation across retailers is a significant pain point for consumers. Users typically have to open multiple apps (Amazon, Flipkart, Myntra, Croma, etc.) or tabs to compare prices, check stock availability, and calculate actual savings after applying bank offers or discounts. This manual process is time-consuming and often leads to missed deals.

## Value Proposition
- **Unified Discovery:** See all prices, stock status, and seller ratings in one place.
- **Time Savings:** Eliminate the need to switch between multiple apps to find the best deal.
- **Smart Tracking:** Monitor price drops and get notified when a product reaches the desired price point.
- **Trust & Transparency:** Unbiased price comparisons with historical data to verify genuine discounts.

## Core User Journey
1. **Discover & Search:** User opens the app, sees trending deals, or searches for a specific product.
2. **Evaluate & Compare:** User views the product details, reviews specifications, and looks at the aggregated list of offers from different retailers.
3. **Save or Act:** User either adds the product to their wishlist to track the price or taps "Buy Now" on the best offer.
4. **Purchase (Affiliate Redirect):** The app seamlessly redirects the user to the chosen retailer's app/website to complete the purchase, logging the affiliate click.

## MVP Scope (Phase 1)
The Initial Minimum Viable Product focuses purely on the frontend application, utilizing mock data to validate the user experience and interface design.
- **Platforms:** Android and iOS (built with Flutter).
- **Core Screens:** Home, Search, Product Detail, Wishlist, Compare.
- **Data:** Comprehensive mock data layer simulating realistic Indian market products and prices.
- **Architecture:** Clean Architecture with Riverpod for state management, ready for backend integration.
- **UI/UX:** High-fidelity, premium design system using Electric Indigo and Plus Jakarta Sans.

## Future Scope (Phase 2+)
- **Backend Infrastructure:** Transition from mock data to a robust API (Node.js/Go) powered by actual retailer data.
- **Web Scraping & APIs:** Integrate official retailer APIs and reliable scraping mechanisms to ensure real-time price accuracy.
- **Affiliate Monetization:** Implement the `GET /go/{offerId}` flow to attribute clicks and earn commissions from networks like Admitad, Cuelinks, or direct Amazon/Flipkart programs.
- **User Accounts & Sync:** Cloud-synced wishlists and personalized deal recommendations.
- **Price Alerts:** Push notifications for price drops on wishlisted items.
