---
title: "DC - DC Güç Regülatörleri Hakkında Bilinmeyenler"
date: Feb 02, 2020 10:00
tags: regulator
cover: "electronics.jpg"
author:
  name: Soner Boztaş
  email: soner@biges.dev
  link: https://sonerboztas.blogspot.com
  bio: Elektronik Mühendisi
---

Herkese merhaba. Bu yazımda DC-DC Güç regülatörlerinin pek bilinmeyen
özellikleri hakkında bir takım tecrübelerimi ve bilgilerimi aktaracağım.

READ_MORE

Burada aktaracağım bilgiler sadece DC-DC dönüştürücü entegreleriyle alakalı
olup bütün olarak şebekeden çıkış voltajına kadar olan sistemlerle alakalı
değildir. Önümüzdeki günlerde bütün olarak tak-çalıştır kullanılabilecek
sistemler hakkında detaylı bir yazı yazacağım.

Konuya girmeden önce DC-DC dönüştürücüler hakkında biraz bilgi vermek istedim.

DC-DC Dönüştürücüler için günümüzde kullanılabilecek 2 farklı yöntem mevcut.

Yöntemlerden ilki “Lineer Dönüştürücüler” dir. Bu yöntem uzun yıllardır
kullanılan bir yöntem olup tasarımlarının kolaylığı ve kararlı çıkışları
nedeniyle günümüzde hassas uygulamalarda görebileceğimiz bir yöntemdir. Ancak
ısıl kayıpları nedeniyle verimliliklerinin düşük olması bu sistemleri ikinci
yöntemimiz olan “Anahtarlamalı Sistemlerin” (*SMPS*) gerisine düşürmüştür.

Yöntemlerden ikincisi ise günümüzde farkında olarak ya da olmayarak
kullandığımız hemen hemen bütün elektronik cihazların beslemesinde ya da
harici olarak cihazlarla birlikte bizlere sunulan adaptörlerin içerisinde
bulunan “Anahtarlamalı Sistemler” (*SMPS*) dir. 

Bu sistemlerin yüksek frekanslarda çalışıyor olması nedeniyle filtreleme
işlemleri ve tasarım süreçleri daha zordur. Ancak yüksek verimlilikleri, küçük
boyutları ve ısıl kayıplarının daha düşük olması DC-DC Dönüştürücüler
içerisinde bu sistemi en çok kullanılan sistem haline getirmiştir.

Temel bilgilerden sonra artık konuya giriş yapmak istiyorum. Bir elektronik
kart/cihazın çalıştırılabilmesi için bir güce ihtiyaç vardır. Bu güç temel
olarak şebekeden (`220V/50Hz`) özel olarak ihtiyaca uygun tasarlanmış devrelerle
ya da piyasadan yine ihtiyaçlar göz önüne alınarak satın alınabilecek
adaptörlerle sağlanmaktadır. 

Ancak unutulmamalıdır ki elektronik devrelerde genellikle tek bir gerilimin
kullanılması pek mümkün değildir. Bu ihtiyaç basitçe açıklanacak olursa; bir
elektronik devrenin kontrol birimi ve bu birimin etrafına dizilmiş çevresel
birimlerin, sensörlerin, rölelerin vb. komponentlerin çalışma gerilimlerinin
farklı olmasından doğmaktadır.

İşte tam bu noktada yardımımıza DC-DC güç dönüştürücü (*DC-DC Power Converter*)
devreleri koşmaktadır. Genellikle sistemler talep edilen en yüksek gerilim
değeriyle beslenip, gerekli olan diğer gerilimler ana beslemeden düşük
olacağından **Buck Konverterler** diğer adıyla Anahtarlamalı Sistemler ya da
**Lineer Regülatörler** ile sağlanmaktadır. Piyasada bulabileceğimiz farklı güç
değerlerinde onlarca entegre mevcuttur.

Bu yazımda ayarlanabilir çıkış voltajlı **3A SMPS** (*LM2596*) ve **lineer** (*LM350*)
konverterdan ve bunların üzerindeki tecrübelerimden bahsedeceğim. Bu
devrelerin ikisinin de çıkış voltajlarını `5` - `5.1 Volt` olarak ayarladım.

Devreler zaten hazır bir şekilde datasheet’lerinde verilmiş olduğundan sadece
birkaç ekleme ve düzenleme yaptım sizlerde kendi sonuçlarınıza göre bu
düzenlemeleri yapabilirsiniz. Devrelerin datasheet dosyalarının linklerini ve
yaptığım tasarımları aşağıda paylaşıyorum.

---

<div class="full zoomable">
    <img src="/public/images/posts/clips/LM2596.jpg" alt="LM2596">
    <p>LM2596<br/><a href="http://www.ti.com/lit/ds/symlink/lm2596.pdf">http://www.ti.com/lit/ds/symlink/lm2596.pdf</a></p>
</div>

<div class="full zoomable">
    <img src="/public/images/posts/clips/LM350.jpg" alt="LM350">
    <p>LM350<br/><a href="http://www.ti.com/lit/ds/snvs772b/snvs772b.pdf">http://www.ti.com/lit/ds/snvs772b/snvs772b.pdf</a></p>
</div>

---

