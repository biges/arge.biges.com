# arge.biges.com

Biges Güvenli Hayat Teknolojileri A.Ş. Ar-Ge Merkezi Yazılım Blogu

## Kurulum

Bu uygulama **Ruby 2.7.0** sürümüne ihtiyaç duymaktakdır. Repo’yu clone
ettikten sonra;

```bash
$ git clone git@github.com:biges/arge.biges.com.git
$ cd arge.biges.com/
$ bundle install --path=vendor/bundle
```

ile kurulumu tamamlayabilirsiniz.

## Kullanım

Uygulama içinde bir kısım `Rake` görevleriyle birlikte geliyor:

```bash
$ rake -T

rake build                       # Test için build
rake deploy                      # Deploy
rake post[post_title,post_date]  # Yeni yazı ekle
rake preview                     # Ön izleme / geliştirme sunucusu
```

Eğer kendinize ait özel task eklemek isterseniz, projenin root dizinine
(`Rakefile`*’ın olduğu seviye*) `private.rake` dosyası ekleyip içine
kendi task’lerinizi yazmanız yeterlidir.


Varsayılan işlem `rake preview` yani sadece `rake` komutunu çalıştırmanız
yeterli. Yeni bir **post** yapmak için;

```bash
$ rake post["Merhaba Dünya"]             # ya da
$ rake post["Yeni postum","Feb 8, 2017"] # 8 Şubat 2017’deki bir post için

Yeni post edit edilmek için hazır: source/posts/2018-09-11-merhaba-dunya.md
```

Şimdi `source/posts/2018-09-11-merhaba-dunya.md` dosyasını düzenlemeniz yeterli.

Önizleme için;

```bash
$ rake
```

Şimdi web tarayıcısından `http://127.0.0.1:4567` adresine gidin.

Tüm post’lar `source/posts/` altındadır. Unutulmaması gereken önemli bir husus da,
post dosyasının adı, post tarihi ile doğru orantılıdır. `2017-02-08-yeni-postum.md`
adlı dosya varsa, içindeki tarih mutlaka `date: Feb 2, 2017 HH:MM` gibi olmalıdır.
İçerideki `date:` bilgisi ile dosya adı uyuşmazsa uygulama hata verir.

Eğer post içindeki tarih bilgisini değiştirirseniz mutlaka `source/posts/` altındaki
dosyanın adını da uygun olan `YIL-AY-GÜN-BAŞLIK.md` bilgilerini girmelisiniz.

Eğer post dosyanız `YIL-AY-GÜN-BAŞLIK.md.erb` gibi `.md.erb` ile biterse, post
içinde **embedded ruby** kullanma imkanınız olur yani;

```erb
<% puts "Merhaba" %>
<%
ary = [1, 2, 3]
ary.each do |n|
  concat "#{n}<br/>"
end
%>
```

---

## Front-matter Değişkenleri

Post oluşturunca karşınıza gelen dosyada `yaml` değişkenleri bulunuyor.

```yaml
---
title: "BAŞLIK"
date: Ay Gün, Yıl Saat:Dakika
# tags: tag1,tag2
# subtitle: 
# published: false
# cover: 
author:
  name: "AD-SOYAD"
  email: "E-POSTA"
  link: "http://LINK"
  bio: "1 SATIR BİO"
  twitter: "twitter_username"
---
```

Eğer proje root’una `config_custom.yaml` adında bir dosya oluşturup içini;

```yaml
main_author:
  name: "AD-SOYAD"
  email: "E-POSTA"
  link: "http://LINK"
  bio: "1 SATIR BİO"
  twitter: "twitter_username"
```

kendi bilgilerinizle doldurursanız, her `rake post` işeminde bu dosyadan
bilgiler okunacaktır. Eğer böyle bir dosya bulunmazsa `config.yaml` içinde
ne yazıyorsa o okunacaktır.

**published: false**

Eğer henüz yazıyı tamamlamadıysanız, yani **Draft** şeklinde, yazmaya devam
ediyorsanız `published: false` durumunda yazıyı görüntüler ama build/deploy
edemezsiniz.

**tags:**

Virgül ile ayrılmış şekilde, yazı ile ilgili etiketler: `tags: core,module` gibi...

**cover:**

Yazıya kapak resmi eklemek için kullanabilirsiniz:

```yaml
cover: "resim.jpg"                    # bakılacak yer: 
                                      # source/public/images/posts/resim.jpg

cover: "http://example.com/resim.jpg" # dış dünyadan resim ekleme
```

**READ_MORE**

Özet kısmı için kullanır. Anasayfada listelenirken eğer ilgili post’da `READ_MORE`
görürse sadece oraya kadar olan kısmı yazar. Örnek:

    ---
    title: "Daha detaylı `git-branch`"
    date: 2013-01-06 22:03
    tags: branch
    ---
    Local’deki ve Remote’daki yani varolan tüm **branch**'leri göstermek 
    için; READ_MORE
    
    Yazının detayları ve devamı burada...


