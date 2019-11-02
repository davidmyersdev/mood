self.addEventListener('push', (event) => {
  const data = event.data.json();
  const notification = self.registration.showNotification(data.title, {
    actions: data.actions,
    body: data.body,
  });

  event.waitUntil(notification);
});

self.addEventListener('notificationclick', (event) => {
  console.log(event);

  if (!event.action) {
    return console.log('Clicked on notfication.');
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
