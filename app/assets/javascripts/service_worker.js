self.addEventListener('notificationclick', handleNotificationClick);
self.addEventListener('notificationclose', handleNotificationClose);
self.addEventListener('push', handlePush);

async function handleNotificationClick(event) {
  event.notification.close();
  console.log('notification: click');

  const data = event.notification.data;
  const url = new URL(data.url);

  url.searchParams.append('notification_id', data.notification_id);
  url.searchParams.append('notification_nonce', data.notification_nonce);

  event.waitUntil(
    clients.openWindow(url)
  );
}

async function handleNotificationClose(event) {
  console.log('notification: closed');
}

async function handlePush(event) {
  const notification = event.data.json();

  event.waitUntil(
    self.registration.showNotification(notification.title, {
      body: notification.body,
      data: notification,
    })
  );
}
