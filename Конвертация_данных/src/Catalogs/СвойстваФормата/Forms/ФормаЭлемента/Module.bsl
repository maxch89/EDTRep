
#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	ТипВариант = 2;
	СтатусСвойства = 1;
	Если ЭтаФорма.Параметры.Свойство("ПараметрыДерева") Тогда
		ПараметрыДерева = ЭтаФорма.Параметры.ПараметрыДерева;
		Если ПараметрыДерева.Свойство("ОбъектКопирования") Тогда
			ОбъектКопирования = ЭтаФорма.Параметры.ПараметрыДерева.ОбъектКопирования;
			ЗаполнитьЗначенияСвойств(Объект, ОбъектКопирования,"Владелец, Наименование, Тип, ОписаниеТекст, ОбъектХранительСвойств, Обязательное, ТипОбщегоСвойства");
			Для Каждого СтрТаб Из ОбъектКопирования.Состав Цикл
				НовСтр = Объект.Состав.Добавить();
				НовСтр.ТипФормата = СтрТаб.ТипФормата;
			КонецЦикла;
			ТекстОписания = ОбъектКопирования.Описание.Получить();
		Иначе
			Если ПараметрыДерева.Свойство("ОбъектФормата") Тогда
				Объект.Владелец = ПараметрыДерева.ОбъектФормата;
			КонецЕсли;
		КонецЕсли;
		Объект.Порядок = ПараметрыДерева.ПредыдущееСвойство.Порядок + 1;
	КонецЕсли;

	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ТекстОписания = Объект.Ссылка.Описание.Получить();
		СсылкаНаОбщееСвойствоОбъект = Справочники.СвойстваФормата.ОпределитьОбщийРеквизит(Объект.Ссылка);
		Если ЗначениеЗаполнено(СсылкаНаОбщееСвойствоОбъект) Тогда
			Если ТипЗнч(СсылкаНаОбщееСвойствоОбъект) = Тип("СправочникСсылка.СвойстваФормата") Тогда
				СвойствоФорматаОбщее = СсылкаНаОбщееСвойствоОбъект;
				ТипОбщегоРеквизита = СвойствоФорматаОбщее.Владелец.ТипОбщегоРеквизита;
			Иначе
				ОбъектФорматаОбщий = СсылкаНаОбщееСвойствоОбъект;
				ТипОбщегоРеквизита = ОбъектФорматаОбщий.ТипОбщегоРеквизита;
			КонецЕсли;
			Если ТипОбщегоРеквизита = Перечисления.ТипыОбщихРеквизитов.ГруппаОбщихСвойств Тогда
				СтатусСвойства = 3;
			ИначеЕсли ТипОбщегоРеквизита = Перечисления.ТипыОбщихРеквизитов.ОбщаяТабличнаяЧасть Тогда
				СтатусСвойства = 2;
			Иначе
				СтатусСвойства = 1;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	ВерсияФормата = Объект.Владелец.Владелец;
	ЗаполнитьСписокВыбораКлючевыеСвойства();
	УстановитьПараметрыВыбораПоВерсииФормата();
	ТипВариант = 0;
	ИмяПоляСписка = "";
	СписокТипов = Неопределено;
	Если Объект.СоставнойТип Тогда
		Для Каждого СтрТаб Из Объект.Состав Цикл
			ТекТипФормата = СокрЛП(СтрТаб.ТипФормата);
			Если ТипВариант = 0 Тогда
				Если ЗначениеЗаполнено(Справочники.ТипыФормата.НайтиПоНаименованию(ТекТипФормата,,,ВерсияФормата)) Тогда
					ТипВариант = 1;
					ИмяПоляСписка = "ТипФорматаСписокЗначение";
					СписокТипов = ТипФорматаСписок;
				ИначеЕсли ЗначениеЗаполнено(Справочники.ОбъектыФормата.НайтиПоНаименованию(ТекТипФормата,,,ВерсияФормата)) Тогда
					ТипВариант = 3;
					ИмяПоляСписка = "ТипКлючевоеСвойствоСписокЗначение";
					СписокТипов = ТипКлючевоеСвойствоСписок;
				КонецЕсли;
			КонецЕсли;
			Если ИмяПоляСписка <> "" Тогда
				Элементы[ИмяПоляСписка].СписокВыбора.Добавить(СокрЛП(ТекТипФормата));
				СписокТипов.Добавить(?(ТипВариант = 1,
							Справочники.ТипыФормата.НайтиПоНаименованию(ТекТипФормата,,,ВерсияФормата),ТекТипФормата));
			КонецЕсли;
		КонецЦикла;
	Иначе
		ТекТипФормата = СокрЛП(Объект.Тип);
		ТипФорматаСсылка = Справочники.ТипыФормата.НайтиПоНаименованию(ТекТипФормата,,,ВерсияФормата);
		Если ЗначениеЗаполнено(ТипФорматаСсылка) Тогда
			ТипВариант = 1;
			Элементы.ТипФорматаСсылка.СписокВыбора.Добавить(ТипФорматаСсылка);
		ИначеЕсли ЗначениеЗаполнено(Справочники.ОбъектыФормата.НайтиПоНаименованию(ТекТипФормата,,,ВерсияФормата)) Тогда
			ТипКлючевоеСвойство = СокрЛП(ТекТипФормата);
			ТипВариант = 3;
			Элементы.ТипКлючевоеСвойство.СписокВыбора.Добавить(ТекТипФормата);
		Иначе
			ТипВариант = 2;
			КонвертацияДанныхXDTOСервер.РазложитьПредставлениеПростогоТипа(НРег(ТекТипФормата),ТипПростогоТипа, 
										ДлинаПростогоТипа, ТочностьПростогоТипа, МинимальнаяДлинаСтроки, НеограниченнаяДлина);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СамостоятельноеСвойство = (СтатусСвойства = 1);
	Элементы.ОткрытьОбщееСвойство.Видимость = НЕ СамостоятельноеСвойство;
	Элементы.ГруппаСтраницаОписание.Доступность = СамостоятельноеСвойство;
	Элементы.Порядок.Доступность = СамостоятельноеСвойство;
	Элементы.Обязательное.Доступность = СамостоятельноеСвойство;
	УстановитьДоступностьЭлементовНастройкиТипа();
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	ХранилищеФорматированногоДокумента = Новый ХранилищеЗначения(ТекстОписания);
	ТекущийОбъект.Описание = ХранилищеФорматированногоДокумента;
	Объект.Состав.Очистить();
	Если ТипВариант = 1 Тогда
		Если Объект.СоставнойТип Тогда
			Для Каждого СтрТаб Из ТипФорматаСписок Цикл
				Если ЗначениеЗаполнено(СтрТаб.Значение) Тогда
					НовСтр = Объект.Состав.Добавить();
					НовСтр.ТипФормата = СтрТаб.Значение;
				КонецЕсли;
			КонецЦикла;
		ИначеЕсли ЗначениеЗаполнено(ТипФорматаСсылка) Тогда
			Объект.Тип = ТипФорматаСсылка;
		КонецЕсли;
	ИначеЕсли ТипВариант = 3 Тогда
		Если Объект.СоставнойТип Тогда
			Для Каждого СтрТаб Из ТипКлючевоеСвойствоСписок Цикл
				Если ЗначениеЗаполнено(СтрТаб.Значение) Тогда
					НовСтр = Объект.Состав.Добавить();
					НовСтр.ТипФормата = СтрТаб.Значение;
				КонецЕсли;
			КонецЦикла;
		ИначеЕсли ЗначениеЗаполнено(ТипКлючевоеСвойство) Тогда
			Объект.Тип = ТипКлючевоеСвойство;
		КонецЕсли;
	КонецЕсли;
	Если НЕ Объект.СоставнойТип Тогда
		НовСтр = Объект.Состав.Добавить();
		НовСтр.ТипФормата = Объект.Тип;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	Если ТекущийОбъект.Родитель.ТипОбщегоСвойства = Перечисления.ТипыОбщихРеквизитов.КлючевыеСвойства Тогда
		// При необходимости синхронное изменение свойства объекта КлючевыеСвойства
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	ОбъектКС.Ссылка КАК ОбъектКС,
		|	СвойстваКлючевые.Ссылка КАК СвойствоКС,
		|	СвойстваКлючевые.Тип,
		|	СвойстваКлючевые.Обязательное,
		|	СвойстваКлючевые.Порядок
		|ИЗ Справочник.ОбъектыФормата КАК ОбъектКС
		|	ЛЕВОЕ СОЕДИНЕНИЕ Справочник.СвойстваФормата КАК СвойстваКлючевые
		|	ПО СвойстваКлючевые.Владелец = ОбъектКС.Ссылка
		|		И СвойстваКлючевые.Наименование = &НаименованиеСвойстваКС
		|		И СвойстваКлючевые.ПометкаУдаления = ЛОЖЬ
		|ГДЕ ОбъектКС.Владелец = &ВерсияФормата
		|	И ОбъектКС.ТипОбщегоРеквизита = ЗНАЧЕНИЕ(Перечисление.ТипыОбщихРеквизитов.КлючевыеСвойства)
		|	И ОбъектКС.Наименование = &НаименованиеОбъектаКС
		|	И ОбъектКС.ПометкаУдаления = ЛОЖЬ";
		Запрос.УстановитьПараметр("ВерсияФормата", ТекущийОбъект.Владелец.Владелец);
		Запрос.УстановитьПараметр("НаименованиеОбъектаКС", ТекущийОбъект.Родитель.ОбъектХранительСвойств);
		Запрос.УстановитьПараметр("НаименованиеСвойстваКС", ТекущийОбъект.Наименование);
		Выборка = Запрос.Выполнить().Выбрать();
		КлючевоеСвойствоОбъект = Неопределено;
		Если Выборка.Следующий() Тогда
			Если ЗначениеЗаполнено(Выборка.СвойствоКС) Тогда
				Если НЕ (ТекущийОбъект.Тип = Выборка.Тип
					И ТекущийОбъект.Обязательное = Выборка.Обязательное
					И ТекущийОбъект.Порядок = Выборка.Порядок) Тогда
					КлючевоеСвойствоОбъект = Выборка.СвойствоКС.ПолучитьОбъект();
				КонецЕсли
			Иначе
				КлючевоеСвойствоОбъект = Справочники.СвойстваФормата.СоздатьЭлемент();
				КлючевоеСвойствоОбъект.Владелец = Выборка.ОбъектКС;
				КлючевоеСвойствоОбъект.Наименование = ТекущийОбъект.Наименование;
			КонецЕсли;
			Если КлючевоеСвойствоОбъект <> Неопределено Тогда
				ЗаполнитьЗначенияСвойств(КлючевоеСвойствоОбъект, ТекущийОбъект,"Тип, Обязательное, Порядок");
				КлючевоеСвойствоОбъект.Записать();
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	Если ТекущийОбъект.Порядок > 0 Тогда
		// Выстраивание порядка после предыдущего свойства
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	Ссылка,
		|	Порядок
		|ИЗ Справочник.СвойстваФормата
		|ГДЕ Владелец = &Владелец И НЕ ПометкаУдаления И Порядок >= &ПорядокНач И Ссылка <> &ТекСсылка
		|УПОРЯДОЧИТЬ ПО Порядок ВОЗР";
		Запрос.УстановитьПараметр("Владелец", ТекущийОбъект.Владелец);
		Запрос.УстановитьПараметр("ПорядокНач", ТекущийОбъект.Порядок);
		Запрос.УстановитьПараметр("ТекСсылка", ТекущийОбъект.Ссылка);
		Результат = Запрос.Выполнить();
		Если Результат.Пустой() Тогда
			// Нет свойств для переупорядочивания
			Возврат;
		КонецЕсли;
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		Если Выборка.Порядок > ТекущийОбъект.Порядок Тогда
			// Не требуется переупорядочивание
			Возврат;
		КонецЕсли;
		Выборка.Сбросить();
		ТекПорядок = ТекущийОбъект.Порядок + 1;
		Пока Выборка.Следующий() Цикл
			Если Выборка.Порядок >= ТекПорядок Тогда
				ТекПорядок = ТекПорядок + 1;
				Продолжить;
			КонецЕсли;
			СвойствоОбъект = Выборка.Ссылка.ПолучитьОбъект();
			СвойствоОбъект.Порядок = ТекПорядок;
			СвойствоОбъект.Записать();
			ТекПорядок = ТекПорядок + 1;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры
