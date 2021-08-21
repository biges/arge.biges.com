---
title: "Pythonistalar için Nesnenin String() Görüntüsü"
date: Oct 18, 2018 13:21
tags: golang,python+golang
cover: "girl-gopher.png"
author:
  name: "Uğur Özyılmazel"
  email: "ugur.ozyilmazel@biges.com"
  link: "https://github.com/vigo"
  bio: "Retrolog"
  twitter: "vigobronx"
---

`python`’daki `__str__` ve `__repr__` metodlarının `golang` karşılığını
arıyordum. Karşıma `String()` çıktı...

READ_MORE

Örneğin `python`’da `User` adlı bir nesne yazmaya karar verdik:

```python
class User:
    pass

u = User()
print(u) # <__main__.User object at 0x10c92d940>
```

`python` bize nesnenin adını ve hafızadaki adresini döner geriye. Eğer `__repr__`
metodunu düzenlersek;

```python
class User:
    def __repr__(self):
        return '<{name}>'.format(name=self.__class__.__name__)

u = User()
print(u) # <User>
```

şeklinde çıktı alırız.

Benzer işlemi `golang`’da yapmak için bize built-in gelen `Stringer` interface’ini
kullanıyoruz:

```go
type Stringer interface {
   String() string
}
```

Herhangi bir tip, eğer `Stringer` interface’inin `String()` metodunu memnun
ediyorsa ya da bu görevi yerine getiriyorsa (*satisfiy*) `Print` türevleri
tüm fonksiyonlarda aynı `python`’daki `__repr__` işini yapmak mümkün hale
geliyor.

Şimdi `vigo` adında uydurma bir `int` tipi yapıp `Printf` ile çıktıya bakalım:

```go
package main

import "fmt"

type vigo int

func (v vigo) String() string {
	// example purpose only
    switch {
	case v > 20:
		return "20+"
	case v > 10:
		return "10+"
	default:
		return fmt.Sprintf("%d", v)
	}
}

func main() {
	number := vigo(22)
	compareNumber := 21

	fmt.Printf("vigo(12): %v\n", vigo(12)) // vigo(12): 10+
	fmt.Printf("vigo(12): %s\n", vigo(12)) // vigo(12): 10+
	fmt.Printf("vigo(12): %d\n", vigo(12)) // vigo(12): 12
	fmt.Printf("vigo(21): %v\n", vigo(21)) // vigo(21): 20+

	if number > vigo(compareNumber) {
		fmt.Printf("%d is greater than %d\n", number, compareNumber)
		// 22 is greater than 21
	}
}
```

`func (v vigo) String() string` ile printer fonksiyonlarının ihtiyacı olan
metodu tamamlamış oluyoruz. Tanımladığımız `vigo` tipindeki sayı `10` değerinden
sayısal olarak büyük olunca `10+`, `20` değerinden büyük olunca da `20+`
yazdırıyoruz. İç dünyasında `int` değer taşımasına rağmen, yazdırma durumunda
yani `%v` ve `%s` kullanımında bizim `String()` metodu devreye giriyor. `%d`
formatında ise sayısal değeri olan `12`’yi görmeye devam ediyoruz.

`number` değişkeni `vigo` tipinde `22` tutuyor, `compareNumber` değişkeni de
bildiğimiz `int` tipinde `21` tutuyor. `number`’ın `compareNumber`’dan
büyük olup olmadığını test etmek için `compareNumber`’ı `vigo` tipine çeviriyoruz.

Özetle printer formatlama değerleri için farklı gösterimler yapmak mümkün :)

