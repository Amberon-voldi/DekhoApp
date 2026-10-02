# Dekho API Plan (Phase 2)

While Phase 1 uses mock data, Phase 2 will introduce a dedicated backend (likely Node.js/Express or Go) to serve real data. This document outlines the planned REST API structure.

## Base URL
`https://api.dekho-app.com/v1`

## 1. Products API

### `GET /products/search`
Search and filter the product catalog.
- **Query Parameters:**
  - `q`: Search string (e.g., "iphone")
  - `sort`: `price_asc`, `price_desc`, `discount`, `rating`, `recommended` (default)
  - `min_price`, `max_price`: Numbers
  - `brands`: Comma-separated (e.g., "apple,samsung")
  - `retailers`: Comma-separated (e.g., "amazon,flipkart")
  - `page`: Integer (default 1)
  - `limit`: Integer (default 20)
- **Response:**
  ```json
  {
    "query": "iphone",
    "totalCount": 145,
    "page": 1,
    "products": [ /* Array of Product Objects */ ]
  }
  ```

### `GET /products/:id`
Retrieve detailed information for a specific product.
- **Response:** Full Product object including specifications and offers.

### `GET /products/:id/offers`
Fetch real-time updated prices for a product. Used to refresh prices on the Product Detail screen without reloading static product metadata.
- **Response:** Array of `RetailerOffer` objects.

### `GET /products/trending`
Retrieve currently popular products based on search volume and clicks.

## 2. Categories API

### `GET /categories`
Retrieve the category hierarchy.
- **Response:**
  ```json
  [
    {
      "id": "c_mobiles",
      "name": "Mobiles",
      "icon": "smartphone",
      "productCount": 1250
    }
  ]
  ```

## 3. Affiliate & Tracking API

### `GET /go/:offerId`
The core affiliate redirect endpoint.
- **Description:** The app hits this endpoint when a user taps "Buy Now". The server logs the click, determines the best affiliate network link, and returns an HTTP 302 redirect to the retailer.
- **Headers:** `User-Agent`, `Authorization` (optional, for tying clicks to users).
- **Response:** `302 Found` with `Location` header pointing to e.g., `https://amazon.in/dp/B0CX...&tag=dekho-21`

### `POST /clicks`
Used for telemetry and analytics within the app before redirecting, if the app handles the redirect locally (alternative to `/go/`).

## Response Standards
- **Success:** `200 OK` with JSON payload.
- **Error:** `4xx` or `5xx` with standard error object:
  ```json
  {
    "error": {
      "code": "INVALID_PARAMETERS",
      "message": "The provided max_price is lower than min_price."
    }
  }
  ```
