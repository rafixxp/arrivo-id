<template>
    <div class="container-fluid d-flex align-items-center justify-content-center vh-100 bg-gradient">
        <div class="row justify-content-center w-100">
            <div class="col-lg-8 text-center">
                <!-- Animated 404 Illustration -->
                <div class="mb-5 position-relative">
                    <div class="floating-animation">
                        <img src="https://cdn.jsdelivr.net/gh/themesberg/flowbite@1.0.0/public/images/404/404-illustration.svg" 
                             alt="404 Illustration" 
                             class="img-fluid mb-4"
                             style="max-height: 300px;">
                    </div>
                    
                    <!-- Animated Numbers -->
                    <div class="d-flex justify-content-center align-items-center mb-4">
                        <div class="number-animation">4</div>
                        <div class="zero-rotation mx-2">0</div>
                        <div class="number-animation">4</div>
                    </div>
                    
                    <!-- Fallback Static Numbers -->
                    <div class="d-flex justify-content-center align-items-center mb-4" style="display: none;" id="fallback-numbers">
                        <h1 class="display-1 fw-bold text-white">404</h1>
                    </div>
                </div>

                <!-- Error Message -->
                <div class="mb-4">
                    <h2 class="h3 fw-bold text-white mb-3 fade-in-up">
                        Oops! Halaman Tidak Ditemukan
                    </h2>
                    <p class="text-white-50 mb-4 fade-in-up-delay">
                        Maaf, halaman yang Anda cari tidak ada atau telah dipindahkan. 
                        Mari kita kembali ke halaman yang aman.
                    </p>
                </div>

                <!-- Action Button -->
                <div class="d-flex justify-content-center mb-4 fade-in-up-delay-2">
                    <button @click="goBack" 
                            class="btn btn-light btn-lg px-5 py-3 rounded-pill hover-lift">
                        <i class="bi bi-arrow-left me-2"></i>
                        Kembali
                    </button>
                </div>

            </div>
        </div>

        <!-- Floating Elements -->
        <div class="floating-elements">
            <div class="floating-shape shape-1"></div>
            <div class="floating-shape shape-2"></div>
            <div class="floating-shape shape-3"></div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'NotFound',
    data() {
        return {}
    },
    mounted() {
        // Add entrance animations
        this.addEntranceAnimations()
        
        // Check if animations are working, show fallback if needed
        setTimeout(() => {
            const animatedNumbers = document.querySelector('.number-animation')
            const fallbackNumbers = document.getElementById('fallback-numbers')
            
            if (animatedNumbers && window.getComputedStyle(animatedNumbers).animationName === 'none') {
                // Animasi tidak berfungsi, tampilkan fallback
                const animatedContainer = animatedNumbers.parentElement
                if (animatedContainer && fallbackNumbers) {
                    animatedContainer.style.display = 'none'
                    fallbackNumbers.style.display = 'flex'
                }
            }
        }, 100)
        
        // Add parallax effect on mouse move
        this.addParallaxEffect()
    },
    methods: {
        goBack() {
            if (window.history.length > 1) {
                this.$router.go(-1)
            } else {
                this.$router.push('/')
            }
        },
        addEntranceAnimations() {
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('animate-in')
                    }
                })
            })

            document.querySelectorAll('.fade-in-up, .fade-in-up-delay, .fade-in-up-delay-2, .fade-in-up-delay-3, .fade-in-up-delay-4').forEach(el => {
                observer.observe(el)
            })
        },
        addParallaxEffect() {
            document.addEventListener('mousemove', (e) => {
                const shapes = document.querySelectorAll('.floating-shape')
                const x = e.clientX / window.innerWidth
                const y = e.clientY / window.innerHeight

                shapes.forEach((shape, index) => {
                    const speed = (index + 1) * 10
                    const xPos = (x - 0.5) * speed
                    const yPos = (y - 0.5) * speed
                    shape.style.transform = `translate(${xPos}px, ${yPos}px)`
                })
            })
        }
    }
}
</script>

