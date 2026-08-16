/* ============================================================
   CasaFaro — GSAP animations
   ============================================================ */
(function () {
  "use strict";

  gsap.registerPlugin(ScrollTrigger);

  // ---------- Scroll progress bar ----------
  gsap.to("#scroll-progress", {
    scaleX: 1,
    ease: "none",
    scrollTrigger: {
      trigger: document.body,
      start: "top top",
      end: "max",
      scrub: 0.3
    }
  });

  // ---------- Navbar shrink on scroll ----------
  const nav = document.getElementById("mainNav");
  const toggleNav = () => nav.classList.toggle("scrolled", window.scrollY > 40);
  toggleNav();
  window.addEventListener("scroll", toggleNav, { passive: true });

  // ---------- Active nav link (based on current page) ----------
  const activePage = document.body.dataset.page;
  if (activePage) {
    document.querySelectorAll('.nav-link[data-nav]').forEach((link) => {
      if (link.dataset.nav === activePage) link.classList.add("active");
    });
  }

  // ---------- Hero intro ----------
  const heroIntro = gsap.timeline({ defaults: { ease: "power3.out" } });
  heroIntro
    .fromTo(".reveal-hero", { y: 60, opacity: 0 }, { y: 0, opacity: 1, duration: 1, stagger: 0.16 }, 0.15);

  // ---------- Floating blobs ----------
  gsap.to(".hero-blob-1", {
    y: -30,
    duration: 4.5,
    yoyo: true,
    repeat: -1,
    ease: "sine.inOut"
  });
  gsap.to(".hero-blob-2", {
    y: 22,
    duration: 5,
    yoyo: true,
    repeat: -1,
    ease: "sine.inOut"
  });
  gsap.to(".hero-blob-3", {
    scale: 1.15,
    duration: 3.6,
    yoyo: true,
    repeat: -1,
    ease: "sine.inOut"
  });

  // ---------- Generic scroll reveal ----------
  gsap.utils.toArray(".reveal").forEach((el) => {
    gsap.fromTo(el,
      { y: 48, opacity: 0 },
      {
        y: 0,
        opacity: 1,
        duration: 0.9,
        ease: "power3.out",
        scrollTrigger: {
          trigger: el,
          start: "top 86%",
          toggleActions: "play none none reverse"
        }
      }
    );
  });

  // ---------- Staggered groups ----------
  function staggerGroup(selector, yFrom) {
    const items = gsap.utils.toArray(selector);
    if (!items.length) return;
    gsap.fromTo(items,
      { y: yFrom || 56, opacity: 0 },
      {
        y: 0,
        opacity: 1,
        duration: 0.9,
        ease: "power3.out",
        stagger: 0.12,
        scrollTrigger: {
          trigger: items[0].parentElement,
          start: "top 82%",
          toggleActions: "play none none reverse"
        }
      }
    );
  }

  staggerGroup(".card-audience");
  staggerGroup(".card-line");
  staggerGroup(".card-service");
  staggerGroup(".team-card");

  // Work-flow table: reveal columns left-to-right
  const workHead = gsap.utils.toArray(".work-row-head .work-col");
  if (workHead.length) {
    gsap.fromTo(workHead,
      { y: 40, opacity: 0 },
      {
        y: 0, opacity: 1, duration: 0.7, ease: "power3.out", stagger: 0.1,
        scrollTrigger: { trigger: ".work-flow", start: "top 82%" }
      }
    );
  }
  const workItems = gsap.utils.toArray(".work-row:not(.work-row-head) .work-col");
  if (workItems.length) {
    gsap.fromTo(workItems,
      { x: -30, opacity: 0 },
      {
        x: 0, opacity: 1, duration: 0.8, ease: "power3.out", stagger: 0.06,
        scrollTrigger: { trigger: ".work-flow", start: "top 78%" }
      }
    );
  }

  // ---------- Credential chips: spring-in on scroll ----------
  const chips = gsap.utils.toArray(".credential-chip");
  if (chips.length) {
    gsap.fromTo(chips,
      { scale: 0.6, opacity: 0 },
      {
        scale: 1, opacity: 1, duration: 0.6, ease: "back.out(2)",
        stagger: 0.08,
        scrollTrigger: { trigger: ".credential-row", start: "top 88%" }
      }
    );
  }

  // ---------- Contact form (opens mail client) ----------
  const contactForm = document.getElementById("contactForm");
  if (contactForm) {
    contactForm.addEventListener("submit", (e) => {
      e.preventDefault();
      const data = new FormData(contactForm);
      const nombre = (data.get("nombre") || "").trim();
      const organizacion = (data.get("organizacion") || "").trim();
      const asunto = (data.get("asunto") || "Contacto desde el sitio web").trim();
      const mensaje = (data.get("mensaje") || "").trim();

      if (!nombre || !mensaje) {
        contactForm.classList.add("was-validated");
        return;
      }

      const body =
        `Nombre: ${nombre}\n` +
        (organizacion ? `Organización: ${organizacion}\n` : "") +
        `Tema: ${asunto}\n\n` +
        mensaje;

      window.location.href =
        `mailto:hola@casafaro.mx?subject=${encodeURIComponent("Contacto web — " + asunto)}` +
        `&body=${encodeURIComponent(body)}`;
    });
  }

  // ---------- Refresh on load (images/fonts) ----------
  window.addEventListener("load", () => ScrollTrigger.refresh());
})();
