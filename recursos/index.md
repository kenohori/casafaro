---
layout: default
---

<section class="section section-white">
    <div class="container">
        <div class="section-head">
            <div class="d-flex align-items-center gap-3 mb-4">
                <img src="{{ site.baseurl }}/img/barra.svg" class="img-fluid" alt="" width="28" height="28" loading="lazy">
                <span class="section-tag section-tag-barra mb-0">Recursos</span>
            </div>
            <h2 class="section-title reveal">Plantillas y artículos de nuestro equipo.</h2>
            <p class="reveal">
                Compartimos materiales, herramientas y reflexiones que producimos en CasaFaro para acompañar
                procesos de cuidado, prevención de violencias y construcción de paz. Descárgalos y adáptalos a tu contexto.
            </p>
        </div>

        <div class="row g-4 mt-2">
            {% for recurso in site.data.recursos %}
            <div class="col-md-6 col-lg-4">
                <div class="card-recurso reveal">
                    <span class="recurso-tipo">{{ recurso.tipo }}</span>
                    <h3 class="recurso-titulo">{{ recurso.titulo }}</h3>
                    <p class="recurso-desc">{{ recurso.descripcion }}</p>
                    {% if recurso.autor %}
                    <span class="recurso-autor">{{ recurso.autor }}</span>
                    {% endif %}
                    <a href="{{ recurso.url | default: '#' }}" class="btn btn-cf btn-cf-outline btn-sm recurso-link"{% if recurso.url and recurso.url contains 'http' %} target="_blank" rel="noopener"{% endif %}>
                        Ver recurso
                    </a>
                </div>
            </div>
            {% endfor %}
        </div>

        <p class="section-note reveal">
            ¿Tienes una plantilla o artículo que quieras sumar? Escríbenos y lo publicamos junto al resto del equipo.
        </p>
    </div>
</section>

<section class="cta-band">
    <div class="container text-center">
        <h2 class="cta-title">¿Necesitas apoyo para adaptar estos recursos a tu organización?</h2>
        <p class="cta-text">Acompañamos a equipos e instituciones a traducir estas herramientas en cambios reales.</p>
        <a href="{{ site.baseurl }}/contact" class="btn btn-cf btn-cf-white btn-lg">Hablemos</a>
    </div>
</section>

<script>
    gsap.registerPlugin(ScrollTrigger);
    gsap.utils.toArray('.reveal').forEach(function(el) {
        gsap.fromTo(el, { y: 48, opacity: 0 }, {
            y: 0,
            opacity: 1,
            duration: 0.9,
            ease: 'power3.out',
            scrollTrigger: {
                trigger: el,
                start: 'top 86%',
                toggleActions: 'play none reverse none'
            }
        });
    });
</script>
