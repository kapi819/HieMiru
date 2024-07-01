document.addEventListener('turbo:load', function() {
  const modal = document.getElementById('howToUseModal');
  const openModalButton = document.getElementById('openModalButton');
  const closeModalButton = document.getElementById('closeModalButton');

  openModalButton.addEventListener('click', function() {
    modal.classList.add('show');
    modal.style.display = 'block';
    modal.setAttribute('aria-hidden', 'false');
  });

  closeModalButton.addEventListener('click', function() {
    modal.classList.remove('show');
    modal.style.display = 'none';
    modal.setAttribute('aria-hidden', 'true');
  });

  window.addEventListener('click', function(event) {
    if (event.target === modal) {
      modal.classList.remove('show');
      modal.style.display = 'none';
      modal.setAttribute('aria-hidden', 'true');
    }
  });
});