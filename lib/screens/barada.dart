import 'package:flutter/material.dart';

class Barada extends StatelessWidget {
  const Barada({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: const Color(0xFF000023),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000023),
        title: const Text('ИНФО', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: sizeHeight * 2),
              Text(
                'Информация о приложении',
                style: TextStyle(fontSize: 22, color: Colors.white),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizeHeight * 1),
              SizedBox(
                width: sizeWidth * 95,
                child: Text(
                  "      Приложение Трезвый шофёр разработано для водителей. Программная реализация учета расхода времени и пробега для определение стоимости поездок. Мы старались учесть наиболее важные аспекты а так же пожелания водителей и клиентов.  Благодаря набору тарифов, можно быстро начинать поездку по подходящему тарифу.",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: sizeHeight * 1),
              SizedBox(
                width: sizeWidth * 95,
                child: Text(
                  "      Во время поездки можно прибавлять дополнительные услуги, если таковые были оказаны или модифицировать режимы. Например, если клиент просит приехать как можно быстрее - можно включить учет побыстрее, либо факторы зимней погоды, то есть в зимнее время суток. Тарифы нельзя редактировать, так как цены фиксированные подстроеные под тарифную политику.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: sizeHeight * 2),
              Text(
                "ПОЛИТИКА КОНФЕДЕНЦИАЛЬНОСТИ ",
                style: TextStyle(color: Colors.white, fontSize: 22),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizeHeight * 1),
              SizedBox(
                width: sizeWidth * 95,
                child: Text(
                  "      Всю информацию, которую мы собираем, мы используем строго в целях поддержки и развития приложения.  Основные возможности и цели приложения обозначены в приложении, в описании и в документации. Вся собранная информация НЕ передается и НЕ будет передана сторонним лицам и организациям. Приложение НЕ собирает данные о контактах, записных книжках, истории вызовов, любой переписки, о пользовательских файлах и приложениях.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: sizeHeight * 1),
              SizedBox(
                width: sizeWidth * 95,
                child: Text(
                  "      Приложение НЕ осуществляет вызовы. Приложение НЕ осуществляет какие-либо другие действия, не связанные с очевидными нуждами приложения. Приложение НЕ содержит какие-либо другие функции, могущие привести вред пользователю, его данными, и используемому устройству. Мы предпринимаем разумные меры для охраны и защиты каких-либо полученных данных. Если для нужд приложения потребуются дополнительные данные о пользователе, то приложение их запросит в явном виде и явно запросит разрешение на их использование и обработку. Приложение предоставляется 'КАК ЕСТЬ' без каких-либо взаимных гарантий.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: sizeHeight * 1),
              SizedBox(
                width: sizeWidth * 95,
                child: Text(
                  "      Если ВЫ не согласны с нашей политикой - откажитесь от использования приложения. ",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: sizeHeight * 1),
              SizedBox(
                width: sizeWidth * 95,
                child: Text(
                  "      Данное приложение “Трезвый шофер” является собственностью частного предпринимателя Абдуллаева.К.И. Использование данного приложение запрещается посторонним людям и возможно только с личного разрешения Абдуллаева.К.И. Любое использование продукта включая его воспроизведение либо распространение не допускается без разрешение владельца. Пользователь данного приложение обязан нести её сохранность, не передавать приложение третьему лицу и удалить его немедленно со всех принадлежащих ему девайсах а так же мобильных телефонов в случае требования владельца.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: sizeHeight * 2),
              Row(
                children: [
                  Container(
                    width: sizeWidth * 14,
                    height: sizeHeight * 7,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.phone_android,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "   Bерсия   1.1.2 ",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
