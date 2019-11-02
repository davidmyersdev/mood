self.addEventListener('push', (event) => {
  const data = event.data.json();
  const notification = self.registration.showNotification(data.title, {
    actions: data.actions,
    body: data.body,
  });

  event.waitUntil(notification);
});
