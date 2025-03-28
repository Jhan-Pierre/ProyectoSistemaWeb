const container = document.getElementById('container');
const registerBtn = document.getElementById('register');
const loginBtn = document.getElementById('login');

if (registerBtn) {
    registerBtn.addEventListener('click', () => {
        container.classList.add("active");
    });
}

if (loginBtn) {
    loginBtn.addEventListener('click', () => {
        container.classList.remove("active");
    });
}

// Funci�n para activar la vista de registro al cargar la p�gina
function toggleRegister(showRegister) {
    if (showRegister) {
        container.classList.add("active");
    }
}
