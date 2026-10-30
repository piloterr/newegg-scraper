<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Newegg Scraper API by Piloterr – scrape Newegg data as JSON" width="100%"></a>
</p>

# Newegg Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Newegg Scraper API** lets you extract public data from Newegg as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Newegg Product API** — Newegg Product API: fetch full product page data from an item number, product ID or URL.
- **Newegg Search API** — Newegg Search API: search product listings by keyword or URL on Newegg.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Newegg Product API](#newegg-product-api) | `/v2/newegg/product` | 2 | Newegg Product API |
| [Newegg Search API](#newegg-search-api) | `/v2/newegg/search` | 2 | Newegg Search API |

## Table of contents

- [How it works](#how-it-works)
- [Newegg Product API](#newegg-product-api)
- [Newegg Search API](#newegg-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Newegg Product API

Newegg Product API: fetch full product page data from an item number, product ID or URL. Returns pricing, specs, images, ratings, seller info and promo codes via browser rendering.

`GET | POST https://api.piloterr.com/v2/newegg/product` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Newegg item number, product ID, or full product URL. |
| `return_page_source` | boolean | — | When `true`, return the raw HTML page source as `{"result": "..."}` instead of structured JSON. Defaults to `false`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/newegg/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "N82E16819113844",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type NeweggProduct = {
  upc?: string;
  url?: string;
  brand?: string;
  model?: string;
  price?: number;
  title?: string;
  images?: string[];
  rating?: number;
  savings?: number;
  currency?: string;
  in_stock?: boolean;
  image_url?: string;
  seller_id?: unknown;
  product_id?: string;
  promo_code?: string;
  breadcrumbs?: string[];
  description?: unknown;
  item_number?: string;
  seller_name?: string;
  subcategory?: string;
  availability?: string;
  review_count?: number;
  bullet_points?: string[];
  original_price?: number;
  promotion_text?: string;
  [key: string]: unknown;
};

const params = new URLSearchParams({
  "query": "N82E16819113844",
});

const response = await fetch(`https://api.piloterr.com/v2/newegg/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as NeweggProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/newegg/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "N82E16819113844"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "upc": "730143315609",
  "url": "https://www.newegg.com/amd-ryzen-5-9000-series-ryzen-5-9600x-granite-ridge-socket-am5-desktop-cpu-processor/p/N82E16819113844",
  "brand": "AMD",
  "model": "100-100001405WOF",
  "price": 189.99,
  "title": "AMD Ryzen 5 9600X - Ryzen 5 9000 Series Granite Ridge (Zen 5) 6-Core 3.9 GHz - Socket AM5 65W - Radeon Graphics Processor - 100-100001405WOF",
  "images": [
    "https://c1.neweggimages.com/productimage/nb640/19-113-844-05.jpg",
    "https://c1.neweggimages.com/productimage/nb640/19-113-844-08.jpg"
  ],
  "rating": 4.8,
  "savings": 89.01,
  "currency": "USD",
  "in_stock": true,
  "image_url": "https://c1.neweggimages.com/productimage/nb640/19-113-844-05.jpg",
  "seller_id": null,
  "product_id": "N82E16819113844",
  "promo_code": "SSF69677",
  "breadcrumbs": [
    "Components & Storage",
    "CPU / Processor"
  ],
  "description": null,
  "item_number": "19-113-844",
  "seller_name": "example",
  "subcategory": "Desktop CPU Processor",
  "availability": "in_stock",
  "review_count": 484,
  "bullet_points": [
    "Experience exceptional gaming performance with smooth 100+ FPS in the most popular games.",
    "This processor features 6 cores and 12 threads, based on AMD's \"Zen 5\" architecture."
  ],
  "original_price": 279,
  "promotion_text": "+ $10 off w/ promo code SSF69677, limited offer"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `upc` | string |  |
| `url` | string |  |
| `brand` | string |  |
| `model` | string |  |
| `price` | number |  |
| `title` | string |  |
| `images` | string[] |  |
| `rating` | number |  |
| `savings` | number |  |
| `currency` | string |  |
| `in_stock` | boolean |  |
| `image_url` | string |  |
| `seller_id` | object |  |
| `product_id` | string |  |
| `promo_code` | string |  |
| `breadcrumbs` | string[] |  |
| `description` | object |  |
| `item_number` | string |  |
| `seller_name` | string |  |
| `subcategory` | string |  |
| `availability` | string |  |
| `review_count` | integer |  |
| `bullet_points` | string[] |  |
| `original_price` | integer |  |
| `promotion_text` | string |  |

## Newegg Search API

Newegg Search API: search product listings by keyword or URL on Newegg. Returns prices, ratings, stock flags, marketplace/combo signals and pagination via browser rendering.

`GET | POST https://api.piloterr.com/v2/newegg/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Search keyword or full Newegg search URL. |
| `page` | number | — | 1-based page number (default: 1). |
| `return_page_source` | boolean | — | When `true`, return the raw HTML page source as `{"result": "..."}` instead of structured JSON. Defaults to `false`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/newegg/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "ryzen 5 9600x",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type NeweggSearch = {
  results?: {
    url?: string;
    brand?: string;
    model?: string;
    price?: number;
    title?: string;
    rating?: number;
    currency?: string;
    in_stock?: boolean;
    is_combo?: boolean;
    image_url?: string;
    product_id?: string;
    item_number?: string;
    availability?: string;
    review_count?: number;
    is_marketplace?: boolean;
    is_refurbished?: boolean;
    original_price?: number;
    promotion_text?: string;
  }[];
  pagination?: {
    next?: unknown;
    page?: number;
    keyword?: string;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "ryzen 5 9600x",
});

const response = await fetch(`https://api.piloterr.com/v2/newegg/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as NeweggSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/newegg/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "ryzen 5 9600x"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "url": "https://www.newegg.com/amd-ryzen-5-9000-series-ryzen-5-9600x-granite-ridge-socket-am5-desktop-cpu-processor/p/N82E16819113844",
      "brand": "AMD",
      "model": "100-100001405WOF",
      "price": 189.99,
      "title": "AMD Ryzen 5 9600X - Ryzen 5 9000 Series Granite Ridge (Zen 5) 6-Core 3.9 GHz - Socket AM5 65W - Radeon Graphics Processor - 100-100001405WOF",
      "rating": 4.8,
      "currency": "USD",
      "in_stock": true,
      "is_combo": false,
      "image_url": "https://c1.neweggimages.com/ProductImageCompressAll300/19-113-844-05.jpg",
      "product_id": "N82E16819113844",
      "item_number": "19-113-844",
      "availability": "in_stock",
      "review_count": 484,
      "is_marketplace": false,
      "is_refurbished": false,
      "original_price": 279,
      "promotion_text": "+ $10 off w/ promo code SSF69677, limited offer"
    }
  ],
  "pagination": {
    "next": null,
    "page": 1,
    "keyword": "ryzen 5 9600x",
    "per_page": 20,
    "total_pages": 1,
    "total_results": 8
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].url` | string |  |
| `results[].brand` | string |  |
| `results[].model` | string |  |
| `results[].price` | number |  |
| `results[].title` | string |  |
| `results[].rating` | number |  |
| `results[].currency` | string |  |
| `results[].in_stock` | boolean |  |
| `results[].is_combo` | boolean |  |
| `results[].image_url` | string |  |
| `results[].product_id` | string |  |
| `results[].item_number` | string |  |
| `results[].availability` | string |  |
| `results[].review_count` | integer |  |
| `results[].is_marketplace` | boolean |  |
| `results[].is_refurbished` | boolean |  |
| `results[].original_price` | integer |  |
| `results[].promotion_text` | string |  |
| `pagination` | object |  |
| `pagination.next` | object |  |
| `pagination.page` | integer |  |
| `pagination.keyword` | string |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Newegg plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Newegg?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/newegg/product` **2**, `/v2/newegg/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Newegg API return?

Each endpoint returns structured JSON: **Newegg Product** — `upc`, `url`, `brand`, `model`, `price`, `title`; **Newegg Search** — `results[]`, `results[].url`, `results[].brand`, `results[].model`, `results[].price`, `results[].title`.

### How do I paginate Newegg results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Newegg is a trademark of its respective owner. This repository is not affiliated with or endorsed by Newegg. Examples are released under the MIT license.</sub>
