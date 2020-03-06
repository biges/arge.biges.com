---
title: "Switched Mode Güç Kaynakları (SMPS) (1)"
date: Feb 09, 2020 10:00
# tags: tag1,tag2
# subtitle: 
# cover: 
# published: false
# comments: false 
author:
  name: Soner Boztaş
  email: soner@biges.dev
  link: https://sonerboztas.blogspot.com
  twitter: "SonerBoztas"
  bio: Elektronik Mühendisi
---

Bugün ki yazımda sizlere genel anlamda **Switched Mode Power Supply** (*SMPS*)
yani halk arasında bilinen tabiriyle **Anahtarlamalı Güç Kaynakları**ndan
bahsedeceğim

READ_MORE

Konu hayli uzun ve detaylı olduğundan birkaç yazıda bu konudan bahsetmeye
devam edeceğim. Bu yazı giriş niteliğinde olup, SMPS’lerin genel çalışma
prensipleri, avantajları ve dezavantajlarıyla ilgili olacak. Bir sonraki
yazımda günümüzde sıklıkla kullanılan topolojilerden bahsedeceğim ve son
olarak da bu bölümde bahsettiğim bazı özel devreler hakkında detaylı bilgiler
vereceğim.

Dünya tarihi boyunca icatlar her zaman belirli ihtiyaçları karşılamak amacıyla
doğmuştur. SMPS devrelerinin doğuşu da aslında tam olarak böyle olmuştur. SMPS
devrelerinden önce kullanılan Linear Power Supply yani Doğrusal Güç
Kaynakları, büyük boyutları ve kararlı çalışmalarına rağmen düşük verimleri
nedeniyle sektörü yeni bir yöntemi aramaya mecbur kılmıştır. 

1960’lı yılların başında *Apollo Uzay Gemisi* için NASA’da yürütülen
çalışmalar sonucu ilk SMPS devresi Apollo’nun bilgisayar birimlerinin
beslemesini sağlamak için doğmuştur. Böylece daha verimli ve daha küçük bir
güç kaynağı tasarımı yapılmış olunup SMPS devrelerinin de tarihsel süreci
başlamıştır.

<div class="full zoomable">
    <img src="/public/images/posts/clips/module-in-front-of-agc-w700.jpg" alt="Apollo Uzay Gemisinde Kullanılan ilk SMPS Tasarımı">
    <p>Apollo Uzay Gemisinde Kullanılan ilk SMPS Tasarımı</p>
</div>

SMPS’lerden bahsetmeden önce SMPS teknolojisinin gelişimine değinmek
istiyorum. Elektriğin insanların hayatına ciddi anlamda girmeye başlamasıyla
beraber elektroniğin gelişimi de temel olarak tasarımcıların tasarımları için
gerekli olan gücü sağlayabilmeleri ile başlamıştır. Burada çok eski bir
teknoloji olarak bildiğimiz *Linear/Doğrusal Güç Kaynakları* varoluşundan bu
yana görmeye alışık olduğumuz bir yöntemdir. 

Bu yöntem günümüzde hassas, ölçeklenebilirlik ve yüksek verim kaygısı olmayan
tasarımlarda hala kullanılmaktadır. Lineer Regülatörler temel olarak şebekeden
(220V/50Hz) alınan gerilimi bir sac trafonun primer-sekonder sargılarının
oranına bağlı olarak daha düşük bir gerilime dönüştürdükten sonra (örneğin;
24V, 12V, 9V vb.) bir köprü diyot yardımıyla tam dalga doğrultarak op-amp,
transistör ve direnç grubuyla çıkış gücünü sağlayan regülatör devreleridir.

Aşağıda temel yapısıyla günümüzde kullanılan haliyle bir lineer regülatör
devresi gösterilmiştir. Op-ampların gelişiminden önce bu devrelerin
tasarımları tamamen transistör ve direnç gruplarıyla kontrol edilmekteydi.

<div class="full zoomable">
    <img src="/public/images/posts/clips/lineer-dogrusal-gk.jpg" alt="Temel Yapısıyla Lineer/Doğrusal Güç Kaynağı Devresi">
    <p>Temel Yapısıyla Lineer/Doğrusal Güç Kaynağı Devresi</p>
</div>

