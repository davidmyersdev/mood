self.addEventListener('push', (event) => {
  const notification = event.data.json();

  event.waitUntil(
    self.registration.showNotification(notification.data.title, {
      actions: notification.data.actions,
      body: notification.data.body,
      data: {
        notification_id: notification.id,
      },
    })
  );
});

self.addEventListener('notificationclick', (event) => {
  if (!event.action) {
    console.log('Clicked on notfication.');

    console.log('Notification data: ', event.notification.data);

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
  }
});

self.addEventListener('notificationclose', (event) => {
  console.log('Notification closed.');
});
