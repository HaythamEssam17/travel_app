extension LanguageCodeToFlag on String {
  /// Converts a language or country code (e.g. "en", "us", "fr") into a flag emoji.
  String get toFlagEmoji {
    // Handle special cases for language codes that don’t directly match country codes
    final specialCases = {
      "en": "us", // English → 🇺🇸 (default to US)
      "ar": "eg", // Arabic → 🇪🇬 (default to Egypt)
      "pt": "pt", // Portuguese → 🇵🇹 (Portugal)
      "zh": "cn", // Chinese → 🇨🇳
    };

    var code = toLowerCase();

    // If the input is a language code, map it to a default country
    if (specialCases.containsKey(code)) {
      code = specialCases[code]!;
    }

    if (code.length != 2) return this; // return original if not valid

    // Convert country code to uppercase
    final countryCode = code.toUpperCase();

    // Convert letters to regional indicator symbols
    return countryCode.runes
        .map((ch) => String.fromCharCode(ch + 127397))
        .join();
  }
}
