# Altiora Marketing Site

![Altiora Logo](public/altiora-logo.svg)

Official marketing website for [Altiora](https://altiora.fit) — the fitness-focused social platform for sharing workouts, sports moments, and movement communities.

This site is **built with [Astro](https://astro.build/)** for speed, **[Tailwind CSS](https://tailwindcss.com/)** for styling, and **MDX** for content flexibility.  
It’s deployed to **AWS S3** (static hosting) behind **Amazon CloudFront** (global CDN), with DNS via **Route 53**. Infrastructure is managed with **Terraform**.
---

## ✨ Features
- ⚡ **Blazing fast** — Static-first rendering with partial hydration for interactive sections.
- 🎨 **Custom design system** — Tailwind utility classes and theme tokens.
- 📝 **Content in MDX** — Rich markdown with embedded components.
- 🌍 **i18n-ready** — Structure prepared for EN/FR/ES/HI/ZH locales.
- 📱 **Responsive & accessible** — Looks and works great on all devices.
- 📊 **SEO optimized** — Meta tags, OG images, sitemap, robots, and schema.org.
- 🔒 **No secrets in repo** — All environment variables stored in hosting provider.

---

## 📂 Project Structure

altiora-site/
├── public/ # Static assets
├── src/
│ ├── components/ # Reusable UI elements
│ ├── layouts/ # Page layouts
│ ├── pages/ # Astro pages (routes)
│ ├── content/ # MDX content collections
│ └── styles/ # Global CSS/Tailwind
├── astro.config.mjs # Astro configuration
├── tailwind.config.cjs
└── package.json

---

## 🛠 Tech Stack
- [Astro](https://astro.build/) — static site builder
- [Tailwind CSS](https://tailwindcss.com/) — utility-first CSS
- [MDX](https://mdxjs.com/) — markdown with JSX
- **AWS S3 + CloudFront** — hosting & CDN
- **Terraform** — infrastructure as code  
- [Sanity](https://sanity.io/) *(optional)* — headless CMS for dynamic content

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/YOUR-USERNAME/altiora-site.git
cd altiora-site

2. Install dependencies
npm install

3. Start the development server
npm run dev

4. Build for production
npm run build

📜 License
This project is open-sourced under the MIT License.

📣 Contributing
We welcome community pull requests for:

Bug fixes

Accessibility improvements

Localization contributions

Please open an issue first to discuss major changes.

📧 Contact
For press or business inquiries: stephen@altiora.fit
For technical issues: GitHub Issues
