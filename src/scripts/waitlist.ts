import { Swiper } from "swiper";
import "swiper/css";
import "swiper/css/pagination";
import { Autoplay, Pagination } from "swiper/modules";

function initSwiper() {
  new Swiper(".swiper-container", {
    modules: [Pagination, Autoplay],
    spaceBetween: 24,
    loop: true,
    centeredSlides: true,
    pagination: { el: ".pagination", type: "bullets", clickable: true },
    breakpoints: { 768: { slidesPerView: 1 } },
  });
}

function initWaitlistForm() {
  const FORM_ENDPOINT = "https://formspree.io/f/XXXXXXXX"; // replace
  const form = document.getElementById("waitlist-form") as HTMLFormElement | null;
  if (!form) return;

  const btn = document.getElementById("submit-btn") as HTMLButtonElement | null;
  const success = document.getElementById("success");
  const failure = document.getElementById("failure");

  const nameEl = document.getElementById("name") as HTMLInputElement | null;
  const emailEl = document.getElementById("email") as HTMLInputElement | null;
  const consentEl = document.getElementById("consent") as HTMLInputElement | null;
  const nameErr = document.getElementById("name-error");
  const emailErr = document.getElementById("email-error");
  const consentErr = document.getElementById("consent-error");

  const show = (el?: Element | null) => el?.classList.remove("hidden");
  const hide = (el?: Element | null) => el?.classList.add("hidden");

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    hide(success); hide(failure);
    hide(nameErr); hide(emailErr); hide(consentErr);

    let valid = true;
    if (!nameEl?.value || nameEl.value.trim().length < 2) { valid = false; show(nameErr); }
    const emailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailEl?.value || "");
    if (!emailValid) { valid = false; show(emailErr); }
    if (!consentEl?.checked) { valid = false; show(consentErr); }

    const hp = (form.querySelector('input[name="website"]') as HTMLInputElement | null)?.value?.trim() || "";
    if (hp) return; // bot

    if (!valid) return;

    if (btn) { btn.disabled = true; btn.textContent = "Submitting..."; }

    try {
      const formData = new FormData(form);
      const res = await fetch(FORM_ENDPOINT, { method: "POST", body: formData, headers: { Accept: "application/json" } });
      if (res.ok) { form.reset(); show(success); } else { show(failure); }
    } catch {
      show(failure);
    } finally {
      if (btn) { btn.disabled = false; btn.textContent = "Join Waitlist"; }
    }
  });
}

// Works with normal loads and Astro view transitions:
document.addEventListener("astro:page-load", () => {
  initSwiper();
  initWaitlistForm();
});
document.addEventListener("astro:after-swap", () => {
  initSwiper();
  initWaitlistForm();
});
