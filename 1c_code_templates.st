﻿{1,
{5,
{"Общее",1,0,"",""},
{6,
{"Области",1,0,"",""},
{0,
{"Общий модуль",0,1,"Обл[асти общего модуль]","
#Область ПрограммныйИнтерфейс
// Код процедур и функций
#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
// Код процедур и функций
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// Код процедур и функций
#КонецОбласти"}
},
{0,
{"Модуль объекта",0,1,"Обл[асти модуля объектов]","
#Область ПрограммныйИнтерфейс
// Код процедур и функций
#КонецОбласти

#Область ОбработчикиСобытий
// Код процедур и функций
#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс
// Код процедур и функций
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// Код процедур и функций
#КонецОбласти"}
},
{0,
{"Модуль формы",0,1,"Обл[асти модуля формы]","
#Область ОбработчикиСобытийФормы
// Код процедур и функций
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
// Код процедур и функций
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы<ИмяТаблицыФормы>
// Код процедур и функций
#КонецОбласти

#Область ОбработчикиКомандФормы
// Код процедур и функций
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// Код процедур и функций
#КонецОбласти"}
},
{0,
{"Модуль команды",0,1,"Обл[асти модуля команды]","
#Область ОбработчикиСобытий
// Код процедур и функций
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// Код процедур и функций
#КонецОбласти"}
},
{0,
{"Описание переменных",0,1,"Обл[асть описания переменных]","#Область ОписаниеПеременных

#КонецОбласти"}
},
{0,
{"Инициализация",0,1,"Обл[асть инициализации]","
#Область Инициализация

#КонецОбласти"}
}
},
{1,
{"Пакет отображаемых документов",1,0,"",""},
{0,
{"Сформировать книгу excel",0,0,"","// Сохраняет табличные документы в файл Excel
//
// Параметры:
//  ИмяФайла  - Строка - указывающая имя сохраняемого файла.
//				Можно включить полный путь;
//                 <продолжение описания параметра>
//  Листы  - Массив - массив структу (АдресВХранилище - адрес табличного документа во временном хранилище, Имя - имя листа).
//
Процедура СформироватьКнигуExcel(ИмяФайла, Листы)
 
	Пакет = Новый ПакетОтображаемыхДокументов;
	
	Для каждого ОчереднойЛист Из Листы Цикл
		ЭлементПакета = Пакет.Состав.Добавить();
		ЭлементПакета.Наименование = ОчереднойЛист.Имя;
		ЭлементПакета.Данные	   = ОчереднойЛист.АдресВХранилище;
	КонецЦикла;
	
	Попытка
		Пакет.Записать(ИмяФайла, ТипФайлаПакетаОтображаемыхДокументов.XLS);
	Исключение
		// Вывести описание ошибки
	КонецПопытки;
 
КонецПроцедуры
"}
}
},
{1,
{"JSON",1,0,"",""},
{0,
{"СериализоватьСтруктуруВJSON",0,0,"","ЗаписьJSON = Новый ЗаписьJSON;
ЗаписьJSON.УстановитьСтроку();
ЗаписатьJSON(ЗаписьJSON, Структура);
Результат = ЗаписьJSON.Закрыть();
"}
}
},
{1,
{"Регистры сведений",1,0,"",""},
{0,
{"ОчиститьНаборЗаписей",0,0,"","	НаборЗаписей = РегистрыСведений.ИмяРегистраСведений.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Измерение1.Установить(ЗначениеИзмерения1);
	НаборЗаписей.Отбор.Измерение2.Установить(ЗначениеИзмерения2);
	НаборЗаписей.Записать();"}
}
},
{2,
{"MSMQ",1,0,"",""},
{0,
{"ПолучитьСообщениеИзОчереди",0,0,"","
	MQ_DENY_NONE = 0; MQ_RECEIVE_ACCESS = 1; MQ_NO_TRANSACTION = 0;

	qinfo = Новый COMОбъект(""MSMQ.MSMQQueueInfo"");
	qinfo.FormatName = ""DIRECT=OS:""+""ИмяКомпьютера\PRIVATE$\ИмяВходящейОчередиДля1С"";
	MSMQQueue = qinfo.Open(MQ_RECEIVE_ACCESS, MQ_DENY_NONE);
	СообщениеВрем = Новый COMОбъект(""MSMQ.MSMQMessage""); // Временный объект необходим для поиска последнего сообщения

	счетчик = 0;
	СообщениеВрем = MSMQQueue.Peek(0, , 0, 0);
	СообщениеВрем = MSMQQueue.PeekCurrent(0,,0,0);

	// Если получили сообщение, разбираем его и передаем данные обмена дальше для обработки
	Пока (СообщениеВрем <> Неопределено) Цикл

		счетчик 	= счетчик+1;
		Сообщение 	= СообщениеВрем;
		Успешно 	= ПрочитатьНовоеСообщение(Сообщение.Label, Сообщение.Body);

		Если Успешно Тогда
			// удалить текущее сообщение как успешное
			СообщениеВрем = MSMQQueue.ReceiveCurrent(MQ_NO_TRANSACTION, , , 0);
			// происходит смещение курсора - нормально
			СообщениеВрем = MSMQQueue.ReceiveByLookupId(Сообщение.LookupId, MQ_NO_TRANSACTION, , , 0);
		КонецЕсли;

		СообщениеВрем = MSMQQueue.PeekNext(0,,0,0);
	КонецЦикла;

	MSMQQueue.Close();
"}
},
{0,
{"ПоместитьСообщениеВОчередь",0,0,"","	
	СтрокаXML = ""Помещаемые данные"";
	MQ_SEND_ACCESS 	= 2;
	MQ_DENY_NONE 	= 0;
	qinfo = Новый COMОбъект(""MSMQ.MSMQQueueInfo"");

	// Формируем путь к очереди на удаленном компьютере, Вариант по имени
	ОчередьОбменаMSMQ 	= ""ИмяУдаленногоЛокальногоКомпьютера\PRIVATE$\ИмяИсходящейОчередиИз1С"";
	qinfo.FormatName 	= ""DIRECT=OS:""+ОчередьОбменаMSMQ; // по IP строка вида: DIRECT=TCP:192.168.0.1\PRIVATE$\ИмяОчереди
	Очередь = qinfo.Open(MQ_SEND_ACCESS, MQ_DENY_NONE);

	Сообщение = Новый COMОбъект(""MSMQ.MSMQMessage"");	
	Сообщение.Label = ""Message"" + СокрЛП(УзелИсточник.Код) + ""_"" + СокрЛП(УзелПриемник.Код) + СокрЛП(Постфикс) + "".xml"";
	Сообщение.Body 	= СтрокаXML;

	Сообщение.Send(Очередь); // Помещаем сообщение в очередь

	Очередь.Close();
"}
}
}
}
}