Devrede giriş bölümü şebeke voltajına bağlanmıştır, bu değer 50 Hz frekanslı
220 VAC’dir. Bu gerilim bir sac trafo yardımıyla daha düşük bir gerilime
dönüştürülür sonrasında bu gerilim bir köprü diyot yardımıyla sağdaki resimde
görüldüğü gibi tam dalga doğrultulur.

Sonrasında giriş kondansatörü köprü diyotun çıkışındaki gerilimi yine yandaki
şekilde görüldüğü gibi şarj/deşarj aralıklarındaki zamana bağlı olarak DC
gerilime yaklaştırır. Bu kondansatörün değeri kullanacağınız gerilimin
değerine göre farklılık gösterebilir. Devrenin üzerinde bulunan NPN transistör
çıkış akımını sağlamakla görevlidir. 

<div class="full zoomable">
    <img src="/public/images/posts/clips/full-wave-rectifier-with-capacitor-filter-waveform.jpg" alt="Kapasitör filtresi dalga formu">
    <p>Kapasitör filtresi dalga formu</p>
</div>

Çıkış akımının değerine bağlı olarak bu transistör değişiklik gösterebilir
ancak burada yüksek kazançlı bir “Darlington Transistör” kullanmakta fayda
vardır. Rcb direnci bir pull-up direncidir ve transistörün base ile op-ampın
çıkışının boşta kalmaması için kullanılmıştır ve kullanılmasında fayda vardır.
Kullanılan op-amp non-inverting amplifier olarak bilinen yöntem ile
kullanılmıştır ve regülasyon işlemini yapan devre elemanıdır. Regülasyon
işlemi sırasında dikkat edilmesi gereken bir nokta op-ampın non-inverting (+)
ucuna bağlı bulunan Zener Diyottur. 

Çünkü bu diyot regülatör devresinin referans gerilimini oluşturmaktadır.
Üzerinde bulunan direnç ise zener diyotun çekmesi gereken akımı sağlayabilmek
amacıyla kullanılmıştır ve 1k değeri yeterlidir. Hassasiyet gerektiren
uygulamalarda zener diyot yerine TL431 gibi bir gerilim referans kaynağı
tercih edilmelidir. 

Tasarımın çalışma prensibi aşağıda verilen formülle açıklanmaktadır.
Formüldeki Vref gerilimi op-ampın `+` ucuna uygulanan gerilimdir. Bir lineer
regülatör tasarımı yapılırken unutulmaması gereken detaylardan birisi de çıkış
akımını sınırlayan bir akım sınırı devresi kullanmaktır.


<div class="full zoomable">
    <img src="/public/images/posts/clips/out-ref-formula.jpg" alt="Formül">
</div>


Lineer regülatör devrelerinin çalışma prensiplerinden de kısaca bahsettikten
sonra avantaj ve dezavantajlarından bahsederek artık yavaş yavaş SMPS
devrelerine geçmek istiyorum. Lineer regülatörler kolay tasarımları, ekstra
filtreleme işlemleri gerektirmemeleri, kararlı çıkışları ve ucuz tasarımları
nedeniyle günümüzde hala güncel ve hassas uygulamalarda kullanılmaktadır.

Ancak bunca avantajının yanı sıra izolasyon ve şebeke gerilimini daha düşük
bir gerilime düşürmek için kullanılan sac trafoların boyutlarının ve
ağırlıklarının oldukça fazla olması başta olmak üzere kararlı çıkışlarına
rağmen regülatör verimlerinin oldukça düşük olması sebebiyle de kullanım
oranları SMPS’lerin gerisinde kalmıştır. Verimleri hakkındaki temel
hesaplamayı bir önceki yazımda paylaştım isteyenler [buraya](/2020/02/02/dc-dc-guc-regulatorleri-hakkinda-bilinmeyenler/) tıklayarak bir
önceki yazıma ulaşabilirler.

<div class="full zoomable">
    <img src="/public/images/posts/clips/lineer-power-supply.jpg" alt="Linear / Doğrusal Power Supply">
    <p>Linear / Doğrusal Power Supply</p>
</div>

Günümüzde kullandığımız elektronik cihazların içerisinde ya da harici olarak
cihazlarla birlikte verilen ürünlerin bir çoğunun içerisinde SMPS devreleri
bulunmaktadır. Çünkü üretici şirketler daha hafif daha küçük ve taşınabilir
cihazlar üreterek minimum boyutlardan maksimum kazançları sağlamayı
hedeflemektedir. 

