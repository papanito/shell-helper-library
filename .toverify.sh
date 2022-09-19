# @description convert currencies
# for currency shorthand: http://www.xe.com/currency/
# @arg $1 int value to convert
# @arg $2 string currency shorthand to convert from
# @arg $3 string currency shorthand to convert to
currency_convert() { 
    if [ $# -lt 3 ]; then
      echo "convert currencies"
      echo "usage: currency_convert [amount] [crrency from] [currency to]"
      currency_convert_help
    else
      (wget -qO- "http://www.google.com/finance/converter?a=$1&from=$2&to=$3&hl=es" | sed '/res/!d;s/<[^>]*>//g')
    fi
}

currency_convert_help() {
   echo "AED - Emirati Dirham
   AFN - Afghan Afghani
   ALL - Albanian Lek
   AMD - Armenian Dram
   ANG - Dutch Guilder
   AOA - Angolan Kwanza
   ARS - Argentine Peso
   AUD - Australian Dollar
   AWG - Aruban or Dutch Guilder
   AZN - Azerbaijani New Manat
   BAM - Bosnian Convertible Marka
   BBD - Barbadian or Bajan Dollar
   BDT - Bangladeshi Taka
   BGN - Bulgarian Lev
   BHD - Bahraini Dinar
   BIF - Burundian Franc
   BMD - Bermudian Dollar
   BND - Bruneian Dollar
   BOB - Bolivian Boliviano
   BRL - Brazilian Real
   BSD - Bahamian Dollar
   BTN - Bhutanese Ngultrum
   BWP - Batswana Pula
   BYR - Belarusian Ruble
   BZD - Belizean Dollar
   CAD - Canadian Dollar
   CDF - Congolese Franc
   CHF - Swiss Franc
   CLP - Chilean Peso
   CNY - Chinese Yuan Renminbi
   COP - Colombian Peso
   CRC - Costa Rican Colon
   CUC - Cuban Convertible Peso
   CUP - Cuban Peso
   CVE - Cape Verdean Escudo
   CZK - Czech Koruna
   DJF - Djiboutian Franc
   DKK - Danish Krone
   DOP - Dominican Peso
   DZD - Algerian Dinar
   EEK - Estonian Kroon
   EGP - Egyptian Pound
   ERN - Eritrean Nakfa
   ETB - Ethiopian Birr
   EUR - Euro
   FJD - Fijian Dollar
   FKP - Falkland Island Pound
   GBP - British Pound
   GEL - Georgian Lari
   GGP - Guernsey Pound
   GHS - Ghanaian Cedi
   GIP - Gibraltar Pound
   GMD - Gambian Dalasi
   GNF - Guinean Franc
   GTQ - Guatemalan Quetzal
   GYD - Guyanese Dollar
   HKD - Hong Kong Dollar
   HNL - Honduran Lempira
   HRK - Croatian Kuna
   HTG - Haitian Gourde
   HUF - Hungarian Forint
   IDR - Indonesian Rupiah
   ILS - Israeli Shekel
   IMP - Isle of Man Pound
   INR - Indian Rupee
   IQD - Iraqi Dinar
   IRR - Iranian Rial
   ISK - Icelandic Krona
   JEP - Jersey Pound
   JMD - Jamaican Dollar
   JOD - Jordanian Dinar
   JPY - Japanese Yen
   KES - Kenyan Shilling
   KGS - Kyrgyzstani Som
   KHR - Cambodian Riel
   KMF - Comoran Franc
   KPW - Korean Won
   KRW - Korean Won
   KWD - Kuwaiti Dinar
   KYD - Caymanian Dollar
   KZT - Kazakhstani Tenge
   LAK - Lao or Laotian Kip
   LBP - Lebanese Pound
   LKR - Sri Lankan Rupee
   LRD - Liberian Dollar
   LSL - Basotho Loti
   LTL - Lithuanian Litas
   LVL - Latvian Lat
   LYD - Libyan Dinar
   MAD - Moroccan Dirham
   MDL - Moldovan Leu
   MGA - Malagasy Ariary
   MKD - Macedonian Denar
   MMK - Burmese Kyat
   MNT - Mongolian Tughrik
   MOP - Macau Pataca
   MRO - Mauritian Ouguiya
   MUR - Mauritian Rupee
   MVR - Maldivian Rufiyaa
   MWK - Malawian Kwacha
   MXN - Mexican Peso
   MYR - Malaysian Ringgit
   MZN - Mozambican Metical
   NAD - Namibian Dollar
   NGN - Nigerian Naira
   NIO - Nicaraguan Cordoba
   NOK - Norwegian Krone
   NPR - Nepalese Rupee
   NZD - New Zealand Dollar
   OMR - Omani Rial
   PAB - Panamanian Balboa
   PEN - Peruvian Nuevo Sol
   PGK - Papua New Guinean Kina
   PHP - Philippine Peso
   PKR - Pakistani Rupee
   PLN - Polish Zloty
   PYG - Paraguayan Guarani
   QAR - Qatari Riyal
   RON - Romanian New Leu
   RSD - Serbian Dinar
   RUB - Russian Ruble
   RWF - Rwandan Franc
   SAR - Saudi or Saudi Arabian Riyal
   SBD - Solomon Islander Dollar
   SCR - Seychellois Rupee
   SDG - Sudanese Pound
   SEK - Swedish Krona
   SGD - Singapore Dollar
   SHP - Saint Helenian Pound
   SLL - Sierra Leonean Leone
   SOS - Somali Shilling
   SPL - Seborgan Luigino
   SRD - Surinamese Dollar
   STD - Sao Tomean Dobra
   SVC - Salvadoran Colon
   SYP - Syrian Pound
   SZL - Swazi Lilangeni
   THB - Thai Baht
   TJS - Tajikistani Somoni
   TMT - Turkmenistani Manat
   TND - Tunisian Dinar
   TOP - Tongan Pa'anga
   TRY - Turkish Lira
   TTD - Trinidadian Dollar
   TVD - Tuvaluan Dollar
   TWD - Taiwan New Dollar
   TZS - Tanzanian Shilling
   UAH - Ukrainian Hryvna
   UGX - Ugandan Shilling
   USD - US Dollar
   UYU - Uruguayan Peso
   UZS - Uzbekistani Som
   VEF - Venezuelan Bolivar Fuerte
   VND - Vietnamese Dong
   VUV - Ni-Vanuatu Vatu
   WST - Samoan Tala
   XAF - Central African CFA Franc BEAC
   XCD - East Caribbean Dollar
   XDR - IMF Special Drawing Rights
   XOF - CFA Franc
   XPF - CFP Franc
   YER - Yemeni Rial
   ZAR - South African Rand
   ZMK - Zambian Kwacha
   ZWD - Zimbabwean Dollar"
}



# @description translate a word using Google
# usage: translate <phrase> <output-language>
# @arg $1 string text to translate
# @example
#   translate "hello" es = hola (will auto-detect source language)
# for a list of language codes: http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
translate() {
   wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=%7C${2:-en}" | sed 's/.*{"translatedText":"\([^"]*\)".*/\1\n/'; 
}

# @description translate a word using Google
# usage: translate <phrase> <output-language>
translate_help() {
   echo"Language   ISO
   (Afan) Oromo           om
   Abkhazian              ab
   Afar                   aa
   Afrikaans              af
   Albanian               sq
   Amharic                am
   Arabic                  ar
   Armenian               hy
   Assamese               as
   Aymara                 ay
   Azerbaijani            az
   Bashkir                ba
   Basque                 eu
   Bengali                bn
   Bhutani                dz
   Bihari                 bh
   Bislama                bi
   Breton                 br
   Bulgarian              bg
   Burmese                my
   Byelorussian           be
   Cambodian              km
   Catalan                ca
   Chinese                zh
   Corsican               co
   Croatian               hr
   Czech                  cs
   Danish                 da
   Dutch                  nl
   English                en
   Esperanto              eo
   Estonian               et
   Faeroese               fo
   Fiji                   fj
   Finnish                fi
   French                 fr
   Frisian                fy
   Galician               gl
   Georgian               ka
   German                 de
   Greek                  el
   Greenlandic            kl
   Guarani                gn
   Gujarati               gu
   Hausa                  ha
   Hebrew                 he (former iw) 
   Hindi                  hi
   Hungarian              hu
   Icelandic              is
   Indonesian             id (former in)
   Interlingua            ia
   Interlingue            ie
   Inupiak                ik
   Inuktitut (Eskimo)     iu
   Irish                  ga
   Italian                it
   Japanese               ja
   Javanese               jw
   Kannada                kn
   Kashmiri               ks
   Kazakh                 kk
   Kinyarwanda            rw
   Kirghiz                ky
   Kirundi                rn
   Korean                 ko
   Kurdish                ku
   Laothian               lo
   Latin                  la
   Latvian, Lettish       lv
   Lingala                ln
   Lithuania              lt
   Macedonia              mk
   Malagasy               mg
   Malay                  ms
   Malayalam              ml
   Maltese                mt
   Maori                  mi
   Marathi                mr
   Moldavian              mo
   Mongolian              mn
   Nauru                  na
   Nepali                 ne
   Norwegian              no
   Occitan                oc
   Oriya                  or
   Pashto, Pushto         ps
   Persian                fa
   Polish                 pl
   Portuguese             pt
   Punjabi                pa
   Quechua                qu
   Rhaeto-Romance         rm
   Romanian               ro
   Russian                ru
   Samoan                  sm
   Sangro                 sg
   Sanskrit               sa
   Scots Gaelic           gd
   Serbian                sr
   Serbo-Croatian         sh
   Sesotho                st
   Setswana               tn
   Shona                  sn
   Sindhi                 sd
   Singhalese             si
   Siswati                ss
   Slovak                 sk
   Slovenian              sl
   Somali                 so
   Spanish                es
   Sudanese               su
   Swahili                sw
   Swedish                sv
   Tagalog                tl
   Tajik                  tg
   Tamil                  ta
   Tatar                  tt
   Tegulu                 te
   Thai                   th
   Tibetan                bo
   Tigrinya               ti
   Tonga                  to
   Tsonga                 ts
   Turkish                tr
   Turkmen                tk
   Twi                    tw
   Uigur                  ug
   Ukrainian              uk
   Urdu                   ur
   Uzbek                  uz
   Vietnamese             vi
   Volapuk                vo
   Welch                  cy
   Wolof                  wo
   Xhosa                  xh
   Yiddish                yi (former ji)
   Yoruba                 yo
   Zhuang                 za
   Zulu                   zu"
}
