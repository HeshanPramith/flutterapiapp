class Config {
  static const backendurl = String.fromEnvironment('BACKEND_URL',
      defaultValue: 'https://www.colourlovers.com/api/colors/new?format=json');
}