Bu ürünlere birkaç örnek vermek gerekirse, telefon şarj aletlerimiz ve
bilgisayar şarj aletlerimiz ve bilgisayarlarımızın içerisindeki besleme
devreleri gözle görülen örneklerdendir. Bunun yanı sıra adaptör ile çalışan
bütün cihazlarda yine adaptörlerin içerisinde bulunan SMPS devreleri ile
çalışmaktadır.

Aşağıdaki fotoğrafta SMPS devrelerinin bütün topolojilerinde geçerli
sayılabilecek bir blok diyagram görülmektedir. SMPS devreleri genel olarak bu
diyagramda görüldüğü gibi çalışmaktadır. Burada kullanılan topolojilere veya
devrelerin gerekliliklerine bağlı olarak kullanılan yani kullanılması zorunlu
olmayan birimleri “opsiyonel” olarak belirttim. Bu bölümleri detaylı olarak
üçüncü SMPS yazımda açıklayacağım.

<div class="full zoomable">
    <img src="/public/images/posts/clips/smpps-bd-ayarli.jpg" alt="SMPS Devrelerinin Genel Blok Diyagramı">
    <p>SMPS Devrelerinin Genel Blok Diyagramı</p>
</div>


SMPS devreleri 20 kHz’den ihtiyaca göre 1-2 MHz’e kadar anahtarlama
frekanslarında çalışabilen devrelerdir. Anahtarlama frekanslarının bu denli
yüksek olması aslında boyutların küçülmesi ile direkt ilişkilidir. Bu ilişkiyi
gösteren denklem aşağıda gösterilmiştir.

<div class="full zoomable">
    <img src="/public/images/posts/clips/waac.jpg" alt="SMPS Devrelerinin Genel Blok Diyagramı">
</div>

Formülde “Wa” parametresi trafonun pencere açıklığını (window area) ifade eder
, “Ac” ise trafonun nüvesinin kesit alanıdır (cross sectional area). Görüldüğü
üzere “fs” yani anahtarlama frekansı, formülün paydasında yer almaktadır ve
bu denklem bize anahtarlama frekansının yükselmesinin, trafonun boyutlarının
küçülmesiyle olan ilgisini açıklamaktadır.

SMPS teknolojisinin en önemli avantajlarından bir diğeri regülatör
kazançlarının %90’nın üzerinde olmasıdır. Bu minimum güç ile maksimum verimi
elde etmek anlamına gelmektedir ve üreticileri SMPS teknolojisine yaklaştıran
diğer bir önemli nedendir.

Verimlilik konusunda yapılan çalışmalar artık günümüzde SMPS devrelerinin
şebekeden çektiği güce bağlı verimlerini de yükseltmiştir. Burada
bahsedeceğimiz teknoloji PFC’dir. İngilizce açılımı “Power Factor Correction”
yani “Güç Oranı Düzeltme” anlamına gelmektedir. PFC kullanılmayan devrelerde
güç çarpanı temel olarak `0.5` veya `0.6` olarak kabul edilir. Bu da çıkışı 100
Watt olan bir SMPS devresinin şebekeden yaklaşık 150 Watt bir güç çekeceği
anlamına gelmektedir.

PFC devrelerinin hedefi kullanımları dışında `0.5` olarak kabul edilen güç
çarpanı değerini "1" e yaklaştırmaktır. Bunu da biraz daha açmak gerekirse,
şebeke tarafından çekilecek olan RMS giriş akımının miktarını azaltmak olarak
açıklayabiliriz. Bunun yanı sıra devre üzerindeki güç dağılımının
verimliliğini de olumlu yönde etkilemektedirler.

PFC devreleri “Active” ve “Passive” olarak ikiye ayrılır. Active PFC devreleri
günümüzde güç çarpanı değerini `0.99`’a kadar yaklaştırmıştır. Güç çarpanı
değerinin ideal olarak `1` olduğu düşünüldüğünde bu değer mükemmele yakındır.
PFC devrelerinin günümüzde verimliliğin önemli olduğu ciddi projelerde
kullanımları kaçınılmaz hale gelmiştir. 

Kullanıldığı yerlere verilebilecek en güzel örnek bilgisayarlarımızın
içerisinde bulunan power supply devreleridir. Passive PFC devreleri temel
olarak bir sac trafo ve kondansatörden oluşmaktadır. Büyük boyutları ve
`0.7 - 0.8` arasında değişen güç çarpanları nedeniyle active PFC devrelerinin
gerisinde kalmıştır. Active PFC devreleri ise temel olarak bir SMPS devresinin
içerisinde bulunan başka bir SMPS devresi gibi düşünülebilir. Güç Çarpanı
değerleri `0.9` ile `0.99` arasında değişmektedir.

