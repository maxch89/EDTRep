#Область РабочиеМеста

// Процедура-обработчик события "ПередЗаписью" ссылочных типов данных (кроме документов). 
// Для механизма регистрации объектов на узлах.
//
// Параметры:
//  ИмяПланаОбмена - Строка, имя плана обмена, для которого выполняется механизм регистрации.
//  Источник       - источник события, кроме типа ДокументОбъект.
//  Отказ          - Булево, флаг отказа от выполнения обработчика.
// 
Процедура РабочиеМестаПередЗаписью(Источник, Отказ) Экспорт
	
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередЗаписью("РабочиеМеста", Источник, Отказ);
	
КонецПроцедуры

// Процедура-обработчик события "ПередУдалением" ссылочных типов данных.
// Для механизма регистрации объектов на узлах.
//
// Параметры:
//  ИмяПланаОбмена - Строка, имя плана обмена, для которого выполняется механизм регистрации.
//  Источник       - источник события.
//  Отказ          - Булево, флаг отказа от выполнения обработчика.
// 
Процедура РабочиеМестаПередУдалением(Источник, Отказ) Экспорт
	
	ОбменДаннымиСобытия.МеханизмРегистрацииОбъектовПередУдалением("РабочиеМеста", Источник, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область ОбщиеДляВсехПлановОбменаПроцедурыФункции

Функция ОпределитьМассивПолучателей (Выгрузка, Получатели) Экспорт
	
	МассивИсключаемыхУзлов = Новый Массив;

	Для Каждого Узел Из Получатели Цикл
		Если Не Выгрузка И Узел.ПравилаОтправкиДокументов = "ИнтерактивнаяСинхронизация"
			Или Узел.ПравилаОтправкиДокументов = "НеСинхронизировать" Тогда
			МассивИсключаемыхУзлов.Добавить(Узел);
		КонецЕсли;
	КонецЦикла;

	Получатели = ОбщегоНазначенияКлиентСервер.СократитьМассив(Получатели, МассивИсключаемыхУзлов);

	Возврат Получатели;

КонецФункции

Процедура РегистрацияИзмененияДляНачальнойВыгрузки(Получатель, СтандартнаяОбработка, Отбор) Экспорт
	
	
КонецПроцедуры

#КонецОбласти
