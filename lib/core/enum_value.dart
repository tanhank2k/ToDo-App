enum EventType {
  today('Today'),
  upcoming('Upcoming'),
  all('All');

  const EventType(this.title);
  final String title;
}