#КонецОбласти
#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура ТипВариантПриИзменении(Элемент)
	Объект.Тип = "";
	УстановитьДоступностьЭлементовНастройкиТипа();
КонецПроцедуры

&НаКлиенте
Процедура ТипПростогоТипаПриИзменении(Элемент)
	Если НЕ (ТипПростогоТипа = "Строка" ИЛИ ТипПростогоТипа = "Число") Тогда
		ДлинаБазовогоТипа = 0;
	КонецЕсли;
	Если ТипПростогоТипа <> "Строка" Тогда
		НеограниченнаяДлина = Ложь;
		МинимальнаяДлинаСтроки = 0;
	КонецЕсли;
	Если ТипПростогоТипа <> "Число" Тогда
		ТочностьБазовогоТипа = 0;
	КонецЕсли;
	ОбновитьПредставлениеТипа();
	УстановитьДоступностьЭлементовНастройкиТипа();
КонецПроцедуры

&НаКлиенте
Процедура ДлинаПростогоТипаПриИзменении(Элемент)
	ОбновитьПредставлениеТипа();
КонецПроцедуры

&НаКлиенте
Процедура ТочностьПростогоТипаПриИзменении(Элемент)
	ОбновитьПредставлениеТипа();
КонецПроцедуры

&НаКлиенте
Процедура НеограниченнаяДлинаПриИзменении(Элемент)
	Если НеограниченнаяДлина Тогда
		ДлинаБазовогоТипа = 0;
		МинимальнаяДлинаСтроки = 0;
	КонецЕсли;
	ОбновитьПредставлениеТипа();
