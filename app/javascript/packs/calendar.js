import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list";

document.addEventListener('turbolinks:load', function() {
  // カレンダーの表示エレメントを取得
  var calendarEl = document.getElementById('calendar');
  if (!calendarEl) {
    return; // カレンダー要素が見つからなかった場合は何もしない
  }
  // FullCalendarの初期化
  var calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, listPlugin],
    initialView: 'dayGridMonth',
    locale: "ja",
    events: '/events.json',
    windowResize: function () { 
      if (window.innerWidth < 991.98) {
          calendar.changeView('listMonth'); // スマホサイズでリストビュー
      } else {
          calendar.changeView('dayGridMonth'); // PCサイズで月ごとのグリッドビュー
      }
    },
  });

  calendar.render();
});