document.addEventListener('turbo:load', () => {
  console.log("JavaScript file loaded!");

  const button = document.getElementById('record-button');
  const canvas = document.getElementById('progress-canvas');
  const context = canvas.getContext('2d');
  const progressText = document.getElementById('progress-text');
  const goalId = button.getAttribute('data-goal-id');
  let count = parseInt(progressText.innerText.match(/\d+/)[0]);

  function drawProgress(count) {
    const progress = (count % 7) / 7;
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.beginPath();
    context.arc(100, 100, 90, 0, Math.PI * 2 * progress, false);
    context.lineWidth = 10;
    context.strokeStyle = '#3498db';
    context.stroke();
  }

  drawProgress(count);

  button.addEventListener('click', () => {
    fetch(`/goals/${goalId}/record`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name=csrf-token]').content
      },
      body: JSON.stringify({})
    })
    .then(response => {
      const contentType = response.headers.get('content-type');
      if (!response.ok) {
        return response.text().then(text => { throw new Error(text); });
      }
      if (contentType && contentType.includes('application/json')) {
        return response.json();
      } else {
        return response.text().then(text => { throw new Error('Unexpected content type: ' + contentType + '\n' + text); });
      }
    })
    .then(data => {
      count = data.count;
      progressText.innerHTML = `<p>${count}/7</p>`;
      drawProgress(count);
    })
    .catch(error => {
      console.error('Error:', error);
      progressText.innerHTML = `<p>エラーが発生しました: ${error.message}</p>`;
      progressText.innerHTML += `<div>${error}</div>`;
    });
  });
});