КонецПроцедуры

&НаКлиенте
Процедура ВладелецПриИзменении(Элемент)
	ВладелецПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ВладелецПриИзмененииНаСервере()
	Если Объект.Владелец.Владелец <> ВерсияФормата Тогда
		ТипФорматаСсылка = Справочники.ТипыФормата.ПустаяСсылка();
		ВерсияФормата = Объект.Владелец.Владелец;
		ЗаполнитьСписокВыбораКлючевыеСвойства();
		УстановитьПараметрыВыбораПоВерсииФормата();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТипФорматаСсылкаПриИзменении(Элемент)
	ТипФорматаСсылкаПриИзмененииНаСервере();
КонецПроцедуры

&НаСервере
Процедура ТипФорматаСсылкаПриИзмененииНаСервере()
	Объект.Тип = ТипФорматаСсылка.Наименование;
КонецПроцедуры

&НаКлиенте
Процедура ТипКлючевоеСвойствоПриИзменении(Элемент)
	Объект.Тип = ТипКлючевоеСвойство;
КонецПроцедуры

&НаКлиенте
Процедура МножественныйСоставПриИзменении(Элемент)
	Если ТипВариант = 1 Тогда
		Элементы.ТипФормат.ТекущаяСтраница = ?(Объект.СоставнойТип, Элементы.ФорматМножественный, Элементы.ФорматОдиночный);
		Если НЕ Объект.СоставнойТип И ТипФорматаСписок.Количество() > 0 Тогда
			ТипФорматаСсылка = ТипФорматаСписок[0].Значение;
			ТипФорматаСписок.Очистить();
			Объект.Тип = СокрЛП(ТипФорматаСсылка);
		ИначеЕсли Объект.СоставнойТип И ЗначениеЗаполнено(ТипФорматаСсылка) Тогда
			ТипФорматаСписок.Добавить(ТипФорматаСсылка);
		КонецЕсли;
	ИначеЕсли ТипВариант = 3 Тогда
		Элементы.ТипКС.ТекущаяСтраница = ?(Объект.СоставнойТип, Элементы.КСМножественный, Элементы.КСОдиночный);
		Если НЕ Объект.СоставнойТип И ТипКлючевоеСвойствоСписок.Количество() > 0 Тогда
			ТипКлючевоеСвойство = ТипКлючевоеСвойствоСписок[0].Значение;
			ТипКлючевоеСвойствоСписок.Очистить();
			Объект.Тип = ТипКлючевоеСвойство;
		ИначеЕсли Объект.СоставнойТип И ЗначениеЗаполнено(ТипКлючевоеСвойство) Тогда
			ТипКлючевоеСвойствоСписок.Добавить(ТипКлючевоеСвойство);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ОткрытьОбщееСвойство(Команда)
	Если НЕ (ЗначениеЗаполнено(СвойствоФорматаОбщее) ИЛИ ЗначениеЗаполнено(ОбъектФорматаОбщий)) Тогда
		Возврат;
	КонецЕсли;
	Если ЗначениеЗаполнено(СвойствоФорматаОбщее) Тогда
		ОткрытьФорму("Справочник.СвойстваФормата.Форма.ФормаЭлемента", Новый Структура("Ключ", СвойствоФорматаОбщее));
	Иначе
		ОткрытьФорму("Справочник.ОбъектыФормата.Форма.ФормаЭлемента", Новый Структура("Ключ", ОбъектФорматаОбщий));
	КонецЕсли;
