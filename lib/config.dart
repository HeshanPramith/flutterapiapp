class Config {
  static const backendurl = String.fromEnvironment('BACKEND_URL',
      defaultValue: 'https://api.spacexdata.com/v4/');
}
