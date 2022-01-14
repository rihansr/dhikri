import 'package:dhikri/helper/datetime_helper.dart';
import 'package:dhikri/helper/preference_manager.dart';
import 'package:dhikri/model/weekday_model.dart';
import 'package:dhikri/utils/extensions.dart';
import 'package:dhikri/values/drawables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'model/adhkar_model.dart';

class Data {
  List<Weekday> weekdays = [
    Weekday(id: 6, dayBn: 'শনি', dayEn: 'Sat'),
    Weekday(id: 7, dayBn: 'রবি', dayEn: 'Sun'),
    Weekday(id: 1, dayBn: 'সোম', dayEn: 'Mon'),
    Weekday(id: 2, dayBn: 'মঙ্গল', dayEn: 'Tue'),
    Weekday(id: 3, dayBn: 'বুধ', dayEn: 'Wed'),
    Weekday(id: 4, dayBn: 'বৃহঃ', dayEn: 'Thu'),
    Weekday(id: 5, dayBn: 'শুক্র', dayEn: 'Fri'),
  ];

  List<Adhkar> adhkars = [
    Adhkar(
      id: 1,
      titleBn: 'সকালের যিকর',
      titleEn: 'Morning Adhkar',
      contentColor: Colors.white,
      backdrop: drawable.morningAzkarIcon,
      background: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF3ABAC7),
          Color(0xFF75CBD3),
        ],
      ),
      itemsBackground: Colors.white30,
      itemView: View.list,
      brightness: Brightness.dark,
      progress: 0,
      weekdays: [6, 7, 1, 2, 3, 4, 5],
      items: _getAdhkars(id: 1),
    ),
    Adhkar(
      id: 2,
      titleBn: 'বিকেলের যিকর',
      titleEn: 'Evening Adhkar',
      contentColor: Colors.white,
      backdrop: drawable.eveningAzkarIcon,
      background: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF28030),
          Color(0xFFECA627),
        ],
      ),
      itemsBackground: Colors.white38,
      itemView: View.list,
      brightness: Brightness.dark,
      progress: 0,
      weekdays: [6, 7, 1, 2, 3, 4, 5],
      items: _getAdhkars(id: 2),
    ),
    Adhkar(
      id: 3,
      titleBn: 'ঘুমানোর আগের আমল',
      titleEn: 'Bedtime Adhkar',
      contentColor: Colors.white,
      backdrop: drawable.sunnahBeforeSleepIcon,
      background: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF0F548B),
          Color(0xFF2671A6),
        ],
      ),
      itemsBackground: Colors.white30,
      itemView: View.list,
      brightness: Brightness.dark,
      progress: 0,
      weekdays: [6, 7, 1, 2, 3, 4, 5],
      items: _getAdhkars(id: 3),
    ),
    Adhkar(
      id: 4,
      titleBn: 'জুমাবারের আমল',
      titleEn: 'Friday Adhkar',
      contentColor: Colors.black,
      backdrop: drawable.fridaySunnahIcon,
      background: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFB8B9B5),
          Color(0xFFEAF0F0),
        ],
      ),
      itemsBackground: Color(0xFF1D989F),
      itemView: View.list,
      brightness: Brightness.light,
      progress: 0,
      weekdays: [5],
      items: _getAdhkars(id: 4),
    ),
  ];

  Adhkar allDuas = Adhkar(
    id: 0,
    titleBn: 'সকল দুআ',
    titleEn: 'All Dua',
    contentColor: Colors.white,
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF46707d),
        Color(0xFF133548),
      ],
    ),
    itemsBackground: Colors.white30,
    itemView: View.list,
    brightness: Brightness.dark,
    weekdays: [6, 7, 1, 2, 3, 4, 5],
    items: _allAdhkars(),
  );
}

List<AdhkarItem> _getAdhkars({required id}) {
  List<AdhkarItem> items = [];
  int count = 0;

  for (AdhkarItem item in _adhkars) {
    if (item?.adhkarIds?.contains(id) ?? false) {
      if ((item?.titleBn?.contains('#') ?? false) ||
          (item?.titleEn?.contains('#') ?? false)) {
        count += 1;
        items.add(item.copyWith(
          azkarIds: [id],
          titleBn: 'দুআ #${extension.digitConversion(count)}',
          titleEn: 'Dua #$count',
          read: isRead(item.id, item.adhkarIds!),
        ));
      } else
        items.add(item
            .copyWith(azkarIds: [id], read: isRead(item.id, item.adhkarIds!)));
    }
  }

  return items;
}

List<AdhkarItem> _allAdhkars() {
  List<AdhkarItem> items = [];

  for (AdhkarItem item in _adhkars) {
    if (item.detailEn == null && item.detailBn == null) continue;
    items.add(item.copyWith(read: isRead(item.id, item.adhkarIds!)));
  }

  return items;
}

bool isRead(int? itemId, List<int> adhkarIds) {
  for (int adhkarId in adhkarIds) {
    bool readToday = dateTimeHelper.itsToday(
        date: preferenceManager.getReadItem(key: '${adhkarId}_$itemId'));
    if (readToday) return true;
  }
  return false;
}