КонецПроцедуры
#КонецОбласти
#Область СлужебныеПроцедурыИФункции
&НаКлиенте
Процедура УстановитьДоступностьЭлементовНастройкиТипа()
	Элементы.ГруппаТипИзФормата.Видимость = (ТипВариант = 1);
	Элементы.ГруппаТипПростой.Видимость = (ТипВариант = 2);
	Элементы.ГруппаКлючевоеСвойство.Видимость = (ТипВариант = 3);
	СамостоятельноеСвойство = (СтатусСвойства = 1);
	Если ТипВариант = 1 Тогда
		Элементы.ГруппаТипИзФормата.Доступность = СамостоятельноеСвойство;
		Элементы.ТипФормат.ТекущаяСтраница = ?(Объект.СоставнойТип, Элементы.ФорматМножественный, Элементы.ФорматОдиночный);
	ИначеЕсли ТипВариант = 2 Тогда
		Элементы.Тип.Доступность = Ложь;
		Элементы.ТипыПростые.Видимость = Ложь;
		Если ТипПростогоТипа = "Число" Тогда
			Элементы.ТипыПростые.Видимость = Истина;
			Элементы.ТипыПростые.ТекущаяСтраница = Элементы.ТипЧисло;
			Элементы.ТипЧисло.Доступность = СамостоятельноеСвойство;
		ИначеЕсли ТипПростогоТипа = "Строка" Тогда
			Элементы.ТипыПростые.Видимость = Истина;
			Элементы.ТипыПростые.ТекущаяСтраница = Элементы.ТипСтрока;
			Элементы.ТипСтрока.Доступность = СамостоятельноеСвойство;
		ИначеЕсли ТипПростогоТипа = "Прочее" Тогда
			Элементы.Тип.Доступность = Истина;
		КонецЕсли;
	ИначеЕсли ТипВариант = 3 Тогда
		Элементы.ГруппаКлючевоеСвойство.Доступность = СамостоятельноеСвойство;
		Элементы.ТипКС.ТекущаяСтраница = ?(Объект.СоставнойТип, Элементы.КСМножественный, Элементы.КСОдиночный);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьПредставлениеТипа()
	Объект.Тип = КонвертацияДанныхXDTOКлиент.СоставляющиеПростогоТипаВСтроку(ТипПростогоТипа, ДлинаПростогоТипа, ТочностьПростогоТипа, МинимальнаяДлинаСтроки);
	ЭтаФорма.Модифицированность = Истина;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокВыбораКлючевыеСвойства()
	ТипКлючевоеСвойство = "";
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Наименование,
	|	ВЫБОР КОГДА Наименование = &ТекущееНаименованиеТипа ТОГДА
	|		ИСТИНА
	|	ИНАЧЕ ЛОЖЬ КОНЕЦ КАК ЭтоТекущийТип
	|ИЗ Справочник.ОбъектыФормата
	|ГДЕ Владелец = &ВерсияФормата И ПометкаУдаления = ЛОЖЬ
	|	И ТипОбщегоРеквизита = ЗНАЧЕНИЕ(Перечисление.ТипыОбщихРеквизитов.КлючевыеСвойства)
	|УПОРЯДОЧИТЬ ПО Наименование";
	Запрос.УстановитьПараметр("ВерсияФормата", ВерсияФормата);
	Запрос.УстановитьПараметр("ТекущееНаименованиеТипа", Объект.Тип);
	Элементы.ТипКлючевоеСвойство.СписокВыбора.Очистить();
	Элементы.ТипКлючевоеСвойствоСписокЗначение.СписокВыбора.Очистить();
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		Элементы.ТипКлючевоеСвойство.СписокВыбора.Добавить(Выборка.Наименование);
		Элементы.ТипКлючевоеСвойствоСписокЗначение.СписокВыбора.Добавить(Выборка.Наименование);
		Если Выборка.ЭтоТекущийТип И ЗначениеЗаполнено(Объект.Тип) Тогда
			ТипКлючевоеСвойство = Выборка.Наименование;
			ТипВариант = 3;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыВыбораПоВерсииФормата()
	ПараметрВыбораВерсияФормата = Новый ПараметрВыбора("Отбор.Владелец", ВерсияФормата);
	ВремМассив = Новый Массив();
	ВремМассив.Добавить(ПараметрВыбораВерсияФормата);
	ПараметрыВыбораВерсияФормата = Новый ФиксированныйМассив(ВремМассив);
	Элементы.ТипФорматаСписокЗначение.ПараметрыВыбора = ПараметрыВыбораВерсияФормата;
КонецПроцедуры

#КонецОбласти