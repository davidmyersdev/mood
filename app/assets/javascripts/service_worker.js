self.addEventListener('push', (event) => {
  const notification = event.data.json();

  event.waitUntil(
    self.registration.showNotification(notification.data.title, {
      body: notification.data.body,
      data: notification,
    })
  );
});

self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  const type = event.notification.data.data.type;
  let url;

  switch (type) {
    case 'authentication':
      url = `/ephemeral/authenticate_by_notification?nonce=${event.notification.data.nonce}&notification_id=${event.notification.data.id}`;
      break;
    default:
      url = `/notifications/${event.notification.data.id}/responses/new?nonce=${event.notification.data.nonce}`;
      break;
  }

  event.waitUntil(
    clients.openWindow(url)
  );
});

self.addEventListener('notificationclose', (event) => {
  console.log('Notification closed.');
});
