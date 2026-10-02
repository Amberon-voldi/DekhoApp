# Dekho Development Roadmap

This roadmap outlines the strategic phases for building and launching the Dekho application.

## Phase 1: Frontend Foundation (Current)
*Focus: Building a robust, high-fidelity user interface that validates the UX.*
- Implement Clean Architecture (Domain, Data, Presentation).
- Setup Riverpod for state management and GoRouter for navigation.
- Implement the Design System (Tokens, Typography, Colors).
- Build all UI screens (Home, Search, Details, Compare, Wishlist).
- Create a comprehensive Mock Data layer to simulate network requests.
- Ensure pixel-perfect responsive layouts on mobile devices.

## Phase 2: Backend API Development
*Focus: Replacing mock data with a real, scalable backend.*
- Select technology stack (Node.js/Express or Go).
- Setup PostgreSQL database for user data and analytics.
- Setup Elasticsearch or Typesense for high-performance product search.
- Create REST endpoints matching the `API_PLAN.md`.
- Implement basic JWT-based authentication for user accounts.
- Update Flutter app's Data layer to use `ApiProductRepository`.

## Phase 3: Retailer Integrations
*Focus: Sourcing real product data and prices.*
- Integrate official API access where available (e.g., Amazon Product Advertising API).
- Develop robust, legal scraping microservices for retailers without public APIs.
- Build a normalization engine to map differing retailer product titles and variants to a single master Dekho `Product` entity.
- Implement real-time price checking for the Product Detail page.

## Phase 4: Affiliate & Monetization
*Focus: Implementing the revenue engine.*
- Register for direct affiliate programs (Amazon, Flipkart).
- Register for aggregator networks (Cuelinks, Admitad).
- Implement the `/go/:offerId` redirect tracking service.
- Setup dashboard to monitor click-through rates (CTR) and conversion postbacks.

## Phase 5: Analytics & Growth
*Focus: Understanding user behavior to optimize conversions.*
- Integrate Firebase Analytics.
- Define custom events (e.g., `search_executed`, `filter_applied`, `wishlist_added`, `outbound_click`).
- Implement Crashlytics for stability monitoring.
- Build SEO-friendly web version of Product Detail pages for organic acquisition (Deep linking).

## Phase 6: Production Launch
*Focus: Releasing to the public.*
- Final QA and performance profiling.
- Prepare App Store and Play Store metadata (Screenshots, descriptions).
- Implement remote configuration for feature flagging.
- Launch v1.0.0.
