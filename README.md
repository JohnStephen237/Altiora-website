# Altiora Website (Open Source)

Altiora is a fitness-first platform and community.  
This repo contains the open-source marketing site built with **Astro + Tailwind CSS + TypeScript**.  
It’s fast by default (static HTML), content-driven (Markdown/MDX), and deploys cleanly to any static host (S3/CloudFront, Netlify, Vercel, etc.).

> Live site: https://altiora.fit

---

## ✨ Highlights

- ⚡ **Zero-JS by default** with Astro Islands for selective interactivity
- 🧱 **Content Collections** with typed frontmatter (safe, MD-first editing)
- 🧭 **Central Base layout** for consistent SEO/meta + theming
- 🖼️ **Optimized images** via `astro:assets` or `/public` with responsive output
- 📨 **Form-ready** (waitlist/contact) — works with Netlify, Formspree, or custom endpoints
- 🔍 **SEO-friendly**: clean URLs, meta tags, OG images, sitemap/robots (via integrations)
- 📱 **Responsive**: Tailwind utility design system
- 🧩 **Composable pages**: content-driven 404, About, Features, Terms, etc.
- ☁️ **Static hosting**: S3/CloudFront-friendly, works behind any CDN

---

## 📁 Project Structure

├── public/
│ └── images/ # Static assets (served as-is)
├── src/
│ ├── components/
│ │ └── PageHeader.astro
│ ├── content/
│ │ ├── config.ts # Content Collections schema (Zod)
│ │ └── pages/
│ │ ├── 404.md # MD-driven 404 content
│ │ └── ... # Other page content (about, terms, etc.)
│ ├── layouts/
│ │ └── Base.astro # Global <head>, meta, and shell
│ ├── pages/
│ │ ├── 404.astro # Renders content from content/pages/404.md
│ │ └── index.astro # Home (or MDX)
│ └── lib/
│ └── utils/textConverter.ts
├── astro.config.mjs
├── tailwind.config.cjs
├── tsconfig.json
└── package.json

Content lives in `src/content/pages`. Types are enforced in `src/content.config.ts`.

🔧 Configuration

Site settings: src/config/config.json (e.g., params.contact_form_action)

Images:

Put raw/static files in /public/images and use <img src="/images/..." />

Or import via astro:assets for automatic optimization:

---
// import Hero from "@/assets/hero.png";
---
<!-- <Image src={Hero} alt="..." /> -->
```

Editor defaults: .editorconfig keeps line endings/indentation consistent

Formatting: use Prettier + ESLint (optional) for code style

📨 Forms (Waitlist / Contact)

This project ships with semantic forms and spam-safe defaults (labels, required, honeypot).
Point action to your provider or serverless endpoint:

Netlify: <form method="POST" netlify> (add hidden honeypot field)

Formspree: action="https://formspree.io/f/xxxxxxx"

Custom: handle POST in your API and return a redirect/thank-you

🛠️ Getting Started
Prerequisites

Node.js LTS (recommended)

Local Dev
npm install
npm run dev


Open the local URL printed in your terminal. Edits hot-reload automatically.

Production Build
npm run build


Output is generated in ./dist.

🚀 Deployment
S3/CloudFront (example)

Build: npm run build

Sync: aws s3 sync dist/ s3://YOUR_BUCKET --delete

Set Index to index.html and Error to 404.html (or custom) in S3/CloudFront

Invalidate CloudFront: aws cloudfront create-invalidation --distribution-id ABC123 --paths "/*"

Also ensure your DNS (Route 53) points to the CDN and that 404s are served by the CDN rather than redirecting to /.

Netlify / Vercel

Import the repo, set build command npm run build, output dir dist

Add Astro integrations for sitemap/robots if desired

🧪 Scripts

dev — start local dev server

build — production build

preview — preview production build locally

(See package.json for the full list.)

🤝 Contributing

We welcome issues and pull requests!

Fork the repo & create a feature branch: feat/your-change

npm i && npm run dev

Add or update tests/content if relevant

Submit a PR describing the change and screenshots when UI changes

Please keep performance (Lighthouse), accessibility (labels, contrast), and SEO (head/meta) in mind.

🛡️ License

Code: MIT © Altiora Contributors

Brand & Content (logos, names, mascots, copy, images, videos): All Rights Reserved.
Do not use Altiora brand assets without written permission.

Third-party packages and assets retain their own licenses.


🙏 Acknowledgements

Built with Astro
, Tailwind CSS
, and the broader open-source community.

