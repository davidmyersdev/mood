self.addEventListener('push', (event) => {
  const notification = self.registration.showNotification('This is a title.', {
    body: 'This is the message.',
  });

  event.waitUntil(notification);
});