<div class="full zoomable">
    <img src="/public/images/posts/clips/passive-pfc.jpg" alt="Passive PFC Devresi">
    <p>Passive PFC Devresi</p>
</div>
<div class="full zoomable">
    <img src="/public/images/posts/clips/active-pfc.jpg" alt="Active PFC Devresi">
    <p>Active PFC Devresi</p>
</div>


SMPS’lerin avantajlarını ve bu avantajları sağlayan durumları açıkladıktan
sonra SMPS devreleri hakkında genel bilgiler vermek istiyorum. SMPS
devrelerinin giriş bölümlerinde bulunan kondansatörler SMPS’lere ilk enerji
verildiği anda yüksek bir şarj akımı çekerler. 

Bu akım devrenin normal sınırlarının üzerinde olur ve devreye zarar verebilme
ihtimali söz konusudur. Bu nedenle SMPS devrelerin girişlerinde “inrush
dirençleri” kullanılmaktadır. Bu dirençler genellikle NTC termistörler olarak
seçilir. Bu dirençlerin kullanılmasının nedeni ani şarj akımlarına karşı
devrenin akımını sınırlandırmak ve devreyi korumaktır.

Burada bahsedilmesi gereken diğer bir eleman ise “sigortalardır”. Sigortalar
olağan dışı koşullarda şebekeden aşırı akım çekilmesini engellemekle görevli
devre elemanlarıdır. Devrenin aşırı akım çekmesi durumunda patlayarak açık
devre konumuna geçer ve devrenin şebekeyle olan ilişkisini keserek devrenin
geri kalanını korurlar. Şebeke bölümüne yerleştirilen sigortaların birkaç
farklı modeli bulunmaktadır ve tasarımcı devrenin parametrelerine göre sigorta
seçimi yapabilmektedir.

SMPS’lerden bahsedildiği zaman filtreleme işlemleri bu tasarımların göz ardı
edilemez bir parçasıdır. Çünkü SMPS’ler yüksek frekanslarda çalışan devreler
olduğu için bu frekanslarda oldukça gürültü ve harmonik üretme kabiliyetine
sahiptirler. Bu gürültülere örnek verilecek olursa; şebeke hattındaki
gürültüler, anahtarlama gürültüleri ve hat gürültüleri gösterilebilir. SMPS
devreleri üzerinde şebeke tarafından gelebilecek gürültüleri ve şebeke
tarafına gidebilecek gürültüleri önlemek için devrenin AC bölümünde
kullanılabilecek filtreleme yöntemleri bulunmaktadır. 

Bu yöntemler devrenin gürültü hassasiyetine göre tasarlanıp, seçilebilir.
Yöntemlerden biri ve kolay olanı hatlardaki gürültüleri kondansatör
gruplarıyla engellemektir. Diğer bir yöntem ise EMI Filtre yöntemidir. EMI
Filtre RLC gruplarından oluşan bir filtreleme yöntemidir ve sonuçları oldukça
başarılıdır. Endüstriyel bir power supply tasarımı yapılırken tasarlanan
devrenin belirli bazı EMI (Electro Magnetic Interferance) değerleri vardır. Bu
değerlerin üzerinde bulunan tasarımlar onay alamayarak satışa sunulamaz.
Filtreleme işlemleri tasarımların gerektirdikleri hassasiyetlere göre
detaylandırılabilir. 

EMI’yi önlemek için EMI Filtre tasarımları yapıldığı gibi PCB’lerin
katmanlarını arttırmak, devrenin çevresini ve manyetik salınım yapabilecek
komponentleri (trafolar, bobinler vb.) ekranlamak gibi yöntemler sıklıkla
kullanılan diğer yöntemlerdendir. Filtreleme içerisinde bazı parametreler
barındıran bir işlemdir. Bunu açıklayacak olursak; devrenin kendi üzerinde
oluşan EMI ve gürültüler, devrenin dışarıya yaydığı EMI, devrenin dışardan
içeriye aldığı EMI, devrenin şebeke hattından gelen gürültüler ve devrenin
şebeke hattına aktarabileceği gürültülerden bahsedebiliriz. Bir SMPS tasarımı
yapılırken tüm bu parametreler göz önünde bulundurulmalıdır. Aşağıdaki örnekte
en basit haliyle bir EMI Filtre devresi gösterilmiştir.

