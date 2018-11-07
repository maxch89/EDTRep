#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
КонецПроцедуры
#КонецОбласти
#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ЗагрузитьСтруктуруФормата(Команда)
	СтруктураПараметров = Новый Структура("парВерсияФормата", Объект.Ссылка);
	ОткрытьФорму("Обработка.ЗагрузкаСтруктурыФормата.Форма", СтруктураПараметров);
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	//TODO: Вставить содержимое обработчика
КонецПроцедуры

#КонецОбласти
