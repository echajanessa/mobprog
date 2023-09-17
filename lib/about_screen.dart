import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class AppBanner {
  final int id;
  final String title;
  final String imagePath;

  AppBanner(this.id, this.title, this.imagePath);
}

//index untuk memunculkan text berbeda pada bgian foto
List<AppBanner> appBannerList = [
  AppBanner(1, 'FTI', 'assets/FTI UNTAR.png'),
  AppBanner(2, 'Sistem Informasi', 'assets/Logo SI clear.png'),
  AppBanner(3, 'Student', 'assets/student.jpeg'),
];


class _AboutPageState extends State<AboutPage> {
  var _selectedIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.7);

  //index kalimat pada masing masing slide
  List<String> pageTexts = [
    "Menghasilkan lulusan yang kompeten di bidang teknologi Informasi, berbudi luhur, berwawasan kebangsaan dan menghargai pluralitas.Menghasilkan lulusan di bidang teknologi informasi yang berintegritas, profesional, serta memiliki jiwa entrepreneurial.",
    "Program Studi Sistem Informasi Universitas Tarumanagara memiliki kurikulum yang sesuai dengan standar pendidikan nasional dan juga disesuaikan (link and match) dengan kebutuhan dunia kerja dan industry, serta memiliki tenaga pengajar yang berkualitas dan berpengalaman dengan kualifikasi pendidikan S2 dan S3 dalam dan luar negeri.",
        "Student Name : Janessa Sarah Destini"
        "\nStudent ID        : 825210047"
        "\nCourse              : Mobile Programming",
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            height: 160,
            decoration: BoxDecoration(
              color: Colors.orange[100],
            ),
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              controller: _pageController,
              itemCount: appBannerList.length,
              itemBuilder: (context, index) {
                var banner = appBannerList[index];
                var _scale = _selectedIndex == index ? 1.0 : 0.8; //ukuran gambar, kalo dislide maka ukuran bisa lebih gede
                //animasi saat di-slide
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 350),
                  tween: Tween(begin: _scale, end: _scale),
                  curve: Curves.ease,
                  child: BannerItem(
                    appBanner: banner,
                  ),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                appBannerList.length,
                    (index) => Indicator(isActive: _selectedIndex == index ? true : false),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            pageTexts[_selectedIndex],
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.justify,

          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key, required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer( //animasi saat dipindah ke slide yang lain
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4.0), //bentuk slider horizontal
      width: isActive ? 22.0 : 8.0, //jika slide aktif, maka ukuran slider akan lebih gede (animasi)
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.grey, //jika slider aktif, maka warna akan berubah menjadi orange, selain itu abu-abu
        borderRadius: BorderRadius.circular(8.0)
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  final AppBanner appBanner;
  const BannerItem({
    Key? key,
    required this.appBanner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: AssetImage(appBanner.imagePath),
          fit: BoxFit.contain,
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white, fontSize: 20.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Text(
                      appBanner.title.toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
