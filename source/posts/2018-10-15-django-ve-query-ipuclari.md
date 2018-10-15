---
title: "Django ve Query İpuçları"
date: Oct 15, 2018 10:00
# tags: tag1,tag2
# subtitle: 
# published: false
# cover: 
author:
  name: Erdi Mollahüseyinoğlu
  email: erdi@biges.com
  link: https://arge.biges.com
  bio: Yazılım Geliştiricisi
---

Üzerinde çalıştığımız Django projesinde artık sıra iyileştirmeler kısmına gelmişti.
Kullandığımız veritabanı PostgreSQL’di ve Django View’larındaki sorgu miktarlarını
incelemeye başlamıştım.

READ_MORE

[Django Debug Toolbar][01]’da, `ProductListView`’un render ettiği html’e
bakarken **80** tane tekrar sorgu yapıldığını gördüm. `Product` modelim
aşağıdaki gibiydi;

```python
class Product(models.Model):
	category = models.ForeignKey(
		to='ProductCategory',
		related_name='products',
		on_delete=models.CASCADE,
		verbose_name=_('category'),
	)
	product_filter_feature = models.ManyToManyField(
		to='ProductFilterFeature',
		related_name='products'
	)
	stock_code = models.CharField(
		max_length=255,
		verbose_name=_('stock code'),
	)
```

Modelin içinden `ForeignKey` verdiğim `ProductCategory` modeliyse aşağıdaki
gibiydi;

```python
class ProductCategory(models.Model):
	name = models.CharField(
		max_length=255,
		verbose_name=_('name'),
	)
```

Son olarak `ManyToManyField` verdiğim `ProductFilterFeature` modeli ise;

```python
class ProductFilterFeature(models.Model): 
	name = models.CharField(
		max_length=255,
		verbose_name=_('name'),
	) 
```

şeklindeydi. Veriyi gösteren html şablonda aşağıdaki gibiydi;

```django
<ul>
{% for product in product_list %}
	<p>{{ product.category.name }}</p>
	
    {% for feature in product.product_filter_feature.all %}
		<span>{{ feature.name }}</span>
	{% endfor %}
{% endfor %}
</ul>
```

Tekrar eden sorguların `related` sorguları yaptığım yerde olduğunu farkettim.
Html şablonda `product.category.name` ve `product.product_filter_feature.all`
buna sebep oluyordu. Hemen [Django’nun QuerySet API][02] dökümanına baktım.

`ForeignKey` ilişkisindeki takip etme yani `product.category.name` gibi
sorgulama yapmaya imkan veren durumlar bize fazla sorgu olarak dönüyor. Bunu
çözmek için Django bize `select_related` [metodunu][03] öneriyor. Bu sayede veritabanı
tarafından ilişkili tabloları birbirleriyle `JOIN` yapmayı sağlıyor. Bu method 
parametre olarak sadece alan adı alıyor ve klasik **dunder lookup** yani;
`field__field__field` şeklinde kullanmayı sağlıyor. `ForeignKey` ve `OneToOne`
alanlar için çok kullanışlı.


`ProductListView`’da hemen aşağıdaki düzenlemeyi yaptım;

```python
class ProductListView(ListView):
    def get_queryset(self):
        return Product.objects.select_related('category)
```

Sorgu tekrarı sayısı düşmüştü ama halen istediğim gibi olmamıştı. Debug Toolbar
beni halen uyarıyordu. Bu durumda Django dokümantasyonuna geri döndüm ve asıl
sorunun `ManyToManyField` alanından kaynaklandığını anladım. Django bu tür sorunlar
için `prefetch_related` metodu yapmış. Argüman olarak *lookup* yani sorgulanacakları
alıyor. `select_related` ile farkı şu, `JOIN` operasyonunu `python` katmanında
yapıyor ve her ilişkili sorgu için ayrı ayrı işlem yapıyor. Bu sayede `select_related`’ın
yapamayacağı [işleri de yapıyor][04]. Özellikle `ManyToMany` ve `ManyToOne` için
ideal.

Hemen `product_filter_feature` (*ManyToMany olduğu için*) ile ilgili işleri de
`get_queryset`’e ekliyorum:

```python
class ProductListView(ListView):
    def get_queryset(self):
        return Product.objects\
            .select_related('category)\
            .prefetch_related('product_filter_feature')
```

`.prefetch_related('product_filter_feature')` aslında içeride `product_filter_feature.all()`
yapıyor ve birleştirme işlerini `python` katmanında yapıp kendince bir **caching**
yapıyor. Bu sayede aynı sorgu tekrar edilmiyor. 

Şimdi tekrar baktığımda, başlangıçta 80 tane tekrar eden sorgu varken şimdi
sayfanın oluşturulması sonucunda toplam sorgu sayısı **12**’ye düştü.

[01]: https://github.com/jazzband/django-debug-toolbar "Django Debug Toolbar"
[02]: https://docs.djangoproject.com/en/2.1/ref/models/querysets/ "Django QuerySet API Doc"
[03]: https://docs.djangoproject.com/en/2.1/ref/models/querysets/#select-related "Django QuerySet - select_related"
[04]: https://docs.djangoproject.com/en/2.1/ref/models/querysets/#prefetch-related "Django QuerySet - prefetch_related"
