<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Newegg Scraper API by Piloterr – scrape Newegg data as JSON" width="100%"></a>
</p>

# Newegg Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Newegg Scraper API** lets you extract public data from Newegg as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Newegg Product API** — Read a Newegg product from an item number, catalog id, or URL.
- **Newegg Search API** — Search Newegg by keyword or search URL.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Newegg Product API](#newegg-product-api) | `/v2/newegg/product` | 2 | Read a Newegg product from an item number, catalog id, or URL. Returns price, specs, images, and seller. |
| [Newegg Search API](#newegg-search-api) | `/v2/newegg/search` | 2 | Search Newegg by keyword or search URL. Returns item numbers, dollar prices, stock, and pagination. |

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

Read a Newegg product from an item number, catalog id, or URL. Returns price, specs, images, and seller.

`GET | POST https://api.piloterr.com/v2/newegg/product` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Item number, catalog id, or product URL. |
| `return_page_source` | boolean | — | When true, return the raw HTML. The string false stays false. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/newegg/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "N82E16823126188",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type NeweggProduct = {
  url?: string;
  brand?: string;
  price?: number;
  title?: string;
  currency?: string;
  in_stock?: boolean;
  product_id?: string;
  item_number?: string;
  price_display?: string;
};

const params = new URLSearchParams({
  "query": "N82E16823126188",
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

{"query": "N82E16823126188"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "url": "https://www.newegg.com/logitech-mk320-920-002836-usb-rf-wireless/p/N82E16823126188",
  "brand": "Logitech",
  "price": 32.99,
  "title": "Logitech MK320 Wireless Desktop Keyboard and Mouse Combo",
  "currency": "USD",
  "in_stock": true,
  "product_id": "N82E16823126188",
  "item_number": "9SIA1CZEDK9378",
  "price_display": "$32.99"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `url` | string |  |
| `brand` | string |  |
| `price` | number |  |
| `title` | string |  |
| `currency` | string |  |
| `in_stock` | boolean |  |
| `product_id` | string |  |
| `item_number` | string |  |
| `price_display` | string |  |

## Newegg Search API

Search Newegg by keyword or search URL. Returns item numbers, dollar prices, stock, and pagination.

`GET | POST https://api.piloterr.com/v2/newegg/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Keyword or a newegg.com search URL. |
| `page` | number | — | Page number, starting at 1. Example: 2. |
| `return_page_source` | boolean | — | When true, return the raw HTML. The string false stays false. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/newegg/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "logitech keyboard",
    },
    timeout=120,
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
    price?: number;
    title?: string;
    rating?: number;
    currency?: string;
    in_stock?: boolean;
    product_id?: string;
    item_number?: string;
    review_count?: number;
    price_display?: string;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    keyword?: string;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "logitech keyboard",
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

{"query": "logitech keyboard"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "url": "https://www.newegg.com/logitech-mk320-920-002836-usb-rf-wireless/p/N82E16823126188",
      "brand": "Logitech",
      "price": 36.99,
      "title": "Logitech MK320 Wireless Desktop Keyboard and Mouse Combo",
      "rating": 3.7,
      "currency": "USD",
      "in_stock": true,
      "product_id": "N82E16823126188",
      "item_number": "23-126-188",
      "review_count": 289,
      "price_display": "$36.99"
    }
  ],
  "pagination": {
    "next": "https://www.newegg.com/p/pl?d=logitech+keyboard&page=2",
    "page": 1,
    "keyword": "logitech keyboard",
    "per_page": 44,
    "total_pages": 20,
    "total_results": 1529
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].url` | string |  |
| `results[].brand` | string |  |
| `results[].price` | number |  |
| `results[].title` | string |  |
| `results[].rating` | number |  |
| `results[].currency` | string |  |
| `results[].in_stock` | boolean |  |
| `results[].product_id` | string |  |
| `results[].item_number` | string |  |
| `results[].review_count` | integer |  |
| `results[].price_display` | string |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.keyword` | string |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

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

Each endpoint returns structured JSON: **Newegg Product** — `url`, `brand`, `price`, `title`, `currency`, `in_stock`; **Newegg Search** — `results[]`, `results[].url`, `results[].brand`, `results[].price`, `results[].title`, `results[].rating`.

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