---

### Post içine resim ve video eklemek

Eğer yazı içinde tıklayınca büyüyecek bir resim koymak isterseniz;

```html
<div class="full zoomable"><img src="resim.jpg" alt="resim"></div>
```

şeklinde in-line html yazabilirsiniz. Aynı şekilde video için;

```html
<div class="flash-video">
    <div><iframe src="video.mp4" width="100%" height="100%" frameborder="0"></iframe></div>
</div>
```

kullanabilirsiniz.

---

## Markdown Özellikleri

* Otomatik link. `http(s)` ile başlayan metinler otomatik olarak linke dönüşür.
* Üzeri çizgili (*strikethrough*) metin için `~~` arasında metin yazın: `~~üstü çizili~~`
* Üst simge kullanımı (*superscript*) için `^(metin)`: `2^(nd)`
* Altı çizili (*underline*) için `_` arasına metin yazın: `Bu _altı çizili_ ama bu *italic*`
* Belirtmek, vurgulamak (*highlight*) için `==` arasına metin yazın: `Bu ==belirtmeli bir metin==`
* Footnote desteği: `Merhaba [^1]` sonra alt kısımlarda `[^1]: Burası footnote`

### Tablo

Yazı içinde tablo kullanmak için:

    Markdown Tablo:
    
       #    | Açıklama
    --------|--------------
    1       | Örnek satır 1
    2       | Örnek satır 2
    3       | Örnek satır 3
    4       | Örnek satır 4

Eğer hücreleri sağa, ya da ortalı hizalama yapmak isterseniz:

        #   | Açıklama
    -------:|--------------       # -------: sağa
    1       | Örnek satır 1
    
        #   | Açıklama
    :------:|--------------       # :------: ortalı
    1       | Örnek satır 1


---

### Kod bloğu

Pygments kütüphanesi yardımıyla neredeyse tüm programlama dillerini renklendirilmiş
olarak kullanmak mümkün. Desteklenen diller: http://pygments.org/languages/
Yapmanız gereken **\`\`\`dil** şeklinde bloğa başlamanız.

    # Python için
    
    ```python
    def fonk(a):
        print(a)
    ```
    
    # Ruby için
    ```ruby
    [1, 2, 3].each do |n|
      puts "#{n}"
    end

Eğer dil belirtmezseniz [Markdown](https://daringfireball.net/projects/markdown/) 
özelliği olan **4 tane boşluk** ile başlayarak kod bloğu tanımlaması yapabilirsiniz.
Yazı içinde (*inline*) kod parçası kullanmak için, yine: \`kod\` (*backtick’ler arasında*)
şeklinde kullanabilirsiniz.

---

### Mathjax Desteği

Matematiksel ifadeleri web sayfasında göstermek için hazırlanmış [Mathjax](https://www.mathjax.org/)
kütüphanesi yardımıyla post içine matematik ifadeler ekleyebilirsiniz:

    $\bold{t}\ = f(N)$

Yazı içinde (*inline*) ifade kullanmak için;

* `$` ile başlayan biten; ya da
* `\\(` başlayan, `\\)` ile biten;

Büyük ve ortalı şekilde kullanmak için;

* `$$` ile başlayan ve biten; ya da
* `\\[` başlayan, `\\]` ile biten;

kullanabilirsiniz. Daha detaylı açıklama için: http://docs.mathjax.org/en/latest/index.html


---

## `config.yaml` dosyası

Site ile ilgili genel değişklenlerin tanımlandığı dosya. Örnek dosya aşağıdaki
gibidir:

```yaml
site:
  production_url: "https://arge.biges.com"
  title: "Biges Ar-Ge Merkezi"
  subtitle: "Yazılım Geliştirme Blogu"
  logo: "logo.png"
  cover_image: "cover.jpg"
  social:
    google_analytics: "UA-XXXXXXXX"
    disqus: "YYYYY"
  main_author:
    name: "Full Name"
    email: "email@example.com"
    link: "http://example.com"
    bio: "Title"
    twitter: "twitter_username"
```


---


## Deployment

Deployment mekanizması olarak **Github Pages** kullanılıyor. `config.rb` dosyasında
görüldüğü gibi:

```ruby
activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method   = :git
  deploy.remote = "origin"
  deploy.branch = "gh-pages"
end
```

build işleminden sonra `gh-pages` branch’ine push ediliyor. `rake deploy`
ya da duruma göre `bundle exec rake deploy` ile bu işi yapabilirsiniz.


---

## Lisans

Bu proje MIT lisansıyla lisanslanmıştır.
