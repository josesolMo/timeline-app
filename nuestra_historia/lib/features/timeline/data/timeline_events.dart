import '../models/timeline_event.dart';

const timelineEvents = <TimelineEvent>[
  TimelineEvent(
    '21/08/2023',
    'El primer mensaje',
    'El inicio de nuestra aventra juntos, muchas cosas han cambiado desde entonces :)',
    media: [
      TimelineMedia.image('assets/images/chat1.jpeg'),
      TimelineMedia.video('assets/videos/vid1.mp4'),
    ],
    music: TimelineMusic(
      coverAsset: 'assets/images/dolly_caratula.webp',
      audioAsset: 'assets/audio/islands.mp3',
      title: 'Islands in the Stream',
    ),
  ),
  TimelineEvent(
    '17/08/2024',
    'La primera serenata',
    'Eramos más tímidos y quise darte una sorpresa al volver de RD. No te vi la carita entonces, pero me hubiera gustado ver tu sonrisa en ese momento y darte un abrazote 🥰',
    media: [
      TimelineMedia.image('assets/images/mc1.jpeg'),
      TimelineMedia.image('assets/images/mc2.jpeg'),
    ],
    music: TimelineMusic(
      coverAsset: 'assets/images/T3R_caratula.jpg',
      audioAsset: 'assets/audio/ojitos.mp3',
      title: 'Ojitos de Miel',
    ),
  ),
  TimelineEvent('28/01/2024', 'La primera foto', 'La que guardo como tesoro.'),
  TimelineEvent('14/02/2024', 'Nuestra primera cita', 'Nervios y sonrisas.'),
  TimelineEvent('02/03/2024', 'El primer abrazo', 'El lugar al que siempre quiero volver.'),
  TimelineEvent('20/04/2024', 'Nuestro primer viaje', 'Kilómetros de recuerdos.'),
  TimelineEvent('10/05/2024', 'La primera sorpresa', 'Tu cara lo dijo todo.'),
  TimelineEvent('01/06/2024', 'El primer “te amo”', 'Y fue real.'),
  TimelineEvent('02/01/2025', 'Nuestro aniversario', 'Un año de magia.'),
  TimelineEvent('14/02/2025', 'Un futuro juntos', 'Seguimos escribiendo nuestra historia.'),
];