<style scoped>
.bg-gradient {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    position: relative;
    overflow: hidden;
}

.number-animation {
    font-size: 6rem;
    font-weight: 900;
    color: #ffffff;
    text-shadow: 0 0 30px rgba(255, 255, 255, 0.8);
    animation: bounce 2s infinite;
    display: inline-block;
}

.zero-rotation {
    font-size: 6rem;
    font-weight: 900;
    color: #ffd700;
    text-shadow: 0 0 30px rgba(255, 215, 0, 0.8);
    animation: rotate 3s linear infinite;
    display: inline-block;
}

.floating-animation {
    animation: float 3s ease-in-out infinite;
}

.floating-elements {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 1;
}

.floating-shape {
    position: absolute;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(5px);
}

.shape-1 {
    width: 80px;
    height: 80px;
    top: 10%;
    left: 10%;
    animation: float-shape 4s ease-in-out infinite;
}

.shape-2 {
    width: 120px;
    height: 120px;
    top: 70%;
    right: 10%;
    animation: float-shape 5s ease-in-out infinite reverse;
}

.shape-3 {
    width: 60px;
    height: 60px;
    bottom: 20%;
    left: 20%;
    animation: float-shape 3s ease-in-out infinite;
}

.fade-in-up {
    opacity: 0;
    transform: translateY(30px);
    transition: all 0.8s ease;
}

.fade-in-up-delay {
    opacity: 0;
    transform: translateY(30px);
    transition: all 0.8s ease 0.2s;
}

.fade-in-up-delay-2 {
    opacity: 0;
    transform: translateY(30px);
    transition: all 0.8s ease 0.4s;
}

.fade-in-up-delay-3 {
    opacity: 0;
    transform: translateY(30px);
    transition: all 0.8s ease 0.6s;
}

.fade-in-up-delay-4 {
    opacity: 0;
    transform: translateY(30px);
    transition: all 0.8s ease 0.8s;
}

.animate-in {
    opacity: 1;
    transform: translateY(0);
}

.hover-lift {
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.hover-lift:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
}

.hover-scale {
    transition: all 0.3s ease;
}

.hover-scale:hover {
    transform: scale(1.1);
    background-color: #007bff !important;
    color: white !important;
}

.max-width-md {
    max-width: 400px;
}

.btn-primary {
    background: linear-gradient(45deg, #007bff, #0056b3);
    border: none;
    transition: all 0.3s ease;
}

.btn-primary:hover {
    background: linear-gradient(45deg, #0056b3, #004085);
    transform: translateY(-2px);
}

.btn-light {
    background: rgba(255, 255, 255, 0.9);
    color: #667eea;
    border: 2px solid rgba(255, 255, 255, 0.3);
    backdrop-filter: blur(10px);
    transition: all 0.3s ease;
}

.btn-light:hover {
    background: rgba(255, 255, 255, 1);
    color: #764ba2;
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
}


@keyframes bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translateY(0);
    }
    40% {
        transform: translateY(-20px);
    }
    60% {
        transform: translateY(-10px);
    }
}

@keyframes rotate {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
}

@keyframes float {
    0%, 100% {
        transform: translateY(0px);
    }
    50% {
        transform: translateY(-20px);
    }
}

@keyframes float-shape {
    0%, 100% {
        transform: translateY(0px) translateX(0px);
    }
    33% {
        transform: translateY(-20px) translateX(10px);
    }
    66% {
        transform: translateY(10px) translateX(-10px);
    }
}

/* Responsive */
@media (max-width: 768px) {
    .number-animation, .zero-rotation {
        font-size: 4rem;
    }
    
    .h3 {
        font-size: 1.5rem;
    }
    
    .btn-lg {
        padding: 0.75rem 2rem;
        font-size: 1rem;
    }
}
</style>