<div class="full zoomable">
    <img src="/public/images/posts/clips/temel-emi-filtre-devresi.png" alt="Temel EMI Filtre Devresi">
    <p>Temel EMI Filtre Devresi</p>
</div>

SMPS devrelerinin diğer özel elemanlarından bir tanesi switchleri yani
anahtarlarıdır. Seçilen topolojiye bağlı olarak düşük güçlü tasarımlarda
anahtarlar entegre sürücü devrelerinin içerisinde de bulunabilmektedirler. Bu
anahtarlar gerek entegrelerin içerisinde gerekse harici olarak dışardan
bağlanan tasarımlarda günümüzde en çok MOSFET’ler olarak seçilmekte ve
kullanılmaktadır. 

Bunun nedeni MOSFET’lerin çok hızlı anahtarlama yapabiliyor olmaları ve çok
yüksek peak akımlarına karşı dayanıklı olmalarıdır. MOSFET’ler devrenin
anahtarlama frekansında anahtarlama yaparak oluşturdukları PWM sinyallerini
regülatör trafolarına iletirler.

Burada bahsetmemiz gereken bir diğer konu ise PWM Controller Entegreleridir.
MOSFET’lerin gatelerini istenilen frekanslarda sürebilmek için kullanılan bu
entegreler topolojilere göre farklılık göstermektedirler. PWM Controller
entegreleri SMPS devrelerinin Primer yani yüksek güç barındıran bölgelerinde
konumlanmaktadır. Bazı tasarımlarda bu entegreler devrenin primerinden tamamen
izole edilirken bazı tasarımlarda ise primer bölgesiyle beraber
değerlendirilip devrenin sekonder bölgesinden izole edilirler. 

Devrenin primerinden izole edildikleri iki yöntem bulunmaktadır. Bu
yöntemlerden ilki ve en sağlıklısı Gate Drive Trafosu kullanılan yöntemdir.
Gate Drive Trafosu endüstriyel ve yüksek güçlü uygulamalarda, çift MOSFET’li
topolojilerde görmeye alışık olduğumuz bir yöntemdir. Bu yöntem sayesinde PWM
Controller Entegresi devrenin primer kısmından izole edilirken çift
anahtarlamalı topolojilerde MOSFET’lerin gatelerine gelen sinyalleri de
fazlandırarak anahtarlama işlemine katkı sağlamaktadır. Bu yöntem düşük güç
yoğunluklu SMPS devrelerinde tercih edilmeyen bir yöntemdir. 

Bunun nedeni Gate Drive Trafosu ile tasarlanan SMPS devrelerinin harici bir
izole besleme devresi (Isolated Aux Supply) gerektirmesidir. İkinci yöntem ise
Low Side ve High Side Gate Drive Sürücü Entegrelerinin opto-couplerlar ile
beraber kullanılmasıdır. Bu yöntem de Gate Drive Trafosu yerine kullanılabilir
ancak daha az tercih edilen bir tasarım yöntemidir. Son yöntem ise günümüzde
sıklıkla karşılaştığımız düşük güç yoğunluklu, tek MOSFET’li devrelerde ve
hatta MOSFET’leri PWM Controller entegrelerinde dahili olarak bulunan
tasarımlarda kullanılan yöntemdir. 

Bu yöntemin tasarımı devrenin primer ve sekonderi arasındaki izolasyonu
sağlayan opto-coupler ile yapılmaktadır. Tek MOSFET’li tasarımlar için
kullanılan en kolay yöntemdir. Günümüzde PWM Controller teknolojisinin
gelişimiyle bu entegreler SMPS devrelerinin vazgeçilmez bir parçası
olmuşlardır. Ayrıca entegrelerin akım veya gerilim feedbacki yapabiliyor
olmaları da regülasyonu kolaylaştıran diğer bir etkendir. Üzerlerinde termal
kapama bulundurmaları da güvenliği arttıran diğer bir etkendir.


MOSFET’lerin anahtarladıkları pulselar regülatör trafosuna ulaştıktan sonra
trafo sarım oranına bağlı olarak sekonder bölgesinde AC görünümlü bir kare
dalga oluşturur. Bu pulse topolojiye bağlı olarak diyot/diyotlar yardımıyla
tam dalga doğrultulur. Doğrultulan dalganın formunun negatif alternansı
yandaki şekilde gösterildiği gibi pozitif alternansının yanına eklenmiştir.
Ancak bu dalga formuna DC gerilim demek doğru değildir. 

