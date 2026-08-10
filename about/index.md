---
layout: default
---

<div class="row" id="about">
    <div class="col-lg-8 align-items-center g-5 py-5">
       <div class="d-flex align-items-center gap-3 mb-3"> 
            <img src="../img/barra.svg" class="img-fluid" alt="Bootstrap Themes" width="90pt" height="90pt" loading="lazy" />
            <h1 class="display-5 fw-bold text-body-emphasis lh-1 mb-0">¿Quiénes somos?</h1>
        </div>
    </div> 
</div>       

<p class="lead about-lead">CasaFaro transforma conocimiento en acción. Integramos investigación, innovación social y trabajo territorial con sensibilidad al trauma y rigor metodológico para acompañar contextos complejos y de alta vulnerabilidad. El equipo cuenta con una sólida trayectoria en instituciones y organismos como la ONU, la OEA y la CISS, formación en Harvard, UCL y Erasmus Rotterdam, y experiencia docente en universidades líderes de México.</p>

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
    gsap.from('.about-lead', {
        opacity: 0,
        y: 30,
        duration: 0.8,
        scrollTrigger: {
            trigger: '.about-lead',
            start: 'top 85%'
        }
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