List<AdhkarItem> _adhkars = [
  AdhkarItem(
    id: 1,
    adhkarIds: [1, 2],
    titleBn: "আয়াতুল কুরসি",
    titleEn: "Ayatul Kursi",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic: "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ",
          meaning: "বিতাড়িত শয়তান থেকে আমি আল্লাহ্‌র আশ্রয় নিচ্ছি।",
        ),
        Verse(
          id: 2,
          arabic: "اللَّهُ لَآ إِلٰهَ إِلَّا هُوَ الْحَىُّ الْقَيُّومُ",
          meaning:
              "আল্লাহ্, তিনি ছাড়া কোনো সত্য ইলাহ্ নেই। তিনি চিরঞ্জীব, সর্বসত্তার ধারক।",
        ),
        Verse(
          id: 3,
          arabic: "لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ",
          meaning: "তাঁকে তন্দ্রাও স্পর্শ করতে পারে না, নিদ্রাও নয়।",
        ),
        Verse(
          id: 4,
          arabic: "لَّهُ مَا فِى السَّمٰوٰتِ وَمَا فِى الْأَرْضِ",
          meaning: "আসমানসমূহে যা রয়েছে ও যমীনে যা রয়েছে সবই তাঁর।",
        ),
        Verse(
          id: 5,
          arabic: "مَنْ ذَا الَّذِى يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ",
          meaning: "কে সে, যে তাঁর অনুমতি ব্যতীত তাঁর কাছে সুপারিশ করবে?",
        ),
        Verse(
          id: 6,
          arabic: "يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ",
          meaning: "তাদের সামনে ও পিছনে যা কিছু আছে তা তিনি জানেন।",
        ),
        Verse(
          id: 7,
          arabic: "وَلَا يُحِيطُونَ بِشَىْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَآءَ",
          meaning:
              "আর যা তিনি ইচ্ছে করেন তা ছাড়া তাঁর জ্ঞানের কোনো কিছুকেই তারা পরিবেষ্টন করতে পারে না।",
        ),
        Verse(
          id: 8,
          arabic: "وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْأَرْضَ",
          meaning: "তাঁর ‘কুরসী’ আসমানসমূহ ও যমীনকে পরিব্যাপ্ত করে আছে।",
        ),
        Verse(
          id: 9,
          arabic: "وَلاَ يَؤُودُهُ حِفْظُهُمَا",
          meaning: "আর এ দুটোর রক্ষণাবেক্ষণ তাঁর জন্য বোঝা হয় না।",
        ),
        Verse(
          id: 10,
          arabic: "وَهُوَ الْعَلِىُّ الْعَظِيمُ",
          meaning: "আর তিনি সুউচ্চ সুমহান।",
        ),
      ],
      source: "(সূরা বাক্বারাহ ২:২৫৫)",
      explanation:
          "যে ব্যক্তি সকালে তা বলবে সে বিকাল হওয়া পর্যন্ত জিন শয়তান থেকে আল্লাহর আশ্রয়ে থাকবে, আর যে ব্যক্তি বিকালে তা বলবে সে সকাল হওয়া পর্যন্ত জিন শয়তান থেকে আল্লাহর আশ্রয়ে থাকবে।\n(আত তারগীব ওয়াত-তারহীব: ১/২৭৩)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic: "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ",
          meaning: "I take refuge with Allah from the accursed devil.",
        ),
        Verse(
          id: 2,
          arabic: "اللَّهُ لَآ إِلٰهَ إِلَّا هُوَ الْحَىُّ الْقَيُّومُ",
          meaning:
              "Allah! There is none worthy of worship but He, the Ever Living, the One Who sustains and protects all that exists.",
        ),
        Verse(
          id: 3,
          arabic: "لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ",
          meaning: "Neither slumber nor sleep overtakes Him.",
        ),
        Verse(
          id: 4,
          arabic: "لَّهُ مَا فِى السَّمٰوٰتِ وَمَا فِى الْأَرْضِ",
          meaning:
              "To Him belongs whatever is in the heavens and whatever is on the earth.",
        ),
        Verse(
          id: 5,
          arabic: "مَنْ ذَا الَّذِى يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ",
          meaning:
              "Who is he that can intercede with Him except with His Permission?",
        ),
        Verse(
          id: 6,
          arabic: "يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ",
          meaning:
              "He knows what happens to them in this world, and what will happen to them in the Hereafter.",
        ),
        Verse(
          id: 7,
          arabic: "وَلَا يُحِيطُونَ بِشَىْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَآءَ",
          meaning:
              "And they will never compass anything of His Knowledge except that which He wills.",
        ),
        Verse(
          id: 8,
          arabic: "وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْأَرْضَ",
          meaning: "His ‘Kursi’ extends over the heavens and the earth,",
        ),
        Verse(
          id: 9,
          arabic: "وَلاَ يَؤُودُهُ حِفْظُهُمَا",
          meaning: "and He feels no fatigue in guarding and preserving them.",
        ),
        Verse(
          id: 10,
          arabic: "وَهُوَ الْعَلِىُّ الْعَظِيمُ",
          meaning: "And He is the Most High, the Most Great.",
        ),
      ],
      source: "(surah al Baqarah 2:255)",
      explanation:
          "The one who recites it in morning, will be in protection of Allah from devils among the jinns till afternoon and whoever recites in afternoon will be in protection of Allah from the devils among the jinns till morning.\n(At-Targhib wat-Tarhib: 1/273)",
    ),
  ),
  AdhkarItem(
    id: 2,
    adhkarIds: [1, 2],
    titleBn: "সবকিছুর (নিরাপত্তার) জন্য যথেষ্ট যে দুআ",
    titleEn: "Dua that will suffice one (as a protection) against everything",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          title: "সূরা ইখলাস",
          arabic:
              "قُلْ هُوَ اللّٰهُ أَحَدٌ  ❊  اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ  ❊  وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ",
          meaning:
              "বলুন, তিনি আল্লাহ, এক-অদ্বিতীয়। আল্লাহ হচ্ছেন ‘সামাদ’ (তিনি কারো মুখাপেক্ষী নন, সকলেই তাঁর মুখাপেক্ষী)। তিনি কাউকেও জন্ম দেন নি এবং তাঁকেও জন্ম দেয়া হয় নি। আর তাঁর সমতুল্য কেউই নেই।",
        ),
        Verse(
          id: 2,
          title: "সূরা ফালাক্ব",
          arabic:
              "قُلْ أَعُوذُ بِرَ‌بِّ الْفَلَقِ  ❊  مِن شَرِّ‌ مَا خَلَقَ وَمِن شَرِّ‌ غَاسِقٍ إِذَا وَقَبَ  ❊  وَمِن شَرِّ‌ النَّفَّاثَاتِ فِي الْعُقَدِ  ❊  وَمِن شَرِّ‌ حَاسِدٍ إِذَا حَسَدَ",
          meaning:
              "বলুন, আমি আশ্রয় প্রার্থনা করছি ঊষার রবের। তিনি যা সৃষ্টি করেছেন তার অনিষ্ট হতে। ‘আর অনিষ্ট হতে রাতের অন্ধকারের, যখন তা গভীর হয়। আর অনিষ্ট হতে সমস্ত নারীদের, যারা গিরায় ফুঁক দেয়। আর অনিষ্ট হতে হিংসুকের, যখন সে হিংসা করে।",
        ),
        Verse(
          id: 3,
          title: "সূরা নাস",
          arabic:
              "قُلْ أَعُوذُ بِرَ‌بِّ النَّاسِ ❊  مَلِكِ النَّاسِ  ❊  إِلَـٰهِ النَّاسِ مِن شَرِّ‌ الْوَسْوَاسِ الْخَنَّاسِ  ❊  الَّذِي يُوَسْوِسُ فِي صُدُورِ‌ النَّاسِ  ❊  مِنَ الْجِنَّةِ وَالنَّاسِ",
          meaning:
              "বলুন, আমি আশ্রয় প্রার্থনা করছি মানুষের রবের, মানুষের অধিপতির, মানুষের ইলাহের কাছে, আত্মগোপনকারী কুমন্ত্রণাদাতার অনিষ্ট হতে; যে কুমন্ত্রণা দেয় মানুষের অন্তরে, জিনের মধ্য থেকে এবং মানুষের মধ্য থেকে।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) বলেন, “তুমি প্রতি দিন বিকালে ও সকালে উপনীত হয়ে তিনবার করে সূরা কুল হুআল্লাহু আহাদ (সূরা আল -ইখলাস) ও আল –মুআওবিযাতাইন (সূরা আল –ফালাক্ব ও সুলা আন -নাস) পাঠ করবে, আর তা প্রত্যেকটি ব্যাপারে তোমার জন্য যথেষ্ট হবে।”\n(তিরমিযী: ৩৫৭৫)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          title: "Surah Al-Ikhlas",
          arabic:
              "قُلْ هُوَ اللّٰهُ أَحَدٌ  ❊  اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ  ❊  وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ",
          meaning:
              "With the Name of Allah, the Most Gracious, the Most Merciful. Say: He is Allah (the) One. The Self-Sufficient Master, whom all creatures need, He begets not nor was He begotten, and there is none equal to Him.",
        ),
        Verse(
          id: 2,
          title: "Surah Al-Falaq",
          arabic:
              "قُلْ أَعُوذُ بِرَ‌بِّ الْفَلَقِ  ❊  مِن شَرِّ‌ مَا خَلَقَ وَمِن شَرِّ‌ غَاسِقٍ إِذَا وَقَبَ  ❊  وَمِن شَرِّ‌ النَّفَّاثَاتِ فِي الْعُقَدِ  ❊  وَمِن شَرِّ‌ حَاسِدٍ إِذَا حَسَدَ",
          meaning:
              "With the Name of Allah, the Most Gracious, the Most Merciful. Say: I seek refuge with (Allah) the Lord of the daybreak, from the evil of what He has created, and from the evil of the darkening (night) as it comes with its darkness, and from the evil of those who practice witchcraft when they blow in the knots, and from the evil of the envier when he envies.",
        ),
        Verse(
          id: 3,
          title: "Surah An-Nas",
          arabic:
              "قُلْ أَعُوذُ بِرَ‌بِّ النَّاسِ ❊  مَلِكِ النَّاسِ  ❊  إِلَـٰهِ النَّاسِ مِن شَرِّ‌ الْوَسْوَاسِ الْخَنَّاسِ  ❊  الَّذِي يُوَسْوِسُ فِي صُدُورِ‌ النَّاسِ  ❊  مِنَ الْجِنَّةِ وَالنَّاسِ",
          meaning:
              "With the Name of Allah, the Most Gracious, the Most Merciful. Say: I seek refuge with (Allah) the Lord of mankind, the King of mankind, the God of mankind, from the evil of the whisperer who withdraws, who whispers in the breasts of mankind, of jinns and men.",
        ),
      ],
      explanation:
          "Then the Messenger of Allah [SAW] said: 'Say: He is Allah, (the) One and Al-Mu'awwadhatain in the evening and in the morning, three times, and that will suffice you against everything.'\n(Tirmizi: 3575)",
    ),
  ),
  AdhkarItem(
    id: 3,
    adhkarIds: [1, 2],
    titleBn: "সায়্যিদুল ইসতিগফার\n(ক্ষমা চাওয়ার শ্রেষ্ঠ দুআ)",
    titleEn: "Sayyidinal Istighfar\n(Best way to ask forgiveness)",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ",
          pronounce:
              "আল্লা-হুম্মা আনতা রব্বী লা ইলা-হা ইল্লা আনতা খলাক্বতানী ওয়া আনা ‘আব্দুকা,",
          meaning:
              "হে আল্লাহ! আপনি আমার রব্ব, আপনি ছাড়া আর কোনো হক্ব ইলাহ নেই। আপনি আমাকে সৃষ্টি করেছেন এবং আমি আপনার বান্দা।",
        ),
        Verse(
          id: 2,
          arabic:
              "وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ",
          pronounce:
              "ওয়া আনা ‘আলা ‘আহদিকা ওয়া ওয়া‘দিকা মাস্তাত্বা‘তু। আ‘উযু বিকা মিন শাররি মা সানা‘তু,",
          meaning:
              "আর আমি আমার সাধ্য মতো আপনার (তাওহীদের) অঙ্গীকার ও (জান্নাতের) প্রতিশ্রুতির উপর রয়েছি। আমি আমার কৃতকর্মের অনিষ্ট থেকে আপনার আশ্রয় চাই।",
        ),
        Verse(
          id: 3,
          arabic: "أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي",
          pronounce: "আবূউলাকা বিনি‘মাতিকা ‘আলাইয়্যা, ওয়া আবূউ বিযাম্বী।",
          meaning:
              "আপনি আমাকে আপনার যে নিয়ামত দিয়েছেন তা আমি স্বীকার করছি, আর আমি স্বীকার করছি আমার অপরাধ।",
        ),
        Verse(
          id: 4,
          arabic:
              "فَاغْفِرْ لِي فَإِنَّهُ لاَ يَغْفِرُ الذُّنُوبَ إِلاَّ أَنْتَ",
          pronounce: "ফাগফির লী, ফাইন্নাহূ লা ইয়াগফিরুয যুনূবা ইল্লা আনতা।",
          meaning:
              "অতএব আপনি আমাকে মাফ করুন। নিশ্চয় আপনি ছাড়া আর কেউ গুনাহসমূহ মাফ করে না।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) বলেন, যে ব্যক্তি সকালবেলা অথবা সন্ধ্যাবেলা এটি (সায়্যিদুল ইসতিগফার) অর্থ বুঝে দৃঢ় বিশ্বাস সহকারে পড়বে, সে ঐ দিন রাতে বা দিনে মারা গেলে অবশ্যই জান্নাতে যাবে।\n(বুখারী: ৬৩০৬)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ",
          pronounce:
              "Allaahumma 'Anta Rabbee laa 'ilaaha 'illaa 'Anta, khalaqtanee wa 'anaa 'abduka,",
          meaning:
              "O Allah, You are my Lord, none has the right to be worshipped except You, You created me and I am Your servant.",
        ),
        Verse(
          id: 2,
          arabic:
              "وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ",
          pronounce:
              "wa 'anaa 'alaa 'ahdika wa wa'dika mas-tata'tu, 'a'oothu bika min sharri maa sana'tu,",
          meaning:
              "and I abide to Your covenant and promise as best I can, I take refuge in You from the evil of which I have committed.",
        ),
        Verse(
          id: 3,
          arabic: "أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي",
          pronounce:
              "a'oothu bika min sharri maa sana'tu, 'aboo'u laka bini'matika 'alayya, wa 'aboo'u bithanbee",
          meaning:
              "I acknowledge Your favour upon me and I acknowledge my sin,",
        ),
        Verse(
          id: 4,
          arabic:
              "فَاغْفِرْ لِي فَإِنَّهُ لاَ يَغْفِرُ الذُّنُوبَ إِلاَّ أَنْتَ",
          pronounce:
              "faghfir lee fa'innahu laa yaghfiruth-thunooba 'illaa 'Anta.",
          meaning: "so forgive me, for verily none can forgive sin except You.",
        ),
      ],
      explanation:
          'The Prophet (ﷺ) said. "If somebody recites it during the day with firm faith in it, and dies on the same day before the evening, he will be from the people of Paradise; and if somebody recites it at night with firm faith in it, and dies before the morning, he will be from the people of Paradise."\n(Bukhari: 6306)',
    ),
  ),
  AdhkarItem(
    id: 4,
    adhkarIds: [1, 2],
    titleBn: "কোনো কিছু ক্ষতি করতে পারবে না",
    titleEn: "Not afflicted by any calamity",
    detailBn: Detail(
      times: "তিনবার",
      verses: [
        Verse(
          id: 1,
          arabic:
              "بِسْمِ اللّٰهِ الَّذِيْ لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِيْ الْأَرْضِ وَلاَ فِيْ السَّمَاءِ وَهُوَ السَّمِيْعُ الْعَلِيْمُ",
          pronounce:
              "বিস্‌মিল্লা-হিল্লাযী লা ইয়াদ্বুররু মা‘আ ইস্‌মিহী শাইউন ফিল্ আরদ্বি ওয়ালা ফিস্ সামা-ই, ওয়াহুয়াস্ সামী‘উল ‘আলীম।",
          meaning:
              "আল্লাহর নামে; যাঁর নামের সাথে আসমান ও যমীনে কোনো কিছুই ক্ষতি করতে পারে না। আর তিনি সর্বশ্রোতা, মহাজ্ঞানী।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) বলেন, যে ব্যক্তি সকালে তিনবার এবং বিকালে তিনবার এটি বলবে, কোনো কিছু তার ক্ষতি করতে পারবে না।\n(আবু দাউদ: ৫০৮৮)",
    ),
    detailEn: Detail(
      times: "Three times",
      verses: [
        Verse(
          id: 1,
          arabic:
              "بِسْمِ اللّٰهِ الَّذِيْ لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِيْ الْأَرْضِ وَلاَ فِيْ السَّمَاءِ وَهُوَ السَّمِيْعُ الْعَلِيْمُ",
          pronounce:
              "Bismillaahil-lathee laa yadhurru ma'as-mihi shay'un fil-'ardhi wa laa fis-samaa'i wa Huwas-Samee 'ul- 'Aleem.",
          meaning:
              "In the name of Allah with whose name nothing is harmed on earth nor in the heavens and He is The All-Seeing, The All-Knowing.",
        ),
      ],
      explanation:
          "Messenger of Allah (ﷺ) said, Whoever recites it in the morning will not be afflicted by any calamity before evening, and whoever recites it in the evening will not be overtaken by any calamity before morning.\n(Abu Dawud: 5088)",
    ),
  ),
  AdhkarItem(
    id: 5,
    adhkarIds: [1, 2],
    titleBn: "কিয়ামতের দিনে আল্লাহর সন্তুষ্টি",
    titleEn: "Pleasure of Allah in the day of judgment",
    detailBn: Detail(
      times: "তিনবার",
      verses: [
        Verse(
          id: 1,
          arabic:
              "رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلاَمِ دِينًا وَبِمُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ نبينا",
          pronounce:
              "রদ্বীতু বিল্লা-হি রব্বান, ওয়াবিল ইসলা-মি দীনান, ওয়াবি মুহাম্মাদিন সাল্লাল্লা-হু ‘আলাইহি ওয়াসাল্লামা নাবিয়্যিনা।",
          meaning:
              "আল্লাহকে রব, ইসলামকে দীন ও মুহাম্মাদ সাল্লাল্লাহু আলাইহি ওয়াসাল্লাম-কে নবীরূপে গ্রহণ করে আমি সন্তুষ্ট।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) বলেন, যে ব্যক্তি এ দু’আ সকাল ও বিকাল তিনবার করে বলবে, আল্লাহর কাছে তার অধিকার হয়ে যায় তাকে কিয়ামতের দিন সন্তুষ্ট করা।\n(ইবনে মাজাহ: ৩৮৭০)",
    ),
    detailEn: Detail(
      times: "Three times",
      verses: [
        Verse(
          id: 1,
          arabic:
              "رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلاَمِ دِينًا وَبِمُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ نبينا",
          pronounce:
              "Radheetu billaahi Rabban, wa bil-'Islaami deenan, wa bi-Muhammadin (sallallaahu 'alayhi wa sallama) Nabiyyan.",
          meaning:
              "I am pleased with Allah as a Lord, and Islam as a religion and Muhammad as a prophet.",
        ),
      ],
      explanation:
          'The Prophet (saas) said: "There is no Muslim - or no person, or slave (of Allah) - who says, in the morning and evening but he will have a promise from Allah to make him pleased on the Day of Resurrection.\n(Ibn Majah: 3870)',
    ),
  ),
  AdhkarItem(
    id: 6,
    adhkarIds: [1],
    titleBn: "তার চেয়ে কেউ উৎকৃষ্ট হবে না যে এই দুআ বেশি পড়বে",
    titleEn: "Not surpassed by anyone except by one who says the dua more",
    detailBn: Detail(
      times: "একশত বার",
      verses: [
        Verse(
          id: 1,
          arabic: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
          pronounce: "সুবহা-নাল্লা-হি ওয়া বিহামদিহী।",
          meaning: "আমি আল্লাহর প্রশংসাসহ পবিত্রতা ও মহিমা ঘোষণা করছি।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) বলেন, যে ব্যক্তি প্রতিদিন একশ’বার সুবহানাল্লাহি ওয়া বিহামদিহ বলবে তার গুনাহগুলো ক্ষমা করে দেয়া হবে তা সমুদ্রের ফেনা পরিমাণ হলেও।\n(বুখারী: ৬৪০৫)",
    ),
    detailEn: Detail(
      times: "Hundred times",
      verses: [
        Verse(
          id: 1,
          arabic: "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
          pronounce: "Subhaanallaahi wa bihamdihi",
          meaning: "How perfect Allah is and I praise Him.",
        ),
      ],
      explanation:
          "Allah's Messenger (ﷺ) said, \"Whoever says, 'Subhan Allah wa bihamdihi,' one hundred times a day, will be forgiven all his sins even if they were as much as the foam of the sea.\n(Bukhari: 6405)",
    ),
  ),
  AdhkarItem(
    id: 7,
    adhkarIds: [1],
    titleBn: "দশটি দাসমুক্তির অনুরূপ ও একশত সাওয়াব",
    titleEn: "Freeing Ten slaves, Hundred Rewards, Hundred Sins taken away",
    detailBn: Detail(
      times: "একশত বার",
      verses: [
        Verse(
          id: 1,
          arabic:
              "لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ",
          pronounce:
              "লা ইলা-হা ইল্লাল্লা-হু ওয়াহ্‌দাহু লা শারীকা লাহু, লাহুল মুলকু, ওয়া লাহুল হামদু, ওয়া হুয়া ‘আলা কুল্লি শাই’ইন ক্বাদীর।",
          meaning:
              "একমাত্র আল্লাহ ছাড়া কোনো হক্ব ইলাহ নেই, তাঁর কোনো শরীক নেই, রাজত্ব তাঁরই, সমস্ত প্রশংসাও তাঁর, আর তিনি সকল কিছুর উপর ক্ষমতাবান।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) বলেন, যে ব্যক্তি এই দু’আ দিনে একশত বার বলবে সেটা তার জন্য দশটি দাশমুক্তির অনুরূপ হবে, তার জন্য একশত সাওয়াব লিখা হবে, সে দিন বিকাল পর্যন্ত সেটা তার জন্য শয়তান থেকে বাঁচার উপায় হিসেবে বিবেচিত হবে; আর কেউ তার মত কিছু নিয়ে আসতে পারবে না। হ্যাঁ, সে ব্যক্তি ব্যতীত যে তার চেয়েও বেশি আমল করবে।\n(বুখারী: ৬৪০৩)",
    ),
    detailEn: Detail(
      times: "Hundred times",
      verses: [
        Verse(
          id: 1,
          arabic:
              "لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ",
          pronounce:
              "Laa 'ilaaha 'illallaahu wahdahu laa shareeka lahu, lahul-mulku wa lahul-hamdu, wa Huwa 'alaa kulli shay'in Qadeer.",
          meaning:
              "None has the right to be worshipped except Allah, alone, without any partner, to Him belong all sovereignty and praise, and He is over all things omnipotent.",
        ),
      ],
      explanation:
          'Allah\'s Messenger (ﷺ) said," Whoever says: "La ilaha illal-lah wahdahu la sharika lahu, lahu-l-mulk wa lahul- hamd wa huwa \'ala kulli shai\'in qadir," one hundred times will get the same reward as given for manumitting ten slaves; and one hundred good deeds will be written in his accounts, and one hundred sins will be deducted from his accounts, and it (his saying) will be a shield for him from Satan on that day till night, and nobody will be able to do a better deed except the one who does more than he."\n(Bukhari: 6403)',
    ),
  ),
  AdhkarItem(
    id: 8,
    adhkarIds: [1],
    titleBn: "চারটি কালেমা সারা সকাল ইবাদতের চেয়েও ওজনে ভারী",
    titleEn: "Four phrases Heavier in the Scales than all Morning of Worship",
    detailBn: Detail(
      times: "তিনবার",
      verses: [
        Verse(
          id: 1,
          arabic:
              "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ",
          pronounce:
              "সুব্‌হা-নাল্লা-হি ওয়া বিহামদিহী ‘আদাদা খালক্বিহী, ওয়া রিদানাফসিহী, ওয়া যিনাতা ‘আরশিহী, ওয়া মিদা-দা কালিমা-তিহী।",
          meaning:
              "আমি আল্লাহর প্রশংসাসহ পবিত্রতা ও মহিমা ঘোষণা করছি- তাঁর সৃষ্ট বস্তুসমূহের সংখ্যার সমান, তাঁর নিজের সন্তোষের সমান, তাঁর আরশের ওজনের সমান ও তাঁর বাণীসমূহ লেখার কালি পরিমাণ (অগণিত অসংখ্য)।",
        ),
      ],
      explanation:
          "চারটি কালেমা সারা সকাল ইবাদতের চেয়েও ওজনে ভারী উম্মুল মুমিনিন জুওয়ায়রিয়া (রাঃ) থেকে বর্ণিত। তিনি বলেন, রাসুলুল্লাহ (সা) প্রত্যূষে তাঁর নিকট থেকে বের হলেন। যখন তিনি ফজরের সালাত আদায় করলেন তখন তিনি সালাতের জায়গায় ছিলেন। এরপর তিনি –দুহা’র পরে ফিরে এলেন। তখনও তিনি বসেছিলেন। নবী (সা) বললেন, আমি তোমাকে যে অবস্হায় রেখে গিয়েছিলাম তুমি সেই অবস্হায়ই আছো?\n\nতিনি বললেন, হ্যা। তখন নবী (সা) বললেনঃ আমি তোমার নিকট থেকে যাওয়ার পর চারটি কালেমা তিনবার পাঠ করেছি। আজকে তুমি এ পর্যন্ত যা বলেছ তার সাথে ওযন করলে এই কালেমা চারটির ওযনই বেশী হবে।\n(মুসলিম: ২৭২৬)",
    ),
    detailEn: Detail(
      times: "Three times",
      verses: [
        Verse(
          id: 1,
          arabic:
              "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ",
          pronounce:
              "Subhaanallaahi wa bihamdihi, 'Adada khalqihi, wa ridhaa nafsihi, wa zinata 'arshihi wa midaada kalimaatihi.",
          meaning:
              "How perfect Allah is and I praise Him by the number of His creation and His pleasure, and by the weight of His throne, and the ink of His words.",
        ),
      ],
      source: "(Muslim: 2726)",
    ),
  ),
  AdhkarItem(
    id: 9,
    adhkarIds: [1],
    titleBn: "উপকারী জ্ঞান, পবিত্র রিযিক এবং কবুলযোগ্য আমলের দো'আ",
    titleEn: "Asking for Beneficial Knowledge, Pure Rizq & Accepted Deeds",
    detailBn: Detail(
      times: "তিনবার",
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا",
          pronounce:
              "আল্লা-হুম্মা ইন্নি আসআলুকা ইলমান নাফে‘আন ওয়া রিয্‌কান তাইয়্যেবান ওয়া ‘আমালান মুতাক্বাব্বালান।",
          meaning:
              "হে আল্লাহ! আমি আপনার নিকট উপকারী জ্ঞান, পবিত্র রিযিক এবং কবুলযোগ্য আমল প্রার্থনা করি।",
        ),
      ],
      source: "(ইবনে মাজাহ: ৯২৫)",
    ),
    detailEn: Detail(
      times: "Three times",
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا",
          pronounce:
              "Allaahumma 'innee 'as'aluka 'ilman naafi'an, wa rizqan tayyiban, wa 'amalan mutaqabbalan.",
          meaning:
              "O Allah, I ask You for knowledge that is of benefit, a good provision, and deeds that will be accepted.",
        ),
      ],
      source: "(Ibn Majah: 925)",
    ),
  ),
  AdhkarItem(
    id: 10,
    adhkarIds: [1],
    titleBn: "কিয়ামতের দিন রসুলুল্লাহ (ﷺ) এর সুপারিশ লাভ",
    titleEn: "Gain Prophet saw's intercession on the Day of Judgment",
    detailBn: Detail(
      times: "যত বেশি সম্ভব",
      verses: [
        Verse(
          id: 1,
          arabic: "اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبَيِّنَا مُحَمَّدٍ",
          pronounce:
              "আল্লা-হুম্মা সাল্লি ওয়াসাল্লিম ‘আলা নাবিয়্যিনা মুহাম্মাদ।",
          meaning:
              "হে আল্লাহ! আপনি সালাত ও সালাম পেশ করুন আমাদের নবী মুহাম্মাদের উপর।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) বলেন, যে ব্যক্তি আমার উপর একবার দরূদ পাঠ করবে, তার বিনিময়ে আল্লাহ্ তার উপর দশবার দরুদ পাঠ করবেন।\n(মুসলিম: ৩৮৪)",
    ),
    detailEn: Detail(
      times: "As much as possible",
      verses: [
        Verse(
          id: 1,
          arabic: "اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبَيِّنَا مُحَمَّدٍ",
          pronounce: "Allahumma salli wa sallim ‘aala nabiyyinaa muhammadin",
          meaning: "O Allah, send prayers and peace upon our Prophet Muhammad.",
        ),
      ],
      explanation:
          'The Prophet saw said: "Who recites blessings upon me 10 times in the morning and 10 times in the evening will obtain my intercession on the Day of Resurrection".\n(Muslim: 384)',
    ),
  ),
  AdhkarItem(
    id: 11,
    adhkarIds: [2],
    titleBn: "বিষধর প্রাণীর ক্ষতি থেকে নিরাপত্তা",
    titleEn: "Protection against harmful animals",
    detailBn: Detail(
      times: "তিনবার",
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ",
          pronounce:
              "আ‘ঊযু বিকালিমা-তিল্লা-হিত তা-ম্মাতি মিন শাররি মা খালাক্বা।",
          meaning:
              "আল্লাহর পরিপূর্ণ কালেমাসমূহের ওসিলায় আমি তাঁর নিকট তাঁর সৃষ্টির ক্ষতি থেকে আশ্রয় চাই।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) বলেন, যে কেউ বিকাল বেলা এ দু’আটি তিনবার বলবে, সে রাতে কোন বিষধর প্রাণী তার ক্ষতি করতে পারবে না।\n(ইবনে মাজাহ: ৩৫১৮)",
    ),
    detailEn: Detail(
      times: "Three times",
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ",
          pronounce: "A’udhu bikalimatil-lahit-tammati min sharri ma khalaq",
          meaning:
              "I seek refuge in the Perfect Words of Allah from the evil of that which He has created.",
        ),
      ],
      explanation: "\n(Ibn Majah: 3518)",
    ),
  ),
  AdhkarItem(
    id: 12,
    adhkarIds: [3],
    icon: drawable.nightAmalOneIcon,
    titleBn: "ওযু করা",
    titleEn: "To make odhu",
  ),
  AdhkarItem(
    id: 13,
    adhkarIds: [3],
    icon: drawable.nightAmalTwoIcon,
    titleBn: "সূরা মুলক, সাজদাহ তিলাওয়াত করা",
    titleEn: "To recite Surah Mulk, Surah Sajdah",
  ),
  AdhkarItem(
    id: 14,
    adhkarIds: [3],
    icon: drawable.nightAmalThreeIcon,
    titleBn: "আয়াতুল কুরসি তিলাওয়াত করা",
    titleEn: "To recite Ayat-Ul-Kursi",
  ),
  AdhkarItem(
    id: 15,
    adhkarIds: [3],
    icon: drawable.nightAmalFourIcon,
    titleBn: "যিকর সমূহ পড়া",
    titleEn: "To do the dhikrs",
  ),
  AdhkarItem(
    id: 16,
    adhkarIds: [3],
    icon: drawable.nightAmalFiveIcon,
    titleBn: "সবাইকে ক্ষমা করে দেয়া",
    titleEn: "To forgive everyone",
  ),
  AdhkarItem(
    id: 17,
    adhkarIds: [3],
    icon: drawable.nightAmalSixIcon,
    titleBn: "ডান পাশ ফিরে ঘুমানো",
    titleEn: "To sleep on right side",
  ),
  AdhkarItem(
    id: 18,
    adhkarIds: [3],
    titleBn: "ঘুমাতে যাওয়ার সময় পড়ার দুআ",
    titleEn: "Dua to recite before sleeping",
    detailBn: Detail(
      verses: [
        Verse(
            id: 1,
            arabic: "اَللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا",
            pronounce: "আল্লাহুম্মা বি-ইসমিকা আমূতু ওয়া আহইয়া।",
            meaning:
                "হে আল্লাহ! আপনার নাম নিয়েই আমি শয়ন করছি এবং আপনার নাম নিয়েই উঠব।"),
      ],
      source: "(বুখারী: ৬৩২৪)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
            id: 1,
            arabic: "اَللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا",
            pronounce: "Allaahumma Bismika 'amootu wa 'ahyaa.",
            meaning: "O Allah, In Your name  I live and die."),
      ],
      source: "(Bukhari: 6324)",
    ),
  ),
  AdhkarItem(
    id: 19,
    adhkarIds: [3],
    titleBn: "খাদিম অপেক্ষা উত্তম যিকর",
    titleEn: "Dua that is better than a servant",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          times: "৩৪ বার",
          arabic: "اللّٰهُ أَكْبَرُ",
          pronounce: "আল্লা-হু আকবার।",
          meaning: "আল্লাহ সবচেয়ে বড়।",
        ),
        Verse(
          id: 2,
          times: "৩৩ বার",
          arabic: "سُبْحَانَ اللّٰهِ",
          pronounce: "সুবহা-নাল্লাহ।",
          meaning: "আল্লাহ কতই না পবিত্র-মহান।",
        ),
        Verse(
          id: 3,
          times: "৩৩ বার",
          arabic: "الْحَمْدُ لِلّٰهِ",
          pronounce: "আলহামদুলিল্লাহ।",
          meaning: "সকল প্রশংসা আল্লাহ্‌র জন্য।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) আলী (রা:) এবং ফাতেমাকে (রা:) বলেন: “আমি কি তোমাদেরকে এমন কিছু বলে দিবো না যা তোমাদের জন্য খাদিম অপেক্ষাও উত্তম হবে? তোমরা যখন ঘুমানোর উদ্দেশে বিছানায় যাবে তখন চৌত্রিশ বার “আল্লাহ্‌ আকবার” তেত্রিশবার “সুবহানাল্লাহ” তেত্রিশবার “আলহামদুলিল্লাহ” পড়ে নিবে। এটা খাদিম অপেক্ষা অনেক উত্তম।\n(বুখারী: ৩৭০৫)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          times: "34 times",
          arabic: "اللّٰهُ أَكْبَرُ",
          pronounce: "Allaahu 'akbar",
          meaning: "Allah is the greatest.",
        ),
        Verse(
          id: 2,
          times: "33 times",
          arabic: "سُبْحَانَ اللّٰهِ",
          pronounce: "Subhanallah",
          meaning: "How Perfect Allah is.",
        ),
        Verse(
          id: 3,
          times: "33 times",
          arabic: "الْحَمْدُ لِلّٰهِ",
          pronounce: "Aalhamdu lillaah",
          meaning: "All praise is for Allaah.",
        ),
      ],
      explanation:
          "Prophet (ﷺ) said to Ali(R.A) & Fatima(R.A): Shall I teach you a thing which is better than what you have asked me? When you go to bed, say, 'Allahu-Akbar' thirty-four times, and 'Subhanallah' thirty-three times, and 'Aalhamdu lillaah' thirty-three times for that is better for you both than a servant.\n(Bukhari: 3705)",
    ),
  ),
  AdhkarItem(
    id: 20,
    adhkarIds: [3],
    titleBn: "ঘুমন্ত অবস্থায় ভয় এবং একাকিত্বের অস্বস্তিতে পড়ার দো‘আ",
    titleEn: "Upon experiencing fear or unrest during sleep",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ غَضَبِهِ وَعِقَابِهِ وَشَرِّ عِبَادِهِ، وَمِنْ هَمَزَاتِ الشَّياطِينِ وَأَنْ يَحْضُرُونِ",
          pronounce:
              "আ‘ঊযু বিকালিমা-তিল্লাহিত্তা-ম্মাতি মিন্ গাদ্বাবিহি ওয়া ইক্বা-বিহি ওয়া শাররি ‘ইবা-দিহি ওয়ামিন হামাযা-তিশ্‌শায়া-ত্বীনি ওয়া আন ইয়াহ্‌দুরূন।",
          meaning:
              "আমি আশ্রয় চাই আল্লাহ্‌র পরিপূর্ণ কালামসমূহের অসীলায় তাঁর ক্রোধ থেকে, তাঁর শাস্তি থেকে, তাঁর বান্দাদের অনিষ্ট থেকে, শয়তানদের কুমন্ত্রণা থেকে এবং তাদের উপস্থিতি থেকে।",
        ),
      ],
      source: "(আবু দাউদ: ৩৮৯৩)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ غَضَبِهِ وَعِقَابِهِ وَشَرِّ عِبَادِهِ، وَمِنْ هَمَزَاتِ الشَّياطِينِ وَأَنْ يَحْضُرُونِ",
          pronounce:
              "A'oothu bikalimaatil-laahit-taammaati min ghadhabihi wa 'iqaabihi, wa sharri 'ibaadihi, wa min hamazaatish-shayaateeni wa 'an yahdhuroon.",
          meaning:
              "I seek refuge in the Perfect Words of Allah from His anger and His punishment, from the evil of His slaves and from the taunts of devils and from their presence.",
        ),
      ],
      source: "(Abu Dawud: 3893)",
    ),
  ),
  AdhkarItem(
    id: 21,
    adhkarIds: [3],
    titleBn: "শেষ তিন সূরা",
    titleEn: "Last three surah",
    detailBn: Detail(
      title:
          "দুই হাতের তালু একত্রে মিলিয়ে নিম্নোক্ত সূরাগুলো পড়ে তাতে ফুঁ দিবে:",
      verses: [
        Verse(
          id: 1,
          title: "সূরা ইখলাস",
          arabic:
              "قُلْ هُوَ اللّٰهُ أَحَدٌ  ❊  اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ  ❊  وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ",
          meaning:
              "বলুন, তিনি আল্লাহ, এক-অদ্বিতীয়। আল্লাহ হচ্ছেন ‘সামাদ’ (তিনি কারো মুখাপেক্ষী নন, সকলেই তাঁর মুখাপেক্ষী)। তিনি কাউকেও জন্ম দেন নি এবং তাঁকেও জন্ম দেয়া হয় নি। আর তাঁর সমতুল্য কেউই নেই।",
        ),
        Verse(
          id: 2,
          title: "সূরা ফালাক্ব",
          arabic:
              "قُلْ أَعُوذُ بِرَ‌بِّ الْفَلَقِ  ❊  مِن شَرِّ‌ مَا خَلَقَ وَمِن شَرِّ‌ غَاسِقٍ إِذَا وَقَبَ  ❊  وَمِن شَرِّ‌ النَّفَّاثَاتِ فِي الْعُقَدِ  ❊  وَمِن شَرِّ‌ حَاسِدٍ إِذَا حَسَدَ",
          meaning:
              "বলুন, আমি আশ্রয় প্রার্থনা করছি ঊষার রবের। তিনি যা সৃষ্টি করেছেন তার অনিষ্ট হতে। ‘আর অনিষ্ট হতে রাতের অন্ধকারের, যখন তা গভীর হয়। আর অনিষ্ট হতে সমস্ত নারীদের, যারা গিরায় ফুঁক দেয়। আর অনিষ্ট হতে হিংসুকের, যখন সে হিংসা করে।",
        ),
        Verse(
          id: 3,
          title: "সূরা নাস",
          arabic:
              "قُلْ أَعُوذُ بِرَ‌بِّ النَّاسِ ❊  مَلِكِ النَّاسِ  ❊  إِلَـٰهِ النَّاسِ مِن شَرِّ‌ الْوَسْوَاسِ الْخَنَّاسِ  ❊  الَّذِي يُوَسْوِسُ فِي صُدُورِ‌ النَّاسِ  ❊  مِنَ الْجِنَّةِ وَالنَّاسِ",
          meaning:
              "বলুন, আমি আশ্রয় প্রার্থনা করছি মানুষের রবের, মানুষের অধিপতির, মানুষের ইলাহের কাছে, আত্মগোপনকারী কুমন্ত্রণাদাতার অনিষ্ট হতে; যে কুমন্ত্রণা দেয় মানুষের অন্তরে, জিনের মধ্য থেকে এবং মানুষের মধ্য থেকে।",
        ),
      ],
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          title: "Surah Al-Ikhlas",
          arabic:
              "قُلْ هُوَ اللّٰهُ أَحَدٌ  ❊  اللَّهُ الصَّمَدُ لَمْ يَلِدْ وَلَمْ يُولَدْ  ❊  وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ",
          meaning:
              "With the Name of Allah, the Most Gracious, the Most Merciful. Say: He is Allah (the) One. The Self-Sufficient Master, whom all creatures need, He begets not nor was He begotten, and there is none equal to Him.",
        ),
        Verse(
          id: 2,
          title: "Surah Al-Falaq",
          arabic:
              "قُلْ أَعُوذُ بِرَ‌بِّ الْفَلَقِ  ❊  مِن شَرِّ‌ مَا خَلَقَ وَمِن شَرِّ‌ غَاسِقٍ إِذَا وَقَبَ  ❊  وَمِن شَرِّ‌ النَّفَّاثَاتِ فِي الْعُقَدِ  ❊  وَمِن شَرِّ‌ حَاسِدٍ إِذَا حَسَدَ",
          meaning:
              "With the Name of Allah, the Most Gracious, the Most Merciful. Say: I seek refuge with (Allah) the Lord of the daybreak, from the evil of what He has created, and from the evil of the darkening (night) as it comes with its darkness, and from the evil of those who practice witchcraft when they blow in the knots, and from the evil of the envier when he envies.",
        ),
        Verse(
          id: 3,
          title: "Surah An-Nas",
          arabic:
              "قُلْ أَعُوذُ بِرَ‌بِّ النَّاسِ ❊  مَلِكِ النَّاسِ  ❊  إِلَـٰهِ النَّاسِ مِن شَرِّ‌ الْوَسْوَاسِ الْخَنَّاسِ  ❊  الَّذِي يُوَسْوِسُ فِي صُدُورِ‌ النَّاسِ  ❊  مِنَ الْجِنَّةِ وَالنَّاسِ",
          meaning:
              "With the Name of Allah, the Most Gracious, the Most Merciful. Say: I seek refuge with (Allah) the Lord of mankind, the King of mankind, the God of mankind, from the evil of the whisperer who withdraws, who whispers in the breasts of mankind, of jinns and men.",
        ),
      ],
    ),
  ),
  AdhkarItem(
    id: 22,
    adhkarIds: [3],
    titleBn: "আয়াতুল কুরসি",
    titleEn: "Ayat-Ul-Kursi",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic: "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ",
          meaning: "বিতাড়িত শয়তান থেকে আমি আল্লাহ্‌র আশ্রয় নিচ্ছি।",
        ),
        Verse(
          id: 2,
          arabic: "اللَّهُ لَآ إِلٰهَ إِلَّا هُوَ الْحَىُّ الْقَيُّومُ",
          meaning:
              "আল্লাহ্, তিনি ছাড়া কোনো সত্য ইলাহ্ নেই। তিনি চিরঞ্জীব, সর্বসত্তার ধারক।",
        ),
        Verse(
          id: 3,
          arabic: "لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ",
          meaning: "তাঁকে তন্দ্রাও স্পর্শ করতে পারে না, নিদ্রাও নয়।",
        ),
        Verse(
          id: 4,
          arabic: "لَّهُ مَا فِى السَّمٰوٰتِ وَمَا فِى الْأَرْضِ",
          meaning: "আসমানসমূহে যা রয়েছে ও যমীনে যা রয়েছে সবই তাঁর।",
        ),
        Verse(
          id: 5,
          arabic: "مَنْ ذَا الَّذِى يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ",
          meaning: "কে সে, যে তাঁর অনুমতি ব্যতীত তাঁর কাছে সুপারিশ করবে?",
        ),
        Verse(
          id: 6,
          arabic: "يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ",
          meaning: "তাদের সামনে ও পিছনে যা কিছু আছে তা তিনি জানেন।",
        ),
        Verse(
          id: 7,
          arabic: "وَلَا يُحِيطُونَ بِشَىْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَآءَ",
          meaning:
              "আর যা তিনি ইচ্ছে করেন তা ছাড়া তাঁর জ্ঞানের কোনো কিছুকেই তারা পরিবেষ্টন করতে পারে না।",
        ),
        Verse(
          id: 8,
          arabic: "وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْأَرْضَ",
          meaning: "তাঁর ‘কুরসী’ আসমানসমূহ ও যমীনকে পরিব্যাপ্ত করে আছে।",
        ),
        Verse(
          id: 9,
          arabic: "وَلاَ يَؤُودُهُ حِفْظُهُمَا",
          meaning: "আর এ দুটোর রক্ষণাবেক্ষণ তাঁর জন্য বোঝা হয় না।",
        ),
        Verse(
          id: 10,
          arabic: "وَهُوَ الْعَلِىُّ الْعَظِيمُ",
          meaning: "আর তিনি সুউচ্চ সুমহান।",
        ),
      ],
      source: "(সূরা বাক্বারাহ ২:২৫৫)",
      explanation:
          "রাসূল (ﷺ) বলেন, “যে কেউ যখন রাতে আপন বিছানায় যাবে এবং ‘আয়াতুল কুরসী’ পড়বে, তখন সে রাতের পুরো সময় আল্লাহর পক্ষ থেকে তার জন্য হেফাযতকারী থাকবে; আর সকাল হওয়া পর্যন্ত শয়তান তার নিকটেও আসতে পারবে না।”\n(বুখারী: ২৩১১)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic: "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ",
          meaning: "I take refuge with Allah from the accursed devil.",
        ),
        Verse(
          id: 2,
          arabic: "اللَّهُ لَآ إِلٰهَ إِلَّا هُوَ الْحَىُّ الْقَيُّومُ",
          meaning:
              "Allah! There is none worthy of worship but He, the Ever Living, the One Who sustains and protects all that exists.",
        ),
        Verse(
          id: 3,
          arabic: "لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ",
          meaning: "Neither slumber nor sleep overtakes Him.",
        ),
        Verse(
          id: 4,
          arabic: "لَّهُ مَا فِى السَّمٰوٰتِ وَمَا فِى الْأَرْضِ",
          meaning:
              "To Him belongs whatever is in the heavens and whatever is on the earth.",
        ),
        Verse(
          id: 5,
          arabic: "مَنْ ذَا الَّذِى يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ",
          meaning:
              "Who is he that can intercede with Him except with His Permission?",
        ),
        Verse(
          id: 6,
          arabic: "يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ",
          meaning:
              "He knows what happens to them in this world, and what will happen to them in the Hereafter.",
        ),
        Verse(
          id: 7,
          arabic: "وَلَا يُحِيطُونَ بِشَىْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَآءَ",
          meaning:
              "And they will never compass anything of His Knowledge except that which He wills.",
        ),
        Verse(
          id: 8,
          arabic: "وَسِعَ كُرْسِيُّهُ السَّمٰوٰتِ وَالْأَرْضَ",
          meaning: "His ‘Kursi’ extends over the heavens and the earth,",
        ),
        Verse(
          id: 9,
          arabic: "وَلاَ يَؤُودُهُ حِفْظُهُمَا",
          meaning: "and He feels no fatigue in guarding and preserving them.",
        ),
        Verse(
          id: 10,
          arabic: "وَهُوَ الْعَلِىُّ الْعَظِيمُ",
          meaning: "And He is the Most High, the Most Great.",
        ),
      ],
      source: "(Surah Al-Baqarah 2:255)",
      explanation: "\nBukhari: 2311",
    ),
  ),
  AdhkarItem(
    id: 23,
    adhkarIds: [3],
    titleBn: "সূরা বাক্বারাহ-র শেষ ২ আয়াত",
    titleEn: "Last 2 ayah of Surah Al-Baqarah",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "ءَامَنَ الرَّسُولُ بِمَآ أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ كُلٌّ ءَامَنَ بِاللَّهِ وَمَلٰٓئِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ وَقَالُوا سَمِعْنَا وَأَطَعْنَا غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ",
          meaning:
              "রাসূল তার প্রভুর পক্ষ থেকে যা তার কাছে নাযিল করা হয়েছে তার উপর ঈমান এনেছেন এবং মুমিনগণও। প্রত্যেকেই ঈমান এনেছে আল্লাহর উপর, তাঁর ফেরেশ্তাগণ, তাঁর কিতাবসমূহ এবং তাঁর রাসূলগণের উপর। আমরা তাঁর রাসূলগণের কারও মধ্যে তারতম্য করি না। আর তারা বলে, আমরা শুনেছি ও মেনে নিয়েছি। হে আমাদের রব! আপনার ক্ষমা প্রার্থনা করি এবং আপনার দিকেই প্রত্যাবর্তনস্থল।",
        ),
        Verse(
          id: 2,
          arabic:
              "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لَا تُؤَاخِذْنَآ إِن نَّسِينَآ أَوْ أَخْطَأْنَا  رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَآ إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا  رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَآ أَنتَ مَوْلٰىنَا فَانصُرْنَا عَلَى الْقَوْمِ الْكٰفِرِينَ",
          meaning:
              "আল্লাহ্ কারো উপর এমন কোন দায়িত্ব চাপিয়ে দেন না যা তার সাধ্যাতীত। সে ভাল যা উপার্জন করে তার প্রতিফল তারই, আর মন্দ যা কামাই করে তার প্রতিফল তার উপরই বর্তায়। ‘হে আমাদের রব! যদি আমরা বিস্মৃত হই অথবা ভুল করি তবে আপনি আমাদেরকে পাকড়াও করবেন না। হে আমাদের রব! আমাদের পূর্ববর্তীগণের উপর যেমন বোঝা চাপিয়ে দিয়েছিলেন আমাদের উপর তেমন বোঝা চাপিয়ে দিবেন না। হে আমাদের রব! আপনি আমাদেরকে এমন কিছু বহন করাবেন না যার সামর্থ আমাদের নেই। আর আপনি আমাদের পাপ মোচন করুন, আমাদেরকে ক্ষমা করুন, আমাদের প্রতি দয়া করুন, আপনিই আমাদের অভিভাবক। অতএব কাফির সম্প্রদায়ের বিরুদ্ধে আমাদেরকে সাহায্য করুন।",
        ),
      ],
      source: "(সূরা বাক্বারাহ ২:২৮৫-২৮৬)",
      explanation:
          "রাসূল (ﷺ) বলেন, যে ব্যক্তি রাতের বেলা সূরা বাক্বারার শেষ দুটি আয়াত পড়বে, তা তার জন্য যথেষ্ট হবে।\n(বুখারী: ৪০০৮)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "ءَامَنَ الرَّسُولُ بِمَآ أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ كُلٌّ ءَامَنَ بِاللَّهِ وَمَلٰٓئِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ وَقَالُوا سَمِعْنَا وَأَطَعْنَا غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ",
          meaning:
              "The Messenger has believed in what was revealed to him from his Lord, and [so have] the believers. All of them have believed in Allah and His angels and His books and His messengers, [saying] , \"We make no distinction between any of His messengers.\" And they say, \"We hear and we obey. [We seek] Your forgiveness, our Lord, and to You is the [final] destination.\"",
        ),
        Verse(
          id: 2,
          arabic:
              "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لَا تُؤَاخِذْنَآ إِن نَّسِينَآ أَوْ أَخْطَأْنَا  رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَآ إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا  رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَآ أَنتَ مَوْلٰىنَا فَانصُرْنَا عَلَى الْقَوْمِ الْكٰفِرِينَ",
          meaning:
              "Allah does not charge a soul except [with that within] its capacity. It will have [the consequence of] what [good] it has gained, and it will bear [the consequence of] what [evil] it has earned. \"Our Lord, do not impose blame upon us if we have forgotten or erred. Our Lord, and lay not upon us a burden like that which You laid upon those before us. Our Lord, and burden us not with that which we have no ability to bear. And pardon us; and forgive us; and have mercy upon us. You are our protector, so give us victory over the disbelieving people.\"",
        ),
      ],
      source: "(Surah Al-Baqarah 2:285-286)",
      explanation:
          "Prophet (ﷺ) said, Whoever recites the last two Aayahs of Surah al-Baqarah at night, those two Aayahs shall be sufficient for him.\n(Bukhari: 4008)",
    ),
  ),
  AdhkarItem(
    id: 24,
    adhkarIds: [3],
    titleBn: "ফিত্‌রাহের উপর মৃত্যুবরণ করা",
    titleEn: "Dying upon the fitrah",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، رَغْبَةً وَرَهْبَةً إِلَيْكَ، لاَ مَلْجَأَ وَلاَ مَنْجَا مِنْكَ إِلاَّ إِلَيْكَ، آمَنْتُ بِكِتَابِكَ الَّذِي أَنْزَلْتَ، وَبِنَبِيِّكَ الَّذِي أَرْسَلْتَ",
          pronounce:
              "আল্লা-হুম্মা আস্‌লামতু নাফ্‌সী ইলাইকা, ওয়া ফাউওয়াদ্বতু আমরী ইলাইকা, ওয়া ওয়াজ্জাহ্‌তু ওয়াজহিয়া ইলাইকা, ওয়াআলজা’তু যাহ্‌রী ইলাইকা, রাগবাতান ওয়া রাহবাতান ইলাইকা। লা মালজা’আ ওয়ালা মান্‌জা মিনকা ইল্লা ইলাইকা। আ-মানতু বিকিতা-বিকাল্লাযী আনযালতা ওয়াবিনাবিয়্যিকাল্লাযী আরসালতা।",
          meaning:
              "হে আল্লাহ! আমি নিজেকে আপনার কাছে সঁপে দিলাম। আমার যাবতীয় বিষয় আপনার কাছেই সোপর্দ করলাম, আমার চেহারা আপনার দিকেই ফিরালাম, আর আমার পৃষ্ঠদেশকে আপনার দিকেই ন্যস্ত করলাম; আপনার প্রতি অনুরাগী হয়ে এবং আপনার ভয়ে ভীত হয়ে। একমাত্র আপনার নিকট ছাড়া আপনার (পাকড়াও) থেকে বাঁচার কোনো আশ্রয়স্থল নেই এবং কোনো মুক্তির উপায় নেই। আমি ঈমান এনেছি আপনার নাযিলকৃত কিতাবের উপর এবং আপনার প্রেরিত নবীর উপর।",
        ),
      ],
      explanation:
          "রাসূল (ﷺ) যাকে এ দো‘আটি শিক্ষা দিলেন, তাকে বলেন: “যদি তুমি ঐ রাতে মারা যাও তবে ‘ফিতরাত’ তথা দীন ইসলামের উপর মারা গেলে।\n(বুখারী: ৬৩১৩)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، رَغْبَةً وَرَهْبَةً إِلَيْكَ، لاَ مَلْجَأَ وَلاَ مَنْجَا مِنْكَ إِلاَّ إِلَيْكَ، آمَنْتُ بِكِتَابِكَ الَّذِي أَنْزَلْتَ، وَبِنَبِيِّكَ الَّذِي أَرْسَلْتَ",
          pronounce:
              "Allaahumma 'aslamtu nafsee 'ilayka, wa fawwadhtu 'amree 'ilayka, wa wajjahtu wajhee 'ilayka, wa 'alja'tu dhahree 'ilayka, raghbatan wa rahbatan 'ilayka, laa maalja' wa laa manja minka 'illaa 'ilayka, 'aamantu bikitaabikal-lathee 'anzalta wa bi-nabiyyikal-lathee 'arsalta.",
          meaning:
              "O Allah, I submit my soul unto You, and I entrust my affair unto You, and I turn my face towards You, and I totally rely on You, in hope and fear of You. Verily there is no refuge nor safe haven from You except with You. I believe in Your Book which You have revealed and in Your Prophet whom You have sent.",
        ),
      ],
      explanation:
          "Prophet (ﷺ) taught a person this ua and said, \"if you should die after reciting this before going to bed you will die on the religion of Islam\".\n(Bukhari: 6313)",
    ),
  ),
  AdhkarItem(
    id: 25,
    adhkarIds: [4],
    icon: drawable.fridayAmalOneIcon,
    titleBn: "মেসওয়াক করা",
    titleEn: "To do miswak",
  ),
  AdhkarItem(
    id: 26,
    adhkarIds: [4],
    icon: drawable.fridayAmalTwoIcon,
    titleBn: "গোসল করা",
    titleEn: "To have a bath",
  ),
  AdhkarItem(
    id: 27,
    adhkarIds: [4],
    icon: drawable.fridayAmalThreeIcon,
    titleBn: "পরিচ্ছন্ন কাপড় পড়া",
    titleEn: "To Wear the best clothes",
  ),
  AdhkarItem(
    id: 28,
    adhkarIds: [4],
    icon: drawable.fridayAmalFourIcon,
    titleBn: "সুগন্ধি মাখা",
    titleEn: "To use perfume",
  ),
  AdhkarItem(
    id: 29,
    adhkarIds: [4],
    icon: drawable.fridayAmalFiveIcon,
    titleBn: "চুল আঁচড়ানো",
    titleEn: "To comb",
  ),
  AdhkarItem(
    id: 30,
    adhkarIds: [4],
    icon: drawable.fridayAmalSixIcon,
    titleBn: "ওয়াক্তের শুরুতে মসজিদে যাওয়া",
    titleEn: "To go to masjid early",
  ),
  AdhkarItem(
    id: 31,
    adhkarIds: [4],
    icon: drawable.fridayAmalSevenIcon,
    titleBn: "পায়ে হেঁটে মসজিদে যাওয়া",
    titleEn: "To go to masjid by walking",
  ),
  AdhkarItem(
    id: 32,
    adhkarIds: [4],
    icon: drawable.fridayAmalEightIcon,
    titleBn: "২ রাকাত তাহিয়াতুল মসজিদে পড়া",
    titleEn: "To pray 2 rakah Tahiyatul Masjid",
  ),
  AdhkarItem(
    id: 33,
    adhkarIds: [4],
    icon: drawable.fridayAmalNineIcon,
    titleBn: "মন দিয়ে খুৎবা শোনা",
    titleEn: "To listen khutbah attentively",
  ),
  AdhkarItem(
    id: 34,
    adhkarIds: [4],
    icon: drawable.fridayAmalTenIcon,
    titleBn: "দুআ কবুলের মুহূর্ত খোঁজা",
    titleEn: "To seek the ‘hidden’ time when prayer will be answered",
  ),
  AdhkarItem(
    id: 35,
    adhkarIds: [4],
    icon: drawable.fridayAmalElevenIcon,
    titleBn: "বেশি বেশি দরূদ পড়া",
    titleEn: "To recite salutation to Prophet ﷺ in abundance",
  ),
  AdhkarItem(
    id: 36,
    adhkarIds: [4],
    icon: drawable.fridayAmalTwelveIcon,
    titleBn: "সূরা কাহফ তিলাওয়াত করা",
    titleEn: "To recite Surah Al-Kahf",
  ),
  AdhkarItem(
    id: 37,
    adhkarIds: [1],
    titleBn: "দুআ #১",
    titleEn: "Dua #1",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا وَبِكَ نَمُوْتُ، وإليك النسورُُ",
          pronounce:
              "আল্লা-হুম্মা বিকা আসবাহ্‌না ওয়াবিকা আমসাইনা ওয়াবিকা নাহ্‌ইয়া, ওয়াবিকা নামূতু ওয়া ইলাইকান নুশূর।",
          meaning:
              "হে আল্লাহ! আমরা আপনার জন্য সকালে উপনীত হয়েছি এবং আপনারই জন্য আমরা বিকালে উপনীত হয়েছি। আর আপনার দ্বারা আমরা জীবিত থাকি, আপনার দ্বারাই আমরা মারা যাব; আর আপনার দিকেই উত্থিত হব।",
        ),
      ],
      source: "(তিরমিযী: ৩৩৯১)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا وَبِكَ نَمُوْتُ، وإليك النسورُُ",
          pronounce:
              "Allaahumma bika 'asbahnaa, wa bika 'amsaynaa, wa bika nahyaa, wa bika namootu wa 'ilaykan-nushoor.",
          meaning:
              "O Allah, by You we enter the morning and by You we enter the evening, by You we live and by You we die, and to You is our resurrection.",
        ),
      ],
      source: "(Tirmizi: 3391)",
    ),
  ),
  AdhkarItem(
    id: 38,
    adhkarIds: [1, 2],
    titleBn: "দুআ #২",
    detailBn: Detail(
      times: "তিনবার",
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي اللَّهُمَّ عَافِنِي فِي بَصَرِي، لاَ إِلَهَ إِلاَّ أَنْتَ اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ القَبْرِ، لاَ إِلَهَ إِلاَّ أَنْتَ",
          pronounce:
              "আল্লা-হুম্মা ‘আ-ফিনী ফী বাদানী, আল্লা-হুম্মা ‘আ-ফিনী ফী সাম্‘ঈ আল্লা-হুম্মা ‘আ-ফিনী ফী বাসারী। লা ইলা-হা ইল্লা আনতা। আল্লা-হুম্মা ইন্নী আ‘উযু বিকা মিনাল কুফরি ওয়াল-ফাক্বরি ওয়া আ‘উযু বিকা মিন ‘আযা- বিল ক্বাবরি, লা ইলাহা ইল্লা আন্‌তা।",
          meaning:
              "হে আল্লাহ! আমাকে নিরাপত্তা দিন আমার শরীরে। হে আল্লাহ! আমাকে নিরাপত্তা দিন আমার শ্রবণশক্তিতে। হে আল্লাহ! আমাকে নিরাপত্তা দিন আমার দৃষ্টিশক্তিতে। আপনি ছাড়া কোনো হক্ব ইলাহ নেই। হে আল্লাহ! আমি আপনার কাছে আশ্রয় চাই কুফরি ও দারিদ্র্য থেকে। আর আমি আপনার আশ্রয় চাই কবরের আযাব থেকে। আপনি ছাড়া আর কোনো হক্ব ইলাহ নেই।",
        ),
      ],
      source: "(আবু দাউদ: ৫০৯০)",
    ),
    detailEn: Detail(
      times: "Three times",
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي اللَّهُمَّ عَافِنِي فِي بَصَرِي، لاَ إِلَهَ إِلاَّ أَنْتَ اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ القَبْرِ، لاَ إِلَهَ إِلاَّ أَنْتَ",
          pronounce:
              "Allaahumma 'aafinee fee badanee, Allaahumma 'aafinee fee sam'ee, Allaahumma 'aafinee fee basaree, laa 'ilaaha 'illaa 'Anta. Allaahumma 'innee 'a'oothu bika minal-kufri, walfaqri, wa 'a'oothu bika min 'athaabil-qabri, laa 'ilaaha 'illaa 'Anta.",
          meaning:
              "O Allah, grant my body health, O Allah, grant my hearing health, O Allah, grant my sight health. None has the right to be worshipped except You. O Allah, I take refuge with You from disbelief and poverty, and I take refuge with You from the punishment of the grave. None has the right to be worshipped except You.'",
        ),
      ],
      source: "(Abu Dawud: 5090)",
    ),
  ),
  AdhkarItem(
    id: 39,
    adhkarIds: [1, 2],
    titleBn: "দুআ #৩",
    titleEn: "Dua #3",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ أَصْلِحْ لِي شَأْنِيَ كُلَّهُ وَلاَ تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ",
          pronounce:
              "ইয়া হাইয়্যু ইয়া ক্বাইয়্যূমু বিরহ্‌মাতিকা আস্তাগীসু, আসলিহ্‌ লী শা’নী কুল্লাহু, ওয়ালা তাকিলনী ইলা নাফসী ত্বারফাতা ‘আইন।",
          meaning:
              "হে চিরঞ্জীব, হে চিরস্থায়ী! আমি আপনার রহমতের অসীলায় আপনার কাছে উদ্ধার কামনা করি, আপনি আমার সার্বিক অবস্থা সংশোধন করে দিন, আর আমাকে আমার নিজের কাছে নিমেষের জন্যও সোপর্দ করবেন না।",
        ),
      ],
      source: "(আত তারগীব ওয়াত-তারহীব: ১/২৭৩)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ أَصْلِحْ لِي شَأْنِيَ كُلَّهُ وَلاَ تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ",
          pronounce:
              "Yaa Hayyu yaa Qayyoomu birahmatika 'astagheethu 'aslih lee sha'nee kullahu wa laa takilnee 'ilaa nafsee tarfata 'aynin.",
          meaning:
              "O Ever Living, O Self-Subsisting and Supporter of all, by Your mercy I seek assistance, rectify for me all of my affairs and do not leave me to myself, even for the blink of an eye.",
        ),
      ],
      source: "(At-Targhib wat-Tarhib: 1/273)",
    ),
  ),
  AdhkarItem(
    id: 40,
    adhkarIds: [1],
    titleBn: "দুআ #৪",
    titleEn: "Dua #4",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ عَالِمَ الغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَوَاتِ وَالْأَرْضِ رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ أَنْتَ أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطانِ وَ شِرْكِهِ ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءًا، أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ",
          pronounce:
              "আল্লা-হুম্মা আ-লিমাল গাইবি ওয়াশ্‌শাহা- দাতি ফা-ত্বিরাস সামা-ওয়া-তি ওয়াল আরদ্বি, রব্বা কুল্লি শাই’ইন ওয়া মালীকাহু, আশহাদু আল-লা ইলা-হা ইল্লা আনতা। আ‘উযু বিকা মিন শাররি নাফ্‌সী ওয়া মিন শাররিশ শাইত্বা-নি ওয়াশারাকিহী ওয়া আন আক্বতারিফা ‘আলা নাফ্‌সী সূওআন আউ আজুররাহূ ইলা মুসলিম।",
          meaning:
              "হে আল্লাহ! হে গায়েব ও উপস্থিতের জ্ঞানী, হে আসমানসমূহ ও যমীনের স্রষ্টা, হে সব কিছুর রব্ব ও মালিক! আমি সাক্ষ্য দিচ্ছি যে, আপনি ছাড়া আর কোনো হক্ব ইলাহ নেই। আমি আপনার কাছে আশ্রয় চাই আমার আত্মার অনিষ্ট থেকে, শয়তানের অনিষ্টতা থেকে ও তার শির্ক বা তার ফাঁদ থেকে, আমার নিজের উপর কোনো অনিষ্ট করা, অথবা কোনো মুসলিমের দিকে তা টেনে নেওয়া থেকে।",
        ),
      ],
      source: "(আবু দাউদ: ৫০৬৭)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ عَالِمَ الغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَوَاتِ وَالْأَرْضِ رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ أَنْتَ أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطانِ وَ شِرْكِهِ ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءًا، أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ",
          pronounce:
              "Allaahumma 'Aalimal-ghaybi wash-shahaadati faatiras-samaawaati wal'ardhi, Rabba kulli shay'in wa maleekahu, 'ash-hadu 'an laa 'ilaaha 'illaa 'Anta, 'a'oothu bika min sharri nafsee, wa min sharrish-shaytaani wa shirkihi, wa 'an 'aqtarifa 'alaa nafsee soo'an, 'aw 'ajurrahu 'ilaa Muslimin.",
          meaning:
              "O Allah, Knower of the unseen and the seen, Creator of the heavens and the Earth, Lord and Sovereign of all things, I bear witness that none has the right to be worshipped except You. I take refuge in You from the evil of my soul and from the evil and shirk of the devil, and from committing wrong against my soul or bringing such upon another Muslim.",
        ),
      ],
      source: "(Abu Dawud: 5067)",
    ),
  ),
  AdhkarItem(
    id: 41,
    adhkarIds: [1],
    titleBn: "দুআ #৫",
    titleEn: "Dua #5",
    detailBn: Detail(
      times: "একশত বার",
      verses: [
        Verse(
          id: 1,
          arabic: "أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ",
          pronounce: "আস্তাগফিরুল্লাহ ওয়া আতূবু ইলাইহি।",
          meaning:
              "আমি আল্লাহর কাছে ক্ষমা প্রার্থনা করছি এবং তাঁর নিকটই তাওবা করছি।",
        ),
      ],
      explanation:
          "নিশ্চয়ই আমি দৈনিক শতবার আল্লাহর নিকট ক্ষমা প্রার্থনা করি এবং তওবা করি।\n(ইবনে মাজাহ: ৩৮১৫)",
    ),
    detailEn: Detail(
      times: "Hundred times",
      verses: [
        Verse(
          id: 1,
          arabic: "أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ",
          pronounce: "‘Astaghfirullaaha wa ‘atoobu ‘ilayhi",
          meaning:
              "I seek Allah's forgiveness and I turn to Him in repentance.",
        ),
      ],
      explanation:
          "The Messenger of Allah (saas) said: 'I seek the forgiveness of Allah and repent to Him one hundred times each day.'\n(Ibn Majah: 3815)",
    ),
  ),
  AdhkarItem(
    id: 42,
    adhkarIds: [1],
    titleBn: "দুআ #৬",
    titleEn: "Dua #6",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَصْبَحْنَا  عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ ، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِينَ",
          pronounce:
              "আসবাহনা ‘আলা ফিত্বরাতিল ইসলামি ওয়া আলা কালিমাতিল ইখলাসি ওয়া আলা দ্বীনি নাবিয়্যিনা মুহাম্মাদিন সাল্লাল্লা-হু আলাইহি ওয়াসাল্লাম ওয়া আলা মিল্লাতি আবীনা ইবরা- হীমা হানীফাম মুসলিমাও ওয়ামা কা-না মিনাল মুশরিকীন।",
          meaning:
              "আমরা সকালে উপনীত হয়েছি ইসলামের ফিত্বরাতের উপর, নিষ্ঠাপূর্ণ বাণী (তাওহীদ) এর উপর, আমাদের নবী মুহাম্মাদ সাল্লাল্লাহু আলাইহি ওয়াসাল্লাম- এর দ্বীনের উপর, আর আমাদের পিতা ইব্রাহীম আলাইহিস সালাম-এর মিল্লাতের উপর—যিনি ছিলেন একনিষ্ঠ মুসলিম এবং যিনি মুশরিকদের অন্তর্ভুক্ত ছিলেন না।",
        ),
      ],
      source: "(সহীহুল জাম’য়: ৪/২০৯)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَصْبَحْنَا  عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ ، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِينَ",
          pronounce:
              "Asbahnaa 'alaa fitratil-'Islaami wa 'alaa kalimatil-'ikhlaasi, wa 'alaa deeni Nabiyyinaa Muhammadin, wa 'alaa millati 'abeenaa 'Ibraaheema, haneefan Musliman wa maa kaana minal-mushrikeen.",
          meaning:
              "We rise in the morning upon the fitrah of Islam, and the word of pure faith, and upon the religion of our Prophet Muhammad and the religion of our forefather Ibraaheem, who was a Muslim and of true faith and was not of those who associate others with Allah.",
        ),
      ],
      source: "(Saheeh Al-Jaami: 4/209)",
    ),
  ),
  AdhkarItem(
    id: 43,
    adhkarIds: [2],
    titleBn: "দুআ #৭",
    titleEn: "Dua #7",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَمْسَيْنَا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ ، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِينَأَمْسَيْنَا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ ، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِينَ",
          pronounce:
              "আমসাইনা ‘আলা ফিত্বরাতিল ইসলামি ওয়া আলা কালিমাতিল ইখলাসি ওয়া আলা দ্বীনি নাবিয়্যিনা মুহাম্মাদিন সাল্লাল্লা-হু আলাইহি ওয়াসাল্লাম ওয়া আলা মিল্লাতি আবীনা ইবরা- হীমা হানীফাম মুসলিমাও ওয়ামা কা-না মিনাল মুশরিকীন।",
          meaning:
              "আমরা বিকালে উপনীত হয়েছি ইসলামের ফিত্বরাতের উপর, নিষ্ঠাপূর্ণ বাণী (তাওহীদ) এর উপর, আমাদের নবী মুহাম্মাদ সাল্লাল্লাহু আলাইহি ওয়াসাল্লাম- এর দ্বীনের উপর, আর আমাদের পিতা ইব্রাহীম আলাইহিস সালাম-এর মিল্লাতের উপর—যিনি ছিলেন একনিষ্ঠ মুসলিম এবং যিনি মুশরিকদের অন্তর্ভুক্ত ছিলেন না।",
        ),
      ],
      source: "(সহীহুল জাম’য়: ৪/২০৯)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَمْسَيْنَا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ ، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِينَأَمْسَيْنَا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ ، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِينَ",
          pronounce:
              "Amsaynaa 'alaa fitratil-'Islaami wa 'alaa kalimatil-'ikhlaasi, wa 'alaa deeni Nabiyyinaa Muhammadin, wa 'alaa millati 'abeenaa 'Ibraaheema, haneefan Musliman wa maa kaana minal-mushrikeen.",
          meaning:
              "We rise in the evening upon the fitrah of Islam, and the word of pure faith, and upon the religion of our Prophet Muhammad and the religion of our forefather Ibraaheem, who was a Muslim and of true faith and was not of those who associate others with Allah.",
        ),
      ],
      source: "(Saheeh Al-Jaami: 4/209)",
    ),
  ),
  AdhkarItem(
    id: 44,
    adhkarIds: [1],
    titleBn: "দুআ #৮",
    titleEn: "Dua #8",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي، وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي، وَآمِنْ رَوْعَاتِي اللَّهُمَّ احْفَظْنِي مِنْ بَينِ يَدَيَّ، وَمِنْ خَلْفِي وَعَنْ يَمِينِي، وَعَن شِمَالِي، وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي",
          pronounce:
              "আল্লা-হুম্মা ইন্নী আসআলুকাল ‘আফওয়া ওয়াল- ‘আ-ফিয়াতা ফিদ্দুনইয়া ওয়াল আ-খিরাতি। আল্লা-হুম্মা ইন্নী আসআলুকাল ‘আফওয়া ওয়াল- ‘আ-ফিয়াতা ফী দীনী ওয়াদুনইয়াইয়া, ওয়া আহ্‌লী ওয়া মা-লী, আল্লা-হুম্মাসতুর ‘আওরা-তী ওয়া  আ-মিন রাও‘আ-তি। আল্লা-হুম্মাহফাযনী মিম্বাইনি ইয়াদাইয়্যা ওয়া মিন খালফী ওয়া ‘আন ইয়ামীনী ওয়া শিমা-লী ওয়া মিন ফাওকী। ওয়া আ‘ঊযু বি‘আযামাতিকা আন উগতা-লা মিন তাহ্‌তী।",
          meaning:
              "হে আল্লাহ! আমি আপনার নিকট দুনিয়া ও আখেরাতে ক্ষমা ও নিরাপত্তা প্রার্থনা করছি। হে আল্লাহ! আমি আপনার নিকট ক্ষমা এবং নিরাপত্তা চাচ্ছি আমার দ্বীন, দুনিয়া, পরিবার ও অর্থ-সম্পদের। হে আল্লাহ! আপনি আমার গোপন ত্রুটিসমূহ ঢেকে রাখুন, আমার উদ্বিগ্নতাকে রূপান্তরিত করুন নিরাপত্তায়। হে আল্লাহ! আপনি আমাকে হেফাযত করুন আমার সামনের দিক থেকে, আমার পিছনের দিক থেকে, আমার ডান দিক থেকে, আমার বাম দিক থেকে এবং আমার উপরের দিক থেকে। আর আপনার মহত্ত্বের অসিলায় আশ্রয় চাই আমার নীচ থেকে হঠাৎ আক্রান্ত হওয়া থেকে।",
        ),
      ],
      source: "(আবু দাউদ: ৫০৭৪)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي، وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي، وَآمِنْ رَوْعَاتِي اللَّهُمَّ احْفَظْنِي مِنْ بَينِ يَدَيَّ، وَمِنْ خَلْفِي وَعَنْ يَمِينِي، وَعَن شِمَالِي، وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي",
          pronounce:
              "Allaahumma 'innee 'as'alukal-'afwa wal'aafiyata fid-dunyaa wal'aakhirati, Allaahumma 'innee 'as'alukal-'afwa wal'aafiyata fee deenee wa dunyaaya wa 'ahlee, wa maalee, Allaahum-mastur 'awraatee, wa 'aamin raw'aatee, Allaahum-mahfadhnee min bayni yadayya, wa min khalfee, wa 'an yameenee, wa 'an shimaalee, wa min fawqee, wa 'a'oothu bi'adhamatika 'an 'ughtaala min tahtee.",
          meaning:
              "O Allah, I ask You for pardon and well-being in this life and the next. O Allah, I ask You for pardon and well-being in my religious and worldly affairs, and my family and my wealth. O Allaah, veil my weaknesses and set at ease my dismay. O Allaah, preserve me from the front and from behind and on my right and on my left and from above, and I take refuge with You lest I be swallowed up by the earth.",
        ),
      ],
      source: "(Abu Dawud: 5074)",
    ),
  ),
  AdhkarItem(
    id: 45,
    adhkarIds: [1],
    titleBn: "দুআ #৯",
    titleEn: "Dua #9",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَهَ إلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ على كل شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ  وَخَيْرَ مَا بَعْدَهُ ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ  وَشَرِّ مَا بَعْدَهُ ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ",
          pronounce:
              "আসবাহ্‌না ওয়া আসবাহাল মুলকু লিল্লাহি ওয়ালহাম্‌দু লিল্লাহি, লা ইলা-হা ইল্লাল্লা-হু ওয়াহ্‌দাহু লা শারীকা লাহু, লাহুল মুলকু ওয়া লাহুল হামদু, ওয়াহুয়া আলা কুল্লি শাই’ইন ক্বাদীর। রব্বি আস্আলুকা খাইরা মা ফী হা-যাল ইয়াউমি ওয়া খাইরা মা বা‘দাহু , ওয়া আ‘ঊযু বিকা মিন শাররি মা ফী হা-যাল ইয়াউমি  ওয়া শাররি মা বা‘দাহু । রব্বি আঊযু বিকা মিনাল কাসালি ওয়া সূইল- কিবারি। রব্বি আ‘ঊযু বিকা মিন ‘আযাবিন ফিন্না-রি ওয়া আযাবিন্ ফিল ক্বাবরি।",
          meaning:
              "আমরা আল্লাহর জন্য সকালে উপনীত হয়েছি, অনুরূপ যাবতীয় রাজত্বও সকালে উপনীত হয়েছে, আল্লাহর জন্য। সমুদয় প্রশংসা আল্লাহর জন্য। একমাত্র আল্লাহ ছাড়া কোনো হক্ব ইলাহ নেই, তাঁর কোনো শরীক নেই। রাজত্ব তাঁরই এবং প্রশংসাও তাঁর, আর তিনি সকল কিছুর উপর ক্ষমতাবান। হে রব্ব! এই দিনের মাঝে এবং  এর পরে যা কিছু কল্যাণ আছে আমি আপনার নিকট তা প্রার্থনা করি। আর এই দিনের মাঝে এবং এর পরে যা কিছু অকল্যাণ আছে, তা থেকে আমি আপনার আশ্রয় চাই। হে রব্ব! আমি আপনার কাছে আশ্রয় চাই অলসতা ও খারাপ বার্ধক্য থেকে। হে রব্ব! আমি আপনার কাছে আশ্রয় চাই জাহান্নামে আযাব হওয়া থেকে এবং কবরে আযাব হওয়া থেকে।",
        ),
      ],
      source: "(মুসলিম: ২৭২৩)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَهَ إلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ على كل شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ  وَخَيْرَ مَا بَعْدَهُ ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ  وَشَرِّ مَا بَعْدَهُ ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ",
          pronounce: "",
          meaning: "",
        ),
      ],
      source: "(Muslim: 2723)",
    ),
  ),
  AdhkarItem(
    id: 46,
    adhkarIds: [2],
    titleBn: "দুআ #১০",
    titleEn: "Dua #10",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَمْسَيْنَا وَ أَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَهَ إلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىكُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِرَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ",
          pronounce:
              "আমসাইনা ওয়া আমসাল মুলকু লিল্লাহি ওয়ালহাম্‌দু লিল্লাহি, লা ইলা-হা ইল্লাল্লা-হু ওয়াহ্‌দাহু লা শারীকা লাহু, লাহুল মুলকু ওয়া লাহুল হামদু, ওয়াহুয়া আলা কুল্লি শাই’ইন ক্বাদীর। রব্বি 16. আস্আলুকা খাইরা মা ফী হাযিহিল লাইলাতি ওয়া খাইরা মা বা‘দাহা, ওয়া আ‘ঊযু বিকা মিন শাররি মা ফী হাযিহিল লাইলাতিওয়া শাররি মা বা‘দাহা। রব্বি আঊযু বিকা মিনাল কাসালি ওয়া সূইল-কিবারি। রব্বি আ‘ঊযু বিকা মিন ‘আযাবিন ফিন্না-রি ওয়া আযাবিন্ ফিল ক্বাবরি।",
          meaning:
              "আমরা আল্লাহর জন্য বিকালে উপনীত হয়েছি, অনুরূপ যাবতীয় রাজত্বও বিকালে উপনীত হয়েছে, আল্লাহর জন্য। সমুদয় প্রশংসা আল্লাহর জন্য। একমাত্র আল্লাহ ছাড়া কোনো হক্ব ইলাহ নেই, তাঁর কোনো শরীক নেই। রাজত্ব তাঁরই এবং প্রশংসাও তাঁর, আর তিনি সকল কিছুর উপর ক্ষমতাবান। হে রব্ব! এই 17. রাতের মাঝে এবং  এর পরে যা কিছু কল্যাণ আছে আমি আপনার নিকট তা প্রার্থনা করি। আর এই রাতের মাঝে এবং এর পরে যা কিছু অকল্যাণ আছে, তা থেকে আমি আপনার আশ্রয় চাই। হে রব্ব! আমি আপনার কাছে আশ্রয় চাই অলসতা ও খারাপ বার্ধক্য থেকে। হে রব্ব! আমি আপনার কাছে আশ্রয় চাই জাহান্নামে আযাব হওয়া থেকে এবং কবরে আযাব হওয়া থেকে।",
        ),
      ],
      source: "(মুসলিম: ২৭২৩)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "أَمْسَيْنَا وَ أَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَهَ إلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىكُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِرَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ",
          pronounce:
              "Amsaynaa wa'amsal-mulku lillaahi walhamdu lillaahi, laa 'ilaaha 'illallaahu wahdahu laa shareeka lahu, lahul-mulku wa lahul-hamdu wa Huwa 'alaa kulli shay'in Qadeer. Rabbi 'as'aluka khayra maa fee haathihil-laylati wa khayra maa ba'daha wa 'a'oothu bika min sharri maa fee haathihil-laylati wa sharri maa ba'daha, Rabbi 'a'oothu bika minal-kasali, wa soo'il-kibari, Rabbi 'a'oothu bika min 'athaabin fin-naari wa 'athaabin fil-qabri.",
          meaning:
              "We have reached the evening and at this very time unto Allaah, belongs all sovereignty, and all praise is for Allah. None has the right to be worshipped except Allah, alone, without any partner, to Him belong all sovereignty and praise and He is over all things omnipotent. My Lord, I ask You for the good of this night and the good of what follows it and I take refuge in You from the evil of this night and the evil of what follows it. My Lord, I take refuge in You from laziness and senility. My Lord, I take refuge in You from torment in the Fire and punishment in the grave.",
        ),
      ],
      source: "(Muslim: 2723)",
    ),
  ),
  AdhkarItem(
    id: 47,
    adhkarIds: [2],
    titleBn: "দুআ #১১",
    titleEn: "Dua #11",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وإليك المصيرُ",
          pronounce:
              "আল্লা-হুম্মা বিকা আমসাইনা ওয়াবিকা আসবাহ্‌না ওয়াবিকা নাহ্‌ইয়া, ওয়াবিকা নামূতু ওয়া ইলাইকাল মাসীর।",
          meaning:
              "হে আল্লাহ! আমরা আপনার জন্য বিকালে উপনীত হয়েছি এবং আপনারই জন্য আমরা সকালে উপনীত হয়েছি। আর আপনার দ্বারা আমরা জীবিত থাকি, আপনার দ্বারাই আমরা মারা যাব;আর আপনার দিকেই প্রত্যাবর্তিত হব।",
        ),
      ],
      source: "(তিরমিযী: ৩৩৯১)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وإليك المصيرُ",
          pronounce:
              "Allaahumma bika 'amsaynaa, wa bika 'asbahnaa, wa bika nahyaa, wa bika namootu wa 'ilaykal maseer.",
          meaning:
              "O Allah, by You we enter the evening and by You we enter the morning, by You we live and and by You we die, and to You is our resurrection.",
        ),
      ],
      source: "(Tirmizi: 3391)",
    ),
  ),
  AdhkarItem(
    id: 48,
    adhkarIds: [3],
    titleBn: "দুআ #১২",
    titleEn: "Dua #12",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللّٰهُمَّ إِنَّكَ خَلَقْتَ نَفْسِيْ وَأَنْتَ تَوَفَّاهَا، لَكَ مَمَاتُهَا وَمَحْيَاهَا، إِنْ أَحْيَيْتَهَا فَاحْفَظْهَا، وَإِنْ أَمَتَّهَا فَاغْفِرْ لَهَا اللّٰهُمَّ إِنِّيْ أَسْأَلُكَ العَافِيَةَ",
          pronounce:
              "আল্লা-হুম্মা ইন্নাকা খালাক্তা নাফসী ওয়া আন্তা তাওয়াফ্‌ফাহা। লাকা মামা-তুহা ওয়া মাহ্‌ইয়া-হা। ইন্ আহ্ইয়াইতাহা ফাহ্‌ফায্‌হা ওয়াইন আমাত্তাহা ফাগফির লাহা। আল্লা-হুম্মা ইন্নী আস্আলুকাল ‘আ-ফিয়াতা।",
          meaning:
              "হে আল্লাহ! নিশ্চয় আপনি আমার আত্মাকে সৃষ্টি করেছেন এবং আপনি তার মৃত্যু ঘটাবেন। তার মৃত্যু ও তার জীবন আপনার মালিকানায়। যদি তাকে বাঁচিয়ে রাখেন তাহলে আপনি তার হেফাযত করুন, আর যদি তার মৃত্যু ঘটান তবে তাকে মাফ করে দিন। হে আল্লাহ! আমি আপনার কাছে নিরাপত্তা চাই।",
        ),
      ],
      source: "(মুসলিম: ২৭১২)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اللّٰهُمَّ إِنَّكَ خَلَقْتَ نَفْسِيْ وَأَنْتَ تَوَفَّاهَا، لَكَ مَمَاتُهَا وَمَحْيَاهَا، إِنْ أَحْيَيْتَهَا فَاحْفَظْهَا، وَإِنْ أَمَتَّهَا فَاغْفِرْ لَهَا اللّٰهُمَّ إِنِّيْ أَسْأَلُكَ العَافِيَةَ",
          pronounce:
              "Allaahwmma 'innaka khalaqta nafsee wa 'Anta tawaffaahaa, laka mamaatuhaa wa mahyaahaa, 'in 'ahyaytahaa fahfadhhaa, wa 'in 'amattahaa faghfir lahaa . Allaahumma 'innee 'as'alukal-'aafiyata.",
          meaning:
              "O Allah, verily You have created my soul and You shall take it's life, to You belong it's life and death. If You should keep my soul alive then protect it, and if You should take it's life then forgive it. O Allah, I ask You to grant me good health.",
        ),
      ],
      source: "(Muslim: 2712)",
    ),
  ),
  AdhkarItem(
    id: 49,
    adhkarIds: [3],
    titleBn: "দুআ #১৩",
    titleEn: "Dua #13",
    detailBn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اَلْحَمْدُ لِلّٰهِ الَّذِيْ أَطْعَمَنَا وَسَقَانَا، وَكَفَانَا، وَآوَانَا فَكَمْ مِمَّنْ لاَ كَافِيَ لَهُ وَلاَ مُؤْوِيَ",
          pronounce:
              "আলহামদু লিল্লা-হিল্লাযী আত‘আমানা, ওয়া সাক্বা-না, ওয়া কাফা-না, ওয়া আ-ওয়ানা, ফাকাম্ মিম্মান লা কা-ফিয়া লাহু, ওয়ালা মু’উইয়া।",
          meaning:
              "সকল প্রশংসা আল্লাহ্‌র জন্য, যিনি আমাদেরকে আহার করিয়েছেন, পান করিয়েছেন, আমাদের প্রয়োজন পূর্ণ করেছেন এবং আমাদেরকে আশ্রয় দিয়েছেন। কেননা, এমন বহু লোক আছে যাদের প্রয়োজনপূর্ণকারী কেউ নেই এবং যাদের আশ্রয়দানকারীও কেউ নেই।",
        ),
      ],
      source: "(মুসলিম: ২৭১৫)",
    ),
    detailEn: Detail(
      verses: [
        Verse(
          id: 1,
          arabic:
              "اَلْحَمْدُ لِلّٰهِ الَّذِيْ أَطْعَمَنَا وَسَقَانَا، وَكَفَانَا، وَآوَانَا فَكَمْ مِمَّنْ لاَ كَافِيَ لَهُ وَلاَ مُؤْوِيَ",
          pronounce:
              "Alhamdu lillaahil-lathee 'at'amanaa wa saqaanaa, wa kafaanaa, wa 'aawaanaa, fakam mimman laa kaafiya lahu wa laa mu'wiya.",
          meaning:
              "All praise is for Allah, Who fed us and gave us drink, and Who is sufficient for us and has sheltered us, for how many have none to suffice them or shelter them.",
        ),
      ],
      source: "(Muslim: 2715)",
    ),
  ),
];
