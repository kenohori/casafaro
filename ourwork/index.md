---
layout: default
---

<section id="empresas" class="section section-white">
    <div class="container">
        <div class="section-head">
            <div class="d-flex align-items-center gap-3 mb-4">
                <img src="../img/barra.svg" class="img-fluid" alt="" width="28" height="28" loading="lazy">
                <span class="section-tag section-tag-barra mb-0">Para empresas y organizaciones privadas</span>
            </div>
            <h2 class="section-title reveal">El cumplimiento normativo es el punto de partida… no el destino.</h2>
            <p class="reveal">
                Más allá de la normativa en materia de riesgos psicosociales, violencia laboral y equidad, nos preguntamos:
                <strong>¿cómo están realmente las personas que sostienen tu organización?</strong>
            </p>
        </div>
        <div class="row g-4 mt-2">
            <div class="col-md-6 col-lg-3">
                <div class="card-service reveal">
                    <span class="card-service-num">01</span>
                    <h3>Diagnóstico participativo</h3>
                    <p>Evaluamos riesgos psicosociales, clima organizacional y dinámicas de conflicto con instrumentos validados y enfoque cualitativo. Te devolvemos resultados que se entienden y sirven para tomar decisiones reales.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-service reveal">
                    <span class="card-service-num">02</span>
                    <h3>Formación a la medida</h3>
                    <p>Talleres para tu personal y tus liderazgos: prevención de burnout, gestión del conflicto, comunicación asertiva, entornos organizacionales favorables, prevención de violencia y acoso laboral, género y masculinidades.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-service reveal">
                    <span class="card-service-num">03</span>
                    <h3>Políticas y protocolos</h3>
                    <p>Diseñamos o actualizamos tus documentos internos: manuales, políticas de prevención, guías de actuación. Gestionamos cumplimiento normativo con sentido.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="card-service reveal">
                    <span class="card-service-num">04</span>
                    <h3>Intervención sostenida</h3>
                    <p>Acompañamiento continuo para transformar cultura organizacional desde adentro, con metodologías participativas y seguimiento a indicadores reales de mejora.</p>
                </div>
            </div>
        </div>
        <p class="section-note reveal">
            Acompañamos a organizaciones de todos los tamaños, desde micro, pequeñas y medianas empresas hasta
            grandes corporaciones. Adaptamos cada intervención a su contexto, necesidades y capacidades, manteniendo
            siempre el mismo compromiso con el impacto y los resultados.
        </p>
    </div>
</section>

<section id="sociedad-civil" class="section section-tint">
    <div class="container">
        <div class="section-head">
            <div class="d-flex align-items-center gap-3 mb-4">
                <img src="../img/barra.svg" class="img-fluid" alt="" width="28" height="28" loading="lazy">
                <span class="section-tag section-tag-barra mb-0">Para sociedad civil e instituciones públicas</span>
            </div>
            <h2 class="section-title reveal">Porque quienes cuidan también necesitan cuidados.</h2>
            <p class="reveal">
                Las organizaciones de la sociedad civil y las instituciones públicas enfrentan un reto particular: trabajan
                por el bienestar de otras personas desde estructuras que con frecuencia descuidan el suyo. El desgaste,
                el trauma vicario, los conflictos internos y la falta de estrategias de cuidado colectivo son algunos de los
                desafíos más silenciosos y costosos del sector.
            </p>
        </div>
        <div class="row g-4 mt-2">
            <div class="col-md-6 col-lg-4">
                <div class="card-service reveal">
                    <span class="card-service-num">01</span>
                    <h3>Diagnósticos institucionales</h3>
                    <p>Analizamos clima organizacional, riesgos psicosociales y dinámicas de conflicto con metodologías participativas que no solo miden: activan conversación y comprensión.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="card-service reveal">
                    <span class="card-service-num">02</span>
                    <h3>Espacios de escucha y cuidado</h3>
                    <p>Procesos grupales de contención para equipos en desgaste, en crisis institucional o en transición.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="card-service reveal">
                    <span class="card-service-num">03</span>
                    <h3>Formación especializada</h3>
                    <p>Capacitación en bienestar laboral, prevención de violencias, equidad de género, masculinidades, derechos humanos y cultura digital.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="card-service reveal">
                    <span class="card-service-num">04</span>
                    <h3>Modelos de cuidado institucional</h3>
                    <p>Acompañamos el diseño de estrategias sostenibles de cuidado colectivo adaptadas a la identidad y las necesidades de cada organización.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="card-service reveal">
                    <span class="card-service-num">05</span>
                    <h3>Facilitación y gestión de conflictos</h3>
                    <p>Acompañamos conversaciones difíciles, procesos de mediación y construcción de acuerdos al interior de equipos e instituciones.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="card-service card-service-cta reveal">
                    <h3 class="mb-3">¿Tu organización necesita cuidados?</h3>
                    <p>Construyamos juntos una cultura interna más humana, equitativa y sostenible.</p>
                    <a href="{{ site.baseurl }}/contact" class="btn btn-cf btn-cf-red mt-2">Hablemos</a>
                </div>
            </div>
        </div>
        <p class="section-note reveal">
            Acompañamos a organizaciones de todos los tamaños. Adaptamos cada intervención a su contexto, necesidades
            y capacidades, manteniendo siempre el mismo compromiso con el impacto y los resultados.
        </p>
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
                toggleActions: 'play none none reverse'
            }
        });
    });
</script>
