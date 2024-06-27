document.addEventListener('turbo:load', () => {
  console.log("JavaScript file loaded!");

  const button = document.getElementById('record-button');
  const canvas = document.getElementById('progress-canvas');
  const context = canvas.getContext('2d');
  const progressText = document.getElementById('progress-text');
  const commentContainer = document.getElementById('comment-container');
  const goalId = button.getAttribute('data-goal-id');
  let count = parseInt(progressText.innerText.match(/\d+/)[0]);

  function drawProgress(count) {
    const progress = (count % 7) / 7;
    const radius = 180;
    const lineWidth = 20;
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.beginPath();
    context.arc(canvas.width / 2, canvas.height / 2, radius, 0, Math.PI * 2 * progress, false);
    context.lineWidth = lineWidth;
    context.strokeStyle = '#3498db';
    context.stroke();
  }

  function getEncouragementMessage(count) {
    switch (count) {
      case 1:
        return "最初の一歩を踏み出しましたね！この調子で頑張りましょう！";
      case 2:
        return "2回目の達成、おめでとうございます！確実に前進していますね。";
      case 3:
        return "3回目の目標達成、素晴らしいです！半分まで来ました！";
      case 4:
        return "4回目の達成、お疲れ様です。あと少しでゴールです！";
      case 5:
        return "5回目の目標達成、見事です！もうすぐ目標達成です。";
      case 6:
        return "6回目の達成、おめでとうございます！あと一回で目標達成です！";
      case 7:
        return "目標達成、おめでとうございます！素晴らしい努力でした！";
      default:
        return "";
    }
  }
  
  function checkIfAlreadyRecorded() {
    fetch(`/goals/${goalId}/check_record`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name=csrf-token]').content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.already_recorded) {
        button.disabled = true;
        commentContainer.innerHTML = `<p>今日はすでに記録されています。</p>`;
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }

  drawProgress(count);
  checkIfAlreadyRecorded();

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

      // コメントを表示する
      const message = getEncouragementMessage(count);
      commentContainer.innerHTML = `<p>${message}</p>`;
    })
    .catch(error => {
      console.error('Error:', error);
      if (error.message.includes('You can only record once per day.')) {
        commentContainer.innerHTML = `<p>今日はすでに記録されています。</p>`;
        button.disabled = true;
      } else {
      progressText.innerHTML = `<p>エラーが発生しました: ${error.message}</p>`;
      progressText.innerHTML += `<div>${error}</div>`;
      }
    });
  });
});