Datasheet’lere göz attığınızda bu iki entegrenin de **3 amper**’lik bir yük
altında çalışabileceğini düşünüyoruz. Ancak devreler gerçeklendiğinde pek de
öyle olmuyor. Entegreler **1.5 amper**’den sonra ciddi anlamda ısınıyor ve **2
amper**’e doğru da termal kapamaya (*Thermal Shut-Down*) giriyor.

Şimdi temel olarak bu iki farklı metodu kullanan entegrelerin çalışma
prensiplerinden bahsedecek olursak aslında temel problemin kaynağına da inmiş
olacağız.

Öncelikle, lineer bir regülatörün giriş voltajı çıkış voltajına ne kadar yakın
olursa (*kullanılabilecek minimum gerilim değerleri entegrelerin
datasheet’lerinde belirtilmektedir*) regülatörün üzerindeki ısı o kadar az
olacak. 

Bunu basitçe açıklayacak olursak **5 Volt** çıkış almak istediğiniz bir lineer
regülatörü **7 ile 8 volt** arasında beslemek size maksimum ısıl kazancı
sağlayacaktır. Bunun nedeni lineer regülatörlerin içerisindeki çıkış akımını
sağlayan transistördür. 

Kabaca bir hesap yapacak olursak; `5V - 1A` çıkış `5W`’lık bir güce eşittir.
Burada çıkış transistörünün besleme geriliminin sizin entegrenizin besleme
gerilimi olduğunu düşünürseniz, **12 volt** ile beslediğinizde (*12 - 5*)V’tan 
**7V** ve **1A** çıkış için de **7W** kaybınız olacaktır. 

Öte yandan **5W** çıkış için devrenizi **7V** ile beslerseniz kaybınız (*7-5*)V ve 
**1A** için **2W** olacaktır. Bu kayıp lineer regülatörlerde direkt ısıya 
dönmektedir. Her ne kadar burada bahsettiğim lineer regülatör **LM350** için 
girişinde bir **6.3 V zener diyot** kullanılmışsa da unutulmamalıdır ki 
entegrelerin yarı iletken tasarımları belirli bir alan içerisinde yapılmış 
olup ısıl kayıplara da pek duyarlı olamıyorlar.

Kullandığım diğer regülatör **LM2596** anahtarlamalı bir regülatör olup çalışma
prensibi lineer regülatörlere göre daha farklıdır. Burada bahsedilmesi gereken
ilk durum lineer regülatörlerin giriş ve çıkış gerilim değerlerinin birbirine
yakın olması gerekirken anahtarlamalı regülatörlerde bu giriş ve çıkış
gerilimi arasındaki farkı arttırmak entegrenin çalışmasını rahatlatmaktadır.

Bunu temel olarak açıklamak gerekirse; devrenin giriş ve çıkış gücünü
birbirine eşit düşünmeliyiz. Burada yine **5W**’lık bir güçten bahsedelim. 
**5 volt 1 amper** bir çıkış için devrenin girişini **10 volta** 
yükselttiğinizde girişten çekilecek akım da **0.5 amper**’e düşecektir. 

Böylelikle devrenin giriş akımını düşürerek ısıl kayıpları aşağı çekmiş 
olacaksınız. Burada gerilimin yükselmesiyle birlikte ısının düşmesinin sebebi 
de entegrenin yongasında bulunan güç transistörlerinin anahtarlama 
periyotlarıdır (*Ton ve Toff*).

Devrenin giriş gerilimini ne kadar yükseltirseniz entegrenin içerisinde
oluşacak kare dalganın **Ton** ve **Toff** süresini de o kadar kısaltmış 
olursunuz.

Diğer bir deyişle entegrenin **Ton** ve **Toff** sürelerinin uzaması direkt ısıya
dönüşen bir kayıptır. Transistör üzerinde yaşanan bu kayıpların nedeni de
entegre yongasının içerisinde kullanılan transistörlerin akımlarının sınırılı
ve iç dirençlerinin yüksek olmasıyla alakalıdır.

Sonuç olarak bir DC-DC regülatör devresi tasarımı yapılırken sistem ne olursa
olsun devrenin çıkış gücüne bağlı olarak giriş gerilim ve akımları göz önünde
bulundurulmalıdır. Bunun yanı sıra eğer devrenizin çıkışından **1.5 amper**’in
üzerinde bir akım çekilecekse tasarıma uygun bir soğutucu düşünülmeli ve
testleri yapılmalıdır. 

Bu bilgilerin yanı sıra tasarlanacak en verimli devre bir kontrolör yardımıyla
harici olarak sürülecek bir **mosfet** ve harici diyotlarla yapılacak bir
tasarımdır. Bu tasarımda da akım değeri yüksek ve iç direnci düşük bir **mosfet**
kullanılması halinde ısıl kayıplar minimuma indirilecektir.

Burada datasheet’leri verilen entegrelerin **2 amper**’den sonraki akım
değerlerinde çalışırken hayli zorlandığı gözlemlenmiştir. Uygun olan
kullanımları ise genellikle **1.5 - 2 amper**’i geçmeyecek akımlarda kullanılması
ve olası durumlara karşı anlık yükselmelerin oluşabileceği sistem tasarımları
için ideal entegreler olduğunu söylemek de yanlış olmayacaktır.