Bu formdan temiz bir DC gerilim elde edebilmek için çıkış filtrelerine ihtiyaç
duyulmaktadır. Bu filtreler topolojiye bağlı olarak bobin&kondansatör veya
kondansatör gruplarından oluşabilir. SMPS devrelerinin çıkışlarında kullanılan
kondansatörler için dikkat edilmesi gereken noktalardan birisi de seçilen
kondansatörlerin Low ESR olmasıdır. ESR Eşdeğer Seri Direnç anlamına
gelmektedir ve bu kondansatörlerin ESR değerinin yüksek olması çıkış
gerilimini olumsuz yönde etkilemektedir.

<div class="full zoomable">
    <img src="/public/images/posts/clips/tam-dalga-pwm.jpg" alt="Trafo Çıkışındaki Dalga formu ve Tam Dalga Doğrultulmuş Hali">
    <p>Trafo Çıkışındaki Dalga formu ve Tam Dalga Doğrultulmuş Hali</p>
</div>


Buraya kadar temel olarak bir SMPS devresinin nasıl çalıştığını anlattık.
Ancak bu koşullarda çalışan bir devrenin çıkış gerilimi regülesizdir. Bir güç
kaynağı devresinin çıkışının yaşanacak her türlü durum göz önüne alınarak
regüleli olması gerekmektedir. Bu durumda SMPS devrelerinde kullanılan PWM
Controller entegreleri kompanzasyon/feedback girişleriyle tasarımcıların
yardımına koşmaktadır. 

Ancak tasarımcı bu uçların yanı sıra kendi feedback devrelerini de
uygulayabilmektedir. Bu durumlarda tasarımcı hızlı opamplar kullanarak “Error
Amplifier” (*Hata Amplifikatörü*) tasarlamak durumundadır. Bu amplifikatörler
voltaj ve akım feedback’i yapabilirler ve devrenin özelliklerine bağlı olarak
farklı yöntemlerle tasarlanabilirler. Bunun yanı sıra tasarımcı çıkış akımının
aşırı yükselmesini engellemek için de bir akım limit devresi tasarlayabilir.

Bu devrenin tasarlanması devrenin akımının kontrolsüz yükselmesini
engelleyerek devrenin geri kalan komponentlerinin zarar görmesini
engellemektedir. Bu tasarım da yine Hata Amplifikatörü tasarımı şeklindedir.
Aşağıda bir Error Amplifier tasarımının örneği verilmiştir.

<div class="full zoomable">
    <img src="/public/images/posts/clips/error-amplifier-with-pole-zero-compensation.png" alt="Type II Hata Amplifikatörü">
    <p>Type II Hata Amplifikatörü</p>
</div>

Böylelikle SMPS devrelerinin genel tasarım süreçlerine değinmiş olduk.
Aşağıdaki fotoğrafta Half Bridge Topolojisi ile tasarlanmış Passive PFC
devreli bir 8 renk WEB matbaa makinesinin sürücülerini, kontrol panellerini,
işlemcilerini ve bilgisayarlarını beslemek için kullanılan, çoklu sabit
çıkışlı bir ATX Power Supply görüyoruz. Bu devrede gerilim/akım ayarı hariç
blok-diyagram üzerinde bulunan bütün birimler aktif olarak kullanılmıştır.

<div class="full zoomable">
    <img src="/public/images/posts/clips/half-bridge-smps.jpg" alt="Yarım Köprü Anahtarlamalı Mod Güç Kaynağı">
    <p>Yarım Köprü Anahtarlamalı Mod Güç Kaynağı</p>
</div>

---

## Kaynaklar

1. http://www.righto.com/2019/08/reliable-after-50-years-apollo-guidance.html
1. http://www.circuitstoday.com/filter-circuits/full-wave-rectifier-with-capacitor-filter-waveform
1. https://tr.farnell.com/solahd/slcasc-cvr/power-supply-safety-cover/dp/4848949
1. https://incompliancemag.com/article/be-careful-with-input-output-feedback-in-filters/
1. https://incompliancemag.com/article/be-careful-with-input-output-feedback-in-filters/
1. https://www.st.com/content/dam/technology-tour-2017/session-3_track-5_acdc-power-conversion.pdf
