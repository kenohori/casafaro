---
layout: default
---

<div class="row align-items-center g-5 py-5" id="nosotros">
    <div class="col-lg-5">
        <div class="d-flex align-items-center gap-3 mb-4">
            <img src="../img/barra.svg" class="img-fluid" alt="" width="28" height="28" loading="lazy">
            <span class="section-tag section-tag-barra mb-0">¿Quiénes somos?</span>
        </div>
        <h2 class="section-title reveal">Transformamos conocimiento en acción.</h2>
    </div>
    <div class="col-lg-7">
        <p class="lead reveal">Integramos investigación, innovación social y trabajo territorial con <strong>sensibilidad al trauma</strong> y <strong>rigor metodológico</strong> para acompañar contextos complejos y de alta vulnerabilidad.</p>
        <p class="reveal">El equipo cuenta con una sólida trayectoria en instituciones y organismos como la <strong>ONU</strong>, la <strong>OEA</strong> y la <strong>CISS</strong>, formación en <strong>Harvard</strong>, <strong>UCL</strong> y la <strong>Erasmus Rotterdam</strong>, y experiencia docente en universidades líderes de México.</p>
    </div>
</div>

<div class="row equipo">
    <div class="col-lg-4">
        <img class="img-fluid rounded-circle" src="../img/Foto FPO.jpeg" alt="Foto de Fabiola" />
        <h2 class="fw-normal rojocf">Fabiola</h2>
        <p>Directora de política y justicia social</p>
    </div>
    <!-- /.col-lg-4 -->
    <div class="col-lg-4">
        <img class="img-fluid rounded-circle" src="../img/Foto FEG2.jpeg" alt="Foto de Fernando" />
        <h2 class="fw-normal rojocf">Fernando</h2>
        <p>Director de bienestar y salud mental</p>
    </div>
    <!-- /.col-lg-4 -->
    <div class="col-lg-4">
        <img class="img-fluid rounded-circle" src="../img/meli.jpg" alt="Foto de Melissa" />
        <h2 class="fw-normal rojocf">Melissa</h2>
        <p>Directora de tecnología y sociedad</p>
    </div>
    <!-- /.col-lg-4 -->
</div>

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
    gsap.utils.toArray('.equipo .col-lg-4').forEach(function(col, i) {
        gsap.from(col, {
            opacity: 0,
            y: 60,
            scale: 0.9,
            duration: 0.9,
            ease: 'back.out(1.6)',
            delay: i * 0.15,
            scrollTrigger: {
                trigger: col,
                start: 'top 85%'
            }
        });
    });
</script>