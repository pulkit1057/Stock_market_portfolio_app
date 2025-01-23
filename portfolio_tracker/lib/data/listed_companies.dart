import 'dart:math';

int generateRandomPrice() {
  return 100 + Random().nextInt(2900);
}

Map<String, Map<String, dynamic>> indianStocks = {
  'Reliance Industries': {'symbol': 'RELIANCE', 'price': generateRandomPrice()},
  'Tata Consultancy Services': {
    'symbol': 'TCS',
    'price': generateRandomPrice()
  },
  'HDFC Bank': {'symbol': 'HDFCBANK', 'price': generateRandomPrice()},
  'Infosys': {'symbol': 'INFY', 'price': generateRandomPrice()},
  'ICICI Bank': {'symbol': 'ICICIBANK', 'price': generateRandomPrice()},
  'Bajaj Finance': {'symbol': 'BAJFINANCE', 'price': generateRandomPrice()},
  'Bharti Airtel': {'symbol': 'BHARTIARTL', 'price': generateRandomPrice()},
  'State Bank of India': {'symbol': 'SBIN', 'price': generateRandomPrice()},
  'Larsen & Toubro': {'symbol': 'LT', 'price': generateRandomPrice()},
  'Hindustan Unilever': {
    'symbol': 'HINDUNILVR',
    'price': generateRandomPrice()
  },
  'Wipro': {'symbol': 'WIPRO', 'price': generateRandomPrice()},
  'Axis Bank': {'symbol': 'AXISBANK', 'price': generateRandomPrice()},
  'Kotak Mahindra Bank': {
    'symbol': 'KOTAKBANK',
    'price': generateRandomPrice()
  },
  'Maruti Suzuki': {'symbol': 'MARUTI', 'price': generateRandomPrice()},
  'Mahindra & Mahindra': {'symbol': 'M&M', 'price': generateRandomPrice()},
  'Asian Paints': {'symbol': 'ASIANPAINT', 'price': generateRandomPrice()},
  'Sun Pharma': {'symbol': 'SUNPHARMA', 'price': generateRandomPrice()},
  'ITC Limited': {'symbol': 'ITC', 'price': generateRandomPrice()},
  'Nestle India': {'symbol': 'NESTLEIND', 'price': generateRandomPrice()},
  'Power Grid Corporation': {
    'symbol': 'POWERGRID',
    'price': generateRandomPrice()
  },
  'Tata Steel': {'symbol': 'TATASTEEL', 'price': generateRandomPrice()},
  'UltraTech Cement': {'symbol': 'ULTRACEMCO', 'price': generateRandomPrice()},
  'Bharat Petroleum': {'symbol': 'BPCL', 'price': generateRandomPrice()},
  'Indian Oil Corporation': {'symbol': 'IOC', 'price': generateRandomPrice()},
  'Tech Mahindra': {'symbol': 'TECHM', 'price': generateRandomPrice()},
  'Dr. Reddy’s Laboratories': {
    'symbol': 'DRREDDY',
    'price': generateRandomPrice()
  },
  'HCL Technologies': {'symbol': 'HCLTECH', 'price': generateRandomPrice()},
  'NTPC Limited': {'symbol': 'NTPC', 'price': generateRandomPrice()},
  'Hero MotoCorp': {'symbol': 'HEROMOTOCO', 'price': generateRandomPrice()},
  'Titan Company': {'symbol': 'TITAN', 'price': generateRandomPrice()},
  'Cipla': {'symbol': 'CIPLA', 'price': generateRandomPrice()},
  'Adani Ports': {'symbol': 'ADANIPORTS', 'price': generateRandomPrice()},
  'Grasim Industries': {'symbol': 'GRASIM', 'price': generateRandomPrice()},
  'IndusInd Bank': {'symbol': 'INDUSINDBK', 'price': generateRandomPrice()},
  'Bajaj Auto': {'symbol': 'BAJAJ-AUTO', 'price': generateRandomPrice()},
  'Divi’s Laboratories': {'symbol': 'DIVISLAB', 'price': generateRandomPrice()},
  'Tata Motors': {'symbol': 'TATAMOTORS', 'price': generateRandomPrice()},
  'SBI Life Insurance': {'symbol': 'SBILIFE', 'price': generateRandomPrice()},
  'Eicher Motors': {'symbol': 'EICHERMOT', 'price': generateRandomPrice()},
  'JSW Steel': {'symbol': 'JSWSTEEL', 'price': generateRandomPrice()},
  'HDFC Life Insurance': {'symbol': 'HDFCLIFE', 'price': generateRandomPrice()},
  'Motherson Sumi Systems': {
    'symbol': 'MOTHERSUMI',
    'price': generateRandomPrice()
  },
  'Reliance Power': {'symbol': 'RELIANCEPOWER', 'price': generateRandomPrice()},
  'Shree Cement': {'symbol': 'SHREECEM', 'price': generateRandomPrice()},
  'Bajaj Finserv': {'symbol': 'BAJAJFINSV', 'price': generateRandomPrice()},
  'Patanjali Ayurved': {'symbol': 'PATAANJALI', 'price': generateRandomPrice()},
  'Dr. Lal PathLabs': {'symbol': 'DLF', 'price': generateRandomPrice()},
  'Hindalco Industries': {'symbol': 'HINDALCO', 'price': generateRandomPrice()},
  'BASF India': {'symbol': 'BASF', 'price': generateRandomPrice()},
  'Ambuja Cements': {'symbol': 'AMBUJACEM', 'price': generateRandomPrice()},
  'ACC Limited': {'symbol': 'ACC', 'price': generateRandomPrice()},
  'V-Mart Retail': {'symbol': 'VMART', 'price': generateRandomPrice()},
  'Exide Industries': {'symbol': 'EXIDEIND', 'price': generateRandomPrice()},
  'Indian Hotels': {'symbol': 'INDHOTEL', 'price': generateRandomPrice()},
  'Zee Entertainment': {'symbol': 'ZEEL', 'price': generateRandomPrice()},
  'ICICI Prudential Life Insurance': {
    'symbol': 'ICICIPRULI',
    'price': generateRandomPrice()
  },
  'Bank of Baroda': {'symbol': 'BANKBARODA', 'price': generateRandomPrice()},
  'PVR Limited': {'symbol': 'PVR', 'price': generateRandomPrice()},
  'TVS Motor Company': {'symbol': 'TVSMOTOR', 'price': generateRandomPrice()},
  'Wockhardt': {'symbol': 'WOCKPHARMA', 'price': generateRandomPrice()},
  'GAIL India': {'symbol': 'GAIL', 'price': generateRandomPrice()},
  'SBI Cards and Payment Services': {
    'symbol': 'SBICARD',
    'price': generateRandomPrice()
  },
  'Tata Chemicals': {'symbol': 'TATACHEM', 'price': generateRandomPrice()},
  'Bajaj Holdings & Investment': {
    'symbol': 'BAJAJHLDNG',
    'price': generateRandomPrice()
  },
  'Lupin': {'symbol': 'LUPIN', 'price': generateRandomPrice()},
  'Zydus Lifesciences': {'symbol': 'ZYDUSLIFE', 'price': generateRandomPrice()},
  'M&M Financial Services': {
    'symbol': 'M&MFIN',
    'price': generateRandomPrice()
  },
  'Colgate-Palmolive India': {
    'symbol': 'COLPAL',
    'price': generateRandomPrice()
  },
  'Britannia Industries': {
    'symbol': 'BRITANNIA',
    'price': generateRandomPrice()
  },
  'Lupin Limited': {
    'symbol': 'LUPIN',
    'price': generateRandomPrice()
  }, // Duplicate
  'SBI Mutual Fund': {'symbol': 'SBIMF', 'price': generateRandomPrice()},
  'Havells India': {'symbol': 'HAVELLS', 'price': generateRandomPrice()},
  'Mahanagar Gas': {'symbol': 'MAHAGAS', 'price': generateRandomPrice()},
  'L&T Infotech': {'symbol': 'LTI', 'price': generateRandomPrice()},
  'Bharat Forge': {'symbol': 'BHARATFORG', 'price': generateRandomPrice()},
  'BHEL': {'symbol': 'BHEL', 'price': generateRandomPrice()},
  'Godrej Consumer Products': {
    'symbol': 'GODREJCP',
    'price': generateRandomPrice()
  },
  'Ultratech Cement': {
    'symbol': 'ULTRACEMCO',
    'price': generateRandomPrice()
  }, // Duplicate
  'Marico': {'symbol': 'MARICO', 'price': generateRandomPrice()},
  'Glenmark Pharmaceuticals': {
    'symbol': 'GLENMARK',
    'price': generateRandomPrice()
  },
  'Sterlite Technologies': {
    'symbol': 'STERTOOLS',
    'price': generateRandomPrice()
  },
  'Indiabulls Housing Finance': {
    'symbol': 'IBULHSGFIN',
    'price': generateRandomPrice()
  },
  'Siemens': {'symbol': 'SIEMENS', 'price': generateRandomPrice()},
  'ABB India': {'symbol': 'ABB', 'price': generateRandomPrice()},
  'Tata Power': {'symbol': 'TATAPOWER', 'price': generateRandomPrice()},
  'Jindal Steel & Power': {
    'symbol': 'JINDALSTEL',
    'price': generateRandomPrice()
  },
  'SpiceJet': {'symbol': 'SPICEJET', 'price': generateRandomPrice()},
  'Biocon': {'symbol': 'BIOCON', 'price': generateRandomPrice()},
  'Tata Elxsi': {'symbol': 'TATAELXSI', 'price': generateRandomPrice()},
  'Dabur India': {'symbol': 'DABUR', 'price': generateRandomPrice()},
  'South Indian Bank': {'symbol': 'SOUTHBANK', 'price': generateRandomPrice()},
  'Aurobindo Pharma': {'symbol': 'AUROPHARMA', 'price': generateRandomPrice()},
  'Ashok Leyland': {'symbol': 'ASHOKLEY', 'price': generateRandomPrice()},
};

List<String> companyNames = indianStocks.keys.toList();
