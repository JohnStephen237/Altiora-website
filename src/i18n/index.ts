import fs from "fs";
import path from "path";

export type LocaleMap = Record<string, any>;

export function loadLocale(locale = "en"): LocaleMap {
  try {
    const file = path.resolve(process.cwd(), `src/i18n/${locale}.json`);
    const raw = fs.readFileSync(file, "utf8");
    return JSON.parse(raw);
  } catch (err) {
    // fallback to English
    const file = path.resolve(process.cwd(), `src/i18n/en.json`);
    return JSON.parse(fs.readFileSync(file, "utf8"));
  }
}

export function createTranslator(localeMap: LocaleMap) {
  return function t(key: string, fallback = "") {
    const parts = key.split(".");
    let cur: any = localeMap;
    for (const p of parts) {
      if (cur && typeof cur === "object" && p in cur) cur = cur[p];
      else return fallback || key;
    }
    return typeof cur === "string" ? cur : fallback || key;
  };
}
