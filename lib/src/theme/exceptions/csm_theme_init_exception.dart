class CosmosThemeManagerInitError implements Exception {
  const CosmosThemeManagerInitError();

  @override
  String toString() {
    return 'Cosmos theme manager isn\'t initialized yet'
        '\n This ocurr when you tried to use or access methods that depends on the value listener from the theme manager'
        'without configuring the correct properties to the CosmossApp to create/initialize the manager';
  }
}
