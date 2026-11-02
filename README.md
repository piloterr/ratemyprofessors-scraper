<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Rate My Professors Scraper API by Piloterr – scrape Rate My Professors data as JSON" width="100%"></a>
</p>

# Rate My Professors Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Rate My Professors Scraper API** lets you extract public data from Rate My Professors as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Rate My Professors Professor API** — Read one Rate My Professors profile, including difficulty and would-take-again when the page shows them.
- **Rate My Professors Search API** — Search Rate My Professors by name.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Rate My Professors Professor API](#rate-my-professors-professor-api) | `/v2/ratemyprofessors/professor` | 2 | Read one Rate My Professors profile, including difficulty and would-take-again when the page shows them. |
| [Rate My Professors Search API](#rate-my-professors-search-api) | `/v2/ratemyprofessors/search` | 2 | Search Rate My Professors by name. Cards include school, department, difficulty, and would-take-again when the card shows them. |

## Table of contents

- [How it works](#how-it-works)
- [Rate My Professors Professor API](#rate-my-professors-professor-api)
- [Rate My Professors Search API](#rate-my-professors-search-api)
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

## Rate My Professors Professor API

Read one Rate My Professors profile, including difficulty and would-take-again when the page shows them.

`GET | POST https://api.piloterr.com/v2/ratemyprofessors/professor` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. The numeric professor id from search, or a /professor/{id} URL. A name is not accepted. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/ratemyprofessors/professor",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "1064107",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type RateMyProfessorsProfessor = {
  id?: string;
  url?: string;
  name?: string;
  rating?: number;
  school?: string;
  last_name?: string;
  department?: string;
  difficulty?: number;
  first_name?: string;
  school_url?: string;
  ratings_count?: number;
  would_take_again_percent?: number;
};

const params = new URLSearchParams({
  "query": "1064107",
});

const response = await fetch(`https://api.piloterr.com/v2/ratemyprofessors/professor?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as RateMyProfessorsProfessor;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/ratemyprofessors/professor
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "1064107"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "1064107",
  "url": "https://www.ratemyprofessors.com/professor/1064107",
  "name": "Kevin Smith",
  "rating": 4.6,
  "school": "Rio Hondo College",
  "last_name": "example",
  "department": "Psychology",
  "difficulty": 3.1,
  "first_name": "example",
  "school_url": "https://www.ratemyprofessors.com/school/2746",
  "ratings_count": 174,
  "would_take_again_percent": 94
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `url` | string |  |
| `name` | string |  |
| `rating` | number |  |
| `school` | string |  |
| `last_name` | string |  |
| `department` | string |  |
| `difficulty` | number |  |
| `first_name` | string |  |
| `school_url` | string |  |
| `ratings_count` | integer |  |
| `would_take_again_percent` | integer |  |

## Rate My Professors Search API

Search Rate My Professors by name. Cards include school, department, difficulty, and would-take-again when the card shows them.

`GET | POST https://api.piloterr.com/v2/ratemyprofessors/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. A professor name, or a Rate My Professors search URL whose path contains /search/professors or whose query contains q=. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/ratemyprofessors/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "smith",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type RateMyProfessorsSearch = {
  results?: {
    id?: string;
    url?: string;
    name?: string;
    rating?: number;
    school?: string;
    department?: string;
    difficulty?: number;
    ratings_count?: number;
    would_take_again_percent?: number;
  }[];
  pagination?: {
    next?: unknown;
    page?: number;
    per_page?: number;
    total_pages?: unknown;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "smith",
});

const response = await fetch(`https://api.piloterr.com/v2/ratemyprofessors/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as RateMyProfessorsSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/ratemyprofessors/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "smith"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "1064107",
      "url": "https://www.ratemyprofessors.com/professor/1064107",
      "name": "Kevin Smith",
      "rating": 4.6,
      "school": "Rio Hondo College",
      "department": "Psychology",
      "difficulty": 3.1,
      "ratings_count": 174,
      "would_take_again_percent": 94
    }
  ],
  "pagination": {
    "next": null,
    "page": 1,
    "per_page": 5,
    "total_pages": null,
    "total_results": 10000
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].rating` | number |  |
| `results[].school` | string |  |
| `results[].department` | string |  |
| `results[].difficulty` | number |  |
| `results[].ratings_count` | integer |  |
| `results[].would_take_again_percent` | integer |  |
| `pagination` | object |  |
| `pagination.next` | object |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | object |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Professor | Search |
|---|---|---|
| cURL (Bash) | [`professor`](examples/curl/professor.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`professor`](examples/php/professor.php) | [`search`](examples/php/search.php) |
| C# | [`professor`](examples/csharp/Professor.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`professor`](examples/go/professor.go) | [`search`](examples/go/search.go) |
| Java | [`professor`](examples/java/ProfessorExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`professor`](examples/ruby/professor.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`professor`](examples/nodejs/professor.mjs) | [`search`](examples/nodejs/search.mjs) |

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
- **One API key, hundreds of sources** — Rate My Professors plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Rate My Professors?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/ratemyprofessors/professor` **2**, `/v2/ratemyprofessors/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Rate My Professors API return?

Each endpoint returns structured JSON: **Rate My Professors Professor** — `id`, `url`, `name`, `rating`, `school`, `last_name`; **Rate My Professors Search** — `results[]`, `results[].id`, `results[].url`, `results[].name`, `results[].rating`, `results[].school`.

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

<sub>Rate My Professors is a trademark of its respective owner. This repository is not affiliated with or endorsed by Rate My Professors. Examples are released under the MIT license.</sub>
