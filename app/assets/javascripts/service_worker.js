self.addEventListener('push', (event) => {
  const notification = event.data.json();

  event.waitUntil(
    self.registration.showNotification(notification.data.title, {
      actions: notification.data.actions,
      body: notification.data.body,
      data: notification,
    })
  );
});

self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  if (!event.action) {
    console.log('Clicked on notfication.');
    console.log(event.notification.data);

    return true;
  }

  switch (event.action) {
    case 'happy':
      console.log('Clicked on Happy!');
      break;
    case 'meh':
      console.log('Clicked on Meh!');
      break;
    case 'sad':
      console.log('Clicked on Sad!');
      break;
    case 'upset':
      console.log('Clicked on Upset!');
      break;
    default:
      console.log('Unknown action.');
      break;
  }

  event.waitUntil(
    postAction(event.notification.data, event.action)
  );
});

self.addEventListener('notificationclose', (event) => {
  console.log('Notification closed.');
});

function postAction(notification, choice) {
  console.log('notification', notification);
  console.log('choice', choice);

  return fetch(`/notifications/${notification.id}/responses`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      choice: choice,
      nonce: notification.nonce,
    }),
  })
  .then((response) => {
    if (response.ok)
      console.log('Choice logged.');
    else
      console.log('Choice not logged.')

    console.log(response);
  })
  .catch(error => console.error(error));
}
