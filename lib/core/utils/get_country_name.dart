String getCountryName(String code) {
  // Map of country codes to country names
  const Map<String, String> countryCodes = {
    'TUN': 'TUNISIA',
    'USA': 'UNITED STATES',
    'CAN': 'CANADA',
    'DEU': 'GERMANY',
    'FRA': 'FRANCE',
    'AFG': 'AFGHANISTAN',
    'ALB': 'ALBANIA',
    'DZA': 'ALGERIA',
    'AND': 'ANDORRA',
    'AGO': 'ANGOLA',
    'ATG': 'ANTIGUA AND BARBUDA',
    'ARG': 'ARGENTINA',
    'ARM': 'ARMENIA',
    'AUS': 'AUSTRALIA',
    'AUT': 'AUSTRIA',
    'AZE': 'AZERBAIJAN',
    'BHS': 'BAHAMAS',
    'BHR': 'BAHRAIN',
    'BGD': 'BANGLADESH',
    'BRB': 'BARBADOS',
    'BLR': 'BELARUS',
    'BEL': 'BELGIUM',
    'BLZ': 'BELIZE',
    'BEN': 'BENIN',
    'BTN': 'BHUTAN',
    'BOL': 'BOLIVIA',
    'BIH': 'BOSNIA AND HERZEGOVINA',
    'BWA': 'BOTSWANA',
    'BRA': 'BRAZIL',
    'BRN': 'BRUNEI',
    'BGR': 'BULGARIA',
    'BFA': 'BURKINA FASO',
    'BDI': 'BURUNDI',
    'CPV': 'CABO VERDE',
    'KHM': 'CAMBODIA',
    'CMR': 'CAMEROON',
    'CAF': 'CENTRAL AFRICAN REPUBLIC',
    'TCD': 'CHAD',
    'CHL': 'CHILE',
    'CHN': 'CHINA',
    'COL': 'COLOMBIA',
    'COM': 'COMOROS',
    'COG': 'CONGO',
    'COD': 'CONGO, DEMOCRATIC REPUBLIC OF THE',
    'CRI': 'COSTA RICA',
    'CIV': 'CÔTE D\'IVOIRE',
    'HRV': 'CROATIA',
    'CUB': 'CUBA',
    'CYP': 'CYPRUS',
    'CZE': 'CZECH REPUBLIC',
    'DNK': 'DENMARK',
    'DJI': 'DJIBOUTI',
    'DMA': 'DOMINICA',
    'DOM': 'DOMINICAN REPUBLIC',
    'ECU': 'ECUADOR',
    'EGY': 'EGYPT',
    'SLV': 'EL SALVADOR',
    'GNQ': 'EQUATORIAL GUINEA',
    'ERI': 'ERITREA',
    'EST': 'ESTONIA',
    'SWZ': 'ESWATINI',
    'ETH': 'ETHIOPIA',
    'FJI': 'FIJI',
    'FIN': 'FINLAND',

    'GAB': 'GABON',
    'GMB': 'GAMBIA',
    'GEO': 'GEORGIA',

    'GHA': 'GHANA',
    'GRC': 'GREECE',
    'GRD': 'GRENADA',
    'GTM': 'GUATEMALA',
    'GIN': 'GUINEA',
    'GNB': 'GUINEA-BISSAU',
    'GUY': 'GUYANA',
    'HTI': 'HAITI',
    'HND': 'HONDURAS',
    'HUN': 'HUNGARY',
    'ISL': 'ICELAND',
    'IND': 'INDIA',
    'IDN': 'INDONESIA',
    'IRN': 'IRAN',
    'IRQ': 'IRAQ',
    'IRL': 'IRELAND',
    'ISR': 'ISRAEL',
    'ITA': 'ITALY',
    'JAM': 'JAMAICA',
    'JPN': 'JAPAN',
    'JOR': 'JORDAN',
    'KAZ': 'KAZAKHSTAN',
    'KEN': 'KENYA',
    'KIR': 'KIRIBATI',
    'PRK': 'KOREA, NORTH',
    'KOR': 'KOREA, SOUTH',
    'KWT': 'KUWAIT',
    'KGZ': 'KYRGYZSTAN',
    'LAO': 'LAOS',
    'LVA': 'LATVIA',
    'LBN': 'LEBANON',
    'LSO': 'LESOTHO',
    'LBR': 'LIBERIA',
    'LBY': 'LIBYA',
    'LIE': 'LIECHTENSTEIN',
    'LTU': 'LITHUANIA',
    'LUX': 'LUXEMBOURG',
    'MDG': 'MADAGASCAR',
    'MWI': 'MALAWI',
    'MYS': 'MALAYSIA',
    'MDV': 'MALDIVES',
    'MLI': 'MALI',
    'MLT': 'MALTA',
    'MHL': 'MARSHALL ISLANDS',
    'MRT': 'MAURITANIA',
    'MUS': 'MAURITIUS',
    'MEX': 'MEXICO',
    'FSM': 'MICRONESIA',
    'MDA': 'MOLDOVA',
    'MCO': 'MONACO',
    'MNG': 'MONGOLIA',
    'MNE': 'MONTENEGRO',
    'MAR': 'MOROCCO',
    'MOZ': 'MOZAMBIQUE',
    'MMR': 'MYANMAR',
    'NAM': 'NAMIBIA',
    'NRU': 'NAURU',
    'NPL': 'NEPAL',
    'NLD': 'NETHERLANDS',
    'NZL': 'NEW ZEALAND',
    'NIC': 'NICARAGUA',
    'NER': 'NIGER',
    'NGA': 'NIGERIA',
    'MKD': 'NORTH MACEDONIA',
    'NOR': 'NORWAY',
    'OMN': 'OMAN',
    'PAK': 'PAKISTAN',
    'PLW': 'PALAU',
    'PAN': 'PANAMA',
    'PNG': 'PAPUA NEW GUINEA',
    'PRY': 'PARAGUAY',
    'PER': 'PERU',
    'PHL': 'PHILIPPINES',
    'POL': 'POLAND',
    'PRT': 'PORTUGAL',
    'QAT': 'QATAR',
    'ROU': 'ROMANIA',
    'RUS': 'RUSSIA',
    'RWA': 'RWANDA',
    'KNA': 'SAINT KITTS AND NEVIS',
    'LCA': 'SAINT LUCIA',
    'VCT': 'SAINT VINCENT AND THE GRENADINES',
    'WSM': 'SAMOA',
    'SMR': 'SAN MARINO',
    'STP': 'SAO TOME AND PRINCIPE',
    'SAU': 'SAUDI ARABIA',
    'SEN': 'SENEGAL',
    'SRB': 'SERBIA',
    'SYC': 'SEYCHELLES',
    'SLE': 'SIERRA LEONE',
    'SGP': 'SINGAPORE',
    'SVK': 'SLOVAKIA',
    'SVN': 'SLOVENIA',
    'SLB': 'SOLOMON ISLANDS',
    'SOM': 'SOMALIA',
    'ZAF': 'SOUTH AFRICA',
    'SSD': 'SOUTH SUDAN',
    'ESP': 'SPAIN',
    'LKA': 'SRI LANKA',
    'SDN': 'SUDAN',
    'SUR': 'SURINAME',
    'SWE': 'SWEDEN',
    'CHE': 'SWITZERLAND',
    'SYR': 'SYRIA',
    'TWN': 'TAIWAN',
    'TJK': 'TAJIKISTAN',
    'TZA': 'TANZANIA',
    'THA': 'THAILAND',
    'TLS': 'TIMOR-LESTE',
    'TGO': 'TOGO',
    'TON': 'TONGA',
    'TTO': 'TRINIDAD AND TOBAGO',

    'TUR': 'TURKEY',
    'TKM': 'TURKMENISTAN',
    'TUV': 'TUVALU',
    'UGA': 'UGANDA',
    'UKR': 'UKRAINE',
    'ARE': 'UNITED ARAB EMIRATES',

    'GBR': 'UNITED KINGDOM',

    'URY': 'URUGUAY',
    // Add more country codes and names as needed
  };

  // Return the country name corresponding to the code
  return countryCodes[code.toUpperCase()] ?? 'Unknown Country Code';
}
