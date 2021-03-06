&НаКлиенте
Перем ОбновитьИнтерфейс;

#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ИспользоватьПроектированиеФормата = НаборКонстант.ИспользоватьПроектированиеФормата;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры
#КонецОбласти
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НаборКонстантИспользоватьПроектированиеФорматаПриИзменении(Элемент)
	ПриИзмененииРеквизитаСервер();
	
	#Если НЕ ВебКлиент Тогда
	ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 1, Истина);
	ОбновитьИнтерфейс = Истина;
	#КонецЕсли
КонецПроцедуры
#КонецОбласти


#Область СлужебныеПроцедурыИФункции
&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы() Экспорт
	
	#Если НЕ ВебКлиент Тогда
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбновитьИнтерфейс();
	КонецЕсли;
	#КонецЕсли
	
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииРеквизитаСервер()
	
	КонстантаМенеджер = Константы.ИспользоватьПроектированиеФормата;
	КонстантаЗначение = ИспользоватьПроектированиеФормата;
	
	Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
		КонстантаМенеджер.Установить(КонстантаЗначение);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
