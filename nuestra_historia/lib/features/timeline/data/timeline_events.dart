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
  TimelineEvent(
    '01/11/2024',
    'Nos hicimos pareja',
    'Llegaron los me gustas, los te amo y eventualmente con el tiempo nos convertimos en la pareja más bonita y fuerte que conozco. Gracias por hacerme tan feliz aquella noche 🥹',
    media: [
      TimelineMedia.image('assets/images/citla1.jpeg'),
      TimelineMedia.image('assets/images/dibujo1.jpeg'),
    ],
    music: TimelineMusic(
      coverAsset: 'assets/images/CAS_caratula.jpg',
      audioAsset: 'assets/audio/apocalypse.mp3',
      title: 'Apocalypse',
    ),
  ),
  TimelineEvent(
    'Nov-Dic 2024',
    'Meses de mucho cariño',
    'Con tus salidas y forma de ser, me sacas una sonrisa todos los días :)',
    media: [
      TimelineMedia.image('assets/images/dibujo2.jpeg'),
      TimelineMedia.video('assets/videos/citla2.mp4'),
    ],
    music: TimelineMusic(
      coverAsset: 'assets/images/gnx_caratula.jpg',
      audioAsset: 'assets/audio/luther.mp3',
      title: 'Luther',
    ),
    poemAssets: [
      'assets/images/poema1.jpeg',
    ],
  ),
  TimelineEvent(
    '10/07/2025',
    'Juntos al fin',
    'El primer abrazo, el primer beso, sosteniendo tu manita todo cobró sentido ✨',
    media: [
      TimelineMedia.image('assets/images/mexico1.jpeg'),
      TimelineMedia.image('assets/images/mexico2.jpeg'),
    ],
    music: TimelineMusic(
      coverAsset: 'assets/images/CAS2_caratula.webp',
      audioAsset: 'assets/audio/sweet.mp3',
      title: 'Sweet',
    ),
    poemAssets: [
      'assets/images/monos.jpeg',
    ],
  ),
  TimelineEvent(
    '11-12 Jul. 2025',
    'Días increíbles a tu lado',
    'Viviendo un sueño, viviendo contigo. Momentos que llevaré conmigo para toda la vida 🥹',
    media: [
      TimelineMedia.image('assets/images/mexico3.jpeg'),
      TimelineMedia.image('assets/images/mexico4.jpeg'),
    ],
    music: TimelineMusic(
      coverAsset: 'assets/images/something_caratula.jpg',
      audioAsset: 'assets/audio/something.mp3',
      title: 'Something Stupid',
    ),
  ),
  TimelineEvent(
    '15/07/2025',
    'Paseando juntos',
    'Conociendo las calles de tu ciudad, imaginando un futuro juntos y viviendo experiencias con la mejor compañera de vida que podría pedir 💕',
    media: [
      TimelineMedia.image('assets/images/carrusel.jpeg'),
      TimelineMedia.image('assets/images/onep.jpeg'),
    ],
    music: TimelineMusic(
      coverAsset: 'assets/images/lennon_caratula.jpg',
      audioAsset: 'assets/audio/boy.mp3',
      title: 'Beautiful Boy',
    ),
  ),
  TimelineEvent(
    '01/11/2025',
    'Nuestro aniversario',
    'Luego de un viaje inolvidable llega nuestra fecha especial, un año que cambio nuestras vidas y me permitió volver a soñar 🌠',
    media: [
      TimelineMedia.image('assets/images/besos1.jpeg'),
      TimelineMedia.image('assets/images/besos2.jpeg'),
    ],
    music: TimelineMusic(
      coverAsset: 'assets/images/roy_caratula.jpg',
      audioAsset: 'assets/audio/sun.mp3',
      title: 'MY SUN',
    ),
    poemAssets: [
      'assets/images/poema2.jpeg',
      'assets/images/poema3.jpeg',
    ],
  ),
  TimelineEvent('02/01/2025', 'Nuestro aniversario', 'Un año de magia.'),
  TimelineEvent('14/02/2025', 'Un futuro juntos', 'Seguimos escribiendo nuestra historia.'),
